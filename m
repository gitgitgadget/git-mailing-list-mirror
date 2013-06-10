From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH v3 22/28] git-remote-mediawiki: Modify strings for a better
 coding-style
Date: Mon, 10 Jun 2013 12:48:06 +0200
Message-ID: <51B5AEE6.8010102@ensimag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr> <1370816573-3808-23-git-send-email-celestin.matte@ensimag.fr> <CAPig+cQWQ842-ZG3_JQxZ=-2qLPpijx9z3vtXns+G3xxp6PsyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 12:48:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulze4-0000M2-3a
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 12:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997Ab3FJKsM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 06:48:12 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45470 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843Ab3FJKsL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 06:48:11 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5AAm5ug004775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 12:48:05 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5AAm6h5013010;
	Mon, 10 Jun 2013 12:48:06 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5AAm6jM022547;
	Mon, 10 Jun 2013 12:48:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CAPig+cQWQ842-ZG3_JQxZ=-2qLPpijx9z3vtXns+G3xxp6PsyQ@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 12:48:06 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227270>

Le 10/06/2013 02:50, Eric Sunshine a =E9crit :
> Given this patch's intention to use ${} within strings, should this b=
e
> ${credential{username}}?
>=20
> (I don't have a preference, but it's a genuine question since it's no=
t
> clear if this was an oversight or intentional.)

The answer is simple: I didn't know the exact syntax, so I didn't bothe=
r
doing it.


> The whitespace-only change to line "my $res =3D do {" is effectively
> noise. The reviewer has to stop and puzzle out what changed on the
> line before continuing with review of the remaining _real_ changes. I=
t
> is a good idea to avoid noise changes if possible.
>=20
> In this particular case, it's easy to avoid the noise since the
> trailing space on that line could/should have been removed in patch
> 18/28 when the statement was split over multiple lines.

Actually, I noticed this but didn't find what the difference between th=
e
two lines was. I assumed git was making some kind of mistake - but eh,
it seems git is never wrong :)

>>                 local $/ =3D undef;
>>                 <$git>
>>         };
>> @@ -475,26 +475,26 @@ sub download_mw_mediafile {
>>                 return $response->decoded_content;
>>         } else {
>>                 print STDERR "Error downloading mediafile from :\n";
>> -               print STDERR "URL: $download_url\n";
>> -               print STDERR "Server response: " . $response->code .=
 " " . $response->message . "\n";
>> +               print STDERR "URL: ${download_url}\n";
>> +               print STDERR 'Server response: ' . $response->code .=
 q{ } . $response->message . "\n";
>=20
> To meet the goals of this patch, would you want to do this instead?
>=20
>     "Server response: @{[$response->code]} @{[$response->message]}\n"=
;
>=20
> Whether this is easier or more difficult to read is a matter of
> opinion. (Again, this is a genuine question rather than a show of
> preference on my part.)

Same as above, I tried to change it but didn't know the exact syntax, s=
o
I gave up.


--=20
C=E9lestin Matte
