From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Sat, 20 May 2006 18:59:48 -0600
Message-ID: <m13bf4qjjv.fsf@ebiederm.dsl.xmission.com>
References: <7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
	<m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
	<7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
	<m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com>
	<7vsln8cwn6.fsf@assigned-by-dhcp.cox.net>
	<m1zmhg31cm.fsf@ebiederm.dsl.xmission.com>
	<7vy7x09qet.fsf@assigned-by-dhcp.cox.net>
	<m1ejyr38xx.fsf@ebiederm.dsl.xmission.com>
	<20060519235825.GA3289@kroah.com>
	<m1ac9dv2ld.fsf@ebiederm.dsl.xmission.com>
	<20060520213257.GH24672@kroah.com>
	<m1fyj4qkm2.fsf@ebiederm.dsl.xmission.com>
	<7v8xow1a6r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 03:00:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhcJG-0001Zd-H5
	for gcvg-git@gmane.org; Sun, 21 May 2006 03:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWEUBAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 21:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWEUBAd
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 21:00:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12743 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932249AbWEUBAc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 21:00:32 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4L0xnWJ004196;
	Sat, 20 May 2006 18:59:49 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4L0xm7r004195;
	Sat, 20 May 2006 18:59:48 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xow1a6r.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 20 May 2006 17:41:16 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20415>

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Currently git-mailinfo distinguishes headers and non-headers by the
>> presence of the first blank line.  So it seems to work just fine on
>> mbox format patches.
>
> The program was designed to be fed one e-mail a time (the
> intended way for it to work is that a wrapper script uses
> git-mailsplit to break mbox up and call git-mailinfo one by
> one).

In this case what is meant is a leading "From " header (no colon)
at the start of the patch.

Where git-mailinfo is likely to fall down is more in the quilt
patches from Andi Kleen. If you look at my quoted patch header below
you will see the subject is a plain line, followed by a space followed
by a from.  On this example git-mailinfo works (except for picking up
the subject) but it appears to be a fluke.

>From x86_64-mm-add-abilty-to-enable-disable-nmi-watchdog-from-sysfs.patch:

> Add abilty to enable/disable nmi watchdog with sysctl
> 
> From: dzickus <dzickus@redhat.com>
> 
> Adds a new /proc/sys/kernel/nmi call that will enable/disable the nmi
> watchdog.
> 
> Signed-off-by:  Don Zickus <dzickus@redhat.com>
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> ---
>  arch/i386/kernel/nmi.c   |   52 +++++++++++++++++++++++++++++++++++++++++++++++
>  arch/x86_64/kernel/nmi.c |   48 +++++++++++++++++++++++++++++++++++++++++++
>  include/asm-i386/nmi.h   |    1
>  include/asm-x86_64/nmi.h |    1
>  include/linux/sysctl.h   |    1
>  kernel/sysctl.c          |   11 +++++++++
>  6 files changed, 114 insertions(+)
> 
> Index: linux/arch/i386/kernel/nmi.c


Eric
