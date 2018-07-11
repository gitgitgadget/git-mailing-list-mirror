Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B3E1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 14:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388612AbeGKOag (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 10:30:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35700 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388548AbeGKOag (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 10:30:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so9163250wrt.2
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Kbh8uECNEL8fDiTdNfrV9NdefbQXY08Y3tl4Ml4WyI=;
        b=QL+wG2ZYWNVdppiIKHvKDmBn3QHFrOE+jrqMPcXl2qZ7sInTJylxH/c9QQFGgDg6LK
         0RLorzfxA/O2DuqBz5LOoBxLnNOPq2bPbkTrh5kL66KxZEHDuyKu7eEnOFMgz5Zv5ikb
         C2Vz1ze/QlDqEK9dvscZbGSepHo86S7eCPdsun4jlgE0E27uJmzlH6s+gns4yep7/RvA
         1+w4TOe8vERI7BTU5Aj+V6h6HdqY48QxUG0PsdM8vDsvaZ9dBNAjCgk3kZEqiS8xb8+a
         v9LjcjRBPZkuRLiWLzMou7vej461pjcShBdi6GXU0jCOoM9szLaz9TjSdc5R81wJVZjg
         mAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Kbh8uECNEL8fDiTdNfrV9NdefbQXY08Y3tl4Ml4WyI=;
        b=shBWCdIkmRy8wnUOnvdrd0axYWkBd+JjDXocPOGJfZlLu42unJl08Jo+0g/fKbOfRq
         R7xoLWg9KrKiCBN956+YrasYde/U8pweruVIOaZE/oaRI+FbQkSyQaPplUvdSu94Omi+
         UElpM1kEIkroLKhfiV8ZJzo+oX6RhHlC2OifMgOVBGdnzEyGquNzt/TAqZGGA+d6LOrk
         SnN2V131xP5B1Q+sDE/DUykS9M+Qb1FPIg+vdCEp7FCyoflHn4wG8a3VDgU9hoiT3ZGG
         oXm/3S+TaHWEfAZNGthaTcoe2zlY8tvgvUw7soNJF3IwSo6tnOQuyY8kvDtEUTNT9Q8M
         GQDg==
X-Gm-Message-State: APt69E3U4jtSZl7+pIkFEP1ytOkriJIGSH1ON8enxmOqeff/xO/wjzsV
        K9C/EZOT+yT5bLT2IX1njpY=
X-Google-Smtp-Source: AAOMgpeJq2WLl/2w4cLMX5CpTi5r9LmZVYVkNxGigRCLkpe7WjqIVAfrAblkVukZ1IWcIZjK1/OTkQ==
X-Received: by 2002:adf:992d:: with SMTP id x42-v6mr20711489wrb.81.1531319158788;
        Wed, 11 Jul 2018 07:25:58 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.gmail.com with ESMTPSA id v25-v6sm1843821wmh.43.2018.07.11.07.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 07:25:57 -0700 (PDT)
Subject: Re: [GSoC][PATCH v3 10/13] rebase--interactive: rewrite
 complete_action() in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180710121557.6698-11-alban.gruin@gmail.com>
 <xmqq4lh667qw.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <c7c20d70-3ad0-4298-66fd-a10e5bb4a91d@gmail.com>
Date:   Wed, 11 Jul 2018 16:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lh667qw.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 11/07/2018 à 00:33, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
>> -	complete_action
>> +	exec git rebase--helper --complete-action "$shortrevisions" "$onto_name" \
>> +		"$shortonto" "$orig_head" "$cmd" $allow_empty_message \
>> +		${autosquash:+--autosquash} ${keep_empty:+--keep-empty} \
>> +		${verbose:+--verbose} ${force_rebase:+--no-ff}
> 
> The $allow_empty_message and later options are all dashed ones.
> git-rebase.sh gives us either empty or --allow-empty-message in the
> variable for $allow_empty_message, and if you follow suit to prepare
> all the other variables that way, the ugly ${frotz+=--frotz} dance
> will all become unnecessary here.
> 

Good idea.

>> +int complete_action(struct replay_opts *opts, unsigned flags,
>> +		    const char *shortrevisions, const char *onto_name,
>> +		    const char *onto, const char *orig_head, const char *cmd,
>> +		    unsigned autosquash, unsigned keep_empty)
>> +{
>> +	const char *shortonto, *todo_file = rebase_path_todo();
>> +	struct todo_list todo_list = TODO_LIST_INIT;
>> +	struct strbuf *buf = &(todo_list.buf);
>> +	struct object_id oid;
>> +	struct stat st;
>> +
>> +	get_oid(onto, &oid);
>> +	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
>> +
>> +	if (!lstat(todo_file, &st) && st.st_size == 0 &&
>> +	    write_message("noop\n", 5, todo_file, 0))
>> +		return error_errno(_("could not write '%s'"), todo_file);
> 
> Wait a minute... thinking back to the early "age-old ommission"
> topic, can the todo file be a non-empty file that does not have any
> command (e.g. just a single blank line, or full of comments and
> nothing else)?  The original wouldn't have added "noop" and then the
> first "do we have anything to do?" check would still have been
> necessary, which would mean that ff74126c's not removing the first
> check was actually not a bug but was a cautious and sensible thing
> to do, and removal of that exact check by this commit becomes a
> regression.  So,... can the todo file be a non-empty file that does
> not have any command in it at this point?
> 

Hum, yes, if the commits are empty, and if rebase was invoked without
the `--keep-empty` flag.  In this case, it would die with the message
“Nothing to do”, instead of dropping the commit altogether.

I will add a test case in the next iteration.

>> +	if (autosquash && rearrange_squash())
>> +		return 0;
> 
> The original, when rearrange-squash failed, exited with failure,
> like so:
> 
> -       test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
> 
> Now this function returns success when rearrange_squash fails.  
> Is that intended?
> 

Yes, it is.  I just saw in the man page that `exit` returns the last
exit status.

>> +	if (cmd && *cmd)
> 
> Shouldn't it be a BUG (programming error) if cmd == NULL?  I thought
> the caller of complete_action() in this patch insisted that it got
> argc == 6 or something, so *cmd might be NUL but cmd would never be
> NULL if I understand your code correctly.  IOW, shouldn't the line
> be more like:
> 
> 	if (!cmd)
> 		BUG("...");
> 	if (*cmd)
> 
> ?
> 

I don’t know, it’s not really problematic if cmd is NULL.  And I think
that when interactive rebase will be a builtin, it will be possible for
cmd to be NULL.

> 
>> +	if (strbuf_read_file(buf, todo_file, 0) < 0)
>> +		return error_errno(_("could not read '%s'."), todo_file);
>> +	if (parse_insn_buffer(buf->buf, &todo_list)) {
> 
> Nice that we have parse* function.  We do not have to work with
> stripspace plus "wc -l" ;-).
> 
>> +		todo_list_release(&todo_list);
>> +		return error(_("unusable todo list: '%s'"), todo_file);
> 
> When the users see this error message, is it easy for them to
> diagnose what went wrong (e.g. has parse_insn_buffer() already
> issued some message to help pinpoint which insn in the todo list is
> misspelt, for example)?
> 

Yes, parse_insn_buffer() will say which line caused the error.  But at
this point, the user should not have changed the todo-list, so this
error should never appear.

Perhaps this is a good use case of BUG()?

>> +	}
>> +
>> +	strbuf_addch(buf, '\n');
>> +	strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
>> +				      "Rebase %s onto %s (%d commands)",
>> +				      todo_list.nr),
>> +			      shortrevisions, shortonto, todo_list.nr);
>> +	append_todo_help(0, keep_empty, buf);
>> +
>> +	if (write_message(buf->buf, buf->len, todo_file, 0)) {
>> +		todo_list_release(&todo_list);
>> +		return error_errno(_("could not write '%s'"), todo_file);
>> +	}
>> +	copy_file(rebase_path_todo_backup(), todo_file, 0666);
>> +	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
>> +
> 
> It is a bit sad that we are mostly working on the byte array
> buf->buf (or external file touched by various helper functions we
> call), even though we have a perfectly usable parsed representation
> in todo_list structure in all of the above and the rest of this
> function.
> 
> It might be better to grab todo_list.nr into a local simple integer
> variable immediately after parse_insn_buffer() returns and then call
> todo_list_release() on todo_list, as the parsed todo-list is only
> used for two purposes (i.e. detecting format error by seeing if
> parser returns success, and seeing how many insns are on the todo
> list by checking todo_list.nr field) and nothing else.  By releasing
> the otherwise unused todo_list early, you do not have to sprinkle
> various error return codepaths with calls to todo_list_release().
> 
> That incidentally would manage too high expectation from readers of
> the code as well ;-).
> 

Unfortunately, this strbuf is part of the todo_list, and it will be
freed if I call todo_list_release().

:/

Cheers,
Alban

