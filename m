Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E596239E9B
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771097; cv=none; b=iyBe7wnlp09BOihySctZGhNp75/z1ICXvHEpaOMMMInW+FtAzDeJHmK66Fs5jtjeqrcAJ3YXqOpwB43wm8VM7R67ok7oB6ys059SZUNJxj/agtyTE50Bo2yn/jbCmXnmsO9nxLWxnnHqV2zOg94cztU8NSUAl4bRqajfvbKpWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771097; c=relaxed/simple;
	bh=CdhomoK3VA4CAV5gva+u017ILpVaqsIJCV53R+r5QQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUmYGOng4/TTDCYnrBC6pCuyPFWhDB21tVBB4pqm/bxWv8OX9OZ+nIcZREu/sgNzokm1GabmRmfLr+HT7plHO4PlTSfM+NOjwp5B+xprdpGT7NtEq1xCPjKsAB57wTYmiEx8ptTjjLwe2MP2qp4VYZTdprnMOq1OHe81aWxeaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ezM/Xxd8; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ezM/Xxd8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759771085; x=1760375885; i=l.s.r@web.de;
	bh=WKLyjGrc42psdo26Jhx7Yyu2iTzODSfDLT0sw0yaisU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ezM/Xxd88aDlcUtElit1V3y4v8fi7I9EY3yspNr7NHTXDPXHw8i138BAz9VscLTk
	 h58rw0y5GpqeOtMMWsx9akHYhJY+a7r+BcbC0CJyvfg9G0Xsg+RnHcW517Slw+9SX
	 Q5HKKx/subvuKZKPbbo5zRL5Fle6+e0MZ63KHJfUOrhfxYjHks8o5l7NXcmitr5pg
	 1sGv+JP1kvrKjwCJmUtjeTMhlMXB5v8qtsbsYmOZaGw+5vE2DB7x/DpltuivSYR2K
	 iZw5VuRy6Sk5erEMVISrM3/tWVMO8s34sK4PtSkBjbXihvf3ViBeZpZWWHmGbApgu
	 hbXdUzl1IlFk/3dyMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.132]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4KJX-1v5XjR43nt-00Ew26; Mon, 06
 Oct 2025 19:18:05 +0200
Message-ID: <0ea56923-2041-43bd-8c35-cc93c3c95c70@web.de>
Date: Mon, 6 Oct 2025 19:18:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] add-patch: let options k and K roll over like j
 and J
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 "Windl, Ulrich" <u.windl@ukr.de>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <17ef29a7-5214-4729-82eb-92a2af33e465@web.de>
 <f99b93d5-3de2-4077-8818-9272e812c289@web.de> <xmqqh5wdrrub.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqh5wdrrub.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HVq8c2EPxxvUdC7XZHhVaSRPrjbf+mo3D82nNGckduseldM3/LZ
 L15wmuPeLobtvXcr5ThsRPnS97XZBdWkWh0mAyvJ+OPhjAUnycwXMLM56ELheFVEaaDuVJV
 N9GvWYZ4w2xOKEDyApwL697vNMltb3X3quIwfl6FRsPcNJNbFCpKe8J4hNriKnCdbLPpJaq
 w+GYsNImU5rnqUtxs1hDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7Xwy7PBHKlM=;nILVCVuH43tQdWf+xxX16Pj4OE4
 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
 1UXpTlaJ0G7RzJepzqv3l9Y7I4=

On 10/5/25 10:55 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> @@ -1584,7 +1591,8 @@ static int patch_update_file(struct add_p_state *=
s,
>>  			}
>>  		} else if (s->answer.buf[0] =3D=3D 'K') {
>>  			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
>> -				hunk_index--;
>> +				hunk_index =3D dec_mod(hunk_index,
>> +						     file_diff->hunk_nr);
>>  			else
>>  				err(s, _("No previous hunk"));
>=20
> I was wondering if we want to always allow J and K; even when you
> have only one hunk, you can still wrap around to come back to the
> current hunk, and that we can do without any extra checking logic.
>=20
> But it is also OK to require 2 or more hunks to "switch" to the
> other hunk, which is what you do with
>=20
> 			if (file_diff->hunk_nr > 1) {
> 				permitted |=3D ALLOW_GOTO_PREVIOUS_HUNK;
> 				strbuf_addstr(&s->buf, ",K");
> 			}
>=20
> to require more than 1.  But the error message "No previous hunk"
> sounds somewhat awkward.  If user accepts the circular nature of how
> we decide what "previous" is, then when we have a single hunk, the
> current hunk itself _is_ the previous hunk, but because we insist
> that there are at least 2, that interpretation would not work.  With
> "wraparound" semantics, "No other hunk(s)", would be a better way to
> give the error, no?  The same comment applies to 'J'.

OK.
>>  		} else if (s->answer.buf[0] =3D=3D 'J') {
>=20
> This makes perfect sense, but then, after this post-context we have this=
:
>=20
> 			if (permitted & ALLOW_GOTO_NEXT_HUNK)
> 				hunk_index++;
> 			else
> 				err(s, _("No next hunk"));
>=20
> and it sticks out that the post-increment of hunk_index here is not
> using inc_mod() for symmetry.

This symmetry _is_ tantalizing.  Had the call originally, removed it
because it was unnecessary and didn't fit the narrative.
> I am wondering if with that updated (I would not say "fixed"), if we
> can lose the "oops we overflowed so let's wrap around" belt-and-suspende=
r
> code at the beginning of the loop, i.e.
>=20
> 	for (;;) {
> 		enum {
> 			ALLOW_GOTO_PREVIOUS_HUNK =3D 1 << 0,
> 			...
> 			ALLOW_EDIT =3D 1 << 6
> 		} permitted =3D 0;
>=20
> 		if (hunk_index >=3D file_diff->hunk_nr)
> 			hunk_index =3D 0;
>=20
> or if there still are other code that rely on this "oops we
> overflowed" adjustment?
Good question, gave me the idea that a and d should roll over as well.

Other than that there's just the so-called soft_increment, which would
need something like this:

diff --git a/add-patch.c b/add-patch.c
index b0389c5d5b..59a9eb586d 100644
=2D-- a/add-patch.c
+++ b/add-patch.c
@@ -1546,8 +1546,7 @@ static int patch_update_file(struct add_p_state *s,
 		if (ch =3D=3D 'y') {
 			hunk->use =3D USE_HUNK;
 soft_increment:
-			hunk_index =3D undecided_next < 0 ?
-				file_diff->hunk_nr : undecided_next;
+			hunk_index =3D undecided_next < 0 ? 0 : undecided_next;
 		} else if (ch =3D=3D 'n') {
 			hunk->use =3D SKIP_HUNK;
 			goto soft_increment;

Or undecided_next could be set to 0 before the if/else cascade, then
this becomes a simple assignment and we can get rid of the goto.

Couldn't find a way to remove the back-to-square-1 check that would be
significantly better overall and thus worth the hassle, though.

Ren=C3=A9

