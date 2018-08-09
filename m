Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484131F46C
	for <e@80x24.org>; Thu,  9 Aug 2018 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbeHIT0R (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 15:26:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33805 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeHIT0R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 15:26:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so2839660wme.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gbj/9lXoS4zH7xZF5X0hpi6xBe+SnlTnyjIFGw6gqww=;
        b=T0fIYerjD8lzXi4tFa2qC42J2UZ6RI6W0bKFaZ4isWyp+wYVbGwdvsbYqaFRSjgZoW
         VOqNBV83J8YW/PJjlDr5GZZ7QjgJbd2j+beqC+YW/88joBEWx9YudTjvJNjI6cimD5YL
         P7KyC2Kdex2u8vhTiT7Tnw0yNIWC+4QExhiPd4r3CisdX0RyU+tTr0xC0ICP8kokavr0
         EI1huEfDyAvOFustTCLmzCD19x9dFIzB7fZfMyFQTJavCxH1j6Ir4Q5hXP9zt2shCihM
         dd+DTDc8bM8wjeojxr6Almug3RCiwZ28bHg3yvjeVMv1e9P6YhUauhH+F4xsZjKodsaK
         gdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gbj/9lXoS4zH7xZF5X0hpi6xBe+SnlTnyjIFGw6gqww=;
        b=ZgzGL/hwO56ecY5uFSIjH8UJz6dbot7HVpkhsCgbbPa8GtIIVtq1nKDGoXg9aDMU9x
         6LrZ5hV+fYl4GlzrjyINQmFXF2AES1cK5QlR5BN4XnD+y9oTalgTuNlMarn+DdMqU9T9
         T1fostdfuIM/K3Va6JI06rjlJVPe8pofWjXtLLl2xz2F+iqTgFdc56F+GfQlUrs78nbZ
         u7YvOKDNR5zZPhYUcam2f2mkDmwoZOrQ45+JtJJSk5837ZmoBDObtOBkflFy5+WjvaIk
         2YIPTVws5yG3zJ7eiMr6cRe959t4ffn5raOQUBt701Qr0Fe5sK9hS5EaTCvpZigY5e/n
         8ChA==
X-Gm-Message-State: AOUpUlFJvLJXsEWobwbCDDltjplsl+iJPVib+FH88wNhEq0hAxPdYLsl
        7MEfbRxb49RUDKG/wH60x7u2w4SR
X-Google-Smtp-Source: AA+uWPzFtBD6SnsXB0WjId4maY6ZhBWDgTHyYqsWLZwQA+jqO4nwV4Dt2ozIK6j7DqacDFAjsDv71w==
X-Received: by 2002:a1c:ea53:: with SMTP id i80-v6mr2326083wmh.113.1533834029835;
        Thu, 09 Aug 2018 10:00:29 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-30-228.w86-222.abo.wanadoo.fr. [86.222.29.228])
        by smtp.gmail.com with ESMTPSA id k4-v6sm11217519wrl.12.2018.08.09.10.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:00:28 -0700 (PDT)
Subject: Re: [GSoC][PATCH v5 11/20] rebase -i: rewrite complete_action() in C
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitster@pobox.com
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180731180003.5421-12-alban.gruin@gmail.com>
 <f2698204-c376-0b0c-b151-22b45d482b7c@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <df96eadb-8c97-2c21-3ab9-6ffbaa61160c@gmail.com>
Date:   Thu, 9 Aug 2018 19:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f2698204-c376-0b0c-b151-22b45d482b7c@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 09/08/2018 à 16:22, Phillip Wood a écrit :
>>   +int complete_action(struct replay_opts *opts, unsigned flags,
>> +            const char *shortrevisions, const char *onto_name,
>> +            const char *onto, const char *orig_head, const char *cmd,
>> +            unsigned autosquash)
>> +{
>> +    const char *shortonto, *todo_file = rebase_path_todo();
>> +    struct todo_list todo_list = TODO_LIST_INIT;
>> +    struct strbuf *buf = &(todo_list.buf);
>> +    struct object_id oid;
>> +    struct stat st;
>> +
>> +    get_oid(onto, &oid);
> 
> Is onto guaranteed to exist? If not the return value of get_oid() needs
> to be checked. Otherwise a comment or an assertion might be useful here.
> 

Yes, either the user defines it manually (with --onto=), or it is
automatically determinated by git-rebase.sh.

>> +    shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
>> +
>> +    if (!lstat(todo_file, &st) && st.st_size == 0 &&
>> +        write_message("noop\n", 5, todo_file, 0))
>> +        return error_errno(_("could not write '%s'"), todo_file);
>> +
>> +    if (autosquash && rearrange_squash())
>> +        return 1;
> 
> git functions normally return -1 for an error as the 'return error(...)'
> does above, is there a reason for a different return value here?
> 

No, I will fix this.

>> +
>> +    if (cmd && *cmd)
>> +        sequencer_add_exec_commands(cmd); > +
>> +    if (strbuf_read_file(buf, todo_file, 0) < 0)
>> +        return error_errno(_("could not read '%s'."), todo_file);
>> +
>> +    if (parse_insn_buffer(buf->buf, &todo_list)) {
> 
> I was worried when I saw this because buf is an alias of todo_list.buf
> and I thought passing the same buffer in twice would end badly. However
> parse_insn_buffer() has a confusing signature, it expects the caller to
> have filled todo_list.buf with the buffer to be parsed and to pass a
> pointer to the same buffer. I think this should be cleaned up at some
> point but it is outside the scope of this series.
> 
>> +        todo_list_release(&todo_list);
>> +        return error(_("unusable todo list: '%s'"), todo_file);
>> +    }
>> +
>> +    if (count_commands(&todo_list) == 0) {
>> +        apply_autostash(opts);
>> +        sequencer_remove_state(opts);
>> +        todo_list_release(&todo_list);
>> +
>> +        fputs("Nothing to do\n", stderr);
> 
> The capital 'N' is a faithful copy of the current message in rebase.sh.
> However it might be worth changing it to 'n' to match the normal style
> of git error messages starting with a lowercase letter.
> 
>> +        return 1;
> 
> It might be better to do 'return error(...)' instead
> 

This will require a test change – not a big deal, of course.  It’s
perhaps a good idea to mark this string for translation, too.

>> +    }
>> +
>> +    strbuf_addch(buf, '\n');
>> +    strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
>> +                      "Rebase %s onto %s (%d commands)",
>> +                      count_commands(&todo_list)),
>> +                  shortrevisions, shortonto,
>> count_commands(&todo_list));
>> +    append_todo_help(0, flags & TODO_LIST_KEEP_EMPTY, buf);
>> +
>> +    if (write_message(buf->buf, buf->len, todo_file, 0)) {
>> +        todo_list_release(&todo_list);
>> +        return error_errno(_("could not write '%s'"), todo_file);
>> +    }
>> +
>> +    copy_file(rebase_path_todo_backup(), todo_file, 0666);
>> +    transform_todos(flags | TODO_LIST_SHORTEN_IDS);
> 
> Both of the above lines can fail, so the return values need checking I
> think.
> 
>> +
>> +    strbuf_reset(buf);
>> +
>> +    if (launch_sequence_editor(todo_file, buf, NULL)) {
>> +        apply_autostash(opts);
>> +        sequencer_remove_state(opts);
>> +        todo_list_release(&todo_list);
>> +
>> +        return error(_("could not execute editor"));
> 
> I think  launch_sequence_editor() will have printed an error message
> already, so this is unnecessary.
> 

And the error would be more specific, true.

Thanks!
Alban

