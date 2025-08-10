Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865CC1F4199
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754855636; cv=none; b=hZRJU+ji2tAxVueqtIKGhsJ7DHgxKMtKo3FF3rk4/f1rWmUsoZduR2Q4rEdXYtyiXJc+kUKiPqqM8rHIr8oQRIaO/HYxkGaXOQTaxBcZMyRVYrTMWARd52nIyQjCIGOLC7JocW9eF4elhLrzu0DuTDMjkAZRYpu433Cim8Dk5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754855636; c=relaxed/simple;
	bh=qIMGzlQeDFoOl/UOIIk0CNGe/kRoGxKbt8inZD4lcsY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=r7QiegkFHYdZ1OIL9U0dzSKviwAGjnSuHK0WmsfSXE7W0QmIZ7oaWqHMAWwOWfWK37/dE1mYB2XxOWuKgBLnKVAceuPeFAf0lEtmLhHAGlBpV0VbLR+WR8+IdzA4UzSohUVyfXhX63rh3bVAUSsDJ4cBZ/afpiicNWhgTvMJU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/OAr4e3; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/OAr4e3"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e9033498768so3616010276.2
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 12:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754855633; x=1755460433; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBxoDOwHtbD/DhAX4YASJ4F++CTO96Jw/ccZGzGdVBM=;
        b=J/OAr4e3K2z553TTyQLZhSz9dH9I+sxO8KkKkd4EHBEww1gd9n+NJX3pM5ZO7TctAc
         ZBhE6nBIm+nJtg98EU4W0NwdFSaDXx6+gQG8mgyKM7KnYDEpfjwmIvION+OBzzJnu6zH
         1CPCt/v8534+1HIp0KOkNJLcNtL93NlotB9c4gPw3sD0RdSz/k1ucOjbJVMHzCTeljZf
         V1HHCo1xwe9gjkfagU4+WKaUAoA0FrzkmTgnb/ImEpM26WURgBMPaAuqotZA/VVvtQGA
         zd1ofMnghV1GUu/g1Zd65iFalXrNifXEOZCCu5xny/quy4Mrr52XOTUh6PmjCY+wyxwB
         nXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754855633; x=1755460433;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBxoDOwHtbD/DhAX4YASJ4F++CTO96Jw/ccZGzGdVBM=;
        b=POdpJvbs5KhfKqRZsfRRh2onRDV7sfM1iHUWDqheqfJq53np5zae4/zzUxqyV6AeTh
         kkO3KpHJzm1PCJ/vk82EcBma4vp0JMuMeMoRTmWwa9IU3ybMdcti6V5cSTlmosDAGngK
         T+MpOCqLid/wHC6UefCFg+X8zZ4QtNwhWkq22STG1VYH5Co8IW65FX8w6CQTMocd4Ihe
         MqyUF3NBmLYax+SfZs6pjaKqhtetTKqMsKBHaAq06j5pj2MvgY6dfaODOaSUO1SSKcLH
         cU9djX3rQZwb1kD28LSyjuNnxRL7i7sQ8Xzwg5Gj+iHhLZ7RpNinvE8+chy6IY+CRU+r
         zL8A==
X-Forwarded-Encrypted: i=1; AJvYcCXAP1SWMlyKO1je7+Xq5exdwMZE1v/bldrHzr4TN2wq6m6J0a1/E0KUiqi/V8PyUlysjsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLe5d9Kar+GIVnOejjuuow44U4iyi9ybttwKKK2briQZg8P5N
	ZV76xjc5IYjAUMH3yhA+jO6RWgqoeVL4aYzcTe1tlEwM8NQoaBU3zHG1
X-Gm-Gg: ASbGnctYUm43RWcBps4tbJZlNbvpXX/tRrI3+JataiainCLTwzPP0JQEqKGbXwxlDME
	Mayk1BAsb91lyOv6+6yL+5QzKqV63ldTc4CN4X1jz6/9Ctfc7OEh/tDedJDLax+ybLqOF9gZzlN
	CJVfNo8aGzt/P5tPxLfYKZ3cWgE/hZb72ilKcTfNWMaUZWZ6Po68tRGZs9JVTlYR0nlarJb78OJ
	XlNM3/DtjG89by5zXBoCh6m8g/HHVL+eM+v0HSsQoUXBW00nzNhEa2dkLuOoa57c5phw6SRPATe
	1FGAL11ItIy/XR9/2NYczcIYV2g/r6gHuIwvleysIqU8Bap3BsgKRwUZGvzcLNkb/ELsu1ibE9y
	zGVXi5NeDEN1KwbQ7hGJw9PMMCiWhNqGEpQuX3USuFwb2KWI2eArEq4W6BGNEAI62E5ABrORNtq
	D3n/5j6RIwfwCYGAA=
X-Google-Smtp-Source: AGHT+IFZM478idaEQynDngXU+2DfprwvPLcwspQNi2+LkCPODJYciwyLNQ0XLmFOYJLzjIAxZvdbUA==
X-Received: by 2002:a05:690c:368e:b0:71c:16b7:5183 with SMTP id 00721157ae682-71c16b78742mr64920097b3.28.1754855633224;
        Sun, 10 Aug 2025 12:53:53 -0700 (PDT)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5fa8b4sm65002717b3.84.2025.08.10.12.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 12:53:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] t7005: sanitize test environment for subsequent tests
Date: Sun, 10 Aug 2025 15:53:41 -0400
Message-Id: <9B179FBA-6695-4F8A-8EE1-A02F1236805E@gmail.com>
References: <144b6ee4-d4b4-4843-841c-93a109e71aa9@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
In-Reply-To: <144b6ee4-d4b4-4843-841c-93a109e71aa9@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: iPhone Mail (21F90)


> Le 10 ao=C3=BBt 2025 =C3=A0 15:44, Phillip Wood <phillip.wood123@gmail.com=
> a =C3=A9crit :
>=20
> =EF=BB=BFHi Ben
>=20
>> On 10/08/2025 17:03, D. Ben Knoble wrote:
>> +test_expect_success 'Using individual editors' '
>> +    test_when_finished "test_unconfig --unset-all core.editor" &&
>> +    (
>> +        TERM=3Dvt100 &&
>> +        export TERM &&
>> +        for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
>> +        do
>> +            sane_unset EDITOR VISUAL GIT_EDITOR &&
>> +            test_might_fail git config --unset-all core.editor &&
>> +            echo "Edited by $i" >expect &&
>> +            case "$i" in
>> +            core_editor)
>> +                git config core.editor ./e-core_editor.sh
>> +                ;;
>> +            [A-Z]*)
>> +                eval "$i=3D./e-$i.sh" &&
>> +                export $i
>> +                ;;
>> +            esac &&
>> +            git --exec-path=3D. commit --amend &&
> [snip]
>> +            git show -s --pretty=3Doneline >show &&
>> +            <show sed -e "s/^[0-9a-f]* //" >actual &&
>> +            test_cmp expect actual
>=20
> We need to add "|| return 1" to the last line here and in the test below t=
o reliably error out when test_cmp fails. I'd have thought that our test lin=
ting should hove picked this up but maybe it is confused by the subshell

AFK for a bit, but didn=E2=80=99t want anyone to think the linter was broken=
:

That=E2=80=99s what I must have lost when rebasing 1/3 from the end of the s=
eries to the beginning, good eyes!

In fact I believe it=E2=80=99s what CI flagged, since chainlint is what sugg=
ested it. I should have run the tests again before sending this set (I=E2=80=
=99d been running frequently them while working on this file).

PS I think it=E2=80=99a actually =E2=80=9Cexit 1=E2=80=9D in this case?=
