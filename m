Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD25A1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfFMRpQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:45:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42705 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfFMRpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 13:45:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so6411847wrl.9
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 10:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PCBRwsln8OupYgIznMpYpUD4wKcrY5HzESL2YqWPlOk=;
        b=kl9om5OzHVovA7h12wKSQPlh/uCZRLtbwrqJF/RD10HW++fFBxI/nXEBwJ1Ihiv2c3
         T4b6GBHgFA+qeAywOgf3KN1uYwsV6CtL28Fys0g/rNCoesgCrDzr+jdNHVuipkeocPVa
         n2vnR5ZKkExO3l4xfqU6sA6LHRRcKf5bj/9EN5cJTJgzV0bagYqWKERyFaUkiXoXchOC
         hU8eHUj+v5uv0JrGZ8TQLFpB2iu1qY/FfYt6SYS/8zcMUlTP660U+sv5F3TwzICbeXyV
         /acq4pQ+bCKqJSVGzlbicXttO5t3aVDqaiVgkK2HW7IM6n7YUmpEvTWJlI15eb4/LBYK
         eA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PCBRwsln8OupYgIznMpYpUD4wKcrY5HzESL2YqWPlOk=;
        b=ZARu3s1qnGNFXEq3j00P9HFpngH/7+a/7BpFpxpPcaABgEW/D9wFO6ciNKpw36Zjdw
         hhWRsmpdMfK2RTCjqac67BBov4vUcmKM35/UazdxG/wsOENbd+2/pNgl4XcG0Qdy8EiM
         JtBV2yVkwtgqfunqhXjrst3qPi+IXf3xhUmmkTjPxSAxL7CX3phGYPSDME8xZECROVfK
         Qu40JWpnGKiGLhztIR9ESa1s3W/Bpq8ylY1Toxp16gzltq4g0S9UbFYZA9wNcKhgCRMK
         jTNYhmfgyoENl3M4z6MltC9K5kkwbxm6UipJiYURzEIMyeFUJP3IrxXqDzqG968+p6v3
         PZSA==
X-Gm-Message-State: APjAAAUz0yqU21EaZc14pUyoPSL6tKxKIcIsH+NZxFMHe7rFlhbLJ+1F
        U3AEoZXgKdd+1tTMKK08Ne8=
X-Google-Smtp-Source: APXvYqw++0JbZ+2oqQrr9/MIQIMFCGCcvS7BNu1yu1lJhCh96mBTZodmJiStybNlwsVgtFBdOSj7Vw==
X-Received: by 2002:a5d:494d:: with SMTP id r13mr7464889wrs.152.1560447914494;
        Thu, 13 Jun 2019 10:45:14 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id y9sm5904677wma.1.2019.06.13.10.45.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 10:45:13 -0700 (PDT)
Subject: Re: [GSoC][PATCH v3 1/3] sequencer: add advice for revert
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        gitster@pobox.com
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190613040504.32317-1-rohit.ashiwal265@gmail.com>
 <20190613040504.32317-2-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0333fe2f-d68a-4536-c736-ca2a356df34b@gmail.com>
Date:   Thu, 13 Jun 2019 18:45:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613040504.32317-2-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/06/2019 05:05, Rohit Ashiwal wrote:
> In the case of merge conflicts, while performing a revert, we are
> currently advised to use `git cherry-pick --<sequencer-options>`
> of which --continue is incompatible for continuing the revert.
> Introduce a separate advice message for `git revert`. Also change
> the signature of `create_seq_dir` to handle which advice to display
> selectively.
> 
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
> changes:
>     - Following Junio's advice[1], I've changed how we're handling error and
>       advice fundamentally.
> 
> [1]: https://public-inbox.org/git/20190608191958.4593-1-rohit.ashiwal265@gmail.com/T/#mf8eefb068b7246c7c2a02cc8f7120a1a903a1eba
> 
>  sequencer.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index f88a97fb10..918cb5d761 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2650,15 +2650,37 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
>  	return 0;
>  }
>  
> -static int create_seq_dir(void)
> +static int create_seq_dir(struct repository *r)
>  {
> -	if (file_exists(git_path_seq_dir())) {
> -		error(_("a cherry-pick or revert is already in progress"));
> -		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
> +	enum replay_action action;
> +	const char *in_progress_advice;
> +	const char *in_progress_error = NULL;
> +
> +	if (!sequencer_get_last_command(r, &action)) {
> +		switch (action) {
> +		case REPLAY_REVERT:
> +			in_progress_error = _("revert is already in progress");
> +			in_progress_advice =
> +			_("try \"git revert (--continue | --abort | --quit)\"");
> +			break;
> +		case REPLAY_PICK:
> +			in_progress_error = _("cherry-pick is already in progress");
> +			in_progress_advice =
> +			_("try \"git cherry-pick (--continue | --abort | --quit)\"");
> +			break;
> +		default:
> +			BUG(_("the control must not reach here"));

This does not need to be translated as BUG() messages are not really for
users. Everything else looks fine to be now

Best Wishes

Phillip

> +		}
> +	}
> +	if (in_progress_error) {
> +		error("%s", in_progress_error);
> +		advise("%s", in_progress_advice);
>  		return -1;
> -	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
> +	}
> +	if (mkdir(git_path_seq_dir(), 0777) < 0)
>  		return error_errno(_("could not create sequencer directory '%s'"),
>  				   git_path_seq_dir());
> +
>  	return 0;
>  }
>  
> @@ -4237,7 +4259,7 @@ int sequencer_pick_revisions(struct repository *r,
>  	 */
>  
>  	if (walk_revs_populate_todo(&todo_list, opts) ||
> -			create_seq_dir() < 0)
> +			create_seq_dir(r) < 0)
>  		return -1;
>  	if (get_oid("HEAD", &oid) && (opts->action == REPLAY_REVERT))
>  		return error(_("can't revert as initial commit"));
> 

