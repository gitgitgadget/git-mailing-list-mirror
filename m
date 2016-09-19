Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7DA72070F
	for <e@80x24.org>; Mon, 19 Sep 2016 12:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759406AbcISM7g (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 08:59:36 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33510 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755245AbcISM7f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 08:59:35 -0400
Received: by mail-io0-f176.google.com with SMTP id r145so90097538ior.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WgFy/wo6TiXWaSzB39N2ZqhaWF8tcwuW1ctDKXYQRwo=;
        b=EQCsiTLLLQpm7Kox6S5EdGfGTammtXSZybhpr+BsYpxr6fyoPdha1n6veqnX4w3gK5
         BhtadWvniyLgX6dPzbBWzr+EWhdThge2aCJ7L8HZ17dHaADvb8ssdf1YkzJ6/oVirxZO
         yqDqNVtDEXPtJVog3ngNNLfezJrpX5Zd9PS5SL3rlYM6p9ZMXj3k3wflExPs2BWQy4LP
         LbPrrQ9egKZ326UNBP6LZ5ywI10KMVFxEX8WZcPhh6jwJOZ+Zk6deIZqYob9RtJ6m2u8
         +fh2EX8CItqUkxHkvrBlR6n7LU4/bFss11SYRvGL7/qFuCIaaUvXFCcEaYyNe0gfscEj
         X9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WgFy/wo6TiXWaSzB39N2ZqhaWF8tcwuW1ctDKXYQRwo=;
        b=RSndZiIsQ8xE1WtAz+zNQAaDLP+CXavC+acrI0ahnLEgLOF5WkeRLhkW+JexSrDI7n
         XNFLfEB5z/1zqlLHCoCTyGJ8DA+5MgMIxxfW0knjIdRj96csN0eKmIchRQ/d4MND3Wz2
         5RAqltgqtscjDBFO+YowcM/g4Xw3wfLS4UfTmeRcoqFk/APHpIQRUo2I+pb6q3MohwmD
         4ykBwRUKhRXYdTpPRwYTSoziuD2QoPd6R3bthKoJYg7Q87SCjb8938c72vZbRmzjCXi4
         CWVwvUqhBZZfHkx4O81lFdoiZKCVIcC+HcJe9HRa5pfgZC4eYTxuwHcliYhjNkNBZcIm
         f3Dg==
X-Gm-Message-State: AE9vXwORoMvjrPhqR0zOpMgU3TUP8ixgHAGJlUunl10IfJj0UY7VdkR7LtMnFc5mdTM00j0dESK3bZKeXol+yQ==
X-Received: by 10.107.142.77 with SMTP id q74mr16764930iod.0.1474289974046;
 Mon, 19 Sep 2016 05:59:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Mon, 19 Sep 2016 05:59:03 -0700 (PDT)
In-Reply-To: <db20ae0c-9c33-1e65-b201-1b6a9ed11340@web.de>
References: <nrje96$q7s$1@blaine.gmane.org> <db20ae0c-9c33-1e65-b201-1b6a9ed11340@web.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Sep 2016 19:59:03 +0700
Message-ID: <CACsJy8BUT6wypU5yn4izCadEF0y32n4m9x8ZLgfod+HNfSZiqg@mail.gmail.com>
Subject: Re: Two bugs in --pretty with %C(auto)
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Anatoly Borodin <anatoly.borodin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 18, 2016 at 1:25 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 17.09.2016 um 14:51 schrieb Anatoly Borodin:
>> Hi All!
>>
>> First bug:
>>
>>       git log -3 --pretty=3D'%C(cyan)%C(auto)%h%C(auto)%d %s'
>>
>> prints %h with the default color (normal yellow), but
>>
>>       git log -3 --pretty=3D'%C(bold cyan)%C(auto)%h%C(auto)%d %s'
>>
>> shows %h with bold yellow, as if only the color was reset, but not
>> the attributes (blink, ul, reverse also work this way). %d and %s are
>> printed with the right color both times.
>>
>> Second bug, maybe related to the first one:
>>
>>       git log -3 --pretty=3D'%C(bold cyan)%h%C(auto)%d %s %an %h %h %s'
>>
>> The first line looks as expected. Well, almost: the '(' of %d is bold
>> yellow.
>>
>> The second line looks like this:
>>
>> * %h, %s, %an with bold cyan;
>> * %h with bold yellow;
>> * %h with normal yellow and %s with normal white (default colors).
>>
>> PS git version 2.9.2
>
> Well, in both cases you could add %Creset before %C(auto) to get what
> you want.
>
> I'm not sure how just how automatic %C(auto) is supposed to be, but you
> expected it do emit the reset for you, right?  Sounds reasonable to me.
> The following patch implements that behavior.
>
> Duy, what do you think?

Even though letting some attributes before %C(auto) through sounds
interesting, I'd say it's a bit unpredictable, especially when the
main usage of %C(auto) is %d which could use plenty of colors. So yes,
your changes look good.
--=20
Duy
