Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB771F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 11:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbcHALdq (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 07:33:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35834 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbcHALdh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 07:33:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so25758837wmg.2
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 04:33:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FNldXXgdorcyKxZHuM92fqyJaEJTR2DxuvVsa5WEJDg=;
        b=PWjRK9KA+kaFV4oCD9a4ElMCzVPngZFB4N1cNxgn6tXphLjU92THmI1jZ8RaiJejkH
         B0TH7CfURrYWIKs+YKDg+CchLoVUmb+jmMpItRbqx0O1E9rNrF1y4G2pvz0nc0aLDVEZ
         1hK/LCgjNVMn5hrSHKzjX04Zmy6aAFlksif8kb3W1LPmfkDxYCRerVGlLKCS9uZ84LEj
         sUea9feylKQz/2glPKMN5mOYQQhS4b3Jsf5U4/Ac8aeVDYK2yZU3DGAodJ3C/JCNALEf
         eJ4WZdHmaF6Joqs9fkG1RagDUTb+Z73/uTfLHDt0UMPYG95HrRSQmo66aiquMmYATsTO
         mfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FNldXXgdorcyKxZHuM92fqyJaEJTR2DxuvVsa5WEJDg=;
        b=hjQXsrj2Vk+7hzneFSwImtMFwdcTKv2QOBIlflNwM5Bwt3dwE4ckM9Ofopr54NEPpc
         XWfoc+F8TOj70RlmTdKiR2AHwZBPYGidp0kJ14P4KlfwDq+ijws+//igeWlJ2WWX+Zz7
         EVjVroX7tOl/o4HnRWgEXCmx1/A+A+MjuFnOxhyU2q/ru3ukWB60/p/kXSh57kVf6B5r
         bhWKsnMizUWgOkhIdw4BAgisv8FRfwLdxd14RmmSoE5OqaR0Zrwp+uGIAbpdEhs9hvwY
         WAT/5tv3XSnMxRoDAtPOOO/pUcln5tSUB1YvFyXa2r9j8ieYv1OZ6GK7CUs4NJDpmJir
         l16A==
X-Gm-Message-State: AEkoouuNTqamwGdiOBP8+ycUnNWTUHoIFyo0+pgaO2XMFsWSw0oQSA5f2NYbDh158q4waA==
X-Received: by 10.194.135.205 with SMTP id pu13mr57074736wjb.37.1470051216390;
        Mon, 01 Aug 2016 04:33:36 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id hb8sm30022778wjd.13.2016.08.01.04.33.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Aug 2016 04:33:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 01/10] pkt-line: extract set_packet_header()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <4081bc44-d964-79ec-165f-f49f33823c17@gmail.com>
Date:	Mon, 1 Aug 2016 13:33:32 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <73AED3FA-C666-4C49-90B2-387E410F7D52@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-2-larsxschneider@gmail.com> <4081bc44-d964-79ec-165f-f49f33823c17@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 30 Jul 2016, at 12:30, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> set_packet_header() converts an integer to a 4 byte hex string. Make
>> this function locally available so that other pkt-line functions can
>> use it.
> 
> This description is not that clear that set_packet_header() is a new
> function.  Perhaps something like the following
> 
>  Extract the part of format_packet() that converts an integer to a 4 byte
>  hex string into set_packet_header().  Make this new function ...
> 
> I also wonder if the part "Make this [new] function locally available..."
> is needed; we need to justify exports, but I think we don't need to
> justify limiting it to a module.  If you want to justify that it is
> "static", perhaps it would be better to say why not to export it.
> 
> Anyway, I think it is worthy refactoring (and compiler should be
> able to inline it, so there are no nano-performance considerations).
> 
> Good work!

Thank you! I would go with this then:

Extract the part of format_packet() that converts an integer to a 4 byte
hex string into set_packet_header().

OK?


>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> pkt-line.c | 15 ++++++++++-----
>> 1 file changed, 10 insertions(+), 5 deletions(-)
>> 
>> diff --git a/pkt-line.c b/pkt-line.c
>> index 62fdb37..445b8e1 100644
>> --- a/pkt-line.c
>> +++ b/pkt-line.c
>> @@ -98,9 +98,17 @@ void packet_buf_flush(struct strbuf *buf)
>> }
>> 
>> #define hex(a) (hexchar[(a) & 15])
> 
> I guess that this is inherited from the original, but this preprocessor
> macro is local to the format_header() / set_packet_header() function,
> and would not work outside it.  Therefore I think we should #undef it
> after set_packet_header(), just in case somebody mistakes it for
> a generic hex() function.  Perhaps even put it inside set_packet_header(),
> together with #undef.
> 
> But I might be mistaken... let's check... no, it isn't used outside it.

Agreed. Would that be OK?

static void set_packet_header(char *buf, const int size)
{
	static char hexchar[] = "0123456789abcdef";
	#define hex(a) (hexchar[(a) & 15])
	buf[0] = hex(size >> 12);
	buf[1] = hex(size >> 8);
	buf[2] = hex(size >> 4);
	buf[3] = hex(size);
	#undef hex
}

- Lars