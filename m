Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B0E20248
	for <e@80x24.org>; Tue, 12 Mar 2019 05:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfCLFum (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 01:50:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40271 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfCLFul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 01:50:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id t5so61877wri.7
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2pvCxK6L2CxWd3OQgKi0sMYKYqhWWLkivJEfqAf/GPI=;
        b=jNVsfbuG05CRoglT/p57ZAqvMvrALYWPHrfbAThvIV+TMz94/cdNqs+5vDF7ILTWcK
         qWTyfwxG67DIwSwdi77323LaXW18i0mC977Ir3kA69c5hyYh3gnuYODbHDmuz1jXUoNZ
         OpavYBh4jpXf5xzUkSIQy++u6WwEpIDY5CXDzUZYelQuhdfxcp58OHpr2vuUmzFExrBr
         9eprv1tqBSWxFTH2DXWUfg2vUWoVIaKKH4ydaVKfjm71sxD7iHR7C0BlPSkLRNWrDmRc
         2J7SGE03BxMA6kJxtEP7UPPxIiAlPamYeIFUdobS0WObcGoeKp6CO385kX46mkeJ3mgQ
         RN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2pvCxK6L2CxWd3OQgKi0sMYKYqhWWLkivJEfqAf/GPI=;
        b=PxLM5aiDOpyXImW5UlvuV3/wH1HewZkA6A9cku2KTOs3GVAEdFb2XvOFX/+CSqqtVL
         9kpBnvFa7peCIiwU+MZmqxNDHFPi4HszZPWnQiWZOvu5O3MAj1LjD8ZAqzMoUCwLPcdx
         gsgXG4SWZdU0IGHTvlH1rTduRd+Z+o6nlls/n+VGBNPRfhKvRpHlOnpc2edCZUTMHvLZ
         8KrI37biWxBGd2SHxiKyAxL2meGzlRGwEp+sxMwN75P4D8HmbL8GUGTchO5HsAbDEVMw
         GISx4+nWeMvYSUrsi9SJVN792EjjVB4Sj4rxKGaI/Lsdg6Aj2AkQXfOU8+LFtj3itDux
         LgOw==
X-Gm-Message-State: APjAAAVkZouyR6OSKznwrzWk3IdyN66oHx8FsjafNERL8EtOAoTT8LAi
        v5JfR85hRFkTFIJQ1mh0nN1T7J845Yk=
X-Google-Smtp-Source: APXvYqxIag4sy1gT9Qw19cYsBm3JNUUyYjH6mRjFeV7p2EEFhfe4y3pM+fEcVFjVNUNkyoACkFOjKA==
X-Received: by 2002:adf:e3ca:: with SMTP id k10mr8762936wrm.277.1552369840039;
        Mon, 11 Mar 2019 22:50:40 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id h137sm1397050wmg.41.2019.03.11.22.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 22:50:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v7 5/8] merge: cleanup messages like commit
References: <cover.1548219737.git.liu.denton@gmail.com>
        <cover.1552275703.git.liu.denton@gmail.com>
        <b2b82954e7060a3f5d47f77e4743493ff4256bd6.1552275703.git.liu.denton@gmail.com>
        <c151ea74-ed9b-f33c-eb14-03243325eaf7@gmail.com>
Date:   Tue, 12 Mar 2019 14:50:37 +0900
In-Reply-To: <c151ea74-ed9b-f33c-eb14-03243325eaf7@gmail.com> (Phillip Wood's
        message of "Mon, 11 Mar 2019 16:58:23 +0000")
Message-ID: <xmqqsgvsiqtu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> -	if (0 < option_edit)
>> -		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
>> +	if (0 < option_edit) {
>> +		strbuf_addch(&msg, '\n');
>> +		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
>> +			wt_status_append_cut_line(&msg);
>> +		else
>> +			strbuf_commented_addf(&msg, _(comment_line_explanation), comment_line_char);
>> +
>> +		strbuf_commented_addf(&msg, "\n");
>> +		strbuf_commented_addf(&msg, _(merge_editor_comment));
>
> I think this has rearranged the message presented to the user so it
> now reads
>
> Lines starting with '#' will be ignored.
> Please enter a commit message to explain why this merge is necessary,
> especially if it merges an updated upstream into a topic branch.
>
> An empty message aborts the commit.
>
> To me it read better before, it would be a little more work but I
> think it would be worth preserving the message (especially as this is
> the message people will see unless they specify --cleanup=scissors)

That may be subjective, but unless the new message is vastly and
uncontroversially better (which I do not think it is, with your
objection), I agree that we should avoid churning the message.

>> @@ -168,6 +169,9 @@ static struct option pull_options[] = {
>>   	OPT_PASSTHRU(0, "edit", &opt_edit, NULL,
>>   		N_("edit message before committing"),
>>   		PARSE_OPT_NOARG),
>> +	OPT_PASSTHRU(0, "cleanup", &opt_cleanup, NULL,
>> +		N_("how to strip spaces and #comments from message"),
>> +		PARSE_OPT_NOARG),
>
> cleanup needs to take an argument so PARSE_OPT_NOARG does not look
> right. Also I think it would be bettor from the user's point of view
> if the value of the argument was checked by pull before it does any
> work rather otherwise if they pass in invalid value pull mostly runs
> and then merge errors out at the end.

Both good points.
