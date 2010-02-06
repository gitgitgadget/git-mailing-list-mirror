From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/4] gitweb: show notes in commit(diff) view
Date: Sat, 6 Feb 2010 22:50:43 +0100
Message-ID: <201002062250.43613.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <201002061534.02972.jnareb@gmail.com> <cb7bb73a1002060813l451ad669nf9ba2dc4643bbd58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 22:52:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdsZx-0001Y8-QP
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 22:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab0BFVuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 16:50:46 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:54027 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab0BFVup (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 16:50:45 -0500
Received: by fxm3 with SMTP id 3so5709656fxm.39
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 13:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yBqhic0U+dHlcNPMRTYuh/MEOdtAWjClGdv0eO8sh9w=;
        b=LFSbbs7cVPnnPuYObF7+6f1dzxDe0weauiUn5yiH8gB7t2Xq77C/kRSpk5ZQQw02Xk
         YdyiH6lStSIS5nQNs2XE7Z7loxD5dSg/ynRs7iHOUsNKTESdC6N0UX8kIGsv0t4lWwVh
         Qcgou29aZEjmwlBPrebXEQwq9G18G7364SWBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RNwx5QMGtYWpLAWIQT+3WAMxBVA3HlYGvaDH68TR4Ua5ydqn5Qw/aXAoUTYbnt0IXF
         CjXQjUbvJ6wAyY7m4TPopvFB0hS0Wp9GHaow1a1EOIzlIGLD5Vsen3ZfOVRQeVlnGLOk
         tKT5XHCMIPF+qi0DgwVBGkoOL0rlzQestqCJg=
Received: by 10.223.15.87 with SMTP id j23mr1267805faa.88.1265493043708;
        Sat, 06 Feb 2010 13:50:43 -0800 (PST)
Received: from ?192.168.1.13? (abws80.neoplus.adsl.tpnet.pl [83.8.242.80])
        by mx.google.com with ESMTPS id 18sm4319467fks.34.2010.02.06.13.50.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 13:50:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a1002060813l451ad669nf9ba2dc4643bbd58@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139194>

On Sat, 6 Feb 2010, Giuseppe Bilotta wrote:
> On Sat, Feb 6, 2010 at 3:34 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> Giuseppe Bilotta wrote:
>>> 2010/2/6 Jakub Narebski <jnareb@gmail.com>:
>>>> On Thu, 4 Jan 2010, Giuseppe Bilotta wrote:
>>
>> [...]
>>>>> =A0# return all refs matching refs/notes/<globspecs> where the gl=
obspecs
>>>>> =A0# are taken from the notes feature content.
>>>>> =A0sub get_note_refs {
>>>>> + =A0 =A0 local $/ =3D "";
>>>>> +
>>>>
>>>> Why it is needed here? =A0Why you want to use empty lines as termi=
nator
>>>> (which means reading whole paragraphs), while treating two or more
>>>> consecutive empty lines as a single empty line (according to
>>>> perlvar(1))?
>>>>
>>>> If you want to slurp whole file, this should be
>>>>
>>>> =A0 =A0 =A0 =A0local $/;
>>>>
>>>> or more explicit
>>>>
>>>> =A0 =A0 =A0 =A0local $/ =3D undef;
>>>
>>> Ah, sorry, for some reason I thought "" was the default.
>>
>> If you wanted to use default value, why set it at all?
>=20
> Ach, sorry, forgot to reply to the first part of the question. It's
> used in a context where $/ is locally set to \0, so it needs to be
> reset.

Oh, so it should be something like the following, then?

   sub get_note_refs {
  +	# reset to default value (can be called with $/ set to "\0")
  +	local $/ =3D "\n"; # line by line

>=20
> --=20
> Giuseppe "Oblomov" Bilotta
>=20

--=20
Jakub Narebski
Poland
