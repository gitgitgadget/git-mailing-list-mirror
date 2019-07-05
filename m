Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 867821F461
	for <e@80x24.org>; Fri,  5 Jul 2019 18:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfGESsY (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 14:48:24 -0400
Received: from mout.gmx.net ([212.227.17.20]:60659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfGESsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 14:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562352498;
        bh=YFfJJOjfFtMTdxdr+PNXlRz7tOIHoPBaX0XdVAALRe8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RP+Mqkbh5oDbF4vQDRaRADcC54uk1QcmK8+RYDe5mtx1sW69726sC7DE07MzfW8PS
         QGpw2B+tNR1pcCRG56EwBSL+jYyiZ/LkGtaqMcDGPMu8OHDE25sM7ohZGsbzx/xvUa
         jFYyj+Pg21btUCq3PWnH6a0iFj8PYf432pNNSm2A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsnF-1hxYfH1FXR-00LBQ4; Fri, 05
 Jul 2019 20:48:18 +0200
Date:   Fri, 5 Jul 2019 20:48:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 07/14] apply: make parse_git_header public
In-Reply-To: <20190705170630.27500-8-t.gummerer@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907052047260.44@tvgsbejvaqbjf.bet>
References: <20190414210933.20875-1-t.gummerer@gmail.com/> <20190705170630.27500-1-t.gummerer@gmail.com> <20190705170630.27500-8-t.gummerer@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wAv2XDmjOr0JMr2Kj9abM3Sg3UB9YbGhlaaEUqI1Z2ImlitAAnY
 +stkNmfQTI/pVOBhURh7j6zSi/K3q1bYUnMXTI30PPsuFqiM3Q6fAml78ksEn41woEhvFB8
 QTBzsdM+HGZbK+EiyO3Idt/yFZIKNkze6uKTgjUWAiWMkNPlJ2Au+z39I/DHPeeQ9xB456w
 dHJrSNo6qPIioYOyJwHkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uEF37W16t/A=:g9Uu8QABrXNJKSxyMtT51/
 EwwT6E4lyD6lvlWzMTuiQa4xQJopVNj/BzPX6+mEM/q6Q5kDBC3Nvn5ehPoWNyH1I+210Ky60
 LGShlZTea8BuK62zK++Cx7Ow7xM0gGZ54ABTPmM9qrwld1GwS7SAnbvCvUIb+5F6i+GrBBkyP
 fWwhsVMLfhA5HBhZBkvc7uO+X79xEMrV7sVrE17Neiuqwvm7tnxhGOvfex65gCszgw/bD4LF+
 kzS+GFZpujKcEHCmcQWgCqXelJjwzWv2PCJk6BFsN5a2Lcu8giSZBSZ/TKtDYQcGFu6XYvMTQ
 5oH5UcwkhodgmiSUhM89o/tX17WiKKEy2vHxhtUwhaP3i84bnzWcQREiJEjsP20KFpQfyogmy
 QPAaG8IPGcyg5OJgKjpp+ELhgdbIk/XalGj0lqp2fO2n24ucgoffoeDp4DIPihWErgq+aZ5z5
 IJ4HP1YTnm8D1V3g9KE/xuYKBf/xXSkAyQNHTzL8Z1fpU5+gWumKtLhQlj1igOH1D6+YlmiHG
 +D738tVihXhwZFtdpvgEJgvkH5t+o1iaAjFyZmk93r/wvujcU89CWccrpKA0UoU4hR8uKBw3r
 aw92fy3MxJGws9atSYuryBjv0M1KDqTR80EjTkGDqoJP2Vh6fo0+RQ0vxi5p401BiD3HyYhVQ
 Pek6SpZoRRXXIT0FgFdFBATDso69VJNdIs3BwZmp/pZ1D+zB3AqOyjmVY3qpON52W8qu2C4Ho
 f6lTK2ynq4+hvTK0WVxjcG8FE0/WiRT43wqP6pYKb7o/oCZYxRKFzv54zWPXt3DGVsYQxrUEG
 KOJ54dq6X+dQRB81c0rL5A0VQJWu7JTXZ8dnyvBesDYtBZ+p2r+qyBEhD0Aj6y74W4n/cwxIZ
 Wo8T0crcTZQ76U+oTJy7gPEqWGHRpRjpFXruEcPCk96LIE/RIMxh6pCOIOf9T6TpYw6VxYqnZ
 dXR98pvC2ZaqVFrFGvN243mag5Pos+QWEgfciSBBl4LTHxy+Mb0aft/2XcTtm2NXxt7ENYXfd
 eitYIGu05arXzUofg63nVpI1IYbyFHxlZ/eJIIcr+eYGLi3P1IIhZcWzA3ojkq9L0V0HsjmHA
 h0LGfQGiGaZC0vgbQ0dfoCJpZHAajPWRXMw
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Fri, 5 Jul 2019, Thomas Gummerer wrote:

> Make parse_git_header a "public" function in apply.h, so we can re-use
> it in range-diff in a subsequent commit.

This function probably wants a different name when it becomes public, as
it was relatively obvious inside `apply.c` that it was talking about a Git
_diff_ header. Maybe `parse_git_diff_header()`?

> @@ -127,6 +161,20 @@ int init_apply_state(struct apply_state *state,
>  void clear_apply_state(struct apply_state *state);
>  int check_apply_state(struct apply_state *state, int force_apply);
>
> +/*
> + * Parse a get header, starting at line.  Fills the relevant metadata

s/get/git/

Ciao,
Dscho

> + * information in 'struct patch'.
> + *
> + * Returns -1 on failure, the length of the parsed header otherwise.
> + */
> +int parse_git_header(struct strbuf *root,
> +		     int *linenr,
> +		     int p_value,
> +		     const char *line,
> +		     int len,
> +		     unsigned int size,
> +		     struct patch *patch);
> +
>  /*
>   * Some aspects of the apply behavior are controlled by the following
>   * bits in the "options" parameter passed to apply_all_patches().
> --
> 2.22.0.510.g264f2c817a
>
>
