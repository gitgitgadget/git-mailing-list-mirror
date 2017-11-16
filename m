Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4268A202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 15:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759883AbdKPPZA (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 10:25:00 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:32835 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759056AbdKPPY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 10:24:59 -0500
Received: by mail-wm0-f45.google.com with SMTP id g130so238922wme.0
        for <git@vger.kernel.org>; Thu, 16 Nov 2017 07:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/N/+VgyYWr/UHAuEghhy0haROiWBEeha5VeU9TJNnR8=;
        b=D/D/i4QlaZrxnZaZVdfkKA4K3Ahm7dn9pn45i+uW66VTCOZ3Arko8AeZbtMqCIOWkz
         m1M0KWzWocIND5vAl8Ij1EtAZr289tOrmYhkR090PUfYfiFFov4J0tBbSxC0p/Ida4KH
         CgABX5fM9ElyjHauwH7d7WC/Gl7G23OEwmFzynpimU1sd7z02iW/hNOaUvRGH6YmeQ35
         m2N17fNTRIRtElBHZrYbQw393ndZt8Rmevy5IqpVoSd+0uP4Y7wI9Bxp84DEzFDjBFmO
         xBp9JiyLK9iPvbzDTo+TZPakukb8wojxg5M6mfsXy1saU2w1vqwfs2Lsy2ekC01f54KW
         laaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/N/+VgyYWr/UHAuEghhy0haROiWBEeha5VeU9TJNnR8=;
        b=UF0VTJXXKv/t/qML42SVHlmaOEqJlyOv5xKFS0XFXBCoCh6e68PgN5KIJiOszCWW9f
         iNQiVWhE1oIr24dLoqGIa3iBaTSw8ky6LYqEh1ABqZGUYV1hpJkiskKL0B05u8IPoZnq
         GNPXdhBQfgVa069Ur+/G1/+3DO4SPho6MmL/O7ZMKmLVXurp2X/etNauaYznh/w0sxjw
         D5un8MHK8sZW6PzqVlYXu4kt9cjW1UXPyEoCoRsFxhEEYgLwG9RyjIPIU0l1XOtZCZtf
         ljKsLp54oJAq3Y2m3a80DKgdm/KfnNe0lkshtab9kCC7TtvyDfUIJ22ZRJpeLJycGtMA
         9auw==
X-Gm-Message-State: AJaThX630mvDynakHMK17SMbmkyENg3LRCAdpcUG0KXGZOeMkLZOL2DD
        GgvSi95ah0Wo3eZCubjxJV8=
X-Google-Smtp-Source: AGs4zMb9JaMnrmAaMQLGKqDiPWHVKtaPtFUWXGxnmjf8DoXAeaRKqDVtqV+SIdpU7P6TqRPgHNzWDg==
X-Received: by 10.223.182.153 with SMTP id j25mr989087wre.242.1510845898061;
        Thu, 16 Nov 2017 07:24:58 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 90sm2420987wrp.93.2017.11.16.07.24.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Nov 2017 07:24:57 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqh8tuuv6l.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 16 Nov 2017 16:24:55 +0100
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Transfer-Encoding: 7bit
Message-Id: <DAA0F91D-5180-4C3B-B0E8-7C917915AC6F@gmail.com>
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com> <xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com> <DAEC36C7-AE09-4C9B-ACC4-07F2C5F2B97F@gmail.com> <xmqqh8tuuv6l.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Nov 2017, at 15:58, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> On 16 Nov 2017, at 07:04, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Wow. Thanks for the quick patch :-)
> 
> Heh, this is not exactly my itch, so if you are inclined to, can you
> take it over from here on?

Absolutely! What is the proper way to proceed here? Should I send a v2
with the changes I suggested? How do I attribute you correctly? I
assume I need to remove your 'Signed-off-by:'?

Thanks,
Lars
