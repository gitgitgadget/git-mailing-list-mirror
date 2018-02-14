Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B0FF1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 01:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966372AbeBNBgC (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 20:36:02 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33130 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966311AbeBNBgB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 20:36:01 -0500
Received: by mail-wm0-f47.google.com with SMTP id x4so15572258wmc.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 17:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UevnvLMtyqzsohgNVj2TIUb8L/SObJpE1zaBWSHiNXw=;
        b=pg/oO6NvhDPd/8gMOtLrWpUae/qavQnamZ16BkXQDsc9e6dnDzQKQvh/RMrtg2hAsA
         MLH9TdYh2//dHISar5OOdEPgojAhFJnmQyASo/0Z42ezC7uUpsyXwcpib07CkqLJvyJj
         KfW8H8j4wpPpPWaG/Wp6bUvMAAFh6xwsyQ8HeLUn7d3Q9+pbn/okRzzGbgjPNsAq1ZLL
         UIG4Djb8dPdT1DqJH7vEuQqwkgK/4ad9jRGfI9eNhLOlyMP4es3q7lTQJlmob7OeJETV
         8frOHW94WLBk53u089ADxtK8hllCjSvwHVyUMQBMmtIP4lR/vbjiDsnGmXMx2HU+mAFm
         livw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UevnvLMtyqzsohgNVj2TIUb8L/SObJpE1zaBWSHiNXw=;
        b=POKEsv6Eu03r+8l88El/uDOv2zJTqiGX+BW+O3AJlfspw856qu+ujWEVGFZGfcOs5O
         5GSVZ9a9tlZjJ121VmlUh0aFRNyRVJCHir8U0x2TCvnD3SeSk3Od507O+Fz0Bkix8KeZ
         5XsneMk2/LfOyUGODAqGRO6epQbBuTdjFiP11pHAt9r6JkYJa06GixbCFarPKAh6gXxQ
         RlCQtJ0zc7Ytk85NaX5q9vy+V3NBpERYM+ss0DDSU8PGqsJKUFmVyRLX7Cc0UDdGQyo6
         ED9B8pKkWwTzQytLqEdDZN2IZWMrY2ZTD3cfDOLkW/7f6brmlndX0SjRAmVwNUjNiG01
         0HiA==
X-Gm-Message-State: APf1xPD7parcJwBe4/Gwz2VblxBifCMyTGS02pI01styCUriygz7kl2O
        4W5Pp30q7EnDtpr4cnSUFTL7nUMTNq8t9rurqJU=
X-Google-Smtp-Source: AH8x226zeZcDzeOFeTX6YdUeEXhtqblsBS6JL7rQqvALKNDJSYTFXkbTF6iGGWGk2MqGzUjf0t9M600iYwb52xQ9LSw=
X-Received: by 10.80.196.73 with SMTP id w9mr4648651edf.293.1518572160037;
 Tue, 13 Feb 2018 17:36:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.149.220 with HTTP; Tue, 13 Feb 2018 17:35:39 -0800 (PST)
In-Reply-To: <8760718imo.fsf@javad.com>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
 <874lmqirma.fsf@javad.com> <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87zi4edbp3.fsf@javad.com> <nycvar.QRO.7.76.6.1802122121230.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xqKPbwt-KeYTKadM3bHDkU3m0WiezKeVu75TyftBSEYDA@mail.gmail.com> <8760718imo.fsf@javad.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 13 Feb 2018 17:35:39 -0800
Message-ID: <CA+P7+xpg76nP8+KBrYWeYPcm8+0jS_MzL+B=LF6WPfBv44zrwA@mail.gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 11:15 PM, Sergey Organov <sorganov@gmail.com> wrote:
> Hi Jake,
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> On Mon, Feb 12, 2018 at 12:39 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> Hi Sergey,
>>>
>>> On Mon, 12 Feb 2018, Sergey Organov wrote:
>>>> > Have a look at https://github.com/git/git/pull/447, especially the
>>>> > latest commit in there which is an early version of the deprecation I
>>>> > intend to bring about.
>>>>
>>>> You shouldn't want a deprecation at all should you have re-used
>>>> --preserve-merges in the first place, and I still don't see why you
>>>> haven't.
>>>
>>> Keep repeating it, and it won't become truer.
>>>
>>> If you break formats, you break scripts. Git has *so* many users, there
>>> are very likely some who script *every* part of it.
>>>
>>> We simply cannot do that.
>>>
>>> What we can is deprecate designs which we learned on the way were not only
>>> incomplete from the get-go, but bad overall and hard (or impossible) to
>>> fix. Like --preserve-merges.
>>>
>>> Or for that matter like the design you proposed, to use --first-parent for
>>> --recreate-merges. Or to use --first-parent for some --recreate-merges,
>>> surprising users in very bad ways when it is not used (or when it is
>>> used). I get the impression that you still think it would be a good idea,
>>> even if it should be obvious that it is not.
>>
>> If we consider the addition of new todo list elements as "user
>> breaking", then yes this change would be user-script breaking.
>
> It _is_ user script breaking, provided such script exists. Has anybody
> actually seen one? Not that it's wrong to be extra-cautious about it,
> just curios. Note that to be actually affected, such a script must
> invoke "git rebase -p" _command_ and then tweak its todo output to
> produce outcome.
>
>> Since we did not originally spell out that todo-list items are subject
>> to enhancement by addition of operations in the future, scripts are
>> likely not designed to allow addition of new elements.
>
> Out of curiosity, are you going to spell it now, for the new todo
> format?
>
>> Thus, adding recreate-merges, and deprecating preserve-merges, seems
>> to me to be the correct action to take here.
>
> Yes, sure, provided there is actual breakage, or at least informed
> suspicion there is one.
>
>> One could argue that users should have expected new todo list elements
>> to be added in the future and thus design their scripts to cope with
>> such a thing. If you can convincingly argue this, then I don't
>> necessarily see it as a complete user breaking change to fix
>> preserve-merges in order to allow it to handle re-ordering properly..
>
> I'd not argue this way myself. If there are out-of-git-tree non-human
> users that accept and tweak todo _generated_ by current "git rebase -p"
> _command_, I also vote for a new option.
>

To be fair, I have not seen anything that actually reads the todo list
and tweaks it in such a manner. The closest example is the git garden
shears script, which simply replaces the todo list.

It's certainly *possible* that such a script would exist though,

Thanks,
Jake

>> I think I lean towards agreeing with Johannes, and that adding
>> recreate-merges and removing preserve-merges is the better solution.
>
> On these grounds it is, no objections.
>
> -- Sergey
