From: konglu@minatec.inpg.fr
Subject: Re: [PATCH] rebase [-i --exec | -ix] <CMD>...
Date: Tue, 05 Jun 2012 19:59:59 +0200
Message-ID: <20120605195959.Horde.h42jfHwdC4BPzkkfVQizm9A@webmail.minatec.grenoble-inp.fr>
References: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vhaurt1m6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 20:00:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sby3A-0006xh-JN
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 20:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631Ab2FESAE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 14:00:04 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:57043 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752304Ab2FESAE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 14:00:04 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id D744A1A02DC;
	Tue,  5 Jun 2012 19:59:59 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Tue, 05 Jun
 2012 19:59:59 +0200
In-Reply-To: <7vhaurt1m6.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199273>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:


>> +		if orig_head=3D$(git rev-parse -q --verify "$2") ||
>> +		   test `expr substr "$2" 1 1` =3D -
>> +		then
>> +			echo "You must specify a command after --exec option\n"
>> +			usage
>> +		else
>> +			if test -n "$cmd"
>> +			then
>> +				cmd=3D"$2,$cmd"
>> +			else
>> +				cmd=3D"$2"
>> +			fi
>> +		fi
>> +		shift
>> +		;;
>
> Are you telling me that I cannot have a branch named "make"?  Drop
> this nonsense, and just write it in a more straightforward way, e.g.
>
> 	-x)
> 		test 2 -le "$#" || usage
>                 cmd=3D"${cmd:+"$cmd$LF"} $2"
>                 shift
>                 ;;
I agree with the fact that the code must not restrain you in naming bra=
nches.
But shouldn't we keep the "test `expr substr "$2" 1 1` =3D -" part so t=
hat
options can't be right after the "--exec" ?
