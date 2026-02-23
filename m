Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51B378D94
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882725; cv=none; b=utTYXZkg2RCn4LZzjARa9M7NW+6Q+0NkFmPz9eWydPSku/N9oNwUN0IVWKYQY6vF6X4IQ6x+ZKUXixfLlA0U/cll7JBEKxsykfEs7XGnCt4co7fsaX/SGX4SSUgZNxhj2AcHzzic4JlNguZRS2VBnI0RlanxNBc7bw2YYOZkx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882725; c=relaxed/simple;
	bh=/x+jvJFdBSss8NvML0660N8uymd3oLxq7xXBNphXIXQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=eoQ0Xd3MlcAeEB+HCfOGcw/POTkFzUq2qz7FMs+L7NPAmsZsZ/45wX2F3NkIvDo9ttmNtWtdRiNksMLsuKm0iozN9gqYwSwjKvPS+tgj60p++Y7BIJeRAXWib4F0LbIY35bQYKaQBRXtvj4MhYaZnzGY0eoU2XEeQeZ2C2HWA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Meck6mGb; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Meck6mGb"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad46a44easo4565353d50.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 13:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771882723; x=1772487523; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMoDJyS8qxGl6wx3Or6kxQVfGwp9AJFqciaWS26lRjk=;
        b=Meck6mGbvPDzv5MVJmVvfIr3aitlo7vL99qo/APoZH+4EfD61ziZPyi40LOtyHQzRw
         6GHOQMz0nt3OlQTGh6ryl7mJsQf1nnO4ebIHmimwAv1QYTnUpV4z/PWMrhV0NH5NM0I9
         B10wN9G1Eip8sd2GCIh/98y1+8LpHiuaPGd3djHk+DYVWsjJi5iryqCSfvJmiqGhf+OL
         /ITQxQEEa69hmwf+ZXBkmtfyzdYwjtKgK6XOboa9q3AISJ3/ZrgyBmDvPxoftGr+Jmda
         /B2yVsag4iJqKfuIlhI4OOiju57lHmnGO9336nVuLp/BVvZgRIQ1f5LaFiyOu6QJ+iF9
         uoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771882723; x=1772487523;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZMoDJyS8qxGl6wx3Or6kxQVfGwp9AJFqciaWS26lRjk=;
        b=pV/IMgLOjsCqy+lIUd4alrnVsUGVgOYP6XUZIx5YdzwCk5w6wg0JtKdZ+LtByhmRia
         HWq9/Pe0ytTn6NXz9mVNBuuCZpjlzELBuNY65RKBgsI0LsXI//roAS22QSh552/ip88Y
         073JQg16qztX2U5fIp62L3EkHQw/wYN9lwO3CCaQ0mULrHRw5LZc1oA7ePpDqiuk8uT9
         1ibvIcNd+7FoeTXz5ngCm5v8t4BPE2/+XR/+gPhIHoGjTVSHrObrC1btU+M5hM2ruGVI
         /Jlp2Cd+Zur/wOpBIf/8qgJI7JOU59Vv4VKElIlvAK5JtAJMW84iCmwtMq15CwY94xDK
         c3XA==
X-Gm-Message-State: AOJu0YyAkbuP7APwLjCF/DWbNFh2UGrGgaW44NCLelP2/YmF9PKB+cSr
	mlJt/9MpnRIrT2d3V+JG1VOOsnu1TGwsVVhpmJtY3xMJUKrwZKmzCwilT1LpxA==
X-Gm-Gg: ATEYQzxSrhjifV//2blf/NL3PtlqfFhnxVRZ9z4OMiudVqwItQ/h5bmVfjbijYRj6l2
	tuDd2mYtRV4I6ShSAegbr0E0v5NbSm7nAz1rwmq4fZe4McbnKouAzEg6OmxHyREpt9Nfao7/tJ2
	+zSYHma2w8q5UnTm6H/ApsXtr3dhRmVsejHUkYO9DvV6ynwPfGRdza+a6jtnSlNbvpq4T5n0qkZ
	ITJCRgal1B7jhbi7zacAcpF25+UgE5dh2EUAy9x0L8+1JSDvOEirD8NJdOHbR2Mcu573hi3Qppx
	b6F74tglUP6F/h9fCB2+NLAYcdEjg4UHPPWji1GFo3RRZ4zDiR2nnozRwAywNuFu9GruPsQNhED
	1jL3L9xolWqXEyb90IJtX1+D/1sVr6ohYrrZdI+5sG012DJ26BLuzYtDLEzmxeD6xMTnvliLSbZ
	35WGF2ZzXFyAPJWQvZzPFAl/g0iNtqx9nteqXp/51B8aWjmEhj/0rXYdjf0m+ad07vxOv2YZbPe
	cBdSsxFLXwTNKw4hKfFFklpm3XW4k+HXYR8kelR
X-Received: by 2002:a05:690e:144a:b0:64a:dbe3:fab7 with SMTP id 956f58d0204a3-64c787d422cmr8180265d50.8.1771882722587;
        Mon, 23 Feb 2026 13:38:42 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:c890:ad73:1b25:1a30])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a39b308sm3634392d50.21.2026.02.23.13.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 13:38:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] send-email: UTF-8 encoding in subject line
Date: Mon, 23 Feb 2026 16:38:31 -0500
Message-Id: <43DCEEB9-33C4-4EE2-9FF3-49DCB9B837E0@gmail.com>
References: <20260222155559.1777883-1-shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
In-Reply-To: <20260222155559.1777883-1-shreyanshpaliwalcmsmn@gmail.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 22 f=C3=A9vr. 2026 =C3=A0 10:56, Shreyansh Paliwal <shreyanshpaliwalcms=
mn@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BF
>>=20
>>> On Sun, Feb 22, 2026 at 9:07=E2=80=AFAM Shreyansh Paliwal
>>> <shreyanshpaliwalcmsmn@gmail.com> wrote:
>>>=20
>>>>> That makes sense, I tried it below.
>>>>> I also wondered whether, in addition to this, it might be helpful to w=
arn on
>>>>> an invalid charset, and/or possibly fall back to UTF-8.
>>>>=20
>>>> Agreed on the first half of the statement, if we have an easy and
>>>> portable way to tell if a given random string names a valid charset.
>>>> I do not recommend to "fall back" to anything, if we are asking an
>>>> input from the user.
>>>=20
>>> Following up on this, I tried adding a warning when the provided charset=

>>> does not appear to be valid. Current flow is,
>>>=20
>>>  Which 8bit encoding should I declare [UTF-8]? y
>>>  Are you sure you want to use <y> [y/N]? y
>>>=20
>>> With the additional check, it becomes,
>>>=20
>>>  Which 8bit encoding should I declare [default: UTF-8]? y
>>>  warning: 'y' does not appear to be a valid charset name.
>>>  Are you sure you want to use <y> [y/N]?
>>>=20
>>> This uses find_encoding() from Perl=E2=80=99s Encode module to detect an=
y
>>> unrecognized charset names.
>>>=20
>>> Let me know what you think.
>>> Also, is there any new test that should be added for this change?
>>>=20
>>> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
>>> ---
>>> git-send-email.perl | 23 ++++++++++++++++++++---
>>> 1 file changed, 20 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/git-send-email.perl b/git-send-email.perl
>>> index cd4b316ddc..e62fa259ba 100755
>>> --- a/git-send-email.perl
>>> +++ b/git-send-email.perl
>>> @@ -23,6 +23,7 @@
>>> use Git::LoadCPAN::Error qw(:try);
>>> use Git;
>>> use Git::I18N;
>>> +use Encode qw(find_encoding);
>>>=20
>>> Getopt::Long::Configure qw/ pass_through /;
>>>=20
>>> @@ -1044,9 +1045,25 @@ sub file_declares_8bit_cte {
>>>        foreach my $f (sort keys %broken_encoding) {
>>>                print "    $f\n";
>>>        }
>>> -       $auto_8bit_encoding =3D ask(__("Which 8bit encoding should I dec=
lare [UTF-8]? "),
>>> -                                 valid_re =3D> qr/.{4}/, confirm_only =3D=
> 1,
>>> -                                 default =3D> "UTF-8");
>>> +       while (1) {
>>> +               my $encoding =3D ask(__("Which 8bit encoding should I de=
clare [default: UTF-8]? "),
>>> +                       valid_re =3D> qr/^\S+$/,
>>> +                       default  =3D> "UTF-8");
>>=20
>> Here we change things, right?
>>=20
>> - The original validation is "at least 4 characters", the new
>> validation is "at least one non-blank." I'm not sure why we'd prefer
>> one or the other, frankly. The original goes to 852a15d748
>> (send-email: ask confirmation if given encoding name is very short,
>> 2015-02-13), which is motivated by the same problem we're discussing
>> here!
>=20
> I see.
> My understanding of the earlier change (852a15d748) is that the
> length check was intended as a heuristic check to catch obviously invalid
> inputs like "y" and trigger an extra confirmation based on the fact that
> charset names would be at least 4 letters.
>=20
> With the additional find_encoding() check, the validation becomes semantic=

> rather than length-based, recognized charset names are accepted directly,
> while unrecognized ones trigger a warning and still require explicit
> confirmation. The relaxed regex (at least one non-blank) is only meant to
> ensure we receive some non-empty input before passing it to find_encoding(=
).
>=20
>> - We get rid of confirm_only, since we're about to roll our own
>> confirmation below:
>>=20
>>> +               next unless defined $encoding;
>>> +               if (find_encoding($encoding)) {
>>> +                       $auto_8bit_encoding =3D $encoding;
>>> +                       last;
>>> +               }
>>> +               printf STDERR __("warning: '%s' does not appear to be a v=
alid charset name.\n"), $encoding;
>>> +               my $yesno =3D ask(
>>> +                       sprintf(__("Are you sure you want to use <%s> [y=
/N]? "), $encoding),
>>> +                       valid_re =3D> qr/^(?:y|n)/i,
>>> +                       default  =3D> 'n');
>>=20
>> =E2=80=A6which might want refactored a bit so it can stay close to the or=
iginal? idk.
>>=20
>=20
> Actually the flow needed to change slightly to insert the validity warning=

> before the final confirmation step. Since ask() handles confirmation inter=
nally
> using confrim_only and is used in multiple places, it seemed simpler to ke=
ep the
> additional confirmation local here rather than modifying ask() itself.
>=20
> Let me know what you think.
>=20
> Best,
> Shreyansh

Ah, my mistake for being ambiguous. I meant:

The code is similar enough to the original that perhaps a helper can be intr=
oduced, or at least we should keep the equivalent strings together to help t=
hose who change one.=20=
