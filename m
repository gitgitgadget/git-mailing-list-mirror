From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 08 Jun 2006 09:25:53 -0700
Message-ID: <7v1wtzaa26.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
	<44880BE8.40804@etek.chalmers.se>
	<Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 18:26:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoNKc-0002fQ-2f
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 18:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWFHQZ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 8 Jun 2006 12:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWFHQZ4
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 12:25:56 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:55691 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964879AbWFHQZz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jun 2006 12:25:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060608162554.EOKE12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Jun 2006 12:25:54 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 8 Jun 2006 13:41:04 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21497>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Johannes Schindelin wrote:
> On Thu, 8 Jun 2006, Lukas Sandstr=F6m wrote:
>> > Since there is a global config now, we need a way to access it
>> > conveniently. Now you can say
>> >=20
>> > 	git repo-config --no-local alias.l "log --stat -M ORIG_HEAD.."
>> >=20
>> > to set the alias globally (it will be stored in ~/.gitconfig).
>>=20
>> Wouldn't it make more sense to call the flag --global ?
>
> Sure, why not? Other opinions? (I will not add a test case until this=
 is=20
> resolved! ;-)

The wording "--no-local" means you are looking at things
relative to a particular repository.  I.e. some configuration
variables come from repository-local file, and others from
somewhere else.  But I do not think that somewhere else is
"global".  We are reading from $HOME, which is different
depending on who is interacting with that same repository.  So I
would probably call the other one "--user" or something if I
were force to pick name.

But as you know, I am horrible at picking names, so please don't
stop this from coming up with a good name the list can agree
upon.
