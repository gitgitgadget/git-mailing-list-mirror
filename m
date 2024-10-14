Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A4153BF8
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 19:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933576; cv=none; b=oXfH3TrBRTrPAEKO1/IX14mZx4hTPu+k9FULcnxboWjDaeydeRloyIAnvOgYCscFUItNXqHGkIt6aSZASiDQjgol9aM6DoCDFD6MTLKVGRDUuSMx4f/ZlTnLMbFwkw97+sfqWCP05mjo03lrGsJmL4J1VzUV2PBU9O/nD+p2k3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933576; c=relaxed/simple;
	bh=S46dSp1M1fdtE29FB1EbXgSyATErwEkmyS3H2TMouqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzfXmIunuiaoxv6vNSOvmtRRHtvKkDOGQb1qIkMms6xQ6QPfShm19gsua/NNGr09lPYraj05gsM6779yWIOCMZ/acBqXIl72Bn1KrKI3x6BIDpSGt8gTqmJU7sCDAVDxKut5c11zul3r4n8ZCHWIyCFHSnkO2FE5KouURNaxVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIflPYfR; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIflPYfR"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbd12b38b4so38945946d6.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728933573; x=1729538373; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rerBvSuTb3c9yU809ZdkS+sVe3qiREmSgehIV0MgYZs=;
        b=jIflPYfR9i8FnJcPvGXwO+IdMnb7MsAp7y/LH2c/PH0/6ZgkC0v2mVjXG62WIu/Fgj
         83MD1mPY/BuaQjirWQ5HWEBsoLOf4XggyqPoH1FuAyblfj2dzafDCXx/zjhidKscfUJe
         +mYlUSYCO9vLR2vidrwfcNW+0hOtVNQpCGsyJwLnubju/7577iHb+r6VE6aKBp39/mgh
         1LmtBi1SDfuHp7hYsi47+y8IW81ct5sYAZZsSrgdTQTLC0aDkh8rF1AqETa5Qb3+HwRv
         JgNBFXC93AuqIVj7Sw1OQ6+jmKdLwBP1v9bC3mo6ykceAW/EXrD0juYo3LSEoRbFWvuy
         wAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728933573; x=1729538373;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rerBvSuTb3c9yU809ZdkS+sVe3qiREmSgehIV0MgYZs=;
        b=LPCnGC91kwq4yKRcLXt7eHzvJ+DndMch7XisISM8ctklA5DHuNJHU+bGdm/T6vkdyf
         jvuujvZ/npVWuYR1GlWCTTf8ka+ziMRGReuYBz8KJVltJY7ts2wXx7H/UJjIA4CCczvk
         lbZhxSVRcZG3NNZv7tIU6vPGs5lgxiCzkVzhp3z/16YgEiBpF5cGkZKmNUw9gGJMu6T2
         VZ/U09GCD3+5S/7+G8DF6CBXnUdHA++OVr9rM+JERamjsIO2Ajy9g0VrmvDrJN00NVo7
         wxEuD7O+5zBYJZgZekY/RW7ETd619gRLq0eeuTR7em//h1pr7pyW0b6rHT7dFY+Owkaq
         vrSg==
X-Gm-Message-State: AOJu0YyOpbmr7RJlbU6fNKI3WUJV90ArUbfb3EOise3g81m/t4zS5Bsl
	qO7U0T+SYaim2/E88lOrHhw7nWd8rJ7rjMlfAC0D/XYrcIUv2a2PnalK5Q==
X-Google-Smtp-Source: AGHT+IFAhxPfeIi5opG40O1YPJ80FCXDdvZOilPA9pFut5ScF/1Dr1kqD6NUFfqMwH2YNga2D7lcTA==
X-Received: by 2002:a0c:f209:0:b0:6c5:297c:da5f with SMTP id 6a1803df08f44-6cbf000bfa9mr200402036d6.33.1728933573438;
        Mon, 14 Oct 2024 12:19:33 -0700 (PDT)
Received: from ?IPV6:2603:6011:3f0:6f00::12ac? ([2603:6011:3f0:6f00::12ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe86322a7sm48617476d6.116.2024.10.14.12.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 12:19:32 -0700 (PDT)
Message-ID: <cd118725-f820-494c-8d10-81aba32e4064@gmail.com>
Date: Mon, 14 Oct 2024 15:19:31 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Modernize the build system v2 problem
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>
References: <28e13e74-d4a4-4be5-8555-27a69c5c5787@ramsayjones.plus.com>
Content-Language: en-US
From: Eli Schwartz <eschwartz93@gmail.com>
Autocrypt: addr=eschwartz93@gmail.com; keydata=
 xsFNBFcpfj0BEADkTcFAwHJmtXbR7WHu6qJ3c83ccZl4qjBsU//JEn9yTtfj8M2a3g+lpGAF
 C/8isGz9InmrqBn1BXQFwcySAkRYuromR5ZPH1HIsv21RTtJbo5wCs8GlvoRYsp5pE7JEIVC
 RsWixG5pFhinlssUxtm0szlrzfaKanohWDfj+2WuWh4doXJZtTQePCGpouSziButkwkgQMqE
 U+ubBiTtjF/f/oCyC6YMWx+5knaqNSWxjF52rXAngVD0YYAiJ7o0KOQhrC2RLF+l0x4hRikp
 QaZrqVL1CaP7gjceOlOZ/zdCOImAaha9ygZiJG652HCIPfsy7uypYwxoMEeldoTnsXbjJXuL
 fMwIp8dCVbKMhebXdCNIWCjNewusz3I4+JjOO+uPgA+YgHu8+A56tpJ7lmHw5C95XjheXt/N
 bo9HONG4oeILZ9pQxnx93ocZM6v0W+taoBbPzOLE0al7Oy5vmJwO/QkprDU/TkzPtrgiCKPV
 Ml/+smp5FXbOjp/Y5UVlFmj2aemDIVAv70RlewAytwQLdGHLv3Au81hq5xrX7JAopEkfhYJY
 g2+7s78C0VaMPXHw2XyLpj5uPBR2q8KihSaASfhGBH0IcxLd+lEq1+NHT2l/WlQVjRfXHZns
 k8giW8M12TJZvvm9rpXMAFk7zSmmojp1M/7+ImOTcDYvErW1iQARAQABzSRFbGkgU2Nod2Fy
 dHogPGVzY2h3YXJ0ejkzQGdtYWlsLmNvbT7CwZQEEwEKAD4CGwMFCwkIBwMFFQoJCAsFFgID
 AQACHgECF4AWIQS9J7B6XvRcKtr3DgSEgYpoGa9KmwUCYstIWwUJEUVkngAKCRCEgYpoGa9K
 m50AEACoEoXaBaVerjTGbezOHK8J+GWkDJQ8wetJJfHhBgDq/lypKF+1LmolXAkmJF29ShBx
 r9zr5n91E1xn4bX53X8NdVAf2r/dFMtzlu0jsl0UcZ6OllpkTBtWqbjNgAI+C/v/lbBVcCz+
 irtrRfM/guLNaaUuZlh+Qtt4kdKygP64jhqRude/eD0tAVzXbnka0k2E40dNT8W23SPnbjJh
 gpZeGeufIf8xFddDdLaqZMuxjDcxqq1jcasPB8M57Vkt5NpTaIvCtO4ZWejoj9im+Onsdvfs
 3mCHr1DcIEAYj36/2U8yXzpsdgFXD96WcLFRL3l4ELTAPua3MFNdty6Bf35Yli1Fby4yOnf8
 5UQd4SRh1pYqBoBw7uEtY8qOJR+bvqo2XnTrR9HVYBZVrVhFe/CCSxOfm2ZxZn2bzMzoJZ5X
 jcMNGdkHVcutvgJOIUASnwSoJM4hoVdwRmGgrT1Mu18rkk05+NjElPmGcn9vFZXVddnqvuqd
 gf4di2xl0adpWgFFSfKeOBjNcPSQqNLjNcJTGVJ0lvlmGcYfyw020IoGu/bBEUpQA12i/4JE
 N5Qx1frWsvXQ+ioJkFsjydbpWqLR5xI44p1FWU2lwKT4QbtSkgx9sHOec+DIIarwxqDiMXR9
 ZhG/Ue7+pXAVD/Zs/XtxXCZQBhl7keIXTmZKTccuYM7BTQRXKX49ARAAo1bWz1d7RvffuaX9
 SAOqQEfeEHaRilIKpqU5+yuBSd7vLNF1QPb105cuMJtj0bHhQnqYlToNODAHn9Ug+Axgz3dT
 +s8j1/mizFLfgpHnWdNr7/a1lMPhmPqtoeEdUAd0bqX94xHedZBtlvhLAwoelNhatJkqbrWc
 voI9d3RMLA3tPrTxY6aeDTa+5LL8oHeZ04KXlWxQIqxXT+e0JEs+0V9viicYy/8i4DqfObtr
 jdNOV3cKCW3rmNTATlVmciGY8xHkwM77C67ibFyYOdoYo6IP7EUI1oTBZN1M2A23sSgUlAHP
 qPFwD38JPiBLYu5pIA3SwDaatTD/+BEdhsiIQsZaWsn0E98Bb0bHfukMvEYFEcwA//HXTVIN
 SGry/Tc9baIgD0hG8ImDCbR9RfXdz0uzelHypcKGnGB7FLtZ8Vw4swa06CXEGG0Oo5AfYRuU
 2bQtFxH66xHEFSfgfpTy5nHTH9Ra1mTtpoDil6rMLq1q43w5XP7oEucZwdZa+hlj2M4I/i+I
 gcaU+Bd9bQMa2mmvmI7pOFMxCCvprY5fDaRY1v8rKWRg12bD4kYM3npR37rWkk+Zdj+w+XgS
 oCW0gNT2yHDDMq7H6qYUjyvaG8l0vhWb44rzQLBFfQv/Lc3QI4jUu6e7TbQui3cw5Qn0E+yu
 4teV2fIVDbLB8wvRS/8AEQEAAcLBfAQYAQoAJgIbDBYhBL0nsHpe9Fwq2vcOBISBimgZr0qb
 BQJiy0j1BQkRRWU4AAoJEISBimgZr0qbjUwQAL+qByV+VpVmD3Guqym9uUX/gUmLdLar7ZrM
 Nr3RnDo/N0Dl2IZpm+eoNGlnBh2+q6bcZUWWoEtbOoy6XrlPnx3Cf+Bg4bFDNN4ibIQkYV2z
 cU9E1AWadCKUm1Z2eDqjc5TlLZiyUGQUh4kAW2Z3gFe1ffhyKarVExfTSxwE1ec5Q9cy6T29
 iO3QjAD3v7R9EXZJIn/RRbsaWQSQLz+DVDZxjy2XcmTGLS3HMIqdYFHYAxUx7HLbCAhfIyD0
 TDsMOutl3B2PWENYWmhO6E+USSwPokx461ePqcYG5haqnoUcXGQ2SGtLaoQ2iKGvGAe17xpQ
 yHK7NGSPWOEmYSJ1bRFJYKoe8+jtesoEY335hyQRn7RbMvTslVUvtVjRYu4FXOwPXT3NLbj8
 v+in+Njm1UfuWvOZS695wepBGvDtMM3Ze+ZRB3S7zmo1/eKol1cQQ/abYlX+7TrUbxcQ+bAQ
 b8PeDaL4sAH77fE6m+3jsMb1CFbN3+LcaUxGV7ysh7kVYVqwhiRqnmF0E3I9z3nyZ9HQgwHt
 1jmoa4lMiRDnkkOFdhoJ3vqmxHKW9XtxrUJlLQfTejUSooLFjNe6tvXgrTvrosGTpDZIIT0/
 8qKt4Nxg06u0jmnXMbbWwoPNWl9PfcPtNhjaycocCzfog5LI8N7HbRy+jHmArWAywaZVLrLe
In-Reply-To: <28e13e74-d4a4-4be5-8555-27a69c5c5787@ramsayjones.plus.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------va9kCQENqjPUGA0OM50xkgbp"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------va9kCQENqjPUGA0OM50xkgbp
Content-Type: multipart/mixed; boundary="------------FeJ02WfVFsFdRl8SGvemAqD3";
 protected-headers="v1"
From: Eli Schwartz <eschwartz93@gmail.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>
Message-ID: <cd118725-f820-494c-8d10-81aba32e4064@gmail.com>
Subject: Re: Modernize the build system v2 problem
References: <28e13e74-d4a4-4be5-8555-27a69c5c5787@ramsayjones.plus.com>
In-Reply-To: <28e13e74-d4a4-4be5-8555-27a69c5c5787@ramsayjones.plus.com>

--------------FeJ02WfVFsFdRl8SGvemAqD3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/14/24 12:59 PM, Ramsay Jones wrote:
> Everything seemed to go without a hitch after that, as far as the build=
 is
> concerned, but when I did a 'ninja test' I ended up with three failures=
:
>=20
>   Summary of Failures:
>  =20
>    979/1028 t9500-gitweb-standalone-no-errors              FAIL        =
   12.36s   exit status 1
>    980/1028 t9501-gitweb-standalone-http-status            FAIL        =
    2.19s   exit status 1
>    981/1028 t9502-gitweb-standalone-parse-output           FAIL        =
    2.22s   exit status 1
>  =20
>   Ok:                 1025
>   Expected Fail:      0  =20
>   Fail:               3  =20
>   Unexpected Pass:    0  =20
>   Skipped:            0  =20
>   Timeout:            0  =20
>  =20
>   Full log written to /home/ramsay/git/build/meson-logs/testlog.txt
>   FAILED: meson-internal__test=20
>   /usr/bin/meson test --no-rebuild --print-errorlogs
>   ninja: build stopped: subcommand failed.
>=20
> The failure is caused by an (apparently) mangled 'gitweb.cgi' file. Sin=
ce I
> still had the make build file, I could directly compare the files:
>=20
>   $ diff ../gitweb/gitweb.cgi gitweb/gitweb.cgi | wc -l
>   160
>   $=20
>=20
> I won't bore you with the whole diff, but it begins like so:
>=20
>   $ diff ../gitweb/gitweb.cgi gitweb/gitweb.cgi
>   83c83
>   < our $GIT =3D "/home/ramsay/bin/git";
>   ---
>   > our $GIT =3D "/usr/local/bin/git";
>   91c91
>   < our $project_maxdepth =3D 2007;
>   ---
>   > our $project_maxdepth =3D "2007";
>   2497c2497
>   < 		{ regexp =3D> qr/^\@\@{$num_sign} /, class =3D> "chunk_header"},
>   ---
>   > 		{ regexp =3D> qr/^@@{$num_sign} /, class =3D> "chunk_header"},
>   2521c2521
>   < 		$line =3D~ m/^\@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) \@{2=
}(.*)$/;
>   ---
>   > 		$line =3D~ m/^@{2} (-(\d+)(?:,(\d+))?) (\+(\d+)(?:,(\d+))?) @{2}(=
=2E*)$/;
>=20
>   ...
>=20
>   $=20
>=20
> Note that, after the 'template variables' have been substituted, many (=
all?)
> character pairs \@ are replaced with @ (ie the backslashes have gone wa=
lkabout).
> This results in compilation errors in the 'gitweb.log' file, for exampl=
e the
> log file for the t9500-*.sh test, looks like:
>=20
>   $ cat gitweb.log
>   [Mon Oct 14 15:12:33 2024] gitweb.cgi: Possible unintended interpolat=
ion of @2 in string at /home/ramsay/git/build/gitweb/gitweb.cgi line 2521=
=2E
>   [Mon Oct 14 15:12:33 2024] gitweb.cgi: Possible unintended interpolat=
ion of @3 in string at /home/ramsay/git/build/gitweb/gitweb.cgi line 2593=
=2E
>   [Mon Oct 14 15:12:33 2024] gitweb.cgi: Possible unintended interpolat=
ion of @vrfy in string at /home/ramsay/git/build/gitweb/gitweb.cgi line 4=
212.
>   [Mon Oct 14 15:12:33 2024] gitweb.cgi: Global symbol "@vrfy" requires=
 explicit package name (did you forget to declare "my @vrfy"?) at /home/r=
amsay/git/build/gitweb/gitweb.cgi line 4212.
>   [Mon Oct 14 15:12:33 2024] gitweb.cgi: Execution of /home/ramsay/git/=
build/gitweb/gitweb.cgi aborted due to compilation errors.
>   $=20
> =20
> So, keeping in mind that I know absolutely nothing about meson, it seem=
s that
> the 'configure_file' function is mangling the 'gitweb.perl' file. I ass=
ume
> that you are not seeing this, so I suspect that you are using a newer (=
fixed)
> version than me. :(
>=20
>   $ meson --version
>   1.3.2
>   $ ninja --version
>   1.11.1
>   $=20


I recognize this: https://github.com/mesonbuild/meson/pull/13302

Note that for files which can change semi-regularly as part of
development it may be better to avoid configure_file() and create
something like edit-files.sh.in which then produces build rules, not
configure-time changes. This would sidestep the problem entirely as
you'd then process gitweb.cgi via e.g. a sed script.

(The main reason though is because it avoids reconfiguring meson when
the gitweb.cgi script is modified via a patch / git pull.)


--=20
Eli Schwartz

--------------FeJ02WfVFsFdRl8SGvemAqD3--

--------------va9kCQENqjPUGA0OM50xkgbp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmcNbsRfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDYw
NDExMzA0QzA5RDM2NjI4MzQwRUVGRkNFQjE2N0VGQjU3MjJCRDYACgkQzrFn77Vy
K9ZNlQ//bRwJu01Crja4QfX5MltACIHrCZS9gIWWfeIH/2dS4VaS6tiRxw51b7Lu
b8nS/7U0tvxJfpNmtSNvWWivVd/fpSCzAUH5r//5L19gb5QD0YFwJvU6Qi+iP1s1
TjtOD7obPmPyZNastkMC+J2Nl7ORZLT6+jDV6GGMgGnbEIj50E8OHvM0uEPBv3fL
wpIy+7sMYxgN3Olcn+z9YiMlg0dqq84RdPwUTxvdBLJbDFlLGIwWkmxSU2bg2uUR
OSkE/7bBndz9mOXy56+6zjEuDQilqvnQAFU3RjNBNGnwEIGXMCMywZa5huKuwc3A
7KeZgFHJiVp3RUMFSeUD/cMOFCdWf+0N5TZOSVj+yjB3TTCUjW6Mi5gAUUbLWPcr
slsEcvEoa+y6qrqjHCwYQQF0kV1Hd3xud95yq1RtGN/c1fcCPDAejvPsPV9sc5PH
/8539BfnADsFjhskj2JGnyYYQPujfIrmA1mNA/94nwf2p9QXH1hoYL5nHs2ZTFwN
ojYWILBwlC3z0UHqehzXcDg/9MtMjKPPFz8oavr9L87+2LVSNhYUC6ilNhlxyiPt
TWQIq0S58Fk+Ocyn27An6SRFb/lGh9qzP675aQmkHtYiIAFzs57xFLTJ40vV7k3K
r6c9wRf16PkJY1fO3lpEBOtb3XUx3Fy3MWiCs9JUQCoYqqbVuIs=
=OcU9
-----END PGP SIGNATURE-----

--------------va9kCQENqjPUGA0OM50xkgbp--
