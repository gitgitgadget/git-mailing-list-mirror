Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5188D3C2770
	for <git@vger.kernel.org>; Tue,  5 May 2026 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778013288; cv=none; b=aaQpL+qQh6OhcAke1KQyJOrRk6xJyta7/OWOl5167l+nKKYW7Em73OmhltBrfSUyhpY+t4sFAN84BkA5eHp/EO8Iwrwa5rrbhupMA/33BP8E6RmpBMVizTGrv5xOrN/3zZn+webp9MAGnKpKuCKuuQ5hCQ5hyJNRyqYzANAFQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778013288; c=relaxed/simple;
	bh=M8Ao3oCxnBwxweA3BSG/ylBjyImNsWhYMu36omrvQPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kp7HkMzj2X/zX44X8T90Eu530f/91362eYgbr9zB2C9YRYZ+V+SzXbXX2KRInekLoVEQngwaB6j5TExePBqAgmF7kJY7zhrUVchzEAlpocnXx5pTzC+lLfmFF6gYXfBZETMac7/3uspWjQZN4tuMEBOfuu44q4HSVFlDa8EfjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=tqI78udq; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="tqI78udq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778013281; x=1778618081; i=l.s.r@web.de;
	bh=5PK3WUvEZMJM71QMsAsBefLprk6IMxyZLNRPoIbtLes=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tqI78udqVUisVpPGriKIlXMqYRFm/Kh8y13xKaGP+XdDScxDvg+W4OLnmProjoIv
	 zHpNv1lDMD4+KKOZvZGR4uYNQv85Ub4vSylOQ/iiJEAwiduf9gPMb/4hajKbHApsd
	 AHtQj6idOZVdRu2wO7PeIZ6rf6vHFj7KJcLAdNbybivc6bgne0cwKvoRSDb6jdjfd
	 3KVg/Vw7YBIodEudMFFksE6yWPLIV597YS1HxqoaTXKAqzNSfTRg34h1RmipF8CKG
	 uddCkKANp4RPXpAO2LVcHss9lQ+txGmddwNFurReDUO4jv/eADHuyD+dcUAxQnmkn
	 whUi6bfnT0CkPDErJg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N30ZL-1vK36y2xTB-00vOVy; Tue, 05
 May 2026 22:34:41 +0200
Message-ID: <e8257951-4ea7-40ba-8043-f4f2a080b70b@web.de>
Date: Tue, 5 May 2026 22:34:37 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] fetch --deepen truncates history in v2.54.0
To: =?UTF-8?Q?Samo_Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
 Owen Stephens <owen@owenstephens.co.uk>, git@vger.kernel.org
References: <CANOh7gEEw+6146NN3JV8EYxQarj0KkyA7r3RZ6v-DxeqQZLrCA@mail.gmail.com>
 <a5fd970d-fd78-41bc-98f8-a6a87a7f39cc@web.de>
 <e39f6770-fcc4-49a2-b3ba-5ac2ec9e047b@web.de>
 <2afd4a28a9a542f8baeab488cb0801d6b98adb0a.camel@t-2.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <2afd4a28a9a542f8baeab488cb0801d6b98adb0a.camel@t-2.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ke5Ml8m3z5au5fmwz20N/C2vQwXfgA5ct/IX1ee5ORm3enySqy3
 CVExqPPfB0/IVbYFYScM6NHXaiWhN4ik5BGG8i73Yb2Jpk8lUeorYATDcUeadi1EF0uuH5O
 48kXYAXmbfLZTgCDosBfQQdTd3VGbejr0olDwfzEPCb18x1EnpQQF2T2RJky91Sln5Knn9P
 FahPUBZllnBSYUDB1sdkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:smIyeWlOFGk=;MfE2xYyK/TgvY15UnKN0gVyGa0R
 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

On 5/5/26 9:27 PM, Samo Poga=C4=8Dnik wrote:
>=20
> Hi, thanks for pointing out this edge case. Would you care to check the
> following change (the provided test is also a bit modified):

There's spurious wrapping in the patch, but the changes look good to me.

Care to send them with a commit message and sign-off?

Ren=C3=A9


> diff --git a/shallow.c b/shallow.c
> index a156006d88..ec95653132 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -245,7 +245,11 @@ struct commit_list *get_shallow_commits(struct obje=
ct_array
> *heads,
>                                         int depth, int shallow_flag, int
> not_shallow_flag)
>  {
>         if (shallows && deepen_relative) {
> -               depth +=3D get_shallows_depth(heads, shallows);
> +               int cur_shallow_depth =3D get_shallows_depth(heads, shal=
lows);
> +               if (cur_shallow_depth)
> +                       depth +=3D cur_shallow_depth;
> +               else
> +                       return NULL;

Nice.  get_shallows_depth() returns 0 on full clones; translating it to
an empty list of shallow commits makes sense.

>         }
>         return get_shallows_or_depth(heads, NULL, NULL,
>                                      depth, shallow_flag, not_shallow_fl=
ag);
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index 6588ce6226..9982dd2aa6 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -251,6 +251,16 @@ test_expect_success '.git/shallow is edited by repa=
ck' '
>                 origin "+refs/heads/*:refs/remotes/origin/*"
>  '
> =20
> +test_expect_success 'fetch --deepen does not truncate' '
> +       git clone --no-local .git full-clone &&
> +       git -C full-clone rev-parse --is-shallow-repository >expect &&
> +       git -C full-clone log --oneline >>expect &&
> +       git -C full-clone fetch --deepen=3D1 &&
> +       git -C full-clone rev-parse --is-shallow-repository >actual &&
> +       git -C full-clone log --oneline >>actual &&

Using the exact same commands to prepare expect and actual creates a
pleasant symmetry.

> +       test_cmp expect actual
> +'
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
>=20

