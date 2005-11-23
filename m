From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Cogito documentation updates
Date: Wed, 23 Nov 2005 15:58:44 +0100
Message-ID: <438483A4.6040802@op5.se>
References: <20051120101112.GA2302@diku.dk>	<86veyn49gc.fsf@blue.stonehenge.com> <20051123121651.GB19302@diku.dk> <8664qjph7d.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 23 16:01:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eew5l-0007pf-Fg
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 15:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbVKWO6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 09:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVKWO6r
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 09:58:47 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53136 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750939AbVKWO6q
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 09:58:46 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id D3B876BCBE
	for <git@vger.kernel.org>; Wed, 23 Nov 2005 15:58:44 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <8664qjph7d.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12632>

Randal L. Schwartz wrote:
>>>>>>"Jonas" == Jonas Fonseca <fonseca@diku.dk> writes:
> 
> 
> Jonas> Ah, yes. I just recently tried local cloning on a FreeBSD box and it
> Jonas> worked fine (apart from it spitting out a few errors, see the log below)
> Jonas> and since the caveat section only mentioned the -u option I thought
> Jonas> everything was fine. However, cloning a specific branch hits the error.
> Jonas> So maybe the caveat section should just be updated to say that the -d
> Jonas> option is required. 
> 
> But instead of targeting GNU tools, why not target POSIX tools where
> possible?
> 
> Delete the -d switch, or explain to me why it is there, and let's work
> out a POSIX workaround.
> 

        -d     same as --no-dereference --preserve=link

        --no-dereference
               never follow symbolic links

        --preserve[=ATTR_LIST]
               preserve   the   specified   attributes  (default:
               mode,ownership,timestamps) and security contexts,
               if possible
               additional attributes: links, all

I don't know how to get those options with POSIX only cp.

> I'm not asking for everyone to be cautious when contributing code.
> I'll be happy to be "mr portability" and figure out how to make it
> still work on OpenBSD and Darwin (my two platforms of choice).
> 
> However, as I said in another posting, maybe I just need to understand
> the target market first.  (I realize that goal #1 is Linux Kernel
> development.)
> 

I'm not Junio, but I think the priorities right now are ordererd like 
this; good performance, fast development, portability.

Good performance because it's designed to handle one of the largest open 
projects there is.

Fast development because it's still a young project but has more 
momentum than most projects, open or closed, ever get. If it slows down 
now it will stay slow until the kernel team needs new features and 
there's no way of recycling inertia.

Portability because that's nice but not vital for the project as a whole 
(it's a linuxish tool, so most users run it on linux so far). I think 
portability usually ends up a bit behind in the race because it often 
hinders #1 and #2.

Again, I'm not Junio. I might be dead wrong.

However, most of the plumbing works on just about anything with a CPU, 
so unless you really need cg-clone you should be able to do it with 
git-clone, which AFAIU uses 'tar' and 'cpio' instead of cp to transfer 
files (for portability reasons, I imagine).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
