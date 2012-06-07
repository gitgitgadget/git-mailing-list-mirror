From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv9 4/4] status: better advices when splitting a commit
 (during rebase -i)
Date: Thu, 07 Jun 2012 23:05:27 +0200
Message-ID: <20120607230527.Horde.vsZkPXwdC4BP0ReXmNcTX0A@webmail.minatec.grenoble-inp.fr>
References: <1338927687-29822-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339075029-27109-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339075029-27109-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7v8vfyg8ga.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 23:05:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scjtg-0007Lx-Qg
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 23:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121Ab2FGVFc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 17:05:32 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:34765 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932086Ab2FGVFc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 17:05:32 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 440F11A02F1;
	Thu,  7 Jun 2012 23:05:28 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Thu, 07 Jun
 2012 23:05:27 +0200
In-Reply-To: <7v8vfyg8ga.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199453>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

> Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:
>
>> +static char *read_line_from_git_path(const char *filename)
>> +{
>> +	struct strbuf buf =3D STRBUF_INIT;
>> +	FILE *fp =3D fopen(git_path(filename), "r");
>
> We currently do not pass any filename with per-cent in it, but that
> call should be git_path("%s", filename) for sanity.

Thanks, that should fix our problem (sometimes, a warning message appea=
rs
during compilation about this line and we didn't know what to change).
