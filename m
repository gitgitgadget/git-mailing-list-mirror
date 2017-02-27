Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D455D1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbdB0W3G (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:29:06 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34637 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdB0W25 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:28:57 -0500
Received: by mail-lf0-f66.google.com with SMTP id a198so4505749lfb.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=jqMgGDZHccMr5MRZMMMoryS5qNxboTY807of/A/z3AE=;
        b=gO6n6vjZ0Qn0yyc+6379stnimCb+44Ua7qWr5L9qbEBFELLioq+El5Zf/Czk/g9ppx
         PAwt8Db4YbBr21iUoPFL5W2v6pTSHRIX45QcgPfCO203Ud4Z1UmeW5nh8OpUW4BCjxLS
         GqvYomXToizRsSfZ8HStF/KzrQn6pl6v1WeQ/XDeGZKtsze8T2Rom7rnp77uzlkaoNNS
         giDGBNCrBlHs3vZSpy7tHxHaZzc4SqyY//qU4fwTVm+PGlEH/phQyomXWJQrcye6MGdx
         JyyFKNm5cxyTPU1pOsCjnTXp/Ou7mBrHwMr7JNU+WPBSeBU/b48awNSDLpOGr+0E0bRl
         PemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=jqMgGDZHccMr5MRZMMMoryS5qNxboTY807of/A/z3AE=;
        b=mVRlVlBUwUM5WCbVNJnVw8hGGs7CnHGzqnm7IVotwTyJWeYqx6wYaqf4xdgYX66kZc
         +ZtFhcVjMYWxUeMpNt+bjEMRPuVm+u+yj1ELaOWiGX7epLkrxj6YVUwInE1LOnoG3mTn
         Xohf8stsWH3IOJIr4zxtEXIFVsrrsUmt1aV2sf7oV0ZXojvbk+mzP0e92rpChlD3jSiD
         aR+OjrGqnDYDZhTS9es5EZuXxE0jhLQ8e0/vhB0T0idqXMn//jHsEJs7VlDJb+e0F8nm
         Yq6byUfW6s54pqh8twyWNntR9PFmEjdv4IUHok99optebZ1hx4VVCD8adT0jTBDJS1Ia
         8p1w==
X-Gm-Message-State: AMke39k+UPWjzeadywnrWv/x2npKVsd8/PWY298eRiTm4fMfKkF98vdWPA3tUHowNMDTyw==
X-Received: by 10.25.221.66 with SMTP id u63mr5568152lfg.52.1488234452311;
        Mon, 27 Feb 2017 14:27:32 -0800 (PST)
Received: from [192.168.1.26] (deg240.neoplus.adsl.tpnet.pl. [83.23.110.240])
        by smtp.googlemail.com with ESMTPSA id x26sm11022950lja.10.2017.02.27.14.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2017 14:27:31 -0800 (PST)
Subject: Re: [PATCH 2/2] commit: don't check for space twice when looking for
 header
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
References: <23989e76-24ba-90a4-91a9-9f66bfccb7c9@web.de>
 <b1d5c882-38b8-dd2d-2e5f-aafb8dfada81@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <1dd0884c-032c-fb04-67f6-8b181fd65eea@gmail.com>
Date:   Mon, 27 Feb 2017 23:27:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <b1d5c882-38b8-dd2d-2e5f-aafb8dfada81@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 25.02.2017 o 20:27, René Scharfe pisze:
> Both standard_header_field() and excluded_header_field() check if
> there's a space after the buffer that's handed to them.  We already
> check in the caller if that space is present.  Don't bother calling
> the functions if it's missing, as they are guaranteed to return 0 in
> that case, and remove the now redundant checks from them.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  commit.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/commit.c b/commit.c
> index 173c6d3818..fab8269731 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1308,11 +1308,11 @@ void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data)
>  
>  static inline int standard_header_field(const char *field, size_t len)
>  {
> -	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
> -		(len == 6 && !memcmp(field, "parent ", 7)) ||
> -		(len == 6 && !memcmp(field, "author ", 7)) ||
> -		(len == 9 && !memcmp(field, "committer ", 10)) ||
> -		(len == 8 && !memcmp(field, "encoding ", 9)));
> +	return ((len == 4 && !memcmp(field, "tree", 4)) ||
> +		(len == 6 && !memcmp(field, "parent", 6)) ||
> +		(len == 6 && !memcmp(field, "author", 6)) ||
> +		(len == 9 && !memcmp(field, "committer", 9)) ||
> +		(len == 8 && !memcmp(field, "encoding", 8)));

I agree (for what it is worth from me) with the rest of changes,
but I think current code is better self-documenting for this
function.

>  }
>  
>  static int excluded_header_field(const char *field, size_t len, const char **exclude)
> @@ -1322,8 +1322,7 @@ static int excluded_header_field(const char *field, size_t len, const char **exc
>  
>  	while (*exclude) {
>  		size_t xlen = strlen(*exclude);
> -		if (len == xlen &&
> -		    !memcmp(field, *exclude, xlen) && field[xlen] == ' ')
> +		if (len == xlen && !memcmp(field, *exclude, xlen))
>  			return 1;
>  		exclude++;
>  	}
> @@ -1357,9 +1356,8 @@ static struct commit_extra_header *read_commit_extra_header_lines(
>  		eof = memchr(line, ' ', next - line);
>  		if (!eof)
>  			eof = next;
> -
> -		if (standard_header_field(line, eof - line) ||
> -		    excluded_header_field(line, eof - line, exclude))
> +		else if (standard_header_field(line, eof - line) ||
> +			 excluded_header_field(line, eof - line, exclude))
>  			continue;
>  
>  		it = xcalloc(1, sizeof(*it));
> 

