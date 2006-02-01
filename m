From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Wed, 01 Feb 2006 14:50:03 -0800
Message-ID: <7v8xsu7kys.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<20060130185822.GA24487@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601311750270.25300@iabervon.org>
	<7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
	<7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>
	<7vhd7ibza2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011307250.21884@g5.osdl.org>
	<7v8xsu91vf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011717010.5397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 23:50:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Qo2-0003cV-Qk
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 23:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422994AbWBAWuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 17:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422995AbWBAWuH
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 17:50:07 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:44466 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1422997AbWBAWuF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 17:50:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201224835.NEME20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 17:48:35 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602011717010.5397@localhost.localdomain> (Nicolas
	Pitre's message of "Wed, 01 Feb 2006 17:25:18 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15458>

Nicolas Pitre <nico@cam.org> writes:

> Actually, my opinion is that should be the behavior for your first item 
> above (when only filenames are specified).  If you want to _also_ 
> include the index like you describe in your first item then an 
> additional switch should be provided.

OK, agreed.  Sorry to be slow.

So, to recap:

git commit paths...			(temporary index thing)
git commit --incremental paths...	(same as current w/o --incremental)
git commit               		(same as current)
git commit -a				(same as current)	

And I agree with Joel that we should not automatically imply
"git add" with or without --incremental.

I do not particularly have much preference among --also,
--with-index, or --incremental, but:

 - 'with-index' is precise but might be too technical;
 - 'incremental' is not really incremental -- you can use it
   only once.

Because you do not have to say "git commit --also" without paths
(which _is_ awkward) to get the traditional behaviour, maybe it
is a good name for that flag (it is also the shortest).
