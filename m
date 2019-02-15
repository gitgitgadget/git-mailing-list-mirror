Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07C831F453
	for <e@80x24.org>; Fri, 15 Feb 2019 16:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391021AbfBOQAH (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 11:00:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41796 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390625AbfBOQAH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 11:00:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so10850360wrs.8
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 08:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=7TfHGXWY8bR6UV+B+ZaL0TvraCuaptvxy5PzH0XQVH4=;
        b=HXLPp8PfUNwUqlttOrtxAgFP/pECrft/TOLqxR65A1bw0mWuLsp6ixSVEcDGuOhq40
         6RXQ9EsIbt46hll8PEMSOXpAU1WDs/2JDXoh73gMgpgJ0eLuFgHV6OfAt/oIoMPSNVRC
         y3Mg5fS+6Eb7cwEP6VlhEt4ZGs/880PGRbKF+EGXE+hBjle6NmvbO5bJJaYW48IS4jPB
         pePC/woBhf5ekxPdSKEJM3ZHOdO6it55zHDHqFrDXaQG4VG0PO/Q0B7O439Rb74UItm6
         X5GerCtSy5yUmzQZbRcGigJ+mZ0jHQ6gL+/pOsfRLgROvwLSqaA5JNNoJdCmyjcIZZME
         NMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=7TfHGXWY8bR6UV+B+ZaL0TvraCuaptvxy5PzH0XQVH4=;
        b=Kn0YYOGjdPUOlX5kQjBn0HDhmzxDOHbiIBBZl1Y2ckjxRCw0XGpzyx75RsA1CT8yHd
         o6Nn8gcv/Sgsw2KNenEXlpT/0tLFcYIPdMdcxxWUZt9ApnQ14SLniuDA8VnheEOzUXGD
         U5XXY8IaYXBpg7L6J22A2zJRIKeeeUM+JxloVFtO1qg2BNzDFYhJVXNd0tsHIPYAiabG
         cdY5t64yGs/T3MMwpfH767AMIFMMmhNMcZdD2AZTSF9+GxtG/2aGSE8UP4mFQEba9UGJ
         HEYWza0F+LXFev86a28Exd4aarx4nBIqMKuaU/46EYmVnXcmBj597ofiIZ1eqLUWT3AM
         AExg==
X-Gm-Message-State: AHQUAubvzvSAr2VCAAVbQNbIdb8gKNsDVU+bIshOBbt7LIKLQ8M5Qq+4
        4o7bV+lwUfEQpEp4fTVWsgI=
X-Google-Smtp-Source: AHgI3IYo9c5ZMltfsCNiqw9kcbTKttr8SWsKnW+bqC3pX0WEpHCRUY3cZPFB/VATBIpAws/1+aMrLA==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr7782551wrp.164.1550246405359;
        Fri, 15 Feb 2019 08:00:05 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id j124sm7193452wmb.48.2019.02.15.08.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 08:00:04 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 02/15] trace2: create new combined trace facility
References: <pull.108.v5.git.gitgitgadget@gmail.com> <pull.108.v6.git.gitgitgadget@gmail.com> <6bad326bbd27426845734d08428e6987a75d9ad9.1549473350.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <6bad326bbd27426845734d08428e6987a75d9ad9.1549473350.git.gitgitgadget@gmail.com>
Date:   Fri, 15 Feb 2019 17:00:02 +0100
Message-ID: <87y36hnit9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 06 2019, Jeff Hostetler via GitGitGadget wrote:

> +	sa.sun_family = AF_UNIX;
> +	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
> +	if ((fd = socket(AF_UNIX, SOCK_STREAM, 0)) == -1 ||
> +	    connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
> +		if (tr2_dst_want_warning())
> +			warning("trace2: could not connect to socket '%s' for '%s' tracing: %s",
> +				path, dst->env_var_name, strerror(errno));
> +
> +		tr2_dst_trace_disable(dst);
> +		return 0;
> +	}

Just curious, what do you use af_unix:* for? Is this provided by some
Windows emulation ?

On Linux with systemd, this does not work for logging to systemd's
/dev/log. You're opening the socket with SOCK_STREAM, but it needs
SOCK_DGRAM. I.e.:

    # fail
    echo '{"yay": "testing"}' | nc -U /dev/log
    # works
    echo '{"yay": "testing"}' | nc -uU /dev/log

So that gives something that'll "work" for "jounalctl -f", but on my
system ends up being munged to the invalid JSON:

    '{"yay"[PID]: "testing"}'.

I found, and this may be specific to the systemd/rsyslog setup on RedHat
I'm working with, that what /dev/log is expecting is a payload in the
syslog format: https://tools.ietf.org/html/rfc5424

So related to my question in
https://public-inbox.org/git/87a7iyk0r8.fsf@evledraar.gmail.com/ I
wonder what we should do about this. It seems the bare minimal thing
that's needed it some way to open a socket with SOCK_DGRAM, maybe we
should just do that unconditionally if the connect() fails with
EPROTOTYPE?

But it seems that for that to be useful for systemd we'd need to support
the syslog.h interface (so different from af_unix:*), or learn how to
write a standard syslog packet to an af_unix:* SOCK_DGRAM socket.

I guess we can start with just supporting that by hardcoding the ident &
LOG_* values to something sensible, e.g.:

  openlog("git", LOG_PID | (tr2_dst_want_warning() ? LOG_CONS : 0), LOG_USER);
  syslog(LOG_USER|LOG_DEBUG, message_or_json);
  closelog();

I can write the patches for this. As in the earlier message I'm just
looking for some context, whether this is stuff you have WIP already,
and whether you have any other/related ideas. Thanks.
