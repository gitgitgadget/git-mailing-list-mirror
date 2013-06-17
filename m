From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently  processed
Date: Mon, 17 Jun 2013 15:33:32 +0200
Message-ID: <c878cf98bff28ea8b72fb6d33fd9ca85@ensibm.imag.fr>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <alpine.DEB.2.00.1306171357440.7683@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	<git@vger.kernel.org>, <gitster@pobox.com>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Jun 17 15:33:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoZZ8-0006MG-BL
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 15:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272Ab3FQNdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jun 2013 09:33:42 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50949 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119Ab3FQNdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 09:33:39 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5HDXVH9014073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Jun 2013 15:33:31 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5HDXWfL013082;
	Mon, 17 Jun 2013 15:33:32 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5HDXWOd025133;
	Mon, 17 Jun 2013 15:33:32 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5HDXWSG025130;
	Mon, 17 Jun 2013 15:33:32 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <alpine.DEB.2.00.1306171357440.7683@perkele.intern.softwolves.pp.se>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 17 Jun 2013 15:33:31 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228067>

Le 2013-06-17 15:10, Peter Krefting a =C3=A9crit=C2=A0:
> Mathieu Lienard--Mayor:
>
>> +	/*
>> +	 * If the file stopped-sha does not exist
>> +	 * we go back to the old output saying "a commit"
>> +	 * instead of providing the commit's SHA1.
>> +	 */
>> +	if (!stopped_sha) {
>> +		stopped_sha =3D "a commit";
>> +		must_free_stopped_sha =3D 0;
>> +	}
>
> This is missing gettext markers, and besides that, it very difficult
> to handle for translators. Please consider changing the code to use
> different strings based on what you want to insert, i.e.:
>
>> 		if (state->branch)
>> 			status_printf_ln(s, color,
>> -					 _("You are currently splitting a commit while rebasing branch=
=20
>> '%s' on '%s'."),
>> +					 _("Splitting %s while rebasing branch '%s' on '%s'."),
>
>    stopped_sha ? _("Splitting %s while rebasing branch '%s' on=20
> '%s'.")
>                : _("Splitting a commit while rebasing branch '%2$s'=20
> on '%3$s'.")
>
> or something similar.
Actually, at first I dealt with it this way:

status_printf_ln(s, color,
                  _("Splitting %s while rebasing branch '%s' on '%s'.")=
,
		 stopped_sha ? stopped_sha : _("a commit"),
		 ....);

Would this be more suitable for translators ?

--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
