Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E513C20A04
	for <e@80x24.org>; Mon, 17 Apr 2017 17:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754806AbdDQRtk (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 13:49:40 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34554 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754517AbdDQRti (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 13:49:38 -0400
Received: by mail-pf0-f169.google.com with SMTP id c198so68851099pfc.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cKtd5mTSmo7kmBzHSFqDp0ZX1j8fhGwnJhFZMzqya8U=;
        b=QhFpLFQSZB4sIjYRbgfOwlBVN2KYVVC2Ns+9KOoPVCq2QpP4rJYWosnh034bNtzayi
         Z6rC5VnAxTnAyKkej+Z3bRYLGmS1OnmY7lq9daBkyHINx++icIiWlUtW3ao+JbGwRAL7
         hFRCjQGh+ydF/ux/wpMe72s8RCEAhs9eV27QvWsK5bWotxgZvxtH3/edbElVmA7Hfhvy
         7IWeZPX0RrTv6v8O8QwllSAGtYfpl2O/SjNDKJU+D+vtrMAbVr1LPH3xmOsu6Wyf1hTW
         u+wTI7xhtkRs9IaPoDCmIU6oq1mdU0xLsvp2JVeluDrMURwqDJ5p/GY/Nc3lVZmWEBOU
         sT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cKtd5mTSmo7kmBzHSFqDp0ZX1j8fhGwnJhFZMzqya8U=;
        b=sIaxHS7dAbjqF0QVR1b5NgjgtftSM4icif1b4lPG0g5DRwczcf+T5iURCFd73JaRdm
         l1UShaZF4M0O4SliEj3onGgV9f/waxVgQZCSQH1QYEnTltfPvseXVr/by4IvXSuWPhLK
         SM0QapO4/TAPHUMIX0K7E5H3f62BEMvsTDt7hwWqMKqdm9PkuNM7ZbnDgWsuGXFoxrfz
         5KWmrzjHcgR0R05o+Yoe78wXVXiLqNJkR2p0hBpwKthDhUGV5R7YH7YRA5QCphuhNhjD
         VfmyEKGVr4Al3LsJUjE0e7hh0hjcG6hvCdAt5wvHofNjiRP1Lhl5B7OJ4waUwI+W8QNY
         aFgw==
X-Gm-Message-State: AN3rC/7mqKk283rL3kYUGCg+c4qfhQ94FzdU+3vGJ1uLjXrwVW5kZvub
        bFOcv/dcUEqrMPP1
X-Received: by 10.98.49.70 with SMTP id x67mr12985056pfx.177.1492451377662;
        Mon, 17 Apr 2017 10:49:37 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:5c24:aa4d:e2a6:31b9])
        by smtp.gmail.com with ESMTPSA id w85sm14627384pfk.62.2017.04.17.10.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2017 10:49:36 -0700 (PDT)
Subject: Re: [PATCH v2] fetch-pack: show clearer error message upon ERR
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20170410210511.8505-1-jonathantanmy@google.com>
 <20170412180602.12713-1-jonathantanmy@google.com>
Cc:     jrnieder@gmail.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <21160598-dbb4-2f14-8e22-f6299a1d9004@google.com>
Date:   Mon, 17 Apr 2017 10:49:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170412180602.12713-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, I noticed that this did not make it into your "What's cooking" 
e-mail [1] - is there anything more that you would like to see in this 
patch?

Jonathan Nieder has reviewed an earlier version, and seems to be OK with 
it. He recommended a change in the error message, which I have changed 
in this new version. I have also done one of his follow-up ideas 
(updating the documentation) in this patch.

[1] 
http://public-inbox.org/git/xmqqmvbfij92.fsf@gitster.mtv.corp.google.com/

On 04/12/2017 11:06 AM, Jonathan Tan wrote:
> Currently, fetch-pack prints a confusing error message ("expected
> ACK/NAK") when the server it's communicating with sends a pkt-line
> starting with "ERR".  Replace it with a less confusing error message.
>
> Also update the documentation describing the fetch-pack/upload-pack
> protocol (pack-protocol.txt) to indicate that "ERR" can be sent in the
> place of "ACK" or "NAK". In practice, this has been done for quite some
> time by other Git implementations (e.g. JGit sends "want $id not valid")
> and by Git itself (since commit bdb31ea: "upload-pack: report "not our
> ref" to client", 2017-02-23) whenever a "want" line references an object
> that it does not have. (This is uncommon, but can happen if a repository
> is garbage-collected during a negotiation.)
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>
> Changes from v1:
>  - used jrneider's suggested change to error message
>  - added documentation about "ERR" in protocol
>  - updated commit message to explain documentation change
>
>  Documentation/technical/pack-protocol.txt | 7 ++++++-
>  fetch-pack.c                              | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index c59ac9936..5b0ba3ef2 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -351,14 +351,19 @@ ACK after 'done' if there is at least one common base and multi_ack or
>  multi_ack_detailed is enabled. The server always sends NAK after 'done'
>  if there is no common base found.
>
> +Instead of 'ACK' or 'NAK', the server may send an error message (for
> +example, if it does not recognize an object in a 'want' line received
> +from the client).
> +
>  Then the server will start sending its packfile data.
>
>  ----
> -  server-response = *ack_multi ack / nak
> +  server-response = *ack_multi ack / nak / error-line
>    ack_multi       = PKT-LINE("ACK" SP obj-id ack_status)
>    ack_status      = "continue" / "common" / "ready"
>    ack             = PKT-LINE("ACK" SP obj-id)
>    nak             = PKT-LINE("NAK")
> +  error-line     =  PKT-LINE("ERR" SP explanation-text)
>  ----
>
>  A simple clone may look like this (with no 'have' lines):
> diff --git a/fetch-pack.c b/fetch-pack.c
> index d07d85ce3..4bed270c5 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -276,6 +276,8 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
>  			return ACK;
>  		}
>  	}
> +	if (skip_prefix(line, "ERR ", &arg))
> +		die(_("remote error: %s"), arg);
>  	die(_("git fetch-pack: expected ACK/NAK, got '%s'"), line);
>  }
>
>
