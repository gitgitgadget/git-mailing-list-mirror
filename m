Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9F061F453
	for <e@80x24.org>; Wed, 26 Sep 2018 17:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeIZXTW (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 19:19:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35052 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeIZXTV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 19:19:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id o18-v6so3180009wmc.0
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2tWkdxgFl1fpImJGbE5WMKYSfhuTQoIBq0Zn0WnqWzI=;
        b=NfftlBV4nbRoG3M/UIb1HeFs4ZZat9CMgqbQtj/8C/hAO+0w8KlnKcJdsOZxPbAqD8
         DhVQoegg3q42y/8fVryrFvWVQMQ/aMEZSfZlkNXs39vaMHvHD2tHNKpxYEAQ6Itkj9DV
         C5ruB/3jNgecVNnvOs/HJA8R49dt6yduYxKZmrAvuVJutr36+aO9c18T5s8BaFeDzIus
         MdePG6Sh7snUequd4gTvavOG9SpdxgFw0ilzLEXoA/vc3ozMNzH45+iERI39glPU79Hd
         GaIuGXsbRgX0V5ayGcrZjX/Gc2AX7V2kMYimbGg8ntgKlMHhD+m744piJwymhRRZGCcm
         HyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2tWkdxgFl1fpImJGbE5WMKYSfhuTQoIBq0Zn0WnqWzI=;
        b=l14RrpYjRAKasGaX7Eoyg4FcSUTI4mnOAesa+67+7q1iTSHCFMWiPsmTfZk+FBUzqV
         tc8Cb1Ow4CQfUxoV/Q33fZyHY/QE5Gd6OwnyS4YzfrcLdlPoWw/NIih5YmXwYsxNU+6a
         B/+0HK1a45eeA9HOTxN/HVvQ9vF0K4uORdM0GfmkpfruvS9D7n7eQ5a8anc4v36xeq3S
         jPfgHKnGrdg7M0rb16eyRM0Q/wyr0/26KyaL1yueaFIDm2xhWZ9GPNQfePjjo/NyCwQx
         qAOANs9KWLzpr8qdLp2H7KI5W8wSWo37P7Rk/QIaOC/8roE2nKxRfNYKH0C0+BYRk4D4
         9Vqg==
X-Gm-Message-State: ABuFfoioMhgSuLxStnu4zS4/oJJGWmEdf4ED/evCV7T/5UXra1ZQACx+
        syOWucL3P0dmMu6JXKAuarluREl5
X-Google-Smtp-Source: ACcGV63poPzgRAscVONZtp2HasFf5+KTrNgigLHnoSQO2XNMv/E8cDZH9pbLK0fn0hJrl7huKRPE5w==
X-Received: by 2002:a1c:970c:: with SMTP id z12-v6mr5100523wmd.20.1537981526124;
        Wed, 26 Sep 2018 10:05:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q135-v6sm8675868wmd.4.2018.09.26.10.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 10:05:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git fetch <remote> <branch> behaves weirdely when run in a worktree
References: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com>
        <39F9931A-B297-4525-A131-736B900F37AF@gmail.com>
        <CACsJy8AScp1v+R62vXWuP-45LLLYwfSBNaZJfR02=d+2CzDqhg@mail.gmail.com>
        <20180926160938.GA15312@duynguyen.home>
Date:   Wed, 26 Sep 2018 10:05:23 -0700
In-Reply-To: <20180926160938.GA15312@duynguyen.home> (Duy Nguyen's message of
        "Wed, 26 Sep 2018 18:09:38 +0200")
Message-ID: <xmqqpnx0mbos.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Sep 26, 2018 at 05:24:14PM +0200, Duy Nguyen wrote:
>> On Wed, Sep 26, 2018 at 6:46 AM Kaartic Sivaraam
>> <kaartic.sivaraam@gmail.com> wrote:
>> > This is the most interesting part of the issue. I **did not** run
>> >'git fetch ...' in between those cat commands. I was surprised by
>> >how the contents of FETCH_HEAD are changing without me spawning any
>> >git processes that might change it. Am I missing something here? As
>> >far as i could remember, there wasn't any IDE running that might
>> >automatically spawn git commands especially in that work
>> >tree. Weird.
>
> Maybe something like this could help track down that rogue "git fetch"
> process (it's definitely _some_ process writing to the wrong file; or
> some file synchronization thingy is going on). You can log more of
> course, but this is where FETCH_HEAD is updated.

Well, a background-ish thing could be some vendor-provided copy of
Git that has nothing to do with what Kaartic would be compiling with
this patch X-<.

> -- 8< --
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 0696abfc2a..0dfb580e92 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -786,6 +786,13 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  	if (!fp)
>  		return error_errno(_("cannot open %s"), filename);
>  
> +	{
> +		struct strbuf sb = STRBUF_INIT;
> +		strbuf_addf(&sb, "( date; ls -l /proc/%d/cwd ) >>%s.log", getpid(), filename);
> +		system(sb.buf);
> +		strbuf_release(&sb);
> +	}
> +
>  	if (raw_url)
>  		url = transport_anonymize_url(raw_url);
>  	else
> -- 8< --
>
> --
> Duy
