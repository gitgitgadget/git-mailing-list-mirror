Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB9E20188
	for <e@80x24.org>; Mon,  8 May 2017 05:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbdEHFWF (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 01:22:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33021 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbdEHFWE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 01:22:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id b23so8405001pfc.0
        for <git@vger.kernel.org>; Sun, 07 May 2017 22:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2Kv8ACD4EMG8mPZOFR/gYy8ukqN+WCP6nWTokQ38ZdI=;
        b=ub6sm0ExX+o+QlbpquAI1dspvYRaHpG47UFCgRT0xXNsS58KONYBEUToWy/o7tO6U6
         HqpHU81+L8nbhghVWsuuNOdXnaV3ztxKlWfve8I3/u65Wz5IKENaC9poFZT/SLjtrLEW
         Ua6t0vzCqGtBg/5nSa8f2wTklQF7cu+GjgRQbNEwBE94Kp1QfAOHWNLNVe3omhdWnaTU
         5IYIQz86VDs/8qI1N59VptftVZTqyRamk7/3IBnUh0Egef/sbjieqbHuma6t8QvtUcUN
         K5AMJdeWSmvZhd6W15UTXLGJN2S4qUAelo6jcgdHqt5zROPmpkwEnf13MsCg6Wm5hh1i
         dFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2Kv8ACD4EMG8mPZOFR/gYy8ukqN+WCP6nWTokQ38ZdI=;
        b=dBeeEvRxJP3RFkTODeiQS76KvU7+4M0eAsczitWHKpPXqyvVVUkFD7zS0AMQI4t0Yj
         ZWB29/+6JGtc7gNM+eRZtXz3MUMAhuIbW1DTmXGaiHs6CJt3jYy7WW57THMGh5fBFntK
         PznfIOsX/k0mEUUAl/VYIan94VR4WsqFo1RROW+nuMXbTsKJVBkipethMRKI7E8Eux91
         GcxTwqenBEBiKIA+KZPhx7l+3t9ruyBiscmJxwe76pEwtsjEqVGw/MhLOxhUM1cbowMm
         s0/zs5GXEP31XWaNXpBflXajIGTtz/Tdh70ECIWy/+bvdaVZXKUIEgjiIILkC5zfJaEM
         5sLg==
X-Gm-Message-State: AN3rC/7WawkWWy00gy25OuO+3YCW9pVTPnrUSFjWN5Y7SL4yhvq7S0Ns
        ci1j3mDwANBdHQ==
X-Received: by 10.98.69.74 with SMTP id s71mr29199916pfa.232.1494220923291;
        Sun, 07 May 2017 22:22:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id f193sm4304722pgc.54.2017.05.07.22.22.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 22:22:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 6/7] Fix the remaining tests that failed with core.autocrlf=true
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
        <cover.1493891336.git.johannes.schindelin@gmx.de>
        <daa27cca688e864c0b85a92639e0fb46261dad5c.1493891336.git.johannes.schindelin@gmx.de>
Date:   Mon, 08 May 2017 14:22:01 +0900
In-Reply-To: <daa27cca688e864c0b85a92639e0fb46261dad5c.1493891336.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 4 May 2017 11:50:37 +0200
        (CEST)")
Message-ID: <xmqqinlb9b46.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Note: the test suite also uses the t/README file as well as the COPYING
> file in t/diff-lib/, expecting LF-only line endings explicitly and
> failing if that assumption does not hold true. That is why we mark them
> as LF-only in the .gitattributes, too.

I said the previous step that used COPYING was good because it
didn't force the file to be checked out with lf (and instead fixed
the test to strip CR if/as necessary), but come to think of it,
these COPYING/README files are in t/diff-lib/ that are shipped as
test vector, and meant to stay constant even when the end-user
facing COPYING and README at the top level changed.

I do not see t/diff-lib/* marked as eol=lf in this patch, but
shouldn't it be done here, just like all these test vector files?

I also wonder if that makes the previous step unnecessary.


>
> This patch can be validated even on Linux by using this cadence:
>
> 	git config core.autocrlf true
> 	rm .git/index && git stash
> 	make -j15 DEVELOPER=1 test
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/.gitattributes | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/t/.gitattributes b/t/.gitattributes
> index 2d44088f56e..3525ca43f30 100644
> --- a/t/.gitattributes
> +++ b/t/.gitattributes
> @@ -1,2 +1,20 @@
>  t[0-9][0-9][0-9][0-9]/* -whitespace
> -t0110/url-* binary
> +/t0110/url-* binary
> +/t3900/*.txt eol=lf
> +/t3901/*.txt eol=lf
> +/t4034/*/* eol=lf
> +/t4013/* eol=lf
> +/t4018/* eol=lf
> +/t4100/* eol=lf
> +/t4101/* eol=lf
> +/t4109/* eol=lf
> +/t4110/* eol=lf
> +/t4135/* eol=lf
> +/t4211/* eol=lf
> +/t4252/* eol=lf
> +/t5100/* eol=lf
> +/t5515/* eol=lf
> +/t556x_common eol=lf
> +/t7500/* eol=lf
> +/t8005/*.txt eol=lf
> +/t9*/*.dump eol=lf
