Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC44F20A2A
	for <e@80x24.org>; Tue, 19 Sep 2017 13:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbdISNiD (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 09:38:03 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:54597 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdISNiC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 09:38:02 -0400
Received: by mail-ua0-f170.google.com with SMTP id l94so13745ual.11
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=91IxGo5Euol5D0X4EDQj5t15Uvn2ccVlvRcOF03lOUg=;
        b=dkKQs6EzE3rQLUvT34TKIfQavmh7RcCt6eL0wsDA3BDqHEYAmXCLYnp/qSXF3GVyjM
         KHuXVdQb0zA7Mfti5VEbquCRJDU5/TwuEDw/MiY15Ul1/Xo+nTONP7xLcOBHMBedxlda
         7AwUfQ77qw4X9TXJp1hC0xMNkmOPgiIqSd6A2cqze/l17OOjRgc3WoRrmsNMGOGV2lL9
         YqhPppl0NQoOlEFxo9yIApWugVqZiB1ShpAd9QkEMv6ZU8cpL3ZWigt+QY1WFaiKqG2T
         qJzlRYjccb9aY88A1a+w5z/tpvwmo2/cUmOVHwUE2UKQRsp/ivM9myO29dBCnZGuM+ZE
         5gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=91IxGo5Euol5D0X4EDQj5t15Uvn2ccVlvRcOF03lOUg=;
        b=AilhOpVTdrFq0c6LL7VicVcqbOEBKV4rlwneY874iwqSubcmqBm7gMUm6TLvVQZmAl
         qPs9QJ8KQ22+0PR3poyeqo+Gh2vTumwG6LvKwlCg/Lm9pNiOrQetsJJZx8h0xhrMWnlB
         s7D5/XBdpSoERBwqPUix7IkeoK0O657P2c1DZ19hV9g/y87L8m7/cFc+eukg7BMI+Jff
         b/M75D4r5JPJkb6Kde75hZKs4DaTJfk5Z72HO1fkniFHvrFPBsArJJ5d1KJaqJ5OpKuB
         /eQhs+OZr9+1wurrgyfdHvpqB5yvcrCyWzEpJVAUtz6smOp2IvxrykW5OYKmHm54GNM/
         OXxA==
X-Gm-Message-State: AHPjjUipTurTTe48OTNF4nPDjvDpFAwdjhi5i2zkmPOJzMyu1eq5uNIX
        ZEE4wdU96tLYuLrh7jN9/9vKT+gmIYueopi9jL4=
X-Google-Smtp-Source: AOwi7QAlZixy68xqL+ph27ou7g06V2sOJ5CEtELjt9DOZcGx+NKXnzwFPuBbO0TpnTSDpSWE+Bm7sd4pPqNikdbzGQc=
X-Received: by 10.176.95.69 with SMTP id z5mr1284486uah.100.1505828281399;
 Tue, 19 Sep 2017 06:38:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.35.76 with HTTP; Tue, 19 Sep 2017 06:38:00 -0700 (PDT)
In-Reply-To: <dab2d555-7e09-4eb3-19b8-cab085626bbe@alum.mit.edu>
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
 <xmqqefr6uolr.fsf@gitster.mtv.corp.google.com> <5c86b55e-20f6-df8e-b01f-66876c3a5f46@alum.mit.edu>
 <xmqqfubku9iy.fsf@gitster.mtv.corp.google.com> <CAGZ79kYXDhcVXd2C-x6e=o7jYdKqV22DY45c7E2TeuhKLfn26w@mail.gmail.com>
 <dab2d555-7e09-4eb3-19b8-cab085626bbe@alum.mit.edu>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 19 Sep 2017 15:38:00 +0200
Message-ID: <CAM0VKjn=KjTHBoubJKbxx7MasJ6wWcUFrCwrvr5oHwUCsfr_Pw@mail.gmail.com>
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty list
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 8:51 AM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 09/19/2017 02:08 AM, Stefan Beller wrote:
>>> I am hoping that this last one is not allowed and we can use the
>>> "same condition is checked every time we loop" version that hides
>>> the uglyness inside the macro.
>>
>> By which you are referring to Jonathans solution posted.
>> Maybe we can combine the two solutions (checking for thelist
>> to not be NULL once, by Jonathan) and using an outer structure
>> (SZEDERs solution) by replacing the condition by a for loop,
>> roughly (untested):
>>
>> #define for_each_string_list_item(item,list) \
>> -       for (item =3D (list)->items; item < (list)->items + (list)->nr; =
++item)
>> +    for (; list; list =3D NULL)
>> +        for (item =3D (list)->items; item < (list)->items + (list)->nr;=
 ++item)
>>
>> as that would not mingle with any dangling else clause.
>> It is also just one statement, such that
>>
>>     if (bla)
>>       for_each_string_list_item {
>>         baz(item);
>>       }
>>     else
>>       foo;
>>
>> still works.
>>
>> Are there downsides to this combined approach?
>
> On the plus side, it's pleasantly devious; I wouldn't have thought of
> using a `for` loop for the initial test. But it doesn't work as written,
> because (1) we don't need to guard against `list` being NULL, but rather
> `list->items`; and (2) we don't have the liberty to set `list =3D NULL`
> (or `list->items =3D NULL`, because `list` is owned by the caller and we
> shouldn't modify it.
>
> The following is a bit closer:
>
> #define for_each_string_list_item(item,list) \
>         for (item =3D (list)->items; item; item =3D NULL) \
>                 for (; item < (list)->items + (list)->nr; ++item)
>
> But I think that also fails, because a callsite that does
>
>         for_each_string_list_item(myitem, mylist)
>                 if (myitem.util)
>                         break;
>
> would expect that `myitem` is still set after breaking out of the loop,
> whereas the outer `for` loop would reset it to NULL.
>
> If `break` were an expression we could do something like
>
> #define for_each_string_list_item(item,list) \
>         for (item =3D (list)->items; item; break) \
>                 for (; item < (list)->items + (list)->nr; ++item)

A bit "futuristic" option along these lines could be something like
this, using a scoped loop variable in the outer loop to ensure that
it's executed at most once:

  #define for_each_string_list_item(item,list) \
      for (int f_e_s_l_i =3D 1; (list)->items && f_e_s_l_i; f_e_s_l_i =3D 0=
) \
          for (item =3D (list)->items; item < (list)->items + (list)->nr; +=
+item)

The high number of underscores are an attempt to make reasonably sure
that the macro's loop variable doesn't shadow any variable in its
callers or isn't being shadowed in the loop body, which might(?)
trigger warnings in some compilers.

Alas we don't allow scoping the loop variable in for loops, and even a
test balloon patch didn't make it into git.git.

  https://public-inbox.org/git/20170719181956.15845-1-sbeller@google.com/T/=
#u


> So I think we're still left with the suggestions of Jonathan or G=C3=A1bo=
r.
> Or the bigger change of initializing `string_list::items` to point at an
> empty sentinal array (similar to `strbuf_slopbuf`) rather than NULL.
> Personally, I think that Jonathan's approach makes the most sense,
> unless somebody wants to jump in an implement a `string_list_slopbuf`.
>
> By the way, I wonder if any open-coded loops over `string_lists` make
> the same mistake as the macro?
