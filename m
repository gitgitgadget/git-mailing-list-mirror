Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E844AC74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 20:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCWUjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCWUjb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 16:39:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1902B4C33
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:39:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u10so27334plz.7
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679603969;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=keUU/6EkEGEQuxRhDJTVHwGGVVYRFxcMK+kBfVf8Ixk=;
        b=fnaLnLsApGvDMqugfAx+ouZkvWQYSPw1IEp5AwUfgO8zn3RmOVnur3j9pyDhmHAkqY
         SCuirfVbuqZE/Jf1ePZ5XLNoU7OTq+WouT2R9DIrW/gaHO6XfBq9uUnnOB11YNjsG52P
         /GXx7Yy7y+tuAhgRdYrUxMryBeyfXpDSkWK/LSdhuCNn6fEFGgEotl5NgQexnuc1gE1m
         jcA2jVU+J/ncJRGR5NhxOdf0Ct/LvDywxpXRlQ/yM8KGla/sv1/7Jcho4Sz5hDshhSQu
         S5v9JEJ9xAZxUVKHXR+YXtd4lwL08eOaNYZhQwS3C7a7qp2FzvFKQYmNALS9YUiQNHjO
         +iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679603969;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=keUU/6EkEGEQuxRhDJTVHwGGVVYRFxcMK+kBfVf8Ixk=;
        b=OLRK7eXVs9dlbf3Gr1bBsJKwiGBF3a62pd1w5nkN5uzI7O8T+j7ENYP/CYhGQ+owtR
         0YiCrXBiJp94OazVb+SW55kYqLElRpeAi/Chs7Nu+CnNDfvvb4vQgud5lBAYMDshEzrj
         TazPVXNCilVQyiJSNfqgSvckYbWo6UZ/VDmoav6bhh8+5zgzBbNORcF0J9XQ+SUHpYZ1
         MYF6eLmF+oHekW728YiStO5qTL0rXqG9COYUKFWkrELdRF8C30D7llaGNk6KF4bNEkJ7
         j7gLQiySche+d0D5CUAN/22x3PtUDYyUOBH2CjQFNiBfbVKj2KfraIkpaqNbK8AhXKXE
         C0DA==
X-Gm-Message-State: AAQBX9cPWut2qS8aZGuG2PfQc7J8lNdFpbdq3nGczMwORJM3ut+A2hhM
        ltbYT/x6dOvR78ahrqNyFf2QyIg/tqY=
X-Google-Smtp-Source: AKy350b9sqSd02CeOI7RNN25praHzLPSWOqaunbKFhmkJ5vTvnC/DTGVODUKIEdmB2hEBv7aX0b6Yg==
X-Received: by 2002:a17:903:2890:b0:19a:b869:f2f8 with SMTP id ku16-20020a170903289000b0019ab869f2f8mr193704plb.21.1679603969373;
        Thu, 23 Mar 2023 13:39:29 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b0019f2a7f4d16sm12804919plb.39.2023.03.23.13.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 13:39:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] Capitalization and punctuation fixes to some user
 visible messages
References: <20230323162234.995485-1-oswald.buddenhagen@gmx.de>
Date:   Thu, 23 Mar 2023 13:39:28 -0700
In-Reply-To: <20230323162234.995485-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Thu, 23 Mar 2023 17:22:32 +0100")
Message-ID: <xmqqttyb6w3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

>  			require_clean_work_tree(the_repository,
>  				N_("pull with rebase"),
> -				_("please commit or stash them."), 1, 0);
> +				_("Please commit or stash them."), 1, 0);

The require_clean_work_tree() function uses the message this patch
touches here like so:

	...
	if (err) {
		if (hint)
			error("%s", hint);
		if (!gently)
			exit(128);
	}

and the message given to error() is shown with "error: " prefix.
Our friendly CodingGuidelines is fairly clear on what to do to a
single sentence error message like this one:

| Error Messages
| 
|  - Do not end error messages with a full stop.
| 
|  - Do not capitalize the first word, only because it is the first word
|    in the message ("unable to open %s", not "Unable to open %s").  But
|    "SHA-3 not supported" is fine, because the reason the first word is
|    capitalized is not because it is at the beginning of the sentence,
|    but because the word would be spelled in capital letters even when
|    it appeared in the middle of the sentence.

So, if you want to touch this message, what you want to do is to
leave the capitalization alone, but to drop the full stop at the
end.

> diff --git a/sequencer.c b/sequencer.c
> index 3be23d7ca2..fda68cd33d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3629,13 +3629,13 @@ static int do_exec(struct repository *r, const char *command_line)
>  			  "\n"),
>  			command_line,
>  			dirty ? N_("and made changes to the index and/or the "
> -				"working tree\n") : "");
> +				"working tree.\n") : "");

I think this long and multi-sentence warning message should be split
into two and the latter half should become an advice message that
the user can squelch.  Until it happens, which would require us to
rewrite these messages, I wouldn't bother touching this message if I
were you.

>  	} else if (dirty) {
>  		warning(_("execution succeeded: %s\nbut "
> -			  "left changes to the index and/or the working tree\n"
> +			  "left changes to the index and/or the working tree.\n"
>  			  "Commit or stash your changes, and then run\n"
>  			  "\n"
>  			  "  git rebase --continue\n"

Likewise.
