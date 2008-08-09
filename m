From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [BUG/PATCH] Revert "gitk: Arrange to kill diff-files & diff-index on quit"
Date: Sat, 9 Aug 2008 13:13:52 +0400
Organization: TEPKOM
Message-ID: <200808091313.52528.angavrilov@gmail.com>
References: <42d19ab224653b2e6988d7209a8d3e87e19858f8.1218207346.git.christian@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Sat Aug 09 11:15:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRkXb-0003eM-An
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 11:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbYHIJOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 05:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbYHIJOI
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 05:14:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:8940 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbYHIJOF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 05:14:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so715101fgg.17
        for <git@vger.kernel.org>; Sat, 09 Aug 2008 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ZxCubYwUMk1gSFl5HjVF0P1QRYZgnq9gEwp4Gy/XrIM=;
        b=WF1Mpb4kl74D8LFYUEJQCKErFb+l/Q7pRUTTxabIk9Y9ZjDbi98DF8rQnA7VdqVsUX
         1o9IOPERCbZy0pQ6iJe9wtDAABdBXV7SQM/X7C8W/tguwRhNjdSGNZWXjs3bzSxuXwbs
         1ShuV1AuJ27ks6jc72HmX61x4e+ospm3wXCH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UHqXdPyMwNS8EbadK1+Jjzd8w42zZLQODh4KTWPFzYk/Og7x6a0WROlDF3bk5dZ1G3
         FRTpwzhQmMg+GipaT2ebJXOvk8Ys/VkMLMqnLfD7uaE1rSYNOidOKv6mg0ppDwPQ3KrS
         RrWbhJgBTa2Wp/9GY4WQ1KtrEhTsFPafz83Ao=
Received: by 10.86.95.8 with SMTP id s8mr1173685fgb.6.1218273243687;
        Sat, 09 Aug 2008 02:14:03 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id 3sm3568468fge.3.2008.08.09.02.14.02
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Aug 2008 02:14:03 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <42d19ab224653b2e6988d7209a8d3e87e19858f8.1218207346.git.christian@jaeger.mine.nu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91756>

On Friday 08 August 2008 18:41:07 Christian Jaeger wrote:
> gitk would not show diffs (or trees when choosing tree view) about
> half of the times it is started, it would only show the commit
> messages. Sometimes it took dozens of times to get it to show a diff
> again with 3 starts, then the next 2 starts not, then the next 2
> starts would show it again, and so on.

> My system environment:
>   Debian Lenny (testing)
>   tk8.4 8.4.19-2

I cannot reproduce this on my Fedora 7 system with tk8.4.13 no matter how I try.
Could you please try to isolate which hunk causes the problem? You should be
able to remove them from bottom to top without any serious problems.


By the way, I experienced a similar problem while working on another patch
(although it required a more elaborate sequence of actions to trigger it), and
made a fix for it:

http://repo.or.cz/w/git.git?a=commitdiff;h=7272131b3e49879d3a7bedacad3cdb12ae678ee8

For some reason, now I cannot reproduce that either.

-- Alexander
