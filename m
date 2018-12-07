Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B896220A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLGWXt (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:23:49 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35002 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGWXt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:23:49 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so4932590edx.2
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=88PTQK7us9tgz5esMnzR27thZQJWIiYLPZ9A8slEKo4=;
        b=ezJJrI9NBd9GKLF0Rr6fWPDQscMARm1ep4yVALZCdolWAZS67Fscdo38mpcSANJZL/
         62L2LfcZqJvWygT92D6cx51c4tQAJmRqEJYPIWqY5/CgLgnqijRTz0fYrYsCvEtKTnd3
         8zIJ4g5cHnVHiKPVooyQKIaQNYh7UBJLXD4MDAIgAjsLNEbK8csrKklIQdjiL/bdiHsk
         qFpUYCGSruVa1KpHWxw8CNaMnSCKA3GPhIOOZtbcxTo+hE0w6Tkqdv/NoI+fbPqNjZk2
         BFofhZu+c7JDlB7r0yYLFQoqplGbg/47AOG9LwnwUnL+ljVhlehEwOvizxgAQv7RmVB2
         hqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=88PTQK7us9tgz5esMnzR27thZQJWIiYLPZ9A8slEKo4=;
        b=ZmQemw/kAdXiLt4J6Myw/iYqY1dJW/IlsgccMk4uy+QTmlabYfh4MZmggSaqhHzCNt
         CmOvAg6D8WQjK/aP2zGuEjw9eftYBuRWiXW3iK4NgS8EWXg0RQ3iS2m6wBOffgHBdVFJ
         8jOqRLG2JgkqYjbXZxo+lyZQfF6DEtXJTrv9XBzMW4pBusxUXDfWWkwitUxcoPFvkZuy
         UsyUWf0sts6aCEljoNeUGA1QUafJtZQnt2D8ttFOPI+u+qfOSATV9r7LspuuMGE2pWrt
         jEF6ckZiNH6eW+5rPN9DyaWtKgyPKBck1UNqXF5plzPhkHtoL2CK0ggK88zq4mKhbnMU
         ac4Q==
X-Gm-Message-State: AA+aEWZkJOiFm10KkxYj43j8byp4JPw4lNbXOlfntO7r/RLGolwWValG
        R0i8AbwHwhP4SsluyH8Ieh5nieCf
X-Google-Smtp-Source: AFSGD/V3tc+qLi2PcB2nfU2+q35Xtck+6oxaTm+kJdyi069L14M2Y0OB4BhEagPjPf/+ohcQyrEFtw==
X-Received: by 2002:a50:a125:: with SMTP id 34mr3565051edj.175.1544221426826;
        Fri, 07 Dec 2018 14:23:46 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id h51sm1471060edh.17.2018.12.07.14.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 14:23:46 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: RFE: git-patch-id should handle patches without leading "diff"
References: <20181207181942.GA6411@pure.paranoia.local> <20181207220116.GB73340@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181207220116.GB73340@google.com>
Date:   Fri, 07 Dec 2018 23:23:45 +0100
Message-ID: <87tvjpx9fy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 07 2018, Jonathan Nieder wrote:

> Hi,
>
> Konstantin Ryabitsev wrote:
>
>> Every now and again I come across a patch sent to LKML without a leading
>> "diff a/foo b/foo" -- usually produced by quilt. E.g.:
>>
>> https://lore.kernel.org/lkml/20181125185004.151077005@linutronix.de/
>>
>> I am guessing quilt does not bother including the leading "diff a/foo
>> b/foo" because it's redundant with the next two lines, however this
>> remains a valid patch recognized by git-am.
>>
>> If you pipe that patch via git-patch-id, it produces nothing, but if I
>> put in the leading "diff", like so:
>>
>> diff a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>>
>> then it properly returns "fb3ae17451bc619e3d7f0dd647dfba2b9ce8992e".
>
> Interesting.  As Ævar mentioned, the relevant code is
>
> 		/* Ignore commit comments */
> 		if (!patchlen && !starts_with(line, "diff "))
> 			continue;
>
> which is trying to handle a case where a line that is special to the
> parser appears before the diff begins.
>
> The patch-id appears to only care about the diff text, so it should be
> able to handle this.  So if we have a better heuristic for where the
> diff starts, it would be good to use it.

No, the patch-id doesn't just care about the diff, it cares about the
context before the diff too.

See this patch:

    $ git diff-tree --src-prefix=x/ --dst-prefix=y/ -p HEAD~..
    diff --git x/refs/files-backend.c y/refs/files-backend.c
    index 9183875dad..dd8abe9185 100644
    --- x/refs/files-backend.c
    +++ y/refs/files-backend.c
    @@ -180,7 +180,8 @@ static void files_reflog_path(struct files_ref_store *refs,
                    break;
            case REF_TYPE_OTHER_PSEUDOREF:
            case REF_TYPE_MAIN_PSEUDOREF:
    -               return files_reflog_path_other_worktrees(refs, sb, refname);
    +               files_reflog_path_other_worktrees(refs, sb, refname);
    +               break;
            case REF_TYPE_NORMAL:
                    strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
                    break;

Observe that the diff --git line matters, we hash it:

    $ git diff-tree -p HEAD~.. | git patch-id
    5870d115b7e2a9a936ab8fdc254932234413c710 0000000000000000000000000000000000000000
    $ git diff-tree --src-prefix=a/ --dst-prefix=b/ -p HEAD~.. | git patch-id --stable
    5870d115b7e2a9a936ab8fdc254932234413c710 0000000000000000000000000000000000000000
    $ git diff-tree --src-prefix=x/ --dst-prefix=y/ -p HEAD~.. | git patch-id --stable
    4cd136f2b98760150f700ac6a5b126389d6d05a7 0000000000000000000000000000000000000000

The thing it doesn't care about is the "index" between the "diff" and
patch:

    $ git diff-tree --src-prefix=x/ --dst-prefix=y/ -p HEAD~.. | grep -v ^index | git patch-id --stable
    4cd136f2b98760150f700ac6a5b126389d6d05a7 0000000000000000000000000000000000000000

We also care about the +++ and --- lines:

    $ git diff-tree --src-prefix=x/ --dst-prefix=y/ -p HEAD~.. | grep -v ^index | perl -pe 's/^(\+\+\+|---).*/$1/g' | git patch-id
    56985c2c38cce6079de2690082e1770a8e81214c 0000000000000000000000000000000000000000

Then we normalize the @@ line, e.g.:

    $ git diff-tree --src-prefix=x/ --dst-prefix=y/ -p HEAD~.. | grep -v ^index | git patch-id
    4cd136f2b98760150f700ac6a5b126389d6d05a7 0000000000000000000000000000000000000000
    $ git diff-tree --src-prefix=x/ --dst-prefix=y/ -p HEAD~.. | grep -v ^index | perl -pe 's/\d+/123/g' | git patch-id
    4cd136f2b98760150f700ac6a5b126389d6d05a7 0000000000000000000000000000000000000000


There's other caveats (see the code, e.g. "strip space") but to a first
approximation a patch id is a hash of something that looks like this:
    
    diff --git x/refs/files-backend.c y/refs/files-backend.c
    --- x/refs/files-backend.c
    +++ y/refs/files-backend.c
    @@ -123,123 +123,123 @@ static void files_reflog_path(struct files_ref_store *refs,
                    break;
            case REF_TYPE_OTHER_PSEUDOREF:
            case REF_TYPE_MAIN_PSEUDOREF:
    -               return files_reflog_path_other_worktrees(refs, sb, refname);
    +               files_reflog_path_other_worktrees(refs, sb, refname);
    +               break;
            case REF_TYPE_NORMAL:
                    strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
                    break;

Which means that accepting a patch like this as input would actually
give you a different patch-id than if it had the proper header.

So it seems most sensible to me if this is going to be supported that we
go a bit beyond the call of duty and fake up the start of it, namely:

    --- a/arch/x86/kernel/process.c
    +++ b/arch/x86/kernel/process.c

To be:

    diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
    --- a/arch/x86/kernel/process.c
    +++ b/arch/x86/kernel/process.c

It'll make the state machine a bit more complex, but IMO it would suck
more if we generate a different hash depending on the tool generating
the diff. OTOH the "diff --git" line was never there, and it *does*
matter, so should we be faking it up? Maybe not, bah!

> "git apply" uses apply.c::find_header, which is more permissive.
> Maybe it would be possible to unify these somehow.  (I haven't looked
> closely enough to tell how painful that would be.)
>
> Thanks and hope that helps,
> Jonathan
