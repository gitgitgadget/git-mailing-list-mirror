Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37A522098B
	for <e@80x24.org>; Tue, 18 Oct 2016 11:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754934AbcJRLmr (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 07:42:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:55751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753889AbcJRLmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 07:42:46 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LoEwL-1ccgMh47RJ-00gJyb; Tue, 18 Oct 2016 13:42:39
 +0200
Date:   Tue, 18 Oct 2016 13:42:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 14/25] sequencer: introduce a helper to read files
 written by scripts
In-Reply-To: <xmqqr37ex5ck.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610181339550.197091@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <b554346c600fafa71d2a3461fda8402e377b596e.1476120229.git.johannes.schindelin@gmx.de> <xmqqr37ex5ck.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Vx5jaY6wJi6dUykuTL8I5nea3eDrtveSkeK+XRrC2jRwzc8T8B7
 V+yzbrPAoEf/TGyrZMgeBpXTaeoszQmvGay9zjIUJ9E5L2QJgt6Y20fdVxEHIta7s6vAla/
 A/q1uSgY8BDfz3CeVvSItGrCIsCZo+1n701pE0OQFjxN9/XdCjmdzI1q04vRWl5Jk/9mn0K
 LqMpercWJcr5kHncwCKWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wXR5GnHB4tw=:XPAdLHGvWLPQ8GR4bPST+1
 uI7mHPfTp9z8fn5xb+Cn1QGJNAbLYLe1N/pBH8UZ5DIqPu0oMrnjTtOboVlgAPIZV7er3IO3i
 LY7kMGOWT0UC9Lgj9tZlVP1CPMnG0z6IzyCHqYHAQcUD3PNkUP/9qvdfIoiGbSRn17v8KyMRa
 zbiUUiigcnkyGfjotjGvu3iHpKVe0XwWLUnT6MEFspGNNG3qIFvi86EUVLc87cf2ehGAuyK0/
 njiWuIlm4m9z/DWJGsg04ap9Bv4cAydU5kJh2jtZf47v7Fbe6MkLR9s7SeJxF9NGGD1IjBzbm
 Ocz4SjaamGKS4K1hhEQgZzwBH0Yvn+KaW+lclX2THnew2Ew7JoizBAEgj4+MxnF0IZ2ywJJZv
 O3NC/EoAfgWSEW+eo4WbSmkoBuY8ZtLeIXfQNC+N2F4W8gxfmH18BJAT62ogVq/8zVIOEPqk6
 K2IjP+1vDxuLtvRsauNgF0SmIrsqAnaza7ag+nT4SK3tn7mqtb7e3eB7R393/PMMbVz+2ieEy
 xjALn5FxRh7i5wzvJyoQ2s4By+2MhIKZZBHRlouX/4jzXUIUSEJ+OsX51b1dzoLI7qC8p7j7M
 F1J7yhyUTtAvJu/g8xZXdxpOzk2Xka2DpCagPbEvpBJ2pDdposBmWdmN9Gxb5Z1+zWvMteq02
 EarSMfbOKFUcNHexzn/1H0TSIoK9L9E3P0DIiINaB4QYJiee2DUXOXNsgSICLLIYd+l/mfQXU
 ZrteiLfMA+tqxYo84x30dPbMsIrub3hgMLqjUzEzXEpSrloxab353Fd9RxPL1QddZFI7psw3m
 /A3Qn2R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 17 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +/*
> > + * Reads a file that was presumably written by a shell script, i.e.
> > + * with an end-of-line marker that needs to be stripped.
> > + *
> > + * Returns 1 if the file was read, 0 if it could not be read or does not exist.
> > + */
> > +static int read_oneliner(struct strbuf *buf,
> > +	const char *path, int skip_if_empty)
> > +...
> > +	if (strbuf_read_file(buf, path, 0) < 0) {
> > +		warning_errno(_("could not read '%s'"), path);
> > +		return 0;
> > +	}
> > +	if (buf->len > orig_len && buf->buf[buf->len - 1] == '\n') {
> > +		if (--buf->len > orig_len && buf->buf[buf->len - 1] == '\r')
> > +			--buf->len;
> > +		buf->buf[buf->len] = '\0';
> > +	}
> 
> The name says "oneliner" but this reads the whole thing and trims
> only the last line of the input.  Which is correct?

The latter. Basically, `read_oneliner()` is short-hand for "that thing
that shell does when you use `cat file` with backticks.

I do not like `read_stripping_last_eol()`, `read_what_the_shell_wrote()`
nor `read_skipping_last_lf()`. So if you come up with any brilliant idea,
I am all ears.

In the meantime, I'd be happy to just add a comment that this function is
intended for oneliners, but that it will also read multi-line files and
only strip off the EOL marker from the last line.

Would that work for you?
Dscho
