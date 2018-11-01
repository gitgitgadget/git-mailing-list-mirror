Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 238EF1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 01:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeKAKm5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 06:42:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53171 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeKAKm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 06:42:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id q19-v6so63341wmc.2
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 18:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qIr36YAVQs8DiiopTOgbdyKUCAHGVPhY0uKidYchZJY=;
        b=AhfZg3OZWYcDZcoxS30+rZK+ec7qJYIpwcOFZ7P8HvkAQ0QdYDiWP+WmTHvg7T/s/n
         hcMzjx3A22muragooLaqYOQsT1hvst5vVmldriP2v5IlJUtze9CQJAFMSHt9lrw+fv95
         l1KUGWo+Sa2haLColUepWI3An+lg34R3+oUJwQn6SxhvfxM2G+sfBToDw+qBWuGazJk0
         zGUkKdR/81kkHMb+uY7dLE/aQ6W0QNGJa4NdYryyXc+E69InTo639SLbWHzbMjlvUS5e
         uRx3ALBHb3FCOeJ6kpxI3DTSmV95LGX5G+3EFRfEYXmbftUiyY7B+7abukLuIG3vdG+n
         5Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qIr36YAVQs8DiiopTOgbdyKUCAHGVPhY0uKidYchZJY=;
        b=khXj/qYjS7HHg290dtO4/E4zBwopv10hU3TXDf1OjV9Sr57GsrDHINE3GTWZqm6pu4
         P+Q4OMfz9aPxTURmG8oAP1WjpGyvq0WfCw9eHjRYXe56nHc74z1wBLLal3o22rP7eNlW
         H8426itqmElT2tTp78yOZXmSOtKoxYEJkp1xc24J35oVo8TZYvfaU5piOJbHQUyU9XVV
         SD2EmrQK/agJXoZOKPbmTcoo7/Qw9jYTUV4MO4J1v6GCSI6OS/fGaB0eeKR8sRGV9QSN
         gBQ8Uj0SLkb14HcJmU+8HmsZBGzMTyeImgMRW5CpbdRhOLcAZNvs3ci/IqyYxlTW6Y/w
         LNMw==
X-Gm-Message-State: AGRZ1gK28pLPJaFvUgu7N5hdmFXXFuHqQ734CI7v9YRXznTc7oNQR5qM
        HDe7ze58MENApWp/TC3NnlyjAswA1q0=
X-Google-Smtp-Source: AJdET5cd72JFwYasEBj7C6QA/ERGCqIZQ+/8XcBZJUCD/zAoU54oULz1QPbtghTzQU6FoGBAdXLYmA==
X-Received: by 2002:a1c:4a:: with SMTP id 71-v6mr3924136wma.96.1541036527746;
        Wed, 31 Oct 2018 18:42:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x186-v6sm14803755wmx.24.2018.10.31.18.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 18:42:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     liu.denton@gmail.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, anmolmago@gmail.com,
        briankyho@gmail.com, david.lu97@outlook.com,
        shirui.wang@hotmail.com
Subject: Re: [PATCH v2] completion: use builtin completion for format-patch
References: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com>
        <72331ce9275ce995009fe8dd3d586bb9d71f2cbf.1540881141.git.liu.denton@gmail.com>
        <CACsJy8Ajc0qWw3RLak1PRPXvQzMHjaFuWJ6BPkhiVg=7fQvCnA@mail.gmail.com>
Date:   Thu, 01 Nov 2018 10:42:05 +0900
In-Reply-To: <CACsJy8Ajc0qWw3RLak1PRPXvQzMHjaFuWJ6BPkhiVg=7fQvCnA@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 30 Oct 2018 16:29:07 +0100")
Message-ID: <xmqqk1lxvaj6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> -__git_format_patch_options="
>> -       --stdout --attach --no-attach --thread --thread= --no-thread
>> -       --numbered --start-number --numbered-files --keep-subject --signoff
>> -       --signature --no-signature --in-reply-to= --cc= --full-index --binary
>> -       --not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
>> -       --inline --suffix= --ignore-if-in-upstream --subject-prefix=
>> -       --output-directory --reroll-count --to= --quiet --notes
>> -"
>> -
>>  _git_format_patch ()
>>  {
>>         case "$cur" in
>> @@ -1550,7 +1541,7 @@ _git_format_patch ()
>>                 return
>>                 ;;
>>         --*)
>> -               __gitcomp "$__git_format_patch_options"
>> +               __gitcomp_builtin format-patch
>
> We do want to keep some extra options back because __gitcomp_builtin
> cannot show all supported options of format-patch. The reason is a
> subset of options is handled by setup_revisions() which does not have
> --git-completion-helper support.

Yeah, that is one of the differences I saw compared to the older
one; thanks for being a careful reviewer.


>> @@ -2080,16 +2071,19 @@ _git_send_email ()
>>                 return
>>                 ;;
>>         --*)
>> -               __gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
>> -                       --compose --confirm= --dry-run --envelope-sender
>> -                       --from --identity
>> -                       --in-reply-to --no-chain-reply-to --no-signed-off-by-cc
>> -                       --no-suppress-from --no-thread --quiet --reply-to
>> -                       --signed-off-by-cc --smtp-pass --smtp-server
>> -                       --smtp-server-port --smtp-encryption= --smtp-user
>> -                       --subject --suppress-cc= --suppress-from --thread --to
>> -                       --validate --no-validate
>> -                       $__git_format_patch_options"
>> +               __gitcomp "--all --annotate --attach --bcc --binary --cc --cc= --cc-cmd
>> +                       --chain-reply-to --compose --confirm= --cover-letter --dry-run
>> +                       --dst-prefix= --envelope-sender --from --full-index --identity
>> +                       --ignore-if-in-upstream --inline --in-reply-to --in-reply-to=
>> +                       --keep-subject --no-attach --no-chain-reply-to --no-prefix
>> +                       --no-signature --no-signed-off-by-cc --no-suppress-from --not --notes
>> +                       --no-thread --no-validate --numbered --numbered-files
>> +                       --output-directory --quiet --reply-to --reroll-count --signature
>> +                       --signed-off-by-cc --signoff --smtp-encryption= --smtp-pass
>> +                       --smtp-server --smtp-server-port --smtp-user --src-prefix=
>> +                       --start-number --stdout --subject --subject-prefix= --suffix=
>> +                       --suppress-cc= --suppress-from --thread --thread= --to --to=
>> +                       --validate"
>
> I have no comment about this. In an ideal world, sendemail.perl could
> be taught to support --git-completion-helper but I don't think my
> little remaining Perl knowledge (or time) is enough to do it. Perhaps
> this will do. I don't know.

So "all", "attach", etc. are added to this list while these similar
options are lost from the other variable?  Is this a good trade-off?
