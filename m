Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F278207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 00:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935224AbcI3A26 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 20:28:58 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32968 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935150AbcI3A24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 20:28:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id w11so6149816oia.0
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AhMz71u6lTEXgy/lA05VdBl+MLBFU2q1Ft0c7s+rKAA=;
        b=Qv5mqj1cjtDXh2LxeeMg6phLx2l6D7OMncV4bjVz/4+3gima53tD7v0iiACgKgwYyL
         w1uScTXqa+ITZ1Ux5IpHVOW++AlRSNFB//Z/1m3K3+4sbM/qUVa2huGj+YMCdZR7pPe3
         ophNXjUz3o/zI3qefnTcbYQFlAi+v+tl0g1ovbdQNuLAKD6+PZGOZlOhf9eIaDU8EUPK
         TvwSmnQTXphjQnYc1L9sO5nQlBNftEWfrWKC1JKT7bt0uiicTbivdZTxsNnv1e8MDDJ4
         kFcdDbtO2mnGjUO8XgQEE8nv602VR8ysWpK5VuU+IRMdytrk5AUJwpgB1yaYRT1H79Bx
         x2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AhMz71u6lTEXgy/lA05VdBl+MLBFU2q1Ft0c7s+rKAA=;
        b=iAdmo17X4hc0XncndPdLO4PGOR96QX0N5JR3HZ+B2dOom4HGedksz43h1nN5/Gwfzs
         HDe9lMlxb3uYJZlMlU1lPoJ9/PcDJQ7pfwWmDR1amh5ijGB0PnKak86deBuNoWzMzaa4
         JT92kapimBLG/uIMWkjCuDzxmfmuFOOiiCh2tyu5tdJn16TLLZ4sHHEzWBZjWxN2f7PY
         L2LwAQevkWItbI2ZOCbmUH+Y9xjH1arEeurMBYgffgtgRsyEl8EPOS59DU5LeG3BZB5C
         eSQdCvvufQt9KljW9M5tRAs8rArZ6YV3sERV+YJEdiiY+eWBscDEHPFJS6jop10qURQM
         pZBg==
X-Gm-Message-State: AA6/9RnK+rY/0T5UdvZeideRwNjEF84Jn7Re95FrfP7yUP1KPRX8QQaBCiTxqJwuCgJ49v5u7qubobp02bCv7Q==
X-Received: by 10.202.69.67 with SMTP id s64mr4099619oia.1.1475195335896; Thu,
 29 Sep 2016 17:28:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 17:28:55 -0700 (PDT)
In-Reply-To: <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net> <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com> <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com> <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 17:28:55 -0700
X-Google-Sender-Auth: IUm_JEGBTPGM9ixvGNNsqGle4b8
Message-ID: <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 5:20 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> As you say, my original patch had neither of those issues.

To be fair, my original patch had a different worry that I didn't
bother with: what if one of the _other_ callers of "get_short_sha1()"
passed in -1 to it.  I only handled the -1 case in th eone path care
about in that first RFC for testing. So I'm *not* suggesting you
should apply my first version,, It has issues too.

Let me see if I can massage my first hacky RFC test-patch into
something more reliable.

              Linus
