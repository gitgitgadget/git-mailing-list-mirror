Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6361F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 12:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbfJHMEV (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 08:04:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40613 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730728AbfJHMEU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 08:04:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so10375146wrv.7
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:reply-to:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=el2c9jUdgCKgRpgH+W8BSr8cR+LBJkYsfSOf2LTz20E=;
        b=TnTfp5xC1Wv42xWhKfYAR9vZCEXYO7YWaZMAt0gO4cvNA6LMpM98/UeGvHy2I+2Rae
         Yw9rCWGJo3yZpaam/SL6pCzf/WqzsChBAbndlOA1APuwV0wEcVK6D/+A1HDpTG6ViBoN
         IkyTi9DvpPVkdMvvpICCM5shXC7zp7j+kjrSlajZ6D1Hn6CUtfOUjSC734uGfC/i0RXw
         GweYHKQ7oFzd6cJziV1VTFT1J6obMRHYNPlMJwW7TsKkpT2FBPC8lg1e7BSQy9yA7md9
         mwYpjiH1SsOeRWJkx/0wbRHxVhyo1ZQ7P8rxzjoH1x2dCzH3+YX3zANGt7x57EZ2G6HE
         KKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:reply-to:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=el2c9jUdgCKgRpgH+W8BSr8cR+LBJkYsfSOf2LTz20E=;
        b=qe/F0gMdYHiQjPrfqayncDOqbRkY7Xluc3abzesfoBGdIqOaCVLFvU1GRgFxY1svXT
         b/MSzXAR/2RFVDXUpz3pnfukALuJjbefwjVclUsXmAxAPr8kQTEYzr+7IswoO/GsQDyw
         JVlr2jLc1YmVNRuXPc6yuwIY1oy6dqfXkmKOp1qMM5ieOTMktu/4YwMvfOSSM6ujLMiK
         SlRPybFdiIwGhYDYdKMqtVB882hfyacSW5Ej2TlDFAeM9n5YOfKw38ANGInDTW/HrNwV
         SmzrYCba572iAKQnmPbYfnVIbNHFYzmTT/L40FvhVOzjPIHEeN7PaWrBEoxwYMNxWA3m
         uBgQ==
X-Gm-Message-State: APjAAAUoth3pdYIlypfokVVN0wFTGv2rhAgSwwrVcv0xv7WArOzYW/a1
        0/mD4H/jzE5qufUvGTomNUY=
X-Google-Smtp-Source: APXvYqyWmvHLPkmrAPqUaFSS5QfaVX/71W0GblDDNerC9aQm2Rzwdn5ebRiptkdZy45U+FeKBYTVCQ==
X-Received: by 2002:adf:e84c:: with SMTP id d12mr3437444wrn.373.1570536256898;
        Tue, 08 Oct 2019 05:04:16 -0700 (PDT)
Received: from [192.168.2.201] (host-92-22-28-119.as13285.net. [92.22.28.119])
        by smtp.googlemail.com with ESMTPSA id a9sm5563230wmf.14.2019.10.08.05.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 05:04:16 -0700 (PDT)
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc:     Zeger-Jan van de Weg <git@zjvandeweg.nl>,
        Denton Liu <liu.denton@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
References: <20191008074935.10972-1-toon@iotcl.com>
 <76753409-34f2-d016-81a9-ea6e3d0e34bd@gmail.com>
Message-ID: <8a018227-b055-15e5-d1c1-ac41f24c155b@gmail.com>
Date:   Tue, 8 Oct 2019 13:04:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <76753409-34f2-d016-81a9-ea6e3d0e34bd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/10/2019 11:11, Phillip Wood wrote:
> Hi Toon & Zeger-Jan
> 
> On 08/10/2019 08:49, Toon Claes wrote:
>> Add support to provide the Co-author when committing. For each
>> co-author provided with --coauthor=<coauthor>, a line is added at the
>> bottom of the commit message, like this:
>>
>>      Co-authored-by: <coauthor>
>>
>> It's a common practice use when pairing up with other people and both
>> authors want to in the commit message.
> 
> Thanks for the patch, it's looking good. I can see this being useful to
> some people - I like the way the patch itself is co-authored.
> [...]
>> @@ -803,6 +805,10 @@ static int prepare_to_commit(const char
>> *index_file, const char *prefix,
>>       if (clean_message_contents)
>>           strbuf_stripspace(&sb, 0);
>>
>> +    for (i = 0; i < coauthors.nr; i++) {
>> +        append_coauthor(&sb, coauthors.items[i].string);
> 
> If you look at the existing code that's calling append_signoff() it does
>   append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0)
> The purpose of ignore_non_trailer is to ignore comment and conflicts
> messages at the end of the commit message (there's more detail in a
> comment above it's definition in builtin/commit.c). I think we need to
> pass this offset when adding co-authors as well.
> 
> One question - what is the desired de-duplication behavior of
> Co-authored-by:? What happens if there is already a matching
> Co-authored-by: footer? (It is also possible for the trailers code to
> only ignore an existing footer if it's the last one.) What happens if
> the same Co-authored-by: is duplicated on the command line? It would be
> nice to have this defined and tests to check it's enforced.

I should give a bit more detail here. git-interpret-trailers gives more
control over handling of duplicates that is configurable via 'git
config' than 'commit --signoff' does. The reason for this is that
'commit --signoff' predates the interpret-trailers stuff. As we're
adding a new footer command we should decide if we want it to act like
--signoff or give the user the ability to configure the de-duplication
behavior by using the interpret-trailers code path instead. (I think
format-patch --signoff respects the interpret-trailers config variables
but 'am --signoff' and 'cherry-pick --signoff' do not.

> 
> Another useful addition would be to check that the footer value looks
> sane but that could come later

Looking at the way commit handles --author (grep for force_author in
builtin/commit.c) it should be simple to add these checks - just call
split_ident() and check it returns zero. --author also checks if the
string contains '<' and if it doesn't it uses the string given on the
command line to lookup a matching author in the commit log - that could
be a nice feature to use here too (see the code that calls
find_author_by_nickname()).

Best Wishes

Phillip

 - I don't think we do that for any other
> footers at the moment (though I haven't checked to see if that's really
> true)
> 
>> +    }
>> +
>>       if (signoff)
>>           append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
>>
>> @@ -1504,6 +1510,7 @@ int cmd_commit(int argc, const char **argv,
>> const char *prefix)
>>           OPT_STRING(0, "squash", &squash_message, N_("commit"),
>> N_("use autosquash formatted message to squash specified commit")),
>>           OPT_BOOL(0, "reset-author", &renew_authorship, N_("the
>> commit is authored by me now (used with -C/-c/--amend)")),
>>           OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
>> +        OPT_STRING_LIST(0, "coauthor", &coauthors, N_("co-author"),
>> N_("add Co-authored-by:")),
>>           OPT_FILENAME('t', "template", &template_file, N_("use
>> specified template file")),
>>           OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
>>           OPT_CLEANUP(&cleanup_arg),
>> diff --git a/sequencer.c b/sequencer.c
>> index d648aaf416..8958a22470 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -36,6 +36,7 @@
>>   #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>>
>>   static const char sign_off_header[] = "Signed-off-by: ";
>> +static const char coauthor_header[] = "Co-authored-by: ";
>>   static const char cherry_picked_prefix[] = "(cherry picked from
>> commit ";
>>
>>   GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
>> @@ -4385,15 +4386,9 @@ int sequencer_pick_revisions(struct repository *r,
>>       return res;
>>   }
>>
>> -void append_signoff(struct strbuf *msgbuf, size_t ignore_footer,
>> unsigned flag)
>> +static void append_footer(struct strbuf *msgbuf, struct strbuf* sob,
>> size_t ignore_footer, size_t no_dup_sob)
>>   {
>> -    unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
>> -    struct strbuf sob = STRBUF_INIT;
>> -    int has_footer;
>> -
>> -    strbuf_addstr(&sob, sign_off_header);
>> -    strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
>> -    strbuf_addch(&sob, '\n');
>> +    size_t has_footer;
>>
>>       if (!ignore_footer)
>>           strbuf_complete_line(msgbuf);
>> @@ -4402,11 +4397,11 @@ void append_signoff(struct strbuf *msgbuf,
>> size_t ignore_footer, unsigned flag)
>>        * If the whole message buffer is equal to the sob, pretend that we
>>        * found a conforming footer with a matching sob
>>        */
>> -    if (msgbuf->len - ignore_footer == sob.len &&
>> -        !strncmp(msgbuf->buf, sob.buf, sob.len))
>> +    if (msgbuf->len - ignore_footer == sob->len &&
>> +        !strncmp(msgbuf->buf, sob->buf, sob->len))
>>           has_footer = 3;
>>       else
>> -        has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
>> +        has_footer = has_conforming_footer(msgbuf, sob, ignore_footer);
>>
>>       if (!has_footer) {
>>           const char *append_newlines = NULL;
>> @@ -4440,7 +4435,32 @@ void append_signoff(struct strbuf *msgbuf,
>> size_t ignore_footer, unsigned flag)
>>
>>       if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
>>           strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
>> -                sob.buf, sob.len);
>> +                sob->buf, sob->len);
>> +}
>> +
>> +void append_signoff(struct strbuf *msgbuf, size_t ignore_footer,
>> unsigned flag)
>> +{
>> +    unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
>> +    struct strbuf sob = STRBUF_INIT;
>> +
>> +    strbuf_addstr(&sob, sign_off_header);
>> +    strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
>> +    strbuf_addch(&sob, '\n');
>> +
>> +    append_footer(msgbuf, &sob, ignore_footer, no_dup_sob);
>> +
>> +    strbuf_release(&sob);
>> +}
>> +
>> +void append_coauthor(struct strbuf *msgbuf, const char *coauthor)
>> +{
>> +    struct strbuf sob = STRBUF_INIT;
>> +
>> +    strbuf_addstr(&sob, coauthor_header);
>> +    strbuf_addstr(&sob, coauthor);
>> +    strbuf_addch(&sob, '\n');
>> +
>> +    append_footer(msgbuf, &sob, 0, 1);
> 
> As we have a constant for APPEND_SIGNOFF_DEDUP can we use it here please
> rather than '1' which does not covey the same meaning to the author.
> Also as I said above I think you want to pass in a real value for
> ignore_footer not zero
> 
>>
>>       strbuf_release(&sob);
>>   }
>> diff --git a/sequencer.h b/sequencer.h
>> index 574260f621..e36489fce7 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -170,6 +170,8 @@ int todo_list_rearrange_squash(struct todo_list
>> *todo_list);
>>    */
>>   void append_signoff(struct strbuf *msgbuf, size_t ignore_footer,
>> unsigned flag);
>>
>> +void append_coauthor(struct strbuf *msgbuf, const char* co_author);
>> +
>>   void append_conflicts_hint(struct index_state *istate,
>>           struct strbuf *msgbuf, enum commit_msg_cleanup_mode
>> cleanup_mode);
>>   enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
>> index 14c92e4c25..5ed6735cf4 100755
>> --- a/t/t7502-commit-porcelain.sh
>> +++ b/t/t7502-commit-porcelain.sh
>> @@ -138,6 +138,17 @@ test_expect_success 'partial removal' '
>>
>>   '
>>
>> +test_expect_success 'co-author' '
>> +
>> +    >coauthor &&
>> +    git add coauthor &&
>> +    git commit -m "thank you" --co-author="Author
>> <author@example.com>" &&
>> +    git cat-file commit HEAD >commit.msg &&
>> +    sed -ne "s/Co-authored-by: //p" commit.msg >actual &&
>> +    echo "Author <author@example.com>" >expected &&
>> +    test_cmp expected actual
>> +'
> 
> This is fine as far as it goes but it would be nice to test the
> de-duplication behavior once that's defined
> 
> Best Wishes
> 
> Phillip
> 
>>   test_expect_success 'sign off' '
>>
>>       >positive &&
>> -- 
>> 2.22.0.rc3
>>

