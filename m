Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FDE91F404
	for <e@80x24.org>; Wed,  7 Mar 2018 01:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933439AbeCGBI6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 20:08:58 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33758 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932804AbeCGBI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 20:08:56 -0500
Received: by mail-wr0-f195.google.com with SMTP id v18so496817wrv.0
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 17:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5wQEUWYl1E4RipgFKYKJz1IUwFrwR7V9KH4WQN+rCOk=;
        b=cs69tlya+RxQjTfqsA+iB8+v8I/N+Fq9PKPwuuK7NXBwk3sJ8o5kE0Bo8cCh4SL75R
         BpyUCq2wPOC97Vvgx0gxjFEHEGMAU/qysGuZqUwK+LlpmctKd0aj6LmDTfqBXNMCS66F
         JFNpofAv5VOL0Q2yvlN7wGmPUMS164zmnei1kEmi53gjZdUy6TRVKgEh2PjlVYGzjfFw
         8sUR+X07wVwDZAEPfcWsj4ONu4FZpHJ9gxSrCrG0vfry7cl0Om/jSYfWkkbyYaYXbDmy
         RfgoSDIrFBmranLqdOBFheiPi/NsfA16lhg1UM0tz7uufSZiawwRAfGHLpOrETBHT3Bk
         TXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wQEUWYl1E4RipgFKYKJz1IUwFrwR7V9KH4WQN+rCOk=;
        b=YqB+xCa0k/XG19t9PphPAGBzFA0si+TZkwD6DrMbXjJeWr6oLiqT3xgRMX/J7UQ4sB
         AmIJuORE4Qxnh+PbOHgC7S+qKUQqegfa0JPlLUeMU3vMldfbYOJ6oknnN+136rj1JCTu
         iiW6iUZkYAmDoDNQow/kLHdKjPW0UM1OMyWHS1D/MudL+RjFzlCTBILNjocVGI2+LT26
         Kqg9rEyjiq2PRl4HSmrbS/TZnUu3rlRjsfOxZcplbzRuh4+dzr16GQefadgCOjm15mwK
         9/bXhfoytLLy1d3FU6x2LmeNEd2LcwpR6+BneRJQ2/PuaqRvoayeszRrF7EHHlnBEVfC
         vN8Q==
X-Gm-Message-State: APf1xPD3TTjcHepnJXwj9SdLPZvBjkOOIlwmo4Ow6txxnYjVDglnIO4b
        sRA24/JKxMQWJp4vMRCQaTM=
X-Google-Smtp-Source: AG47ELtl59s+UtcghGukW8v8BoTWqK2dViVt9Hepgoua8cqJtDBQjJJCZ12OJcTnZprkcTWdo7YVSg==
X-Received: by 10.223.184.17 with SMTP id h17mr18823126wrf.9.1520384935503;
        Tue, 06 Mar 2018 17:08:55 -0800 (PST)
Received: from localhost.localdomain (x4db1d309.dyn.telefonica.de. [77.177.211.9])
        by smtp.gmail.com with ESMTPSA id p29sm13996409wmf.3.2018.03.06.17.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Mar 2018 17:08:55 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] completion: simplify _git_notes
Date:   Wed,  7 Mar 2018 02:08:43 +0100
Message-Id: <20180307010843.3503-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.512.g74dde89aed
In-Reply-To: <xmqqd10g3jxb.fsf@gitster-ct.c.googlers.com>
References: <20180303092307.3796-1-pclouds@gmail.com> <20180303092307.3796-3-pclouds@gmail.com> <CAM0VKjmmF2t=B2s3rJoKmO3j6Bk5d6PEfCV==ONRGMcdUMLFpQ@mail.gmail.com> <xmqqd10g3jxb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > There is a minor behaviour change here, though.  This
> >
> >   prune,*)
> >     ;;
> >
> > case arm ensured that we don't list refs for 'git notes prune <TAB>',
> > because it doesn't accept them (and then we take our usual fallback and
> > let Bash complete filenames;  yeah, 'git notes prune' doesn't accept
> > filenames either, but, as I said, that's our usual fallback when we
> > can't offer anything for completion).
> >
> > This patch removes that case arm, and refs will be offered for 'git
> > notes prune <TAB>'.
> >
> >> +       *,--*)
> >> +               __gitcomp_builtin notes_$subcommand
> >>                 ;;
> >>         *)
> >>                 case "$prev" in
> 
> I have this tentatively queued on the topic.  Can we wrap the topic
> up and move it forward, instead of leaving it (and other topics)
> hanging around and causing conflicts with other topics in flight,
> please?
> 
> Thanks.
> 
> 
> Subject: [PATCH] SQUASH???
> 
> By Szeder <CAM0VKjmmF2t=B2s3rJoKmO3j6Bk5d6PEfCV==ONRGMcdUMLFpQ@mail.gmail.com>
> ---
>  contrib/completion/git-completion.bash | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ab80f4e6e8..5f7495cda3 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1836,6 +1836,11 @@ _git_notes ()
>  	add,--reedit-message=*|append,--reedit-message=*)
>  		__git_complete_refs --cur="${cur#*=}"
>  		;;
> +	prune,--*)
> +		__gitcomp_builtin notes_prune
> +		;;
> +	prune,*)
> +		;;
>  	*,--*)
>  		__gitcomp_builtin notes_$subcommand
>  		;;
> -- 
> 2.16.2-345-g7e31236f65
> 

That works fine, but this would work just as well and has one less
case arm:

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ab80f4e6e8..038af63c1a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1839,6 +1839,8 @@ _git_notes ()
 	*,--*)
 		__gitcomp_builtin notes_$subcommand
 		;;
+	prune,*)
+		;;
 	*)
 		case "$prev" in
 		-m|-F)
