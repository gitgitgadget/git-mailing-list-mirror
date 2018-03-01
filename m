Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AE111F404
	for <e@80x24.org>; Thu,  1 Mar 2018 06:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966309AbeCAGSm (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 01:18:42 -0500
Received: from mail-pl0-f53.google.com ([209.85.160.53]:40031 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966207AbeCAGSl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 01:18:41 -0500
Received: by mail-pl0-f53.google.com with SMTP id i6-v6so3092901plt.7
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 22:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3K7TATqxpcTBuvST7h0AsU57KsFRZ5kIr+9nHj+NCwE=;
        b=TofSB4W/pbKD+C7Z/QSgg+pAJ2s0buOGb1sVKuSO+3QKLW+zYgnz4QeukI9GvfJ88h
         hQVssnQgZ/l/nK9s30spiKZYeDC3cft6DeI/HHEeV8DwicFkTKCtD77lU5q0oFn6lMSR
         UP5HJAvSVOu/ipERwR7JAt9LgifKOd7/UQmh2OFdjV0XnPDOxWqiH/01S/9exT1UHipu
         BCq2E6uC9uQLIQppeEmO+BkKQcwAU4qIHrHsLM99uoZlfyNDy8wxIzrLqRxwPVRjheRO
         OvMoEgaP6tP0889Mkvkn7hUcyt1y+L8M52nKiawh5pbpo1nLhesaxC3JqZNaN2HEy6D2
         INDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3K7TATqxpcTBuvST7h0AsU57KsFRZ5kIr+9nHj+NCwE=;
        b=Pap4Dexp7u7BqLJuRlE1V+sX5RIeit7nZOuE2dngdLlVLd1zxSpZfFE/oLw7TLY7ql
         Oye+pprC+kqTr7ZCJBE2Y2TQb6HJ5U5OIFAAHm2tnOuyva6JDGINU5kRVpyDIuL3eSeS
         qrilYcyjVaPRdRzSnVC1MRJm6rI27eL+Feh60LU1fB/8WMO+tTrocrs5nCvbyqWACe5C
         db6GaC9+CSQ3nSp32zc6HB3PW3hzFK6noXFUHl9RAsjU9G4Sx6QmnA6s13uGc5p08QW9
         64T0VvozsW8UArZOpiuGdmwWJpzi8YpFzrcLkvtdmLvnyIEbO5+SFnqtNZFZrhOmy8pL
         zHAg==
X-Gm-Message-State: APf1xPCfOmLvDs98FwDchgnTAz3ZT828+84UN6DF0YSZlGn4R2SA/n78
        zJ5HjB+oUeeC4frZHJGFxV++/BUtHYCKX7InjABOVtA8
X-Google-Smtp-Source: AG47ELv3WTOgLL5Ufjvw2Fm5iExgAdQG2uIMLIfMOQHlr7feOGY/24QQluz8PsmsfMf9iY74i0daDtzd+e0n9YCpuwQ=
X-Received: by 2002:a17:902:b117:: with SMTP id q23-v6mr874615plr.58.1519885121308;
 Wed, 28 Feb 2018 22:18:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Wed, 28 Feb 2018 22:18:40 -0800 (PST)
In-Reply-To: <xmqqr2p4itvh.fsf@gitster-ct.c.googlers.com>
References: <cover.1519843916.git.martin.agren@gmail.com> <20180228195809.9145-1-martin.agren@gmail.com>
 <xmqqr2p4itvh.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 1 Mar 2018 07:18:40 +0100
Message-ID: <CAN0heSpcaR3bzHuD3AG48p8DagD_HDY8kVxYNctS1Qhoopcvqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] roll back locks in various code paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1 March 2018 at 00:20, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> A further upshot of this patch is that `active_cache_changed`, which is
>> defined as `the_index.cache_changed`, now only has a few users left.
>
> I am undecided if this is a *good* thing.  In a few codepaths where
> we make a speculative update to the on-disk index file, I find that
> the explicit mention of active_cache_changed clarifies what is going
> on.  Perhaps once my (and other old timers') eyes get used to this
> new SKIP_IF_UNCHANGED symbol, it would start serving the same
> purpose ;-)

Right, you might say that this trades one symbol for another. What I
meant was, we only have a few "active_cache_changed" and soon (TM) they
might all be "the_index.cache_changed" or "index->cache_changed" and the
macro could be retired. My understanding of the history is limited, but
I was under the impression that this was like a transition macro (albeit
a very old one!).

Martin
