Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C28C1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 12:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbeHMOtO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:49:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:43699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbeHMOtO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:49:14 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYOY5-1fJzgc0NKz-00V6G4; Mon, 13
 Aug 2018 14:07:11 +0200
Date:   Mon, 13 Aug 2018 14:07:17 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 3/8] diff.c: simplify caller of emit_line_0
In-Reply-To: <20180810223441.30428-4-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808131406371.71@tvgsbejvaqbjf.bet>
References: <20180810223441.30428-1-sbeller@google.com> <20180810223441.30428-4-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C/GglYxkMaUhQ+MbNz7yO9ySMicFxUS6PdCj7MkbaQVzVrqbvLF
 vZkJ8YCX5gSHeA389Jv88SNRmcHvIYtj0u4zZLque8Q61jjRjJjkOiBcsIpOwX0XX9plQqa
 VQw6EoJm69OrhstUCX1tQr126w/yPAvKc1O94R8gjxqKo5me2C2oNbZdL46QlvmVU8oFg9o
 L7vcbTkQE8RPX+tEUub+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KDMgUAGO3YY=:ZGXQT2qhWsWDaPWFudMzdM
 ZHOIXR0oIiySqQohLXso5rpyUXB/lOhQ//J/hFYgfMt4rbqZS6pPx8aYfxKpgKKAJoemGuRVT
 +oMy9THiMjyBRkQ/b1TsHLyE+xButaqbgoSBOBOt793qS/4z306Uy7mYd9iSN5Z6rMBAx4HZb
 drJCRf3uqCFPcbil3+PGiwFcvDy9C91lqEONKvVYsb+yaEW9sM79gpElKeVy66UzJcVO6zG3G
 Dp1azpBgalW+SLZim2kpAOvU0Ios2MzdZ5r4AVHW8krhh9v4aMKxMoSgG8JYnzHklNmJeJHGy
 zWrxcn9QBEeRyQ8yImFZovxwVppLgJxDxqK8hvQuzxtvoScIBqAeIE0f6cXA6w1nfKuUzSXQv
 9Ykk0OhahVyXbTQYhrRtpDKCRkvpwy8Eyt/xPKqQ2tf2F3Z49Gr3NCmaQPvUIQkA15Ku5uE4Y
 BLJx8gU5wFFnM/uu5s7+NH9/Sb1oEErDbgXFTuBsiUotcmpoFT0dyKlAuWVns6iL+hldej+7c
 YgY07071W6PvtXZxDYGzlW+/tHPsmcOX1u2ic6nXYUGJR5qLK0afB2hy4yUOjrXercWSINinV
 Cy/SYcZR3JX9jLe2EBxt0rHoa92dP8NL0yHkUmfZoTiPPzEVZNj/kIGMl3QiZMulj/fsARbBw
 B6VGbWMwB8RFbiEouNdceet/cu9FXklXB730l+ORW1NZ7Ma2WTBr01gxDJlNril/zpPrlhYuQ
 vZNK8WPr7yM7Y191cTjUJy4V4aVmDnO5ejq4xz9kr0jQP96BaFqJmngRi+43wMqS7GXzBweg7
 lPVCU05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 10 Aug 2018, Stefan Beller wrote:

> Due to the previous condition we know "set_sign != NULL" at that point.

I trust your judgement on that, also on how likely this previous condition
is to keep guaranteeing that assumption.

Thank you,
Dscho

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index ae131495216..f6df18af913 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1202,8 +1202,7 @@ static void emit_line_ws_markup(struct diff_options *o,
>  		emit_line_0(o, set, 0, reset, sign, line, len);
>  	else if (!ws) {
>  		/* Emit just the prefix, then the rest. */
> -		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
> -			    sign, "", 0);
> +		emit_line_0(o, set_sign, !!set_sign, reset, sign, "", 0);
>  		emit_line_0(o, set, 0, reset, 0, line, len);
>  	} else if (blank_at_eof)
>  		/* Blank line at EOF - paint '+' as well */
> -- 
> 2.18.0.865.gffc8e1a3cd6-goog
> 
> 
