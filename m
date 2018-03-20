Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82CC1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 03:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbeCTDk0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 23:40:26 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:33971 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeCTDkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 23:40:25 -0400
Received: by mail-ot0-f182.google.com with SMTP id m7-v6so264183otd.1
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 20:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dakotahawkins.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YG//+TkzPXDRzg9aqa4oDULWLveYYa64eCrppf7qfCE=;
        b=H2hBoAfdJGIzpdHQ6cU83W86mshXv/Gd9zaeG66PvKORkS+gAoWmnorotFuOM1bQtB
         KYVxibglJUicKBANyY4Z7ELqRsae+4sMUuKDG2kQAOK/Sfxep7dBX5oLAjJTSRIgAIQu
         XPBIT9mCzOACqepROlbksifuFO6sNugjoJSkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YG//+TkzPXDRzg9aqa4oDULWLveYYa64eCrppf7qfCE=;
        b=pO26A0mKLlelcl8xjCP8GeOZ2LcEFYIB338WWzdoOjyl+qdR7WIuA7mQPm8QStBbgr
         ZtUj3zqCcLMKzSvSzIcyahc8JmPHsZMWBIk2LP6hMLI3o5z1ecJtfRrasDSvDJCYulj+
         4P0Vmhw7gRb+BAsjIjAFdf2Cw104GLBfNHRXcC4FpSL2NSAaFON+MdIo2POF+yChkyy7
         N1R7bG4qTa+Z3H/kp9RSGmfDKpBV5BUA5IMgevSKzD9MI5RvKfcPVShs96rACIMlIQjH
         WdBI7br8PTfWKfJcdlw0aErJ8cChtUKbtCsBadXhZIVHOTKbrPaY82yMkMIa6/u/92Xf
         mL2Q==
X-Gm-Message-State: AElRT7HZIEBfhtYYehEexpEtVvIxb0iVEeQT9Emttc4SUJym3cC0Gb+Z
        DQEzss5jsRhMzS1o7yfTeZljXXndFDyI95s0nV7Ds+RH
X-Google-Smtp-Source: AG47ELt4W0oNz5tezeTf5hyBWYEu18I2xCWReCNI+2G8HkWzHstENVr5ILUCIio9Ja3K3zZFxFE8yVQBLDly2a0GaFo=
X-Received: by 2002:a9d:3c0a:: with SMTP id q10-v6mr3610438otc.156.1521517224770;
 Mon, 19 Mar 2018 20:40:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a69:0:0:0:0:0 with HTTP; Mon, 19 Mar 2018 20:40:24
 -0700 (PDT)
In-Reply-To: <xmqq8tanto90.fsf@gitster-ct.c.googlers.com>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net> <xmqq8tanto90.fsf@gitster-ct.c.googlers.com>
From:   Dakota Hawkins <dakota@dakotahawkins.com>
Date:   Mon, 19 Mar 2018 23:40:24 -0400
Message-ID: <CAHnyXxRjqKKyp0U7ryxUk4BMHGdqN1pMYC66BDG+8UYPaF7a3w@mail.gmail.com>
Subject: Re: .gitattributes override behavior (possible bug, or documentation bug)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 11:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> The best you can probably do is:
>>
>>   /.readme-docs/* diff=foo
>>
>> Since you have no diff.foo.* config, that will behave in the default way
>> (including respecting the usual "is it binary" checks). So a bit hacky,
>> but I think it would work as "ignore prior diff".
>
> You can say
>
>         /.readme-docs/* !diff
>
> I think.  Thre is a difference between setting it to "false"
> (i.e. Unset) and reverting it to unspecified state.
>
> Isn't that what you want here?

In this case, I think so? In this context I don't necessarily know the
files in /.readme-docs/ are binary (though that's its intent).
Ideally, I just want it to do whatever it did before the match gave it
"diff=lfs". I realize that that's not possible/feasible, so I asked in
a separate reply whether it might be a good idea to ask git-lfs for a
"no-lfs" filter for exactly this situation.

The actual "lfs" section of my .gitattributes file is about 65 lines
for 65 different extensions, so I'd prefer to handle the exclusion of
a directory without having to repeat that whole block with different
options, if that makes sense :)
