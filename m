Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664B41FF40
	for <e@80x24.org>; Mon, 27 Jun 2016 05:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbcF0Fup (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 01:50:45 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35609 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbcF0Fuo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 01:50:44 -0400
Received: by mail-io0-f176.google.com with SMTP id f30so143815238ioj.2
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 22:50:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6WJWBU0fWYkSDsf3fQZXCdA/iSWMbxJmtqwgKhZysMY=;
        b=mfkZ/uZqiAZYcdeg4uoKWVMWPxgLkkgUE2x9aoLU41gx+yD08ut/0R/taIIbmTSLZh
         deMlE6HMSc20r/rfKJYTn4aajrwRJ57GTL4LjoTMkn1+l+Z3olMxDRk54/6c9GDd+jBM
         Q1JtIxvQYgv5W7hgfrKg6or78ADerhMpOBlVLoKlCMPe4upJUGP4M1XpvismC/FGP8X+
         I9TBHEJQVpSQZ4Ob3DkSO5vzk3R+ghKqxxzV5fA/GGb8N4UCKBYeQfrQ/+9ySBKqt0hv
         MMofXPiICI1q8EWldSv8g63zMwyupaqffEIOv3GwhHwIENyO/LIYeUvBSgYBgAjgdASk
         pkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6WJWBU0fWYkSDsf3fQZXCdA/iSWMbxJmtqwgKhZysMY=;
        b=cM5swMUTOQZPsdBsAY1LnohovLkYUPxKb/2Qi2MzLphqXY40cTX60ANI2sjJ0svyku
         tGGjECJE6OGzBELZ9iVi8l6sv5s1ASZvMv+8S8Eb7Yg6Tdtw9xxTRyUmlS6TafwIy+5q
         q7sQzbJPMLlqyfMmFgxYa1Zju8kIEVjuXtqKJi777qjtcY4V7fZh8tFQ3jLOjJzZfVKY
         LwS0PvmgXlmkYn3PaGdMCVdoor9+6iLWA35MQ1NdbtxGFl+Iys5Z9YZxHEeJpRyS5nJM
         5fwQaJbNeTC8yk/CsLXDy+3pfVdx1sviAzMkcy65ZjJKMC8t86N4yozAQX4TpjAfF1nk
         EN2A==
X-Gm-Message-State: ALyK8tJeZHtkRbCRiNzjS9h5ksc6sKTzN6o630YfbN+BpboFZgCJBA/V+o/pmQ/qrxX7zGa2h3pWfNtq5yi2BA==
X-Received: by 10.107.8.220 with SMTP id h89mr14849290ioi.95.1467006643812;
 Sun, 26 Jun 2016 22:50:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sun, 26 Jun 2016 22:50:14 -0700 (PDT)
In-Reply-To: <57702D2F.9080306@novalis.org>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
 <1463694357-6503-5-git-send-email-dturner@twopensource.com>
 <CACsJy8CftPGmrKP8Yeok90T9=whzj69bfE3_X6wHyWOEp6vRzg@mail.gmail.com>
 <576ED9A2.8070202@novalis.org> <CACsJy8Dqvv-Ty-wG0qkenyvLNLyqVueJmhjiQXnr0zVUGFvDeA@mail.gmail.com>
 <57702D2F.9080306@novalis.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 27 Jun 2016 07:50:14 +0200
Message-ID: <CACsJy8Au47OpLcK14=gqkSXMhmeHXRCKRR8rQaBbBxVBLgWo6Q@mail.gmail.com>
Subject: Re: [PATCH v12 04/20] index-helper: new daemon for caching index and
 related stuff
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 26, 2016 at 9:29 PM, David Turner <novalis@novalis.org> wrote:
> On 06/26/2016 12:27 AM, Duy Nguyen wrote:
>>
>> On Sat, Jun 25, 2016 at 9:21 PM, David Turner <novalis@novalis.org> wrote:
>>>
>>> On 06/25/2016 10:33 AM, Duy Nguyen wrote:
>>>>>
>>>>>
>>>>> +               /*
>>>>> +                * Our connection to the client is blocking since a
>>>>> client
>>>>> +                * can always be killed by SIGINT or similar.
>>>>> +                */
>>>>> +               set_socket_blocking_flag(client_fd, 0);
>>>>
>>>>
>>>>
>>>> Out of curiosity, do we really need this? I thought default behavior
>>>> was always blocking (and checked linux kernel, it seemed to agree with
>>>> me). Maybe for extra safety because other OSes may default to
>>>> something else?
>>>
>>>
>>>
>>> Yes -- see this bug report for details:
>>> https://bugs.python.org/issue7995
>>>
>>
>> I think we should refer to this issue in the comment block right
>> before set_socket_blocking_flag() call. Imagine a year from now, I may
>> read the code, decide this code is useless and try to remove it.
>
>
> Assuming that we do keep this (see Eric Wong's note), I do not think we need
> a comment.  It is documented in the man page for accept[1], and it is the
> reader's responsibility to understand standard POSIX APIs.
>
>
>
> [1] "On Linux, the new socket returned by accept()  does  not  inherit file
> status  flags such as O_NONBLOCK and O_ASYNC from the listening socket. This
> behavior differs from the canonical  BSD  sockets implementation."

But we do not ever set O_NONBLOCK on listening socket, and the default
should be no O_NONBLOCK at socket creation even on BSDs, right? If we
know where this O_NONBLOCK comes from then we can clear it at that
place (maybe with #if BSD to emphasize) instead of after accept(). The
bug report actually confuses me because "timeout is set" then
O_NONBLOCK is also set, but I don't know exactly what "timeout is set"
is, on poll()? I'll check out socketmodule.c later.
-- 
Duy
