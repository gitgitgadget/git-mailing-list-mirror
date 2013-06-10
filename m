From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: [PATCH 1/2] rm: better error message on failure for multiple  files
Date: Mon, 10 Jun 2013 09:43:44 +0200
Message-ID: <f3f6cb36e56ea8fdf7ebe22230c2aff7@ensibm.imag.fr>
References: <1370680434-2709-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <CALkWK0mqVCfrPgSLi1dnDv26YAyRrJJD_S179VYfEApmGkd4Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	<git@vger.kernel.org>, <gitster@pobox.com>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 09:43:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulwlf-0003ZN-9V
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 09:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab3FJHnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 03:43:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45322 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528Ab3FJHnu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 03:43:50 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5A7hh4x005140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 09:43:45 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5A7hilK009128;
	Mon, 10 Jun 2013 09:43:44 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5A7hiQo019054;
	Mon, 10 Jun 2013 09:43:44 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5A7hiNG019053;
	Mon, 10 Jun 2013 09:43:44 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <CALkWK0mqVCfrPgSLi1dnDv26YAyRrJJD_S179VYfEApmGkd4Uw@mail.gmail.com>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 09:43:46 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227251>

Once again, thanks a lot your feedback, we appreciate it a lot!
Le 2013-06-08 15:51, Ramkumar Ramachandra a =C3=A9crit=C2=A0:
> Mathieu Lienard--Mayor wrote:
>> @@ -170,30 +175,47 @@ static int check_local_mod(unsigned char=20
>> *head, int index_only)
>>                  * "intent to add" entry.
>>                  */
>>                 if (local_changes && staged_changes) {
>> -                       if (!index_only || !(ce->ce_flags &=20
>> CE_INTENT_TO_ADD))
>> -                               errs =3D error(_("'%s' has staged=20
>> content different "
>> -                                            "from both the file and=
=20
>> the HEAD\n"
>> -                                            "(use -f to force=20
>> removal)"), name);
>> +                       if (!index_only || !(ce->ce_flags &=20
>> CE_INTENT_TO_ADD)) {
>> +                               strbuf_addstr(&files_staged, "\n    =
=20
>>   ");
>
> Ouch.  Wouldn't a string-list be more appropriate for this kind of=20
> thing?
Matthieu Moy told me string-list would be better aswell, so we're gonna=
=20
change it.

--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
