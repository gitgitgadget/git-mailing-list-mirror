From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs.
Date: Tue, 03 Oct 2006 10:39:07 -0700
Message-ID: <7vbqotpadg.fsf@assigned-by-dhcp.cox.net>
References: <20060929221641.GC2871@admingilde.org>
	<7v8xk2jofc.fsf@assigned-by-dhcp.cox.net>
	<20060930181408.GD2871@admingilde.org>
	<7vfye9dtv7.fsf@assigned-by-dhcp.cox.net>
	<20061001215748.GG2871@admingilde.org> <eftkdk$2ii$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Oct 03 19:39:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUoEc-00031Y-Kw
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 19:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbWJCRjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 3 Oct 2006 13:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWJCRjK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 13:39:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:3568 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030364AbWJCRjJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 13:39:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003173908.ZXPE16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Oct 2006 13:39:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vtf11V00v1kojtg0000000
	Tue, 03 Oct 2006 13:39:02 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eftkdk$2ii$3@sea.gmane.org> (Jakub Narebski's message of "Tue,
	03 Oct 2006 14:18:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28283>

Jakub Narebski <jnareb@gmail.com> writes:

> Martin Waitz wrote:
>
>> +=A0=A0=A0=A0=A0=A0=A0'pathinfo' =3D> {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'override' =3D> 0,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'default' =3D> [1]},
>
> You should add failsafe to gitweb_check_feature for when 'sub' is not=
 set;
> for example when somebody sets $feature{'pathinfo'}{'override'} to 1.

Yes, I noticed this last night while playing with it.  We would
at least need a big warning that says this should not be made
overridable (which does not make any sense anyway).

Setting 'sub' to a failsafe one that only returns what is in the
default without looking at individual repository would be the
cleanest, I think.
