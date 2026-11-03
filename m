Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793671694;
	b=IQxuV5Nu32Vt/auKU/75Bp3D1a1+cOVlyTMRNUm1KK3o/tkhT/dx545gaREaQRNVRo1I
	 m0qBAb+7YsgIndYB+1SdpSUVvXvZPFwLjJkkLD/PmqMkBozT3putV3r9rOnK3swfFAz6i
	 lwGHndCzT/tdhMmk+/mhItkdJxyeRhhxjGmd8JIMciSNjg2ra3R7SBAIAWpfeBewbQvSg
	 5/wOiJtow5/QAW44DJ7LwQ+5Pw8kBWbiv/kmLbwEJkMdikVqAuwPcS/u6qktuHulSwrQi
	 DEdMXgxjTf90LVapkenFKCblHIU/yujufgboSfGOo723kpZtiUiYKnP7gaa8vqnxl0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Xh2DUFvkHvO84pV3J+1TLwnzqmcgyQN50+mIRhUdZns=;
	b=lXEOqQ7lM7qIxkLn646riPXhZSHlXuU5OvENp+uYyYU87r4xtlCLICSegCvKYPWOjP41
	 no/zeQoivQaUUt5AT5ObyhEAICIWbbQy7E8c3BYiz+Lvu0wHn2DJBY8ENkXg8SpjtcqAc
	 ODFM63mka22cwm0m1T8iCUUocaZdfJQK1+UtWdgdQwNPWVGn+wnxuwjwLw5nyLUIx42Br
	 +wWtMQI1zJhPatm47xrSHDzNE9JbnHUEFIhP6ByOhC+yNpcJOFQtCVrzC+8JtiyLnUXHI
	 BsyEx5BJs7dfBx0ZLyVjVAigRHyy7AGQ9+y5EaBs/NqsQMZ+PpD21SJG1USaz4GBwVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H4lXb+++;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA30606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 02:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCA30606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H4lXb+++
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b190cdc9feso2550836b6e.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 18:08:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793671693; cv=none;
        d=google.com; s=arc-20260327;
        b=g7IMGsTpO25cmwOuBifsC/iAyJZoi6Rkqam9PRwsRtTtm+1txLNMk5a8arqAZRxX+9
         P+C8y81qq+bwGq+OuaOehYSMlkutgl8xCwgF9iMXHbm2K6749gsCru+q6nPFRoUVoUHR
         65xYswwNRWXhB/qg434fu4BPK0BViDEiN4zO9OXgxrCHZRbw/bfccI14gbYO8kR98/m2
         iDMFx+bWdopaAm8KO0xbvJvKfZvRD7JrNztc2gdJZQsya+8c+xmmSTLq6Z6fJbxqHvSM
         cvl56PQLiLAJPpyxOtySdZNjEoOH1AVVjKDgJw88BaFHKTbOKWfASCTI78kjmMq72djj
         1HmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xh2DUFvkHvO84pV3J+1TLwnzqmcgyQN50+mIRhUdZns=;
        fh=mv5zqN92u4yGkXYcJT4eDsfhsA+TdzFjZ8yY/QsyRCY=;
        b=GWzxZWuOsmbFVZMjNZlsCstD5jNyVoJzO/rz4j5WKd59Y02MbqqWi30CTdPHR4alt9
         ptn38NMi8sOQx3wh5LdnQ9i47UKjzfiq3N6hMk5DwWTb51DxTaLth4I2f9RY/rq8knXM
         HMk3GH+trHHHeGG95fmeovKf2yDS2ohiNYPlEiOVPrSInC1U2bh/TT3fJg+YBkLKFXCx
         miPfYNfkmZ6+6TJ19Yfm4y1GoWKXIVck8tL/fC8dZBBnNP9C+R9tYhG2ZDtDZQLEDo46
         oSzPT/xmbvd0SRzrsNjaMbxs6ResDKhUbuUzKk2gG1ZDk121zgV5vI4hSAvfgD9UjN4v
         3frw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793671693; x=1794276493; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xh2DUFvkHvO84pV3J+1TLwnzqmcgyQN50+mIRhUdZns=;
        b=H4lXb+++6tYoUygwni2a1t5hsEtZNL3oxtWjwbJ106BaAs7jMt6mhei2sMua2C/A9+
         PyipiW1yESZkgBRPBrchLoI0k+LuS1v7b5D7H96WcvH8vs8yLmTHtRGMNVG0WgjPf1uv
         9fkW1N+cA9MuWkH/XgHxljNn4+bHKT+b06jNubhaqV0RIeS2/ASc1kmQts5uopaeKW0p
         oY65Ui/vT2HCsMtAbIvBgahiA3RvN4bxiHWDWPW9JoUV1YB+hUn08KOs6WETic+pbsvf
         KJBgJDkOvc0bJrlyV44mwN4BACF1L8fH5MBfG60Tt8LBfII2Q+OfdrMtNzWHTrW4Y8G5
         qoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793671693; x=1794276493;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xh2DUFvkHvO84pV3J+1TLwnzqmcgyQN50+mIRhUdZns=;
        b=INOaMvYMrZPAMzJcnwZ3ysyzaOg8RKC6wO7XucI5NEt8Y8DNK0Eb9ncWdfe4nkDZAk
         DEKkh28c8LrzAGurlRc6rRxPNGST8dv3hBqoooNfvdr3gb4a1hkVSYbvQkplLt4Jodz8
         al6mdhM/v5OrkuEvPfd8KNiS5XhQuBsfelgfO9GJkyze643rnUt/qticdn9MJ4u4T5w1
         KIWeHdS38ubPDSoyqzQtkeJAb839OI12f9Qbl0GBxJ6Qu5yDDfYRTJeK4mWEZLl04Vgf
         mKywNMa/o4G3zpYFaYnNbwvs0KOCLUwJlQy00v2I3c8kMsDHw0X66UswQsAQSGZYFNf/
         bOEQ==
X-Gm-Message-State: AFq9FYK6NE57bY/tn4YuhFlckMAjCNrhAfaOVO8+GHlArbbjl6wLxJfh
	Oqhe2mrfQvSTWtsjTEMhh3jtzlu3bWtZD9r9iLblI/c/r61QJT6D+19JgQFxXqxInYNxowGgaXN
	IBPoyym7odPRudXjdLkrX+rhb3zrf8xw=
X-Gm-Gg: AYBFou1xdAxYa9oRDwj12+bx88raoDm+FgSw8Db4DMwcGGyh8xV3Fn2eRdn/sTKcmRA
	P8O7719COmP34zACaS+y/EDZZPTyQU2xDZ3Q6iy7zpCDy09sPqoV3bpxAE11CaM1pR94e2l6BI+
	0lxfxW+bDb4PuJcIWEgdSG/T0fi19WB/TcHXzWPa96ov/tbc8pyNiHPEQz02JmOxDwWRCSD2nHd
	hFZjMoRTsxwXjLBkS43YAp1jD/DR3eG0xSyEmJRRjtv6QyOJw9uvHGSr4GpNakjQmAbo6P/jIl6
	lp2dK2/NdGxasVfyx0s4Cx+LxT7HUEFbbJ5gxt/Q4QWx3cGUd/KCHMOfskDPzZNSD/sPpyt3laz
	enpSVwN+kY9IgKEbs8FCIYRJlLxjMuobjHQhx6wheaSUuXv1xXJ3TkmrJS5A+j9QCLBfvAB0U+8
	U4/LiRVnHFPuY2SXzp0QCPP8Ra8bvnUhyVR2s7PyO0l0gILNCAK+3+i4c=
X-Received: by 2002:a05:6808:1798:b0:4e5:a74e:d6c0 with SMTP id
 5614622812f47-5640dea5592mr8487792b6e.64.1793671692786; Mon, 02 Nov 2026
 18:08:12 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-3-jayatheerthkulkarni2005@gmail.com> <auj3hhrRvyX9lus6@denethor>
In-Reply-To: <auj3hhrRvyX9lus6@denethor>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Tue, 3 Nov 2026 07:38:01 +0530
X-Gm-Features: AclHuK-py7w9j6hgY710rpPLbMIeoiNygNJ7H8hr-FFiznpSZk49CMtRrF-3_Wg
Message-ID: <CA+rGoLd8D7r45xZVDycpJG68kbo=14b2pr0SgyW2aQD0+7-dDQ@mail.gmail.com>
Subject: Re: [GSoC Patch v7 2/8] submodule: use repository to find superproject
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 3:06=E2=80=AFAM Justin Tobler <jltobler@gmail.com> w=
rote:
>
> On 26/09/27 05:14PM, K Jayatheerth wrote:
> > `get_superproject_working_tree()` currently uses `xgetcwd()` to
> > determine the repository whose superproject should be checked.
> >
> > This is incorrect when `--git-dir` points to a repository different
> > from the one associated with the current working directory. In that
> > case, the current working directory may cause the function to return
> > the wrong superproject or an empty result.
>
> Ok, so we are not taking into account here that the git dir location
> could be different than the current working directory.
>
> > Pass the `repository` to `get_superproject_working_tree()` so that the
> > superproject is determined from the repository being inspected rather
> > than the current working directory.
>
[snip]
> [snip]
> > +test_expect_success 'path.superproject-root works with --git-dir' '
> > +     test_when_finished "rm -rf sub super" &&
> > +     git init sub &&
> > +     test_commit -C sub initial &&
> > +     git init super &&
> > +     (
> > +             cd super &&
> > +             git -c protocol.file.allow=3Dalways submodule add "../sub=
" sub &&
> > +             git commit -m "add submodule" &&
> > +
> > +             SUPER_ROOT=3D"$(test-tool path-utils real_path .)" &&
> > +             MODULE_DIR=3D"$SUPER_ROOT/.git/modules/sub" &&
> > +
> > +             echo "path.superproject-root.absolute=3D$SUPER_ROOT" >exp=
ect &&
> > +             git --git-dir=3D"$MODULE_DIR" repo info path.superproject=
-root.absolute >actual &&
>
> `path.superproject-root` isn't introduced until the next patch, so this
> test fails at this commit. Maybe the test should exercise the existing
> `git --git-dir=3D... rev-parse --show-superproject-working-tree` caller i=
n
> t1500 instead?
>

Right, It was meant to use rev-parse. I will make the change.

- K Jayatheerth
