From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: gitk "parent information" in commit window
Date: Sun, 07 Aug 2005 23:19:11 -0400
Message-ID: <42F6CF2F.9010507@gmail.com>
References: <Pine.LNX.4.58.0508071351150.3258@g5.osdl.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 08 05:20:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1yAs-0004xQ-JY
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 05:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVHHDTP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 23:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVHHDTO
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 23:19:14 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:65046 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750709AbVHHDTO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2005 23:19:14 -0400
Received: by wproxy.gmail.com with SMTP id i20so759859wra
        for <git@vger.kernel.org>; Sun, 07 Aug 2005 20:19:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=U6x/NfPR9PWUbdUMr1Wld7XgWV5o+97Z0aZQM+Ciu84J95t137BOOQWRgXinvr5TZmLvzm2a68OuUtaF7TpPlxiqlwS+FYtfPRZRqmowUp6iYbjg33mvEaNH8Gt9vIDCtMri/dMUzao8aFAyaSpfFNaRkS0IM5auof4Kkh8ywNU=
Received: by 10.54.116.12 with SMTP id o12mr4515922wrc;
        Sun, 07 Aug 2005 20:19:13 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id 24sm6965367wrl.2005.08.07.20.19.13;
        Sun, 07 Aug 2005 20:19:13 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.58.0508071351150.3258@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> This adds a useful "Parent:" line to the git commit information window.
> 
> It looks something like this (from the infamous octopus merge):
> 
> 	Author: Junio C Hamano <junkio@cox.net>  2005-05-05 16:16:54
> 	Committer: Junio C Hamano <junkio@cox.net>  2005-05-05 16:16:54
> 	Parent: fc54a9c30ccad3fde5890d2c0ca2e2acc0848fbc  (Update git-apply-patch-script ...)
> 	Parent: 9e30dd7c0ecc9f10372f31539d0122db97418353  (Make git-prune-script executa ...)
> 	Parent: c4b83e618f1df7d8ecc9392fa40e5bebccbe6b5a  (Do not write out new index if ...)
> 	Parent: 660265909fc178581ef327076716dfd3550e6e7b  (diff-cache shows differences  ...)
> 	Parent: b28858bf65d4fd6d8bb070865518ec43817fe7f3  (Update diff engine for symlin ...)
> 	
> 	    Octopus merge of the following five patches.
> 	    
> 	      Update git-apply-patch-script for symbolic links.
> 	      Make git-prune-script executable again.
> 	      Do not write out new index if nothing has changed.
> 	      diff-cache shows differences for unmerged paths without --cache.
> 	      Update diff engine for symlinks stored in the cache.
> 	    
> 	    Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> where all the parent commit ID's are clickable, because the new lines are 
> added as part of the "comment" string, and thus the regular clickability 
> thing will match them automatically.

This new functionality is great except when it truncates the commit 
description needlessly.

When running gitk full-screen on a large display, I have a commit 
information window that is much wider than needed for the truncated 
parent information. Leaving me with a lot of whitespace that should be 
used for the commit descriptions.

On a related nit: some of the diffs I'm viewing have lines longer than 
the width of the commit information window and it's annoying that gitk 
wraps the line rather than providing horizontal scrolling.

How about implementing horizontal scrolling in the commit information 
window when the commit text or the diffs are wider than the window and 
not truncating the commit descriptions?
