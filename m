From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv6 2/4] t7512-status-help.sh: better advices for git
 status
Date: Mon, 04 Jun 2012 12:04:06 +0200
Message-ID: <20120604120406.Horde.ge3VMHwdC4BPzIgWN72l8oA@webmail.minatec.grenoble-inp.fr>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vvcj8xffp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 12:04:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbU90-00027x-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 12:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825Ab2FDKEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 06:04:10 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:34100 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752015Ab2FDKEJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 06:04:09 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 886CE1A02E8;
	Mon,  4 Jun 2012 12:04:06 +0200 (CEST)
Received: from wifi-030076.grenet.fr (wifi-030076.grenet.fr [130.190.30.76])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Mon, 04 Jun
 2012 12:04:06 +0200
In-Reply-To: <7vvcj8xffp.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199124>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

> I thought Matthieu always called himself "Matthieu Moy", not the
> other way around.  I also inferred the convention used for naming
> the mailboxes at your institution to be "$First.$Last@$Domain",
> which tells me that perhaps these names are all spelled backwards,
> i.e. "$Last $First", which probably goes against the convention used
> around you and Matthieu?

Hm, yeah it's spelled backwards, I didn't take notice of that.

>> +. ./test-lib.sh
>> +
>> +. "$TEST_DIRECTORY"/lib-rebase.sh
>> +
>> +set_fake_editor
>> +
>> +test_expect_success 'status when conflicts unresolved' '
>> +	git init git &&
>> +	cd git &&
>
> Eek.
>
> Later tests seem to use
>
> 	git init git &&
> 	(
> 		cd git &&
>                 ... everything is done inside git subdirectory ...
> 	)
>
> with either "test_when_finished 'rm -fr git'" clean-up before the
> first "git init git" or "&& rm -fr git" at the end of the && chain.
>
> Please be consistent.  If you want _me_ to pick one, I'd say
>
> 	test_when_finished 'rm -fr git' &&
>         git init git &&
>         (
>         	cd git &&
>                 ... do everything in git subdirectory ...
> 	)
>
> would be my choice.

Btw, should each test be independant with the others ? We saw that ther=
e
are already a lot of tests that are dependant. In this case, can we app=
ly
this method with the parenthesis ?

Wouldn't it be better if we remove the "git init git" part?
