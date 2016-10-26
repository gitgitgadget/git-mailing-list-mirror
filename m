Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB6A2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 17:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932983AbcJZRI7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 13:08:59 -0400
Received: from mout.web.de ([212.227.15.3]:54505 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755427AbcJZRI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 13:08:58 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lw1CH-1cy0Qq3HJt-017nrq; Wed, 26 Oct 2016 19:08:45
 +0200
Subject: Re: [PATCH] hex: use unsigned index for ring buffer
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
 <20161023091146.p2kmqvgwxdf77dnn@sigill.intra.peff.net>
 <fb816dd5-8fb9-c6a6-2ec2-9ea4dddfdb26@web.de>
 <20161024130015.awlmgpfzixiy6wkb@sigill.intra.peff.net>
 <xmqqwpgx7jn6.fsf@gitster.mtv.corp.google.com>
 <xmqqshrl7j42.fsf@gitster.mtv.corp.google.com>
 <b1f9054e-fadb-c2d3-bf95-00e88e1fb85b@web.de>
 <xmqq60ohtib5.fsf@gitster.mtv.corp.google.com>
 <20161025003023.6vaqofsixana3zno@sigill.intra.peff.net>
 <xmqqd1ios2p3.fsf@gitster.mtv.corp.google.com>
Cc:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3c95a89a-2a9b-2856-42a1-6b994f2e31cd@web.de>
Date:   Wed, 26 Oct 2016 19:08:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqd1ios2p3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ide2fU525bTWC2OzYFyn2trtse95YDXYneJD9hGkLyi6YQW1GT7
 gvqSdFA5pQrn24c7ORTKEF+fofkya6yAKGuqzvehLTuc1k9xNk9z+99E5tH5GLgS8AtuYYZ
 bvfMpzLIeloLZn070lDqRgQO4yjPQWz+s+NDDgTuvBM2J/fLphYhGQ2xsTWhYbxUz740UOx
 VNq7syFWeyJ6UXeJDRFzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9zShrYAwXL4=:A58EgTzvebnKSvGroDFS4G
 qJVTEM8p3TilZiY2PDr5F4sX9+4aNb2tcVSiTRmEDIc+WIgoBVohR9qxADpOPOQAPitQrTqbb
 pDb0+GGBk+Y3crRMin7L3AwV9p1HlXVyNksDnwXJ7k9GJDaVsUpvooBn+iyLXq9/HbqXcRPyW
 MfWzADlJgEJO+5lLU2UI34fv9JSAKV/CR9rpblWixjkah0KEA6+XM5RGZOUdr6zr7pmmnOPf0
 hOEVgQrr6otP3G8KDBlCzDR4C3MoAykNLN1iWFPAAM2gf0KD7mOp/L0LTA1cnb+c/839JJKud
 lzLan+TOl7wqpOI5TkxeI32SQohL6D0jcf6EPn1cQU9h4Z3bKWvnDCSLxrjzrmu6b11QOY1BW
 ViaudjTgwkbVgeMThbys4o5mGAg2UQ0RyA3ASBckWyakeiPD1eMtJm1L3N/mjvfZwDcLxOVuM
 4CPJ3tubrluVFAlzkIncVsPBI1z13JJZ5taNAc1lGYSIxMt1rpQw4aS39w/fqAbO5mw9xDn/3
 9dVCrFeIfdVjWGzwVi3PfYUm421625Gd4WfoPDOmrwd1BR60ir5Ip7Hiv8aODbK5Tm5Ns2VRi
 KG8qm9CiRfvPWDL2ZFa+2QxAP25B9xf9tDY7DNTGpqBPWUG64cQMTc9HlqXiKh5L5P4gUKxeI
 eUPkBlGRBvMFjGmVN+C83y2CP0kUEQMhqUGWDdODCmaDzA3T4JU3jm2l9zeKSoBtw9JNQHH9A
 Vyx9P8v/AJh5iXlxwSTJ9iPVZbjA8mCFXMKrYIjzDeytIZYIszELmJyvLi8n8IGmWtoMkd8Px
 R96/W9J
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.10.2016 um 20:28 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
>
>> On Mon, Oct 24, 2016 at 04:53:50PM -0700, Junio C Hamano wrote:
>>
>>>> So how about this?  It gets rid of magic number 3 and works for array
>>>> size that's not a power of two.  And as a nice side effect it can't
>>>> trigger a signed overflow anymore.
>>>
>>> Looks good to me.  Peff?
>>
>> Any of the variants discussed in this thread is fine by me.
>
> OK, here is what I'll queue then.
> I assumed that René wants to sign it off ;-).

Actually I didn't sign-off on purpose originally.  But OK, let's keep
the version below.  I just feel strangely sad seeing that concise magic
go.  Nevermind.

Signed-off-by: Rene Scharfe <l.s.r@web.de>

> -- >8 --
> From: René Scharfe <l.s.r@web.de>
> Date: Sun, 23 Oct 2016 19:57:30 +0200
> Subject: [PATCH] hex: make wraparound of the index into ring-buffer explicit
>
> Overflow is defined for unsigned integers, but not for signed ones.
>
> We could make the ring-buffer index in sha1_to_hex() and
> get_pathname() unsigned to be on the safe side to resolve this, but
> let's make it explicit that we are wrapping around at whatever the
> number of elements the ring-buffer has.  The compiler is smart enough
> to turn modulus into bitmask for these codepaths that use
> ring-buffers of a size that is a power of 2.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  hex.c  | 3 ++-
>  path.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hex.c b/hex.c
> index ab2610e498..845b01a874 100644
> --- a/hex.c
> +++ b/hex.c
> @@ -78,7 +78,8 @@ char *sha1_to_hex(const unsigned char *sha1)
>  {
>  	static int bufno;
>  	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
> -	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
> +	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
> +	return sha1_to_hex_r(hexbuffer[bufno], sha1);
>  }
>
>  char *oid_to_hex(const struct object_id *oid)
> diff --git a/path.c b/path.c
> index fe3c4d96c6..9bfaeda207 100644
> --- a/path.c
> +++ b/path.c
> @@ -24,7 +24,8 @@ static struct strbuf *get_pathname(void)
>  		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
>  	};
>  	static int index;
> -	struct strbuf *sb = &pathname_array[3 & ++index];
> +	struct strbuf *sb = &pathname_array[index];
> +	index = (index + 1) % ARRAY_SIZE(pathname_array);
>  	strbuf_reset(sb);
>  	return sb;
>  }
>
