From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] C version of git-count-objects
Date: Thu, 27 Apr 2006 17:25:38 -0700
Message-ID: <7vu08eim0t.fsf@assigned-by-dhcp.cox.net>
References: <20060427101254.GA22769@peppar.cs.umu.se>
	<Pine.LNX.4.64.0604270914570.18816@localhost.localdomain>
	<7vhd4ekfu1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604271535460.18816@localhost.localdomain>
	<20060427194559.GA26386@brainysmurf.cs.umu.se>
	<Pine.LNX.4.64.0604271257010.3701@g5.osdl.org>
	<20060427205155.GA26856@brainysmurf.cs.umu.se>
	<7vaca6k6za.fsf@assigned-by-dhcp.cox.net>
	<20060428001049.GA28347@brainysmurf.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 02:26:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZGoj-00043w-PY
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 02:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWD1A0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 20:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWD1AZv
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 20:25:51 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:25496 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965069AbWD1AZk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 20:25:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060428002540.TZUN25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Apr 2006 20:25:40 -0400
To: Peter Hagervall <hager@cs.umu.se>
In-Reply-To: <20060428001049.GA28347@brainysmurf.cs.umu.se> (Peter Hagervall's
	message of "Fri, 28 Apr 2006 02:10:50 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19257>

Peter Hagervall <hager@cs.umu.se> writes:

> On Thu, Apr 27, 2006 at 03:07:37PM -0700, Junio C Hamano wrote:
>
> ...
>
>> +int cmd_count_objects(int ac, const char **av, char *ep)
>                                                        ^
> ...
>
>> +extern int cmd_count_objects(int argc, const char **argv, char **envp);
>                                                                   ^^
> Looks like we have a type mismatch here, no?

Interesting.  Lack of #include <builtin.h> was causing the
compiler not to notice X-<.
