Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3EY745u"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED6710E6
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 12:34:12 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9b77be7ceso18990171fa.2
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 12:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701376451; x=1701981251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnIldExwa33GJYRBQQzeiwIDXmGnqeInmC/C2UrIhr4=;
        b=f3EY745ufj3DkWo2YR5dkKp3S7v995ZHOKrBC+nVoATYUyJYYyx91Td011JkRw9nBQ
         WCkWPwW/4hoeqLcKFus2J8wmeQYC3552IHEwj/SEj+keoe3cWoEaSmMPxsE7XYfP4Dpn
         dMt+Wtrfq/a8QGcLvHfSlFER5LbhcBRGWybTj4PCWXekFZFMp0FyiNYZlH+yyfl66JWE
         GnSgLzBJGK9zUFlcWLaNleMdIKE/IDooD07dIWpdUXCGIqHUhvsHurG69KxHEnPAmXRg
         JNzYsUr5sxqzeio6NPvRCrLwQ9tEwZCl/N9vCRZ48M9nC1ZW/5QmRrl6p77pIZnXppfI
         uDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376451; x=1701981251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnIldExwa33GJYRBQQzeiwIDXmGnqeInmC/C2UrIhr4=;
        b=LAS8Vl4am5TQ+tvo8gdCmgzlcJNEg2sYNuqYS6dNWtKgOno+/7CUXczN9y5rnOtIWA
         /e82phxavX9jfY5qP9/LOs/stv21FuDSVlg6DBTSt/lp6/XbpsTlVhH8nVxemi2Yw4yi
         7qPUj957LgHhLPRbjNzA7AeiRt2pSQsKX56DkF9QcBPaQKgMjmZAUcHdSnIRg04WV2Wj
         r74XYlJ0ATkPcTnkO2W4keJQ3BWc/GhKK6Fem6Tlsemuzs1ONUcP/Iewx1EONaITuKiS
         hjzCE4lQinOSRn9BDMXlHeGceS83c7PCVxVyom6RsPNXe8HlpPtSTL0TYWTcl5QPNHaL
         N9pw==
X-Gm-Message-State: AOJu0YzisE54L+F6r9X7YYg8EKES6arwohiydf437NKglfxW4GhETZp2
	i7CvzGz6BobAuyhZVCq27XICarqt4OHMIfweEp8=
X-Google-Smtp-Source: AGHT+IEBTD9YuUtvUCrgyEkEFZprB/YIZVfs+bw6H1M0y5wyMmVyx1QBIKwcMhFV32QjhZvu/XKvdIApdbMKIRPdy1Y=
X-Received: by 2002:a2e:7204:0:b0:2c9:bab8:e46d with SMTP id
 n4-20020a2e7204000000b002c9bab8e46dmr25603ljc.48.1701376447329; Thu, 30 Nov
 2023 12:34:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.v4.git.1698347871200.gitgitgadget@gmail.com> <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
In-Reply-To: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 30 Nov 2023 21:33:54 +0100
Message-ID: <CAP8UFD1rd+q-dC_w2VgZ_jC++LDeF6gu5wDcbQzSuhU1ksfBpA@mail.gmail.com>
Subject: Re: [PATCH v5] subtree: fix split processing with multiple subtrees present
To: Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Zach FettersMoore <zach.fetters@apollographql.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 10:17=E2=80=AFPM Zach FettersMoore via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> To see this in practice you can use the open source GitHub repo
> 'apollo-ios-dev' and do the following in order:
>
> -Make a changes to a file in 'apollo-ios'A and 'apollo-ios-codegen'

It looks like there is a spurious A after 'apollo-ios' in the line above.

>  directories
> -Create a commit containing these changes
> -Do a split on apollo-ios-codegen
>    - git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin

I might be doing something stupid or wrong, but I get the following:

$ git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin
fatal: could not rev-parse split hash
cc70a7d49e84696f0df210710445784c504ed748 from commit
360f068ea0d57f250621ab7dbe205313f52a0e98
hint: hash might be a tag, try fetching it from the subtree repository:
hint:    git fetch <subtree-repository> cc70a7d49e84696f0df210710445784c504=
ed748

> -Do a split on apollo-ios
>    - git subtree split --prefix=3Dapollo-ios --squash --rejoin

Same issue:

$ git subtree split --prefix=3Dapollo-ios --squash --rejoin
fatal: could not rev-parse split hash
b852c0aa1fd5ab9e1323da92b606ad3f2211e111 from commit
b48030c3eb6e2faf4bff981c5c63ca72aceecdfa
hint: hash might be a tag, try fetching it from the subtree repository:
hint:    git fetch <subtree-repository> b852c0aa1fd5ab9e1323da92b606ad3f221=
1e111

I didn't try to get farther than this, as it seems that some
instructions might be missing.

[...]

> So this commit makes a change to the processing of commits for the
> split command in order to ignore non-mainline commits from other
> subtrees such as apollo-ios in the above breakdown by adding a new
> function 'should_ignore_subtree_commit' which is called during
> 'process_split_commit'. This allows the split/rejoin processing to
> still function as expected but removes all of the unnecessary
> processing that takes place currently which greatly inflates the
> processing time. In the above example, previously the final split
> would take ~10-12 minutes, while after this fix it takes seconds.

Nice!

Except for the above issues in the commit message, the rest of the
patch looks good to me, thanks!
