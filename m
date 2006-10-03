From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs.
Date: Tue, 03 Oct 2006 13:16:13 -0700
Message-ID: <7vwt7hm9yq.fsf@assigned-by-dhcp.cox.net>
References: <20060929221641.GC2871@admingilde.org>
	<7v8xk2jofc.fsf@assigned-by-dhcp.cox.net>
	<20060930181408.GD2871@admingilde.org>
	<7vfye9dtv7.fsf@assigned-by-dhcp.cox.net>
	<20061001215748.GG2871@admingilde.org> <eftkdk$2ii$3@sea.gmane.org>
	<7vbqotpadg.fsf@assigned-by-dhcp.cox.net> <efu7r9$fra$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 22:18:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUqgd-00076V-2b
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 22:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWJCUQQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 3 Oct 2006 16:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbWJCUQQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 16:16:16 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20613 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030236AbWJCUQP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 16:16:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003201614.QNQQ12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Oct 2006 16:16:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VwG81V0051kojtg0000000
	Tue, 03 Oct 2006 16:16:08 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <efu7r9$fra$1@sea.gmane.org> (Jakub Narebski's message of "Tue,
	03 Oct 2006 19:50:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28297>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Jakub Narebski <jnareb@gmail.com> writes:
>>=20
>>> Martin Waitz wrote:
>>>
>>>> +=A0=A0=A0=A0=A0=A0=A0'pathinfo' =3D> {
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'override' =3D> 0,
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'default' =3D> [1]},
>>>
>>> You should add failsafe to gitweb_check_feature for when 'sub' is n=
ot
> set;
>>> for example when somebody sets $feature{'pathinfo'}{'override'} to =
1.
>>=20
>> Yes, I noticed this last night while playing with it.  We would
>> at least need a big warning that says this should not be made
>> overridable (which does not make any sense anyway).
>>=20
>> Setting 'sub' to a failsafe one that only returns what is in the
>> default without looking at individual repository would be the
>> cleanest, I think.
>
> Perhaps we should not add 'override' key, and test for existence
> of 'override' to fallback on 'sub'.

Excellent idea.  Please make it so.
