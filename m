From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Wed, 13 Jun 2012 21:38:36 +0200
Message-ID: <20120613213836.Horde.qI8GQnwdC4BP2Ow8uCTQqgA@webmail.minatec.grenoble-inp.fr>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD70A8E.7050502@in.waw.pl> <7vk3zc4mgz.fsf@alter.siamese.dyndns.org>
 <4FD89DD6.1070705@in.waw.pl>
 <20120613200552.Horde.JHFYfHwdC4BP2NaA39-wrmA@webmail.minatec.grenoble-inp.fr>
 <7vipevgjhp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew J?drzejewski-Szmek <zbyszek@in.waw.pl>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 21:39:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetP6-0007Oh-8g
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab2FMTim convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 15:38:42 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:59161 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754472Ab2FMTil (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 15:38:41 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 5317B1A025A;
	Wed, 13 Jun 2012 21:38:37 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Wed, 13 Jun
 2012 21:38:36 +0200
In-Reply-To: <7vipevgjhp.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199938>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

> It looks that editing
>
>     pick foo            pick foo
>     exec cmd1           exec cmd1 && cmd2
>     exec cmd2
>     pick bar            pick bar
>     exec cmd1           exec cmd1 && cmd2
>     exec cmd2
>
> to
>
>     pick foo            pick foo
>                         exec         cmd2
>     exec cmd2
>     pick bar            pick bar
>     exec cmd1           exec cmd1
>
> would take exactly the same effort, at least to me.  And more
> importantly, without editing don't they do *exactly* the same thing?
> If cmd1 fails, the sequencing stops at that step without running cmd2=
=2E

True. I was thinking under the fact that the user would edit the comman=
ds
by himself but the purpose of the "--exec" option is to avoid that (or =
at
least that the user won't have to type all by himself). Forget what I s=
aid
then :).
