From: Christian Biesinger <cbiesinger@web.de>
Subject: Re: [PATCH] Ignore commits for which cvsps can't identify a branch
Date: Fri, 10 Feb 2006 23:02:11 +0100
Message-ID: <43ED0D63.5090105@web.de>
References: <200602102102.k1AL2Xkd010415@biesi.no-ip.org> <7vmzgyvrih.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 23:02:22 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7gLN-0006eW-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 23:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWBJWCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 17:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWBJWCR
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 17:02:17 -0500
Received: from smtp08.web.de ([217.72.192.226]:18319 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S932220AbWBJWCR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 17:02:17 -0500
Received: from [85.124.17.142] (helo=[192.168.1.4])
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.105 #340)
	id 1F7gLE-00073U-00; Fri, 10 Feb 2006 23:02:12 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060209 SeaMonkey/1.5a
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzgyvrih.fsf@assigned-by-dhcp.cox.net>
X-Sender: cbiesinger@web.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15890>

Junio C Hamano wrote:
> Does continuing with this kind of "fixups" produce usable
> history, perhaps just some changes missing but trees contained
> in other commits are still faithful reproductions of what the
> CVS repository would have given you?  Or does it result in
> unusable history?

I have to admit that I can't actually tell you for sure, since I still 
get a failure later (I think it's because cvsps orders changesets 
wrongly). However, I was told that the revisions that give me this 
CVSPS_NO_BRANCH issue came into existence by (partially) removing tags 
from a file, so not listing them should be fine, I think. (This happened 
by copying a ,v file and removing its tags, simulating a file copy)

Anyway, based on that, I expect that the history is the same as what I 
get from cvs, but I can't verify that.

> Depending on the nature of corruption and its expected use,
> sometimes silently corrupt conversion result is worse than not
> having it at all.

Well, without the patch this error is fatal, and the conversion is very 
partial. I'm not sure if that's better.

(This is also not "silent" corruption. I do show a message for it. Would 
you rather have it displayed unconditionally?)

Would it be better to have a flag --continue-on-errors?
