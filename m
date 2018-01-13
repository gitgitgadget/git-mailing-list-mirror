Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8081F404
	for <e@80x24.org>; Sat, 13 Jan 2018 12:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754961AbeAMMkW (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 07:40:22 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:46374 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754833AbeAMMkV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 07:40:21 -0500
Received: by mail-vk0-f53.google.com with SMTP id e125so1873418vkh.13
        for <git@vger.kernel.org>; Sat, 13 Jan 2018 04:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osmialowski-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7CC2m77POXUOaAiTV7lDL3Yim6NqZUlxZOl/+fQjcBM=;
        b=UgT4DSqEk7q3UW7z7gaQCCcp/DsBMvLiG59VqrQa/yKXAYOxW5OD7i878utG9D433f
         vL9Vub6zRavzDq2OQgYLsv6JAkqHMLIK1ZhyI8pNao9p50qRFk7/QGqCcTGiEendlXeD
         mgJiVhhM/CtI9TlQb3eROoPzh8aZCV4WVmLFbejevvj4DZ1EfT1jm7oKUCLx91N1qojF
         IgNhfhugDlIl4PONkcFvv9bieCCXQV7gk9cJxhIyB5LaO/eNtvRQPMFo6ruYNlt+M8vM
         pijvE1i3Y36B/NMkU9Q9TMBCoR14fTSiYQiwJwEFqrpxIHEkJKnMDHI7Ezz1XSn0q9AL
         v6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7CC2m77POXUOaAiTV7lDL3Yim6NqZUlxZOl/+fQjcBM=;
        b=apsOT1cgkMVRQeSi0zDIPv+G8EDGa8Cma8lO7NATXlLWF0GqIJiPBDjOJL0zhHzSms
         tgSJDholrze/CPIBFUbokXhxmzR96rEHg3KY6pkl/WE/md2HUBsPQkPlG5LB6wSXcsw+
         jDdG3KitExIwcVoSBvtCqbMXe9dsAC/Z7PHE/Zu1otqBRmItzEdXmcFJCPTC/JiVEm58
         ulGhMB4F+FGqYoanF5Gk/pgLYsVydbwJ44herOj6LFj6zepdQSCQuIazdzFJ95PeTH9d
         ZjrpviKcXk9n393giC01aQqA/i0mFrc5CBRTg5lEsTld9cwKfbOvhTUKRN/2CdPajOlC
         +dNw==
X-Gm-Message-State: AKwxytdY09epvHfk65R5LiTNmRf54qzqlV42pmh6fOzdji1ZS4HqeFye
        84FHCLk5LamArI1cjHf2cd/3tS8RyPjfMRIpE+/KaQ==
X-Google-Smtp-Source: ACJfBovQRiI+1KKEWECIJPnQr/Y1HK2tarCBlJcR5+zz6nwNmS9YpUNhFkDdNouvWC7m7iQNFDxlABnAP1e/y1wLIbI=
X-Received: by 10.31.141.5 with SMTP id p5mr25107306vkd.37.1515847220993; Sat,
 13 Jan 2018 04:40:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.61.70 with HTTP; Sat, 13 Jan 2018 04:40:20 -0800 (PST)
In-Reply-To: <20180113002221.GQ29313@zaya.teonanacatl.net>
References: <CAHLNBdVp0VTqtxHQ_cQ2XPMMDhqnQG5boj0M2JrT-iECaFUFZA@mail.gmail.com>
 <20180113002221.GQ29313@zaya.teonanacatl.net>
From:   =?UTF-8?B?QW5kcnplaiBPxZttaWHFgm93c2tp?= <me@osmialowski.net>
Date:   Sat, 13 Jan 2018 13:40:20 +0100
Message-ID: <CAHLNBdUTWTbvkLdqbvB-1vs=oPJOHP5S3CWMZbtCgBnJNh4hRQ@mail.gmail.com>
Subject: Re: Git uses wrong subkey for signing commits with GPG key
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd,

On Sat, Jan 13, 2018 at 1:22 AM, Todd Zullinger <tmz@pobox.com> wrote:
> Hi Andrzej,
>
> Andrzej O=C5=9Bmia=C5=82owski wrote:
>> I have an issue with git and signing commits with GPG subkey.
>>
>> My setup:
>> - master key used for certification only
>> - subkey for my main workstation
>> - subkey for my mobile workstation (a notebook).
>>
>> Both subkeys are used for signing only.
>>
>> I've configured git to use my specific subkey however it does not
>> work: git config --global user.signingkey =3D KEYID. Every commit is
>> being signed using the newest subkey. I've verified the same behavior
>> on three systems (although with the same setup). I've tried to use
>> --gpg-sign=3DKEYID flag, but it does not work either.
>
> I could be wrong, but I think you need to append '!' to
> KEYID to force gpg to use that specific signing subkey.
>
> --
> Todd
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> A vacuum is a hell of a lot better than some of the stuff that nature
> replaces it with.
>     -- Tennessee Williams
>

thanks for reply. You just solved my issue. I will prepare a PR to the
docs to add relevant information.
