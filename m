Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569701F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbeGJSTk (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:19:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33939 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbeGJSTj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:19:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so15561844wrt.1
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bgahQJ3nMZWOTA0TB5C8WurEjitSX0LqWW5r84p2z7k=;
        b=DPPJYNmYTWXLxbVGzu+hAbltQAVFlsUP/pD2PokuRYLxGnbJuX6+GdWwLoBbLfx4a3
         0YYbjBRfDujrjc4LKUv/qxQrt7ZkMXsLLSAmStp5x5LbQarK3Doq7iZArl85d5ax79y2
         mn3cBfNv53A8JXH9o1vDgM4IpfCSJ4ygJjedFRaDcRdpq9cTSSHZ4Jh3L6vOzoDO2JNJ
         kFRn6xzy3E8gMcCHDYXEpp2OYpr9tS0NWBhp5nWtbbqnoYNrIs69Kej5RjzgqKWn+Uzm
         75KKFkr50IWZ1NLS4se/h9W7rUvH26/vDU0FLFtrsf0Bsad7uxF2N6Aa0Hp8qOSzeO4U
         ZHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bgahQJ3nMZWOTA0TB5C8WurEjitSX0LqWW5r84p2z7k=;
        b=Wh7nFD6SAMNhgVC2Z8QgiBCrA/r5ppI4HO4p4SwnUWYet4nwYEfNGYJCItt14JXoRb
         fjl9mH6+UR1j0440Y3G2ReiYcfozrHNXbGWRrSETQLN/u3ASokJEBAd2b0DK6WuwhD5I
         eOEDt5ZcyKTn6AElaNhc69iBn00aEi0rdbgK8Xn9LyTwKFSGCgzlYW2gryJJXrcMp+fE
         sH6y2mkHlK2swP3tnz2jdYTuqRflCGh3/0tDaug/6FWd3qtZTmMfNvYjaC8jmPGJsbiW
         rR+90I5WAAzmlBTWxFwbfqhYN8IRbbQa1bdq9aGxVgFOJL4Rjxi/7ialCOxwoyy8ic8j
         Q+2Q==
X-Gm-Message-State: APt69E1PRZP9a/FteJ+uKMPPajdbZPiRo0fOHO7w+UfUg/32oc5191X3
        bIbSEfElXKqQJEdWZq3q8+OyNuRZ
X-Google-Smtp-Source: AAOMgpd7FbEu9J1KUP7wgfQILAHLtd5OhwNkAcGvVHtgZPIYk5YUPAvMPwx4G7kONuP3cHxIlnJjDQ==
X-Received: by 2002:adf:c383:: with SMTP id p3-v6mr18271830wrf.68.1531245504989;
        Tue, 10 Jul 2018 10:58:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g75-v6sm22844798wmd.38.2018.07.10.10.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 10:58:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 03/13] editor: add a function to launch the sequence editor
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-4-alban.gruin@gmail.com>
Date:   Tue, 10 Jul 2018 10:58:23 -0700
In-Reply-To: <20180710121557.6698-4-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:47 +0200")
Message-ID: <xmqqy3ej6khs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For those reading from sidelines, this is unchanged from the
previous round, and looking good.

Alban Gruin <alban.gruin@gmail.com> writes:

> +const char *git_sequence_editor(void)
>  {
> -	const char *editor = git_editor();
> +	const char *editor = getenv("GIT_SEQUENCE_EDITOR");
> +
> +	if (!editor)
> +		git_config_get_string_const("sequence.editor", &editor);
> +	if (!editor)
> +		editor = git_editor();
>  
> +	return editor;
> +}
> +
> +static int launch_specified_editor(const char *editor, const char *path,
> +				   struct strbuf *buffer, const char *const *env)
> +{
>  	if (!editor)
>  		return error("Terminal is dumb, but EDITOR unset");

Nice code reuse.


