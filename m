From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Cogito documentation updates
Date: Wed, 23 Nov 2005 13:16:51 +0100
Message-ID: <20051123121651.GB19302@diku.dk>
References: <20051120101112.GA2302@diku.dk> <86veyn49gc.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 13:17:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EetYo-0002P3-Ue
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 13:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVKWMQx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 07:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVKWMQx
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 07:16:53 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:23492 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750738AbVKWMQw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 07:16:52 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 3AD786DFEC9; Wed, 23 Nov 2005 13:16:16 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id EEAFC6DFE93; Wed, 23 Nov 2005 13:16:15 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 673C1613F9; Wed, 23 Nov 2005 13:16:51 +0100 (CET)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86veyn49gc.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12619>

Randal L. Schwartz <merlyn@stonehenge.com> wrote Sun, Nov 20, 2005:
> >>>>> "Jonas" == Jonas Fonseca <fonseca@diku.dk> writes:
> 
> Jonas>  - local cg-fetch now works without the cp option -u
> 
> But it still requires cp -d, unless some other patch fixed that recently.

Ah, yes. I just recently tried local cloning on a FreeBSD box and it
worked fine (apart from it spitting out a few errors, see the log below)
and since the caveat section only mentioned the -u option I thought
everything was fine. However, cloning a specific branch hits the error.
So maybe the caveat section should just be updated to say that the -d
option is required. 

---

$ cg clone cogito cogito-now
defaulting to local storage area
Hard links don't work - using copy
Fetching head...
/home/jonas/src/cogito/.git/HEAD -> .git/refs/heads/.origin-fetching
Fetching objects...
progress: 10289 objects, 16992385 bytes
Fetching tags...
error: missing object referenced by 'refs/tags/junio-gpg-pub'
fatal: protocol error: bad line length character
Failed to find remote refs
unable to get tags list (non-fatal)
New branch: 73874dddeec2d0a8e5cd343eec762d98314def63
Cloned to cogito-now/ (origin /home/jonas/src/cogito available as branch "origin")

$ cg clone cogito#cogito-0.10 cogito-0.10
cp: illegal option -- d
usage: cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src target
       cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src1 ... srcN
       directory
       cg-fetch: unable to get the head pointer of branch cogito-0.10
       cg-clone: fetch failed

-- 
Jonas Fonseca
