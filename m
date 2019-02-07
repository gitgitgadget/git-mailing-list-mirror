Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 915AA1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 17:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfBGR3t (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 12:29:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35232 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGR3s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 12:29:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so753080wmt.0
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 09:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=uZcCt3NFTYRuGN2wmwxIRKBLFoqC0OaZEtQlZOyOl+w=;
        b=ZRGN+4B86QeIePodZP02Rbp4QqCn0xc44ITyADnMbO3aXvYootPvZktxOuk9DlIfwD
         niQoMdFs3OXEKMt5C8nBnzM5Y3jwm53FV6MHINeBtT0dD1xKVVyzQ2cLm6doTy27Ngej
         uqbpgpix2tY4MV63uEOXsYfEuPcYQDpOltIqZMG6ydnh5c/fjMOKY0pUbF9gMrJTOsRx
         qnFqE0zZGWhgH7gIwMVIvH8oofGpqrmDirADq+TGn1V1jnAvRl7WYdswdNAuZusBgKTf
         kV5iqY1SabxUaVwSHa9F1H0DRA1TpFTwjPEvMDLsadfSK35FkkQpwIn5Po/O1ilog9zf
         iPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=uZcCt3NFTYRuGN2wmwxIRKBLFoqC0OaZEtQlZOyOl+w=;
        b=IvsdPOTpYWtJ97zW7SoxKX1X2HcvKzT9tA8+h51zWk76V3FhPMcWjdvtnXgNINuSyh
         3uI5Wg4uH7NczMg1w/WrMaa/2W0SrD5khK0qxfBWnPR3JPeK3z9+68SQ/8fDHxsoDpwF
         N2E3CbiqaxbI3kMN2P4VT+8DhCFHNyXpqkjZULae0+HkeI6BS1fqqLTWTOr3ueRFG3DT
         QVqH9UQeltmolA/J80VA1j7QCAVX3dhmaP/+VGSOE42Jq7561S+Swys32eh57SCCX/E1
         fHML83VzbpdZaZ7jdWVud8UAjEzYoL4NqDG94qkejMTjyCKLddIYlFlpv+dIHoGHBHSb
         J8Mw==
X-Gm-Message-State: AHQUAuZ5NWE0qWDa3hi2G89w5qG0JycLOgEqE5n/ZqlTZSFv18Iu6SZp
        +XMc8RNzbELGJS1/GXywqv6Q0gXv
X-Google-Smtp-Source: AHgI3IaIYOTBlRR39RXk70b91lgQlbkASGHLV8cXHngGOhXq+hrz6J9bd0YCb+v6bNcZDksMh2LHXQ==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr8393815wmc.141.1549560586111;
        Thu, 07 Feb 2019 09:29:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l6sm21787785wrv.70.2019.02.07.09.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 09:29:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     matni403@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Pretty-format: Ability to add newline after non-empty string
References: <20190207063957.11052-1-matni403@gmail.com>
Date:   Thu, 07 Feb 2019 09:29:43 -0800
Message-ID: <xmqq36ozqzg8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

matni403@gmail.com writes:

> Subject: Re: [PATCH] Pretty-format: Ability to add newline after non-empty string

Downcasing 'P' and 'A' would make this fit better when it appears in
the "git shortlog --no-merges" output, I think.  Or perhaps

	[PATCH] pretty: allow to add LF only after non-empty string

or something may fit even better.

> diff --git a/pretty.c b/pretty.c
> index 0ab45d10d7..fedea05acc 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1457,7 +1457,8 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
>  		NO_MAGIC,
>  		ADD_LF_BEFORE_NON_EMPTY,
>  		DEL_LF_BEFORE_EMPTY,
> -		ADD_SP_BEFORE_NON_EMPTY
> +		ADD_SP_BEFORE_NON_EMPTY,
> +		ADD_LF_AFTER_NON_EMPTY

Appending at the end in this case does not make less sense than
inserting at the right place in the middle.  Noticing that earlier
ones are all about LF, perhaps

	NO_MAGIC
	ADD_LF_BEFORE_NON_EMPTY
	ADD_LF_AFTER_NON_EMPTY
	DEL_LF_BEFORE_EMPTY
	ADD_SP_BEFORE_NON_EMPTY

may make more sense?  

An obvious question that would come to the reader's mind would be if
we also want ADD_SP_AFTER and DEL_SP_BEFORE for completeness, once
the list is ordered in a more logical way like we see above.

I am not suggesting to add these two right now, but we still must
think about them before adding this new one, because it would affect
the choice of the letter used for this new one.  It is irresponsible
to say "I do not need it, so somebody else can add them later",
without making sure that somebody else can later choose sensible
letters that make the parallel between those two they are adding
with the existing ones.

We have '+' and '-' as a matching pair that adds or deletes a LF
before the expansion, and we are adding '*' to that group to make
the repertoire <add before non-empty, del before empty, add after
non-empty>.  On the SP side, we currently only use ' ', whose
counterpart on the LF side is '+'.  Can we easily find counterparts
for '-' and this new '*' for the SP side, when we want to add "add
after non-empty" and "delete before empty", or would it become
easier if we chose something other than '*', and if so what letter?

> @@ -1501,7 +1507,8 @@ static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
>  {
>  	struct userformat_want *w = context;
>  
> -	if (*placeholder == '+' || *placeholder == '-' || *placeholder == ' ')
> +	if (*placeholder == '+' || *placeholder == '-' ||
> +		*placeholder == ' ' || *placeholder == '*')
>  		placeholder++;
>  
>  	switch (*placeholder) {
> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index da113d975b..e333ed91d3 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -445,6 +445,11 @@ test_expect_success 'add SP before non-empty (2)' '
>  	test $(wc -w <actual) = 6
>  '
>  
> +test_expect_success 'add LF after non-empty' '
> +	git show -s --pretty=format:"%s%*sThanks" HEAD^^ >actual &&

Here the subject is expanded, LF is added, and then the subject is
expanded _again_ before 'Thanks'.  That does not sound like a
realistic example that shows off the situation in which this new
feature becomes useful.

> +	test_line_count = 2 actual
> +'
> +
>  test_expect_success '--abbrev' '
>  	echo SHORT SHORT SHORT >expect2 &&
>  	echo LONG LONG LONG >expect3 &&

Thanks.
