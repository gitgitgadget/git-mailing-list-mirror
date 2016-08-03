Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08A721F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757759AbcHCV4r (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:56:47 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35537 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbcHCV4q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:56:46 -0400
Received: by mail-wm0-f44.google.com with SMTP id f65so464007653wmi.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 14:56:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zbY2Cl8S9xIQGdlNgd580LAyeO8+bxTF9IyUk2t/TFs=;
        b=LoMKPQfAOqOOVD5pgYvWkEwAMQieqbHZjsdVqIhnzTCA/m85Ym4NQT3FReGQIB7+ev
         paJz4O17JUyzVSCt0p7T2exyRfKGF1UcXl5q83PW+vZEJcluB+Oo88fBJj0BYSUy/7kH
         mWIwmm0ebj7QS5axxOyI71WBDonjR8WMbXKufC6NPX3S3Caulx2bFO4ABJuJPfSXqtoO
         TyKb8Kjs+8FyBgFSoBb4VpuuRYyacWZX8Z9F1rbA+PToMUd3+Ou3C//5IvHAHJZVdzDG
         PZ7ocCfc2hZ9sTDvwns647HSJw7MOfHkorcyW/ufR6LpK1uy9At2othq9xHh/BGyNpjS
         bsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zbY2Cl8S9xIQGdlNgd580LAyeO8+bxTF9IyUk2t/TFs=;
        b=cn2gPVOx82Bbi8JTWk2JaX98eQ5Ed08UD1KMT8Ysnd5l/aHzpWvdIC8CsudwT+f/s2
         XNaY0RCOF8y1cDb7I7DNNLKuP/BvAipPj6l/8SRf6ATtI0S9Q0mxJ1ZbA3wwtnQ1NJ09
         oBKI7VfH9BOlbRP5yW+8RInDuVZAhoPezhxCTiXFlnWxHUU3/uk/1GRCy9haVNfirR0t
         RUybdXyuxx5eSqcOv9C/1sJMADB5tyAmnUdE10/cXI1Po7Cje8QmkjATqTJfyfGEkH23
         fOG2+YASjKzC765vJFmNqdcG9Qln9kxYA2SIw12Jbv6eCtSOXyroWx89BnVGkT7f4b2O
         mNsQ==
X-Gm-Message-State: AEkoous8V+1zLL+yekdUZsZz3NcHmYJgnU8/Z5zHvLKv991gkh2kPJJL20oqFW1Twu+ZXQ==
X-Received: by 10.28.174.76 with SMTP id x73mr67795227wme.60.1470261404559;
        Wed, 03 Aug 2016 14:56:44 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB674A.dip0.t-ipconnect.de. [93.219.103.74])
        by smtp.gmail.com with ESMTPSA id o142sm397188wme.20.2016.08.03.14.56.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 14:56:44 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 01/12] pkt-line: extract set_packet_header()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqd1lp8v2o.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 3 Aug 2016 23:56:42 +0200
Cc:	git@vger.kernel.org, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Content-Transfer-Encoding: 7bit
Message-Id: <D116610C-F33A-43DA-A49D-0B33958822E5@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com> <20160803164225.46355-1-larsxschneider@gmail.com> <20160803164225.46355-2-larsxschneider@gmail.com> <xmqqd1lp8v2o.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 03 Aug 2016, at 22:18, Junio C Hamano <gitster@pobox.com> wrote:
> 
> larsxschneider@gmail.com writes:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> set_packet_header() converts an integer to a 4 byte hex string. Make
>> this function locally available so that other pkt-line functions can
>> use it.
> 
> Didn't I say that this is a bad idea already in an earlier review?

Yes, but in that earlier version I made this function *publicly*
available. In this patch the function is only available and used
within pkt-line.c.


> The only reason why you want it, together with direct_packet_write()
> (which I think is another bad idea), is because you use
> packet_buf_write() to create a "<header><payload>" in a buf in the
> usercode in step 11/12 like this:
> 
> +	packet_buf_write(&nbuf, "command=%s\n", filter_type);
> +	ret = !direct_packet_write(process->in, nbuf.buf, nbuf.len, 1);
> 
> which would be totally unnecessary if you just did strbuf_addf()
> into nbuf and used packet_write() like everybody else does.

The usercode in step 11/12 could use packet_buf_write(). I am not
worried about performance here. What I am worried about is that
packet_buf_write() dies on error. Since direct_packet_write()
has a "gentle" parameter in can handle these cases. This is important
because a filter might be configured as "required=false" and then
errors are OK.

Would you prefer to see a packet_buf_write_gently() instead?

Thanks,
Lars
