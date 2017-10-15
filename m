Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E25220372
	for <e@80x24.org>; Sun, 15 Oct 2017 16:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbdJOQjr (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 12:39:47 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33499 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdJOQjq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 12:39:46 -0400
Received: by mail-oi0-f66.google.com with SMTP id 14so5759421oii.0
        for <git@vger.kernel.org>; Sun, 15 Oct 2017 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0xl403YWozVwPuLG/K4mVUOGwzQbgZeCzkcrMLaYwLk=;
        b=glMZJpr3oWhqh5NKBAD4oksHPMtHSFC7ZFELyM8NNw1pgrDZRiuxtH/xlLFxbQjhkp
         TV5YZHtInTQzfmpBIy952L0k7JVrfWntHh/Z9gQ92V1ubPC7ENdYN9ey9DzA0JTyMEP0
         53wfYP93IiTEkmCK467TAjmKHRVVM9SD7H4c1lXQfEqsQbQmWkysS2wvEt6MYIves8Ie
         kieSONQnF29A+w/ic4xtcyjSg3YObJ2d5615tztWQczOk5WmAIPS7KOQs0SS6oZ5QGkP
         n7o89Hj2gtuHEtgKfzs1+69jgL+IgRAttNTVKGJ7AGsCvs6Hqca+uOR28aTtZwHgvsde
         zZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0xl403YWozVwPuLG/K4mVUOGwzQbgZeCzkcrMLaYwLk=;
        b=RiH/EtY64hRh8iom8xtgNy/svxQu1IYYgkLSlWSg5ixptQY5R57g0KGlIv+1ttb3bI
         Rsvm7mGrFsc3dsTOJ2XVmXkdTl+t8Y86ttIyYIVaPbJAOgrBFFgNg0xvn9lZE78ovC0a
         OhnPwP2jLez+cSAP1G9jIc+sDsPhtgH7N5LEN3f/TTDTWfoD03ZCpdS34EohDzuQZ4ka
         k0Yc8aZJVPu3n/e77viJYyHaKToNcLbpQ8HCQyYX6z0eLIsT0F/cZDynuI6VRrgZ6XIm
         a/D297mcPu00MazXRRBsz32tbS2+X4CunlXrsVrB9MVMUcK5/77+drGceQ8KRfmQ0oix
         fDoQ==
X-Gm-Message-State: AMCzsaVxQavAtw1Q34yUIdTzVWtORCe1jRaD2ovQa7DWPXaH22m33sm7
        8uSJKRk1dtWLqBTXT1u58C9By4n6H4hn0JnhfD4=
X-Google-Smtp-Source: ABhQp+TxZZUAfRL5vyN2iMnEqEUpfDSBSFcwzXPa8Vzi+fkZJ8dFWYcFkRRwvvktksey3jAKE2fTDPx83CnSW01XKJI=
X-Received: by 10.157.91.106 with SMTP id e39mr4622069otj.435.1508085585442;
 Sun, 15 Oct 2017 09:39:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.4.104 with HTTP; Sun, 15 Oct 2017 09:39:45 -0700 (PDT)
In-Reply-To: <87zi8sxvkg.fsf@linux-m68k.org>
References: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
 <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat> <87zi8sxvkg.fsf@linux-m68k.org>
From:   Joris Valette <joris.valette@gmail.com>
Date:   Sun, 15 Oct 2017 18:39:45 +0200
Message-ID: <CA+o7MD8fcD5-SFeQsX84Etu68ov7yy48OO4dV=gXMp5xY8s9Rg@mail.gmail.com>
Subject: Re: Consider escaping special characters like 'less' does
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-10-15 17:46 GMT+02:00 Andreas Schwab <schwab@linux-m68k.org>:
> On Okt 15 2017, "Jason Pyeron" <jpyeron@pdinc.us> wrote:
>
>>> -----Original Message-----
>>> From: Joris Valette
>>> Sent: Sunday, October 15, 2017 9:34 AM
>>> To: git@vger.kernel.org
>>> Subject: Consider escaping special characters like 'less' does
>>>
>>> The pager 'less' escapes some characters when calling 'git diff'. This
>>> is what I might get:
>>>
>>> $ git diff --cached
>>> diff --git a/some_file b/some_file
>>> new file mode 100644
>>> index 0000000..357323f
>>> --- /dev/null
>>> +++ b/some_file
>>> @@ -0,0 +1 @@
>>> +<U+FEFF>Hello
>>> \ No newline at end of file
>>>
>>> This example is a simple file encoded in UTF-8 *with BOM*.
>>> On the other hand, the built-in git output shows this:
>>>
>>> $ git --no-pager diff --cached
>>> diff --git a/some_file b/some_file
>>> new file mode 100644
>>> index 0000000..357323f
>>> --- /dev/null
>>> +++ b/some_file
>>> @@ -0,0 +1 @@
>>> +?Hello
>>> \ No newline at end of file
>>
>> It is your terminal, not git's fault that you get a ? rendered.
>
> It's your MUA's fault that you get a ?, the mail didn't contain any.

Actually, the original mail contained the special BOM sequence but
it's generally invisible. His MUA shows it with a '?', mine doesn't
show anything, neither does Firefox on the mailing list page.

The question remains: could escaping be done?

Joris
