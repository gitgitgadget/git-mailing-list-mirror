Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14421F407
	for <e@80x24.org>; Wed, 13 Dec 2017 23:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750992AbdLMXCh (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 18:02:37 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:44045 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdLMXCg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 18:02:36 -0500
Received: by mail-wm0-f42.google.com with SMTP id t8so7989513wmc.3
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sebgo4tQsa8dT11n3GDu6upuv0gjoyr5zzc872/Kwtw=;
        b=iD06REv6Nqkm1ijKo+BMdgJn4Sx1PoCt4RjfwDNzSuTwoOpT65PVV6NebQyiP6elx0
         cJBiCO0ZMtnk9/UlQSUR4ARBOgyRDZxdcy4s7q3GA7PLUgzpYEFHFgEpe5JE+9vuHnor
         HhNZD/swpEFSZ1WbjKxLcK3GNdoVpMsPKO60dQQhD7ZaCkHciK31+w9t1C46QEpl7kOY
         cxC0CnOtUG04cXtGs7JPTLhNLhZ4tuxwRNPoIQMtDJPUk3Tnwr/jHwvRTGJhar8r8h3M
         x9HcBp4nQafx1LQkXcSnVkc3eldkIesCSW3EkdHYgDux3uPAWCGz4TfZIu8cmRhPXpLc
         9hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sebgo4tQsa8dT11n3GDu6upuv0gjoyr5zzc872/Kwtw=;
        b=sRvLIDR6AnFwuJe9gM9E+qUzoZc5IKBVHwGWX/wGkb7qBfUcUM7xYnD6IfO7WiHx8k
         RexNGwws4fmKOvO4tVKmLGKfbjGeicd7duzoRasZbBEobyPaCA+9b0AmRo0Ga+BASuEu
         kORJQbxD3c6hOXrYDO0oZyi5ArBx1gtiYF0WSRo/FzQbqlumRNlBMaRMzw7IDgM3DwQ4
         UI24s/GgHq4h1qqU3EuyY55yz2+lfQ/83BhUW/CaqCdZK8W1uh5Mq6KD1vSfijHRuc53
         DUwaLt/kwxfjMwwtahachPgcKa/selKF6iH7KEetSQY537Zg6cYbDnDM/aZo9h2OuQDi
         a6fg==
X-Gm-Message-State: AKGB3mJgipGJsni4oP2GxUhlUP7HNOwKSOPztdEzCAviM5EFlu/mOuA9
        eA1ZUEumqV5XgsbCjpRdKPM=
X-Google-Smtp-Source: ACJfBoscoCNl3Z9IFLX2Z1/keceZKQWp7pm3bQgeSBOfF5kTrZJ3xOVuSP2kI46wYMu2SoBkfEOCBA==
X-Received: by 10.28.165.130 with SMTP id o124mr458844wme.124.1513206155506;
        Wed, 13 Dec 2017 15:02:35 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB50E0.dip0.t-ipconnect.de. [93.219.80.224])
        by smtp.gmail.com with ESMTPSA id g7sm5481676wra.38.2017.12.13.15.02.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 15:02:34 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqzi6mwlai.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 14 Dec 2017 00:02:32 +0100
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>, patrick@luehne.de
Content-Transfer-Encoding: 7bit
Message-Id: <C062CB10-9885-46B4-9614-65A39BD5FBE8@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com> <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org> <0BA27EC9-3836-407A-9A8A-52D06B8052AE@gmail.com> <xmqqzi6o3go9.fsf@gitster.mtv.corp.google.com> <48ebcb7a-2a7f-e790-2613-a1f3e3dc41f9@kdbg.org> <F571AAED-C325-4151-9566-6BA249C1B3D4@gmail.com> <xmqq1sjz3frf.fsf@gitster.mtv.corp.google.com> <D2973852-BDF4-4251-8DE3-CE6AAD303A5F@gmail.com> <xmqqzi6mwlai.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 13 Dec 2017, at 19:11, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> ... In a perfect world I think I would store
>> the encoding of a file in the tree object. I didn't pursue that solution
>> as this would change the Git data model which would open a can of worms
>> for a problem that not that many people have (almost everyone is on
>> UTF-8 anyways).
> 
> Having that "encoding" trailt recorded in the tree that contains the
> blob would mean that the same blob can be recorded with one
> "encoding" trait in a tree, and in a different tree it can be
> recorded with a different "encoding" trait.  I doubt it really makes
> sense.

The "blob object" would store the text data encoded in a canonical 
UTF-8 form. The "tree object" would store the encoding. On checkin 
Git would convert the text from the stored encoding to UTF-8 and on 
checkout it would do the reverse.

That way you could control the encoding for a text file specific
for each path similar to the "mode bits". That also means you could
change the encoding of a file while the blob content stays the same.

Changing the encoding of a file with the .gitattributes approach
can be difficult if you have configured the attribute with a very 
broad pattern (e.g. *.foo). You would either need to rename the
file or limit the scope of your pattern.

- Lars
