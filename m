Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F6B1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 04:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752476AbdBCEci (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 23:32:38 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35099 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbdBCEch (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 23:32:37 -0500
Received: by mail-lf0-f41.google.com with SMTP id n124so4006285lfd.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 20:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GmfgJ2dOi0sJ+PeCbe0R5Z0ysrJaQkCt/WajiiHhC6c=;
        b=oPfVbjGvHcjXlV8Z6wTwPfos2rsyNnwAko8UE0GJteXIVLxeHq4f+E61GMrsMx04hu
         CKOi36fYzHsF7auSz0HTrVKKrWtPpQDirmNfNOMQe/fOdUtRKxwKrnUU3B+76wqkErpe
         72ulAdbIyaxg4GPp4fNsgzBM+WexT1AzVihf7B0gMBRy50Eird0tHapurn9PaV72bP0L
         QQxXuOJC4/NEayqU1ZfFNaI/9z74LDhX1u36NMYKtE4XUJOQHF23lvFDmoya4ARF/5UN
         OtmbpVBAKDexxONPYoUO/81aCwEOrjp6hWfpZrZej5sRI8S9AkqkzHchsOEk+VGaZxs5
         4XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GmfgJ2dOi0sJ+PeCbe0R5Z0ysrJaQkCt/WajiiHhC6c=;
        b=s1S8HMNzjNL2+axC/2mPcSsVYdeZ1YD2+vWlS+9t77lQ0MbG9Z8CJ9lB23HpoLk9Of
         Rl6ZWuin6zZoX54oBfKJa+LJcKUOEGJlRVXTYI16v4A8ois1ZDQGV/ir/qxg2d7LuW4p
         +AkKDS8S/kmXKvAP0jzhTFjfmS54+3enavdZqGq/bD/o/nZaq9AI4E19a0B6ptO/1l4e
         1A2o0jDzDzPMRzFsQvH3km1WH2q0J7Bcm3TO/7j/JLFQoUIVB6DTYW58gf3bA7y+9xss
         qt/qESTNER1DTb7b+tEgsXqdlJgMLJaxwH1nNL0ZuDnM43Y3BkakO44RLgyodS62YsKE
         M6EA==
X-Gm-Message-State: AIkVDXKe3k3bwBfkS95f7ErScIIsH8JWDTMqcTg0xBip3tFtuRCHop90jbiTH4NZH5loqbMXcm2bQQxKvBe2MA==
X-Received: by 10.25.21.96 with SMTP id l93mr4203637lfi.136.1486096355153;
 Thu, 02 Feb 2017 20:32:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.20.193 with HTTP; Thu, 2 Feb 2017 20:32:14 -0800 (PST)
In-Reply-To: <CAAj3zPz8wFc_5dRmM=-jMnqp6a7fGtc4XSyU5meF6mO5me47Dw@mail.gmail.com>
References: <CAE1pOi0-8JnnZbdm9vu1RwTU1mXr7dboLC3ito3LcvK9gkNi_A@mail.gmail.com>
 <CAAj3zPz8wFc_5dRmM=-jMnqp6a7fGtc4XSyU5meF6mO5me47Dw@mail.gmail.com>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Thu, 2 Feb 2017 20:32:14 -0800
Message-ID: <CAE1pOi1agWBHJHmnKkJ7A1EdhJoJausTX7fUeypLbDP6A2FuHQ@mail.gmail.com>
Subject: Re: How to use git show's "%<(<N>[,trunc|ltrunc|mtrunc])"?
To:     "G. Sylvie Davies" <sylvie@bit-booster.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 February 2017 at 20:19, G. Sylvie Davies <sylvie@bit-booster.com> wrot=
e:
> On Thu, Feb 2, 2017 at 9:51 AM, Hilco Wijbenga <hilco.wijbenga@gmail.com>=
 wrote:
>> Hi all,
>>
>> I'm trying to get the committer date printed in a custom fashion.
>> Using "%cI" gets me close:
>>
>> $ git show --format=3D"%cI | %an" master | head -n 1
>> 2017-01-31T17:02:13-08:00 | Hilco Wijbenga
>>
>> I would like to get rid of the "-08:00" bit at the end of the
>> timestamp. According to the "git show" manual I should be able to use
>> "%<(<N>[,trunc|ltrunc|mtrunc])" to drop that last part.
>>
>> $ git show --format=3D"%<(19,trunc)cI | %an" master | head -n 1
>> cI | Hilco Wijbenga
>>
>> Mmm, it seems to be recognized as a valid "something" but it's not
>> working as I had expected. :-) I tried several other versions of this
>> but no luck. Clearly, I'm misunderstanding the format description. How
>> do I get "2017-01-31T17:02:13 | Hilco Wijbenga" to be output?
>>
>
> Will this work for you?
>
> $ git show -s --pretty=3D'%cd | %an' --date=3Dformat:%FT%R:%S
> 2017-02-02T10:01:36 | G. Sylvie Davies

Ah, that does indeed do exactly what I want. Thank you.

> I have no idea how portable this might be.  As "git help log" says:
>
>          --date=3Dformat:...  feeds the format ...  to your system
> strftime. Use --date=3Dformat:%c to show the date in your system
> locale=E2=80=99s preferred format. See the strftime manual for a complete=
 list
> of format placeholders.

It should be fine for my purposes.

Any idea why "%<(19,trunc)cl" doesn't work? (Your solution solves my
original problem perfectly but I'd like to understand how I'm
misreading the spec.)
