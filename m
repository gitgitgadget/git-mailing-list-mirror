Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71CA11FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753606AbdFVT0Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:26:25 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35675 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbdFVT0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:26:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id s66so4321100pfs.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lMFROxxxKUs6b8bmTl1PaeSFEJwTW8YAkCmMN/1R1uU=;
        b=i1KZzpZHB1vtcFYuB1btGJmUk5tImSHm9xQW7CWgEtuPL+Dda8AYRg1+PK8EWZ7YEs
         +grzho7y9twxZw/0ccjXxBBv/aOmk0VG+RdGSYCTr86FWQA82rpszNuaOLyDUFgG8+7J
         2fC7p/+lGvJmF2p9qY1clYHGsk7QxnLlV5uD1MVieooxHZi06R23r21R9Ut9EWsOOzYD
         B+yAiJCk0vk05sDmbh8PQWqAzssaGQtzTSucezQ+TxcV8u5mgNMQgvXWY0rwEK0hhSeA
         ZjjO+c8d643IrOALUh5oz3NvCkfagHC5Bt6t14si/ym6xaK6bPcdJurcrLamAPgV3/3y
         XS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lMFROxxxKUs6b8bmTl1PaeSFEJwTW8YAkCmMN/1R1uU=;
        b=OTz7jpNsWLylPU4ag5ib+fGwLJ2mKidnoqSuzyMhw9EKYmQedQLhuadEvU4er4Zoes
         RDjne0+Yh5eFSkodBPetBhdRTvLb9mnl0xgbfwIdb75RS9vXZXLHyrgd43XSgqiBWXP+
         9Ofd51DPP8qMM8PQF2A5Bl7p86zJ8AHYOB+ESb3LhybMjE6kZAVth9gdHkRdpUt+fDvl
         AaW8QLHeQVUuXLRC3aWLi2lUd0WeBcmciNimhf34FCgK/DXeMQ72Ns4WkKyBgKN2OnBj
         4YCTZl9qfxpw3gU2GOpWvYv0nDZFlFOxdEscQJs2Rg0tooRWfHPVTLAS6/N9R6P4tl4l
         TEHw==
X-Gm-Message-State: AKS2vOxnF7yqjdanZ4zzrFNwokQ5FC2EQsEn+xGEMr7+Zsw3vkqHcySh
        DUOm7dMTwtxtZw==
X-Received: by 10.98.71.212 with SMTP id p81mr4344164pfi.106.1498159583447;
        Thu, 22 Jun 2017 12:26:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id k11sm5547463pfj.48.2017.06.22.12.26.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 12:26:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/5] Git.pm Add unquote_path()
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
        <20170622102622.26147-2-phillip.wood@talktalk.net>
Date:   Thu, 22 Jun 2017 12:26:22 -0700
In-Reply-To: <20170622102622.26147-2-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Thu, 22 Jun 2017 11:26:18 +0100")
Message-ID: <xmqqlgojken5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> Subject: Re: [PATCH 1/5] Git.pm Add unquote_path()

Subject: [PATCH 1/5] Git.pm: add unquote_path()

But I think it is more customary to remove the implementation in the
other file and adjust the existing callers to call this new one in
this same commit.  And then in follow-up commits, improve the
implementation in Git.pm.

When that happens, the subject would become

Subject: [PATCH 1/?] add-i: move unquote_path() to Git.pm

and the first sentence in the body would be tweaked ("move
unquote_path() from ... to Git.pm so that ...").

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Add unquote_path() from git-add--interactive so it can be used by
> other scripts. Note this is a straight copy, it does not handle
> '\a'. That will be fixed in the next commit

s/next commit/&./

Good to notice and document the lack of '\a' which does get used by
quote.c::sq_lookup[] when showing chr(7).

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  perl/Git.pm | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/perl/Git.pm b/perl/Git.pm
> index bfce1f795dfa5fea05f4f96637a1ae2333038735..8afde87fc8162271ba178e0fff3e921f070ac621 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -61,7 +61,8 @@ require Exporter;
>                  remote_refs prompt
>                  get_tz_offset get_record
>                  credential credential_read credential_write
> -                temp_acquire temp_is_locked temp_release temp_reset temp_path);
> +                temp_acquire temp_is_locked temp_release temp_reset temp_path
> +                unquote_path);
>  
>  
>  =head1 DESCRIPTION
> @@ -1451,6 +1452,56 @@ sub prefix_lines {
>  	return $string;
>  }
>  
> +=item unquote_path ( PATH )
> +
> +Unquote a quoted path containing c-escapes as returned by ls-files etc.
> +when not using -z
> +
> +=cut
> +
> +{
> +	my %unquote_map = (

The original calls this cquote_map, partly because there may be
other kinds of quoting possible.  I do not see a reason not to
follow suit here.

> +		"b" => chr(8),
> +		"t" => chr(9),
> +		"n" => chr(10),
> +		"v" => chr(11),
> +		"f" => chr(12),
> +		"r" => chr(13),
> +		"\\" => "\\",
> +		"\"" => "\""

In an early part of "sub unquote_path" we see dq spelled as "\042"
and in the original cquote_map, this is also defined with "\042".  I
do not think you want to change the above to make them inconsistent.

> +	);
> +
> +	sub unquote_path {
> +		local ($_) = @_;
> +		my ($retval, $remainder);
> +		if (!/^\042(.*)\042$/) {
> +			return $_;
> +		}

Other than that, I can see this is just a straight-copy, which is
exactly what we want in an early step of a series like this.  Squash
in a change to remove the original from add-i and adjust the caller
to call this one (you may not have to do anything as it uses Git.pm
already, or perhaps "use Git qw(unquote_path)" or something?) and it
would be perfect ;-)

Thanks.

