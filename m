Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6212136351
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789840863; cv=pass; b=b9Wyq3ZmFVyvtzbs1TFMM7stIvYmM6lh25f2sCkm9FCPhs5a0eBdaIz7Xl+t6Z1KJBtyAYhc4HJN4c1XfF12cXex7U1YRwjGcHlxHS3lvGfiKd7c+4ytHLW6GY5UOav8KMWJ3ubKdEQD04eP6Gr6lw3T1ZmbGLagt3iyH1mRZdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789840863; c=relaxed/simple;
	bh=FQyVj/W5ZJbXDcEgmzjPNzGYb0dOcHWWluLcr/urHTA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=gs8XhetiPupK0wKUhRqWbPSAXzjt9iTv9ELXZyDPnMXo9WvMHxr1XW16KzVHlGDMDf+rf59lExhhkI8+wdqfIgwS3VzZ9oGsJEZw26ojlXWetqECWgtiuuKj61bJPZ5c71y7kMVa0WZDU+rROYYHlS6vKgE9po3g8cJKSDT5kiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pzk9eLTb; arc=pass smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzk9eLTb"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-785692e5907so1087317137.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 11:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789840860; cv=none;
        d=google.com; s=arc-20260327;
        b=ekuUSXc+HjmmSUCrTF3YX2OFnM2pdic0INyvq2B2nQNO7TH8OvOr4YYnMTAwyxN9Qb
         Ll9pKe9th+FV2r9r6pxo/RFHPmIzqAjE1nGOB5Zw2GngbOA9iZk1FNkqC9wseDeO6vTq
         LLOdh5+SPVGv49VNE5pMt9QuxDjbJWJmCvXmppRzmrkALGik1XbKNw0HyDYt+JDW27Eg
         ZlH8mpJK0p40zSl67wl0heYddOIEgwsf5ftrwLztO3BFzcoTEg+kohST1eq9z7uibclc
         wf+bXbP5DXfvAddd1LOapPwn8s66wAxEOOoh/H3xzfYm2r1YtbmNP/K20FRNDkuYt+tC
         X6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=zX6Pv1T7TGZpgi7DW5RhMCxEUIj0XP96/BVdkssFGYY=;
        fh=wj4Ny/rtIjbS9xB65gsKN+rIJROAZrpIvhTRLU98HGk=;
        b=fSyoJF0RV7Wez7C2P2or/NbByJGHO/QJdnXKLmUIHIZjFM/ftpQd8nGMcAJYaiSxwP
         Wq0+s3UhXQO/C5q7L02FUczzCleRkkkpiNmm2FtllNK038dv5GDeoNORWiJyv3ZXv0Y+
         ZrqqYftaXk6U2o3l/02lT1BNk1kTY9I2/DSXzlXe6GgP1L3dfqG/zpjDH4xS4GOPAp1D
         YbKvBpvRutZEmBez2X3C0rQjF96aciL38jYYd4Aat/Z1vIB5/HeNf2kJQcVAh5Hx381Q
         nE6u1tLenJtMppegsf/urD5260ErpkxgOB8GhgC+e0PPzNAZpZl5O4+QfJbzgldnhkQi
         mpvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789840860; x=1790445660; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zX6Pv1T7TGZpgi7DW5RhMCxEUIj0XP96/BVdkssFGYY=;
        b=pzk9eLTbZA4XtdrWm0tlNqCJ6vfaI98F5p7JGlRlVL5ybj2bobStwZ54v3bviDtNO/
         604e2FlMciT7sDbwaFBUaXJ+19bNKABr8tpIczkLx4edLwlZ/fwvBEXldIJH8g7kgnZd
         Tuf8Juw/WFtsuUFBIc2AP2xxAW50xzMq38PXg5Z1MKvh6SFggC9I/LtYv3ul5liIYUEX
         FtK9gxtM2pXkABuSf00fz4mFhElROBtDM2+8PuYcH0hBGd9p+d1BRqzoiyYDaM6/pjLE
         fn3VKjfnsAKYOn7JCyV6Oj+rF2Nu4w3JI+1DwWK+bl/5ng4IKY5VPY165T/NlPiYfTTo
         macQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789840860; x=1790445660;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zX6Pv1T7TGZpgi7DW5RhMCxEUIj0XP96/BVdkssFGYY=;
        b=zWWerN63sq+pJwWBvJxwf2YQ9hjxKTQH8d+yMfknC+tTaoEPg/lVOBxsguk2lAOghE
         /CTkkuXjRsNqPBvgMLjX/B2issX9nrDkC4E/iVpj8l2KZ37T9R6VFBho82dk4VGu84Pu
         TCWS/eInCcTQTGOmYn9VtlCTMprs/RZvLyBT+NGk+14CuTcdgHW8EASjqT3Ye2FNJGsI
         w/xYB51hFS3Stll2qzsDvt4TjbA85SuqhNRpG00OiT+XHOXhygCPPA5NW1ROyeZSd+rP
         JEZ5UmpDyqU37prwSIk37xPdkGxELjo3JJXV+N9Wii4a2IwA9ci52OnIws8QhXH/k5S/
         dQyw==
X-Forwarded-Encrypted: i=1; AKwUvBy5+MhlUGErdLn8xMrda4+MEByrxIVT/XbSAig1tswWjt/RROc5MUszygiebWrKxWUHJb8=@vger.kernel.org
X-Gm-Message-State: AFuF++ksrtUpyFk93J2qO4bhrf77Sx0ah8qfLF2ZWdFNkJBCpM872BDW
	x/GY5JOGvJQuzG9a33DrE8ezVe9p0oYFDm06U2Eu8WSeBOd12/gipScLXaXy1VQPd157Fqme5Xm
	jEukvbdGNxzXFzfc0fzUlM1kak9+upSycEQ==
X-Gm-Gg: AYBFou1BuAFjKmugpSZ8d4xesvPmDQYRF5F80/6b9fJ+SOCpIUdUllCfjwwMbdcS3TW
	qb8L32rdu5SGZkQXa8y7LXgulkS+YHf7AgYnwYB9Dg2nDdn08ggeLCDXEbmZFkMVds+xEI6ilIS
	EgD7UPe7SW7f9NjR6F60oiefdOprZG20mSPhz3i+uAZQu65mCBsAI0eBDIylDUoJWNR9Pqa4ljf
	9ii6NR7PZtIf0TIsEEWJrKYEDiwMyvSnuQydNHA4vvnUtu9aqfR8SfksvQRArIddwjOaO68dVYM
	NGAEOIISQ8G3paJcQtnrfltrE6cuGV7o7Q1D4ce7zUCqhhum25563cU1lPGsozqud+TMoJqVkCe
	JCFt5zyMMNp1NX/NViwOJBq55/W5G5h7AVw5yAQu+rdAKog==
X-Received: by 2002:a05:6102:5114:b0:79e:373e:8216 with SMTP id
 ada2fe7eead31-7a556e12596mr3468415137.0.1789840860376; Sat, 19 Sep 2026
 11:01:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 19 Sep 2026 11:00:58 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 19 Sep 2026 11:00:58 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260918171847.2670739-2-markchucarroll@fastmail.com>
References: <20260918171847.2670739-1-markchucarroll@fastmail.com> <20260918171847.2670739-2-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Sep 2026 11:00:58 -0700
X-Gm-Features: AcwNN1XDAsVn2er2Wf8JT6em4fQ4rHfMUZGgDlWYWx_mMjy-cMgPaHtBj7o4JhQ
Message-ID: <CAOLa=ZSB05yNzFRzya1R=yGaphUaTtuZUprKgZqwsDKnP09JiA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] t4001: modernize
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b01218065bd9ccfb"

--000000000000b01218065bd9ccfb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:

> Old tests were written in a different style than modern
> ones; for better readability and test error messages,
> update t4001 to the modern style.
>
> * run everything inside of a test_expect_success block.
> * write title line on the same line as test_expect_success,
>   end that line with a single quote that opens the body of the test,
>   and end the test with a single quote that closes the body.
> * write expected output of a test to a file named "expect",
>   and actual output to a file named "actual".
> * write here-docs using "<<-" syntax, so that they're indented
>   uniformly with the rest of the test.
> * make test names more clearly reflect the functionality that
>   they test.
>
> Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
> ---
>  t/t4001-diff-rename.sh   | 94 ++++++++++++++++++----------------------
>  t/t4009-diff-rename-4.sh | 54 +++++++++++------------
>  2 files changed, 69 insertions(+), 79 deletions(-)
>
> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index ad474100af..15567b52a0 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -8,6 +8,7 @@ test_description=3D'Test rename detection in diff engine.=
'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-diff.sh
>
> +

Nit: looks like this was unintentional?

>  test_expect_success 'setup' '
>  	cat >path0 <<-\EOF &&
>  	Line 1
> @@ -26,7 +27,7 @@ test_expect_success 'setup' '
>  	Line 14
>  	Line 15
>  	EOF
> -	cat >expected <<-\EOF &&
> +	cat >expect <<-\EOF &&
>  	diff --git a/path0 b/path1
>  	rename from path0
>  	rename to path1
> @@ -42,7 +43,7 @@ test_expect_success 'setup' '
>  	 Line 13
>  	 Line 14
>  	EOF
> -	cat >no-rename <<-\EOF
> +	cat >expect-no-rename <<-\EOF &&
>  	diff --git a/path0 b/path0
>  	deleted file mode 100644
>  	index fdbec44..0000000
> @@ -86,47 +87,36 @@ test_expect_success 'setup' '
>  	+Line 14
>  	+Line 15
>  	EOF
> +    update-index --add a file. &&

Shouldn't this be `git update-index`?

  =E2=9D=AF meson test t4001-diff-rename
  ninja: Entering directory `/home/karthik/code/git/build'
  [21/21] Linking target git-http-fetch
  1/1 git:t4001-diff-rename        ERROR           0.74s   exit status 1
  ...

  Ok:                0
  Fail:              1

Also what are these files?

> +    git update-index --add path0
>  '
>
> -test_expect_success \
> -    'update-index --add a file.' \
> -    'git update-index --add path0'
> -

Ah! So we remove this test and add it to the setup, isn't 'update-index
--add a file.' the name of the test?

> -test_expect_success \
> -    'write that tree.' \
> -    'tree=3D$(git write-tree) && echo $tree'
> -
> -sed -e 's/line/Line/' <path0 >path1
> -rm -f path0
> -test_expect_success \
> -    'renamed and edited the file.' \
> -    'git update-index --add --remove path0 path1'
> -
> -test_expect_success \
> -    'git diff-index -p -M after rename and editing.' \
> -    'git diff-index -p -M $tree >current'
> -
> -
> -test_expect_success \
> -    'validate the output.' \
> -    'compare_diff_patch current expected'
> +test_expect_success 'diff shows path0 renamed to path1 with edit.' '

Generally we don't end the test descriptions with a fullstop.

> +	initial_setup &&

What is `initial_setup` here? This fails running the test.

> +	tree=3D$(git write-tree) &&
> +	sed -e "s/line/Line/" <path0 >path1 &&
> +	rm -f path0 &&
> +	git update-index --add --remove path0 path1 &&
> +	git diff-index -p -M $tree >actual &&
> +	compare_diff_patch actual expect
> +'
>

[snip]

--000000000000b01218065bd9ccfb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 36c4377011c63cb3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xdXpkZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejNNREFDTjNWVHEvdENxcURCZjNlM0sxQzZiNFdNSApWb3U5dHRsQW1K
K0ZkT0hGbnFwUVRtanpxYWc2V29lOGRmSUpxOUNrZHdLeUNHOVE1Slk2aEc0dXdPSndDTjF0CjZU
QUJrelFOYmtydXNkSGU3QjdURzArZ01QSmp5Ykw5aDBIVFRlS2J1K1pRdlVKRFErTmQzU0ttYytz
MzFsMzUKZHRSeGtYbVdhNGJlczByQ0hXdFdCNE84VjNOMlRtSDROdHdHTE11SHMzaVV0cVJqKy92
SkxNeWUvTW5OOTZSeQp6NWtJNTR2Sjg4eHcwd0Q5dUVDVWpMZ0lTMys1V1V3eFBTRXUyd2Q4YStx
QUZpK2xNZTViU0NkR3N4bFRKaVh6CncvcE9nakRuOGllUUFiMjVYNmhTZCt6aE8yQWxnU3dBR1lY
K1RCVHZjcmxEbzR5MDl0RVdualFuN2luMzBXS1YKS21FTFRXRFFBOCt2bE9oSTFnL2xwcDAzU2tD
UnVqbHVaWDFEa1I0NlE4ZTY0UzRMVWsxSWJHYkhvTmR5VUp6YgpKaTlhV3ZqMC9nT0oybmtqdjQ3
ak9FRDV3clpFdHZBWEpSN0NtU1Mwdksza0NIaTBPVDNFTW44UkVZeVhYb1daCm4yRisvemMzYm9D
bmlvWHZtNzlMczBDdUlON3NHb3FmbEd1R1Jjbz0KPTM3ZS8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b01218065bd9ccfb--
