Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718E01F454
	for <e@80x24.org>; Fri,  2 Nov 2018 17:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeKCCbv (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 22:31:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40767 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeKCCbv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 22:31:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id z12-v6so2417504edp.7
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zSewPcW9CkygGBHs0iX1II0VE1Cxy5iNThXT+jTZO1k=;
        b=N51DxeeXtVj9UmNJw20BXwmX62d7mREdltThU6PH27GPimMHRS3ZEJR+gtocIb1RzW
         dY82dkXFLvxDr8zO22kbxXZGvncX92u3dHVB0tbT8N91+uRzjfmjlduCs6PrBOylDcbS
         6lN8vVJlEfTI15/S8UvwF14DdJmfUiGTqbcrFwdGY0+HUayg65Qq11aIY6yB2lFS0g2B
         UgG2eHyG17yQN+bylv1ld+gts2x9H5I1nlNy/LXSw2CxsxVpMjCWZDwsG9KSfUemTeAY
         KvSmyYpQh5Qz+i9TpObcHAxOPjYq+hu5zxOhU9BJNdxSAa7Vr0hOfg5A8vhNbhXqdu/B
         w+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zSewPcW9CkygGBHs0iX1II0VE1Cxy5iNThXT+jTZO1k=;
        b=Ayn5o0fL2Hn4wsf3sckfB6BRxe7U+Qf1QooVOlIGiB4J48GcCN04uqMqM6FqmnoH5w
         kGwaRF6/BLtckgkvVuRd+OaVSGsK1YdrlHnghBG71KtTrLhjhkThxNp6CwcW/7IBk0XY
         P0VROLQ2gtQNeiLjUDqmFn3n5dGdnVkHxPf+BlhOVkC4pvZ4umRnKvCjRSp2Otfj7AfO
         Eg9v985yP+nEGvcW/zT4vFBCZ6hzvFOgYbySC3UwWnZc1rPvwWqkVhpQUkYxMD65HeCf
         X/V4PoPzLnDm9Ak46XhZ3qnJSBotOoKg+Bp2SR+zMSuFJJdtEgKDGqg2xBky1EcIl/Mz
         ft0A==
X-Gm-Message-State: AGRZ1gINIkMLKCLqwOi9m9e6ZSHm1acq3IdGgg0G40NdB+hgGXOlv681
        EASaUc1CQJYQ4HqKCVWZ8d//gOw1Q1/fyGEDlrZLsg==
X-Google-Smtp-Source: AJdET5fO9u28pKWyMBXMR30+fXwTK5qtlLAEtlLYa6j7mnADQFWvCrGFCEM4yd59q2BZyiPAC7bvMUCgNuXdSuv6Vek=
X-Received: by 2002:a50:bc12:: with SMTP id j18-v6mr9484314edh.154.1541179436044;
 Fri, 02 Nov 2018 10:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com> <20181030220817.61691-20-sbeller@google.com>
 <127add9b-d58c-ee46-73de-41bfe915589b@gmail.com>
In-Reply-To: <127add9b-d58c-ee46-73de-41bfe915589b@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Nov 2018 10:23:44 -0700
Message-ID: <CAGZ79kZV9AZLHiSz19jx_Z5PnqO1V+-ngL9ACGhr21umn6UQVQ@mail.gmail.com>
Subject: Re: [PATCH 19/24] submodule: use submodule repos for object lookup
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 2, 2018 at 6:03 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/30/2018 6:08 PM, Stefan Beller wrote:
> > This converts the 'show_submodule_header' function to use
> > the repository API properly, such that the submodule objects
> > are not added to the main object store.
> >
> > Signed-off-by: Stefan Beller <sbeller@google.com>
>
> A couple tests are broken in 'pu' when run with GIT_TEST_COMMIT_GRAPH=3D1=
,
> including t4041-diff-submodule-option.sh. The failure bisects to this pat=
ch.
>
> Here is a verbose output of the first failure in that script:;
>
>
> expecting success:
>          git diff-index -p --submodule=3Dlog HEAD >actual &&
>          cat >expected <<-EOF &&
>          Submodule sm1 $head2..$head3 (rewind):
>            < Add foo3 ($added foo3)
>            < Add foo2 ($added foo2)
>          EOF
>          test_cmp expected actual
>
> + git diff-index -p --submodule=3Dlog HEAD
> + cat
> + test_cmp expected actual
> + diff -u expected actual
> --- expected    2018-11-02 12:58:43.429262380 +0000
> +++ actual      2018-11-02 12:58:43.429262380 +0000
> @@ -1,3 +1,5 @@
> -Submodule sm1 30b9670..dafb207 (rewind):
> +Submodule sm1 30b9670...dafb207:
>     < Add foo3 (hinzugef=C3=BCgt foo3)
>     < Add foo2 (hinzugef=C3=BCgt foo2)
> +  > Add foo1 (hinzugef=C3=BCgt foo1)
> +  < Add foo1 (hinzugef=C3=BCgt foo1)
> error: last command exited with $?=3D1
> not ok 9 - modified submodule(backward)
>
> I've been looking into the patch below to see if there is an obvious
> problem, but the best I can think is that open_submodule() creates an
> alternate 'struct repository' and somehow the commit-graph feature is
> interacting poorly with that struct.
>
> Stefan, do you know what's going on?

Sure, see the last four patches of this series
https://public-inbox.org/git/20181030220817.61691-1-sbeller@google.com/
(to which you also reply to? Junio did not queue this one, yet).
