From: Nils Homer <nilshomer@gmail.com>
Subject: Re: How to delete large files
Date: Fri, 02 Oct 2009 12:20:58 -0700
Message-ID: <C6EBA0AA.D7D3%nilshomer@gmail.com>
References: <4AC6031A.2070409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 02 21:21:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtngo-0001gw-ET
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 21:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbZJBTVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 15:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753111AbZJBTVE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 15:21:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:15230 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbZJBTVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 15:21:03 -0400
Received: by fg-out-1718.google.com with SMTP id 22so2238120fge.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from
         :to:message-id:thread-topic:thread-index:in-reply-to:mime-version
         :content-type:content-transfer-encoding;
        bh=VPW6IqRLyiG03zpYSDcD5ksLTNcEjD35agt1Mv2aSxI=;
        b=QxMCqfjy7eHK+p91vJZVnQnwTkcySDdrHSsLswwFu1IVephGuBZSXAwbLf2IIwJqV5
         5lXh7LbWPwdp9jWNlOKjJWtImx68WhB9QlrsCN4dQ4RKAdTgRjT4nJhvrkPhOHtT5C1u
         3YESZ9WTRH0Ah7PxZAINxGg53//ge8LGXvjKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:message-id:thread-topic
         :thread-index:in-reply-to:mime-version:content-type
         :content-transfer-encoding;
        b=jcGqE2T/Opoh0csI6a+fQ7TrnqCnorON5OS4/9kBfrEwPfrfpkAickM4LXaVQs6qqR
         86jyZNG9IwsISzutXcEEu5EudoP5c/C6GpRIKpZDszXpC52OmRJNozdHsHGKb1E5sguu
         Zz7j6YUExsUvZthgbJ3t1M5iosiLmq6JCx6UI=
Received: by 10.86.242.15 with SMTP id p15mr2728212fgh.14.1254511266087;
        Fri, 02 Oct 2009 12:21:06 -0700 (PDT)
Received: from ?192.168.1.100? (cpe-76-172-154-28.socal.res.rr.com [76.172.154.28])
        by mx.google.com with ESMTPS id e11sm277651fga.23.2009.10.02.12.21.04
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 12:21:05 -0700 (PDT)
User-Agent: Microsoft-Entourage/12.20.0.090605
Thread-Topic: How to delete large files
Thread-Index: AcpDlXg+V6zM6nDps06XIQcLoYinlw==
In-Reply-To: <4AC6031A.2070409@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129457>

Thank-you for all of your insightful help. Combining all the advice, the
commands that worked are:

git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch
$files" --tag-name-filter cat -- --all

git -rf .git/refs/original

git reflog expire --expire=now

git gc --prune=now

I then cloned the repository to a different location and replaced my
centralized version with the cloned copy.

Thanks,

Nils


On 10/2/09 6:41 AM, "Johannes Sixt" <j.sixt@viscovery.net> wrote:

> Mikael Magnusson schrieb:
>> Well, you just gave "HEAD" to git filter-branch to rewrite, i think
>> you want --all to rewrite all refs you have.
> 
> ... and '--tag-filter cat' to rewrite tags as well.
> 
> -- Hannes
