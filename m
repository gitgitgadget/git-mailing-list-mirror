Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE65820281
	for <e@80x24.org>; Tue,  7 Nov 2017 06:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754783AbdKGGeu (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 01:34:50 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:57266 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbdKGGet (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 01:34:49 -0500
Received: by mail-io0-f177.google.com with SMTP id m81so969065ioi.13
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 22:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DC95NHp2jU7Ifvg83g2KIBZNAPfIi+Sy7RQ5/p4MIzA=;
        b=N22AXKYlk2sepn0PfBjml9zxulAYqAwlcmicAnZUc0OxwP81YYxKhdF52/DWqVoyy5
         sQjHqqjrF28Ynya0aYF+c8jEeKsOiBq3OIfqZ1dfxt6pT7xtM4NK3XyeBRyEbgW51lau
         qeJRbjHg+qTf2y+8NnElcRo1wOVCUadLULFUIx4VuVCFCXTRdTuj/rudWDK4NXErv4XI
         +OLxQJqWePjZTrimJCG2U4VyGeBa9iGVHOKdOUeSBPq3uqFzvgE2cwavcnD5u36QLbmm
         N5+xTlN6FYw3wdsfcXjw1DstokJnZYvPDCwOoqaV4aNV5XmQRVzUj//qSRp/pive8Q8M
         /2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DC95NHp2jU7Ifvg83g2KIBZNAPfIi+Sy7RQ5/p4MIzA=;
        b=dpNdW6IRNuqhdQHvCvwojIMRGL6/JI56wyX/92qTydTshwUUA8mRyu8P0onpmDINGN
         mDo/LhNBnmGcyI5PULN5Cfn8Iu9u7ehdCIlWvBCNxVg7H0z2ykqn21k5pm86Guanbhdn
         NvTqzeNQ8qj+avnvTbcfixJwkFqdjyEvN8FUYniAiArTkhnedKJxFexTG7h7ZQ7Y0SSH
         DadUvnoM3sCWrrxfveNbD/MdVFMvSBOeqc1Xt7B6aZmQALMJN6Pl9GQE4oUwde0S+Mwo
         oVqL+D3TagwM7jlJBp6rQHuz6bTNhQm52tBWkx0JDC2EHKECSn3FjVmqouNI8x68U/n9
         BXRQ==
X-Gm-Message-State: AMCzsaUG14g4j/QfsSzAqY4U5rDgG62Fg/KvCpeR7tE3ng2WC5ljOcq3
        cooUTBZ0nDmpVe9j8SqO+iZemRUk4YvKWLfU06s=
X-Google-Smtp-Source: ABhQp+Qsmu1Uml6rS5fxepdrB3lKk7BvVlGAg1fAZx2xs94pk8axoFJdhUW9myMfTtbEPQHEKQ9oQAz8L/d+M9tnSeI=
X-Received: by 10.107.180.20 with SMTP id d20mr23074827iof.116.1510036488547;
 Mon, 06 Nov 2017 22:34:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Mon, 6 Nov 2017 22:34:48 -0800 (PST)
In-Reply-To: <xmqqo9oehotn.fsf@gitster.mtv.corp.google.com>
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
 <20171105213836.11717-3-chriscool@tuxfamily.org> <xmqqo9oehotn.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 7 Nov 2017 07:34:48 +0100
Message-ID: <CAP8UFD2vk4jV7jEBx3Axd-dhfcsGSJVFFt+pumdT1j8GD_oM_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] t0021/rot13-filter: refactor packet reading functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 7, 2017 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> +sub packet_required_key_val_read {
>> +     my ( $key ) = @_;
>> +     my ( $res, $buf ) = packet_txt_read();
>> +     unless ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
>> +             die "bad $key: '$buf'";
>> +     }
>> +     return ( $res, $buf );
>> +}
>
> The function calls itself "required", but it does not die when it
> sees an unexpected EOF or an empty line.

If $res is not -1, it will die if $buf is empty.

> Neither of these cases
> gives it a key (nor val), but it is not treated as an error.
>
> That is curious, isn't it?

Yeah it is a bit strange for the unexpected EOF case.
I think I will remove "required" from the name and add a comment
before the function.

> By the way, is it just me who finds this "unless" even less
> unerstandable than the original in packet_txt_read() you modeled
> this one after?  The original depended on packet_bin_read() to die
> on an unexpected EOF, so its "unless" made some sense (we know we
> got some input, and it is an error for the input not to end with LF
> unless it is an empty string).  Negating the condition and making it
> "if" may make it easier to understand, perhaps.  I dunno.

I can remove the "unless" and make it easier to understand like this:

  if ( $res == -1 ) {
          return ( $res, $buf );
  }
  if ( $buf =~ s/^$key=// and $buf ne '' ) ) {
          return ( $res, $buf );
  }
  die "bad $key: '$buf'";

Or to keep it short just:

  if ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
          return ( $res, $buf );
  }
  die "bad $key: '$buf'";
