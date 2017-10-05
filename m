Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B1A1FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 20:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbdJEUtP (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:49:15 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:57263 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdJEUtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:49:14 -0400
Received: by mail-qk0-f173.google.com with SMTP id l194so6053154qke.13
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dam.io; s=arbre;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Eg660KGx3aZ6+SblyFKKB2NnSGf7CzlDRpTsqSp9rV8=;
        b=Xns/RMYTZ3ThYj2LsKyZDjNTuleVKYK/iHhvGzZEsv24vYxe52AkLIX8v95AQQ5/Nr
         ZgG3c/V7VOsPHkmy5OiaULNiCw8tsj9mLZMSMJNVY4r9Hjh9fOmwDeHl57KHh5dUq1Of
         ubpGEgtIJDdSiGxDt2zy7iBUpcnfqbDDUjA3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Eg660KGx3aZ6+SblyFKKB2NnSGf7CzlDRpTsqSp9rV8=;
        b=U/nZZ5FtqNV5Fbqa/XDiJ+IrCzOFznkWGx2dTftYTQaqoNmNkFm9iIW9JLPOfzURz8
         tvkhjxnsOywrPbbgRCExMHeKxVQ9qTs25PhSYRHX6yEqwV/YuLJGwS6OwTuVDl4IjPt1
         Xj3aqwa4M6bGKFS32qVrbxrH76NmYht9MdJ5aAfyXubLoFlwxPTgCaL220LBDCcpML8d
         4vleJp7t7k9tkYiNAsO3qqitd0fAMD1j4JHacFsl9kwvtGPOXBlXc9NxK98Nxy9cHfig
         krFn9T8Qu4v7LD/mhu+6uy+m4SaG0HpJtv4gzk2zdQ5BKm86GJ34fPIaSI49KI69zHXO
         ylPQ==
X-Gm-Message-State: AMCzsaUNF6Slr9N1cBVDGYrB2BbO3EgfQDKGZjBQTiIwt7xDxTQ0JeCC
        BrLHCEU1Ss4u0DXffBO4jHDDxmEG
X-Received: by 10.55.78.76 with SMTP id c73mr21583068qkb.320.1507236553666;
        Thu, 05 Oct 2017 13:49:13 -0700 (PDT)
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com. [209.85.216.174])
        by smtp.gmail.com with ESMTPSA id c7sm12246884qtg.30.2017.10.05.13.49.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Oct 2017 13:49:13 -0700 (PDT)
Received: by mail-qt0-f174.google.com with SMTP id 34so10780525qtb.13
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:49:13 -0700 (PDT)
X-Google-Smtp-Source: AOwi7QA2Qm85c0W7GXc9gZRu4zogQb2aoBpArIqzyUVgC43nLgsJJlAaUzmWpnY7hzxbWSPSvI+GNd0FEHIiDSgncUI=
X-Received: by 10.237.36.125 with SMTP id s58mr16132625qtc.24.1507236552841;
 Thu, 05 Oct 2017 13:49:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.149.67 with HTTP; Thu, 5 Oct 2017 13:48:52 -0700 (PDT)
In-Reply-To: <xmqqo9pnedar.fsf@gitster.mtv.corp.google.com>
References: <0102015ee1e41f17-927a8da1-ac14-4399-8424-fee8a82c2b0a-000000@eu-west-1.amazonses.com>
 <xmqqo9pnedar.fsf@gitster.mtv.corp.google.com>
From:   Damien <damien@dam.io>
Date:   Thu, 5 Oct 2017 22:48:52 +0200
X-Gmail-Original-Message-ID: <CAAQ5yihCj2uM00bYO2ipEDkh5mT4F7CwbQ48Fae5XFRebO=nRA@mail.gmail.com>
Message-ID: <CAAQ5yihCj2uM00bYO2ipEDkh5mT4F7CwbQ48Fae5XFRebO=nRA@mail.gmail.com>
Subject: Re: [PATCH] run-command.c: add hint when hook is not executable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 4, 2017 at 6:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Damien <damien@dam.io> writes:
>
>> ---
>
> Please explain why this change makes sense to those who find this
> commit in "git log" output six months down the line, without having
> read the original thread that motivated you to add this feature
> above this line with three dashes.  Use your full name on the From:
> header of your mail (or alternatively, you can use an in-body "From:"
> to override what your MUA places there) and add sign-off with the
> same name (cf. Documentation/SubmittingPatches).

Thanks, I'm gonna post another version via submitGit. I'm not sure
how to send the "cover letter" via submitGit so I'm just gonna explain
the patch here and then send it in another message.

First, I changed the name of the config to "advice.ignoredHook"
since it's more generic and it will allow us to add other cases
such as the bad permission case..

> But for the purpose of your patch, you now do care.  access(X_OK)
> may have failed with EACCESS (i.e. you have no permission to run the
> script), in which case your new advise() call may make sense.  But
> it may have failed with ENOENT or ENOTDIR.  And your new advise()
> call is a disaster, if the user didn't even have such a hook.

For sure, the previous version was really broken. I've now added a
EACCES check. But I see two shortcomings left:

  - the message is shown twice (for a "pre-commit" hook at least)
  - I tried to take into account the STRIP_EXTENSION case but
    it's not tested yet

> Writing a test would have helped notice this, I would think.  You'd
> need at least the following variations to cover possibilities:

As you will see, I've added tests but my scripting skills are a bit
lacking and I used a simple "if...then false else true". I've tried
`grep -v` and similar things but this solution is the only one that
I found that really works.

Thanks for the review, see PATCH in a coming email.
