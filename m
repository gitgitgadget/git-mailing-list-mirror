From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: How to check new commit availability without full fetch?
Date: Mon, 11 Jan 2010 08:38:15 +0300
Message-ID: <20100111053815.GB10586@dpotapov.dyndns.org>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
 <alpine.LFD.2.00.1001101501520.10143@xanadu.home>
 <7v8wc5itlc.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001101556490.10143@xanadu.home>
 <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 06:40:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUD0V-0004pE-F7
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 06:40:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140Ab0AKFjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 00:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135Ab0AKFjL
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 00:39:11 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43535 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab0AKFjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 00:39:10 -0500
Received: by bwz27 with SMTP id 27so21148bwz.21
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 21:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KicUjhC+IuOzfUgCxgu+EBCkexhAgFL0iaq2yQoLEsI=;
        b=MFEaGZH34FD7mUNqeoUs+zi4ULt7CR/wsLKgVwz0mrLfh8VyxBvde2img1MQo3zL1G
         hK+2xpQWXRbkDInlhuTED4jDi5hhD1FnAL5l22Ac4Tkc/ivCxNa+nxaj7ANec67vgSjA
         7nE0VyeOAU9p6mTZDj68LpxpoRMm8r4DwOA48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TGRw07CNSsP6KAUZikgqrM/j+2XTSKSBi6K3m+lmiM/vxNeOpBzHu85VyEWc/WQLyU
         msXpcZ06+D+9cLEBYo8Ezsdrfzz1/YxI6xCZc7mgnNAFnv6R4r4fWf1F8YYkn9osuO4M
         lPbN3soie+Hyn8UIU0R/8ZI706GTCvWk/ofWg=
Received: by 10.204.49.79 with SMTP id u15mr889337bkf.117.1263188347965;
        Sun, 10 Jan 2010 21:39:07 -0800 (PST)
Received: from localhost (ppp85-141-235-124.pppoe.mtu-net.ru [85.141.235.124])
        by mx.google.com with ESMTPS id 15sm2312099bwz.8.2010.01.10.21.39.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Jan 2010 21:39:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136605>

On Sun, Jan 10, 2010 at 08:36:44PM -0500, Leo Razoumov wrote:
> 
> BTW, pull and push are in a way symmetric operations.

Not really... 'pull' = 'fetch' + 'merge', while 'push' only propagates
changes without any merging. You can say 'fetch' and 'push' are in a way
symmetric operations, but this symmetry is limited due to difference in
usage between local and remote branches.

> Is there any
> deep reason why push supports --dry-run but pull/fetch does not??

I guess it is because no one needs it. 'push' has --dry-run, because
it updates local references in a remote repository. So, you may want
to be sure that you are pushing the right thing. On the other hand,
I see no reason to have --dry-run for 'fetch', because it updates only
remote references, making them to point to the current state of the
corresponding branches. 'fetch' does not change any local branch, so
I see no reason for --dry-run.

What use case do you have in mind that needs --dry-run for 'fetch'?


Dmitry
