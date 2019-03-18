Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E740020248
	for <e@80x24.org>; Mon, 18 Mar 2019 07:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCRHgJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 03:36:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35404 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfCRHgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 03:36:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id d6so12034039eds.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 00:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2X3PiT2C/dFDGK4H9ndPTFRuQJnlRjJZqC5U0u9aWOo=;
        b=HGfslOeDofyk0LH1chQsHzhYpl6Wx+B5C3gFTkFAX0358ThGR/zt/msGN/tfxvtTbm
         U95aVmYscDlBLpZcGI75zRYefqFp4vOJmcevo5YtJuge1RBl1uJs+EYsDUS2F/Xkl96T
         TSKGZoib86rFh7Ft0iz/WysKj8h/j9NiRuR2Tru+R8Ul5GGxprVn/2gAejIzconmcc0A
         yQ9hnEXv2h78fWppARWSAVF/5sZ3mDhYUH0NtaknEAyhW3Fo2kJuE8TuXUt1/Gg7TNFx
         gUVMTXefwNLsm5ltTV6LifzLNLyfDz20YaZ/ZDYtS66S21VVqKgCStqV0njTw5Ztct0f
         QtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=2X3PiT2C/dFDGK4H9ndPTFRuQJnlRjJZqC5U0u9aWOo=;
        b=XpkXTnj30ls7mVeOeE5j69turSUtcPU/v0VL7g4eWAkl5GMQa+1fMtZu7DlmVG2JzB
         sL5TOV8A7cHZ9khwVAlTSk+htJJPKbZ7UvADjbiJsGcq4jRnSHp7/zFT4EBgNSvMU14N
         FrrBDK6FVmTLXXN4KLKGy5W00WdaZ4IQ86PWJroyk6ugX8n09w0WF+50IBPwh4yKYy7l
         Y1c33aZB1OJNRh8ZZGXDSO/dxwtju1PJ3+dmUpXGzx4xJqhQyTubZJW3I5XbSNsceagv
         QuYU06ppmk9SSpnCFAkMF7tb/wqop3RApkTDebHcfxQOHsgh2t01QL2g20bU/+F9snle
         oVLg==
X-Gm-Message-State: APjAAAXHLG4E1HUCl2/NfP/XWBJ+fQddwPzMP64ZEtK1NVSGh08pjC5/
        cVfXXsPIfltBGQ18jYxr5m8t1TRh
X-Google-Smtp-Source: APXvYqwpyBdDnUCrtjqVJtKiGNg+UaP579v3JyVOmz/SJGCwwO2Yf+eT2mwxOyuQ5UBIktrTOB+jug==
X-Received: by 2002:a50:bacc:: with SMTP id x70mr11792083ede.211.1552894567007;
        Mon, 18 Mar 2019 00:36:07 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id s49sm917565edm.34.2019.03.18.00.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 00:36:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v3 3/3] t0000: use test_line_count instead of wc -l
References: <cover.1552835153.git.ttjtftx@gmail.com> <bc3dee82a91592e50fd39c5a332b13b76fefa009.1552835153.git.ttjtftx@gmail.com> <87h8c1a1mi.fsf@evledraar.gmail.com> <20190317200609.GA1216@hank.intra.tgummerer.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190317200609.GA1216@hank.intra.tgummerer.com>
Date:   Mon, 18 Mar 2019 08:36:07 +0100
Message-ID: <87ftrkab2w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 17 2019, Thomas Gummerer wrote:

> On 03/17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Sun, Mar 17 2019, Jonathan Chang wrote:
>>
>> > Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
>> > ---
>> >  t/t0000-basic.sh | 7 +++----
>> >  1 file changed, 3 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
>> > index 47666b013e..3de13daabe 100755
>> > --- a/t/t0000-basic.sh
>> > +++ b/t/t0000-basic.sh
>> > @@ -1136,8 +1136,8 @@ test_expect_success 'git commit-tree omits dupli=
cated parent in a commit' '
>> >  	parent=3D$(sed -n -e "s/^parent //p" -e "/^author /q" actual | sort =
-u) &&
>> >  	test "z$commit0" =3D "z$parent" &&
>> >  	git show --pretty=3Draw $commit2 >actual &&
>> > -	numparent=3D$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc=
 -l) &&
>> > -	test $numparent =3D 1
>> > +	sed -n -e "s/^parent //p" -e "/^author /q" actual >parents &&
>> > +	test_line_count =3D 1 parents
>> >  '
>> >
>> >  test_expect_success 'update-index D/F conflict' '
>> > @@ -1146,8 +1146,7 @@ test_expect_success 'update-index D/F conflict' '
>> >  	mv tmp path2 &&
>> >  	git update-index --add --replace path2 path0/file2 &&
>> >  	git ls-files path0 >actual &&
>> > -	numpath0=3D$(wc -l <actual) &&
>> > -	test $numpath0 =3D 1
>> > +	test_line_count =3D 1 actual
>> >  '
>>
>> ...of course reading this series in sequence I find that 50% of my
>> suggestions for 2/3 are then done in this patch... :)
>
> Indeed.  I think doing this in a separate patch is a good idea, as it
> makes the previous patch slightly easier to review imho.  But I think
> something to take away from this for Jonathan would be that this
> should have been described in the commit message of the previous
> commit.  Maybe something like
>
>     This commit doesn't make any additional simplifications, such as
>     using the test_line_count function for counting the lines in the
>     output.  These simplifications will be made in a subsequent commit.
>
> in addition to the existing commit message would have helped save a
> bit of review effort.

FWIW I chuck this up to just my blindness / expedience in reading the
thing.

No objections to changing this, but I don't think it's the fault of a
commit message if someone reading it doesn't get an explanation for a
future unrelated improvement.

The times when a commit should have such an explanation are cases like
e.g. introducing a function that's not used yet to make a subsequent
commit smaller, or other such cases where the change is incomplete in
some way.
