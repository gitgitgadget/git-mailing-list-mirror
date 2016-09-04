Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D83BF1F6BF
	for <e@80x24.org>; Sun,  4 Sep 2016 05:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbcIDFbf (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 01:31:35 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38035 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbcIDFbe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 01:31:34 -0400
Received: by mail-it0-f44.google.com with SMTP id c198so103202145ith.1
        for <git@vger.kernel.org>; Sat, 03 Sep 2016 22:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5VxijY6Gf8SaKqzrwgpG4MRgiZY8jOS6McEjgmxWonY=;
        b=WcdUmY9RQZZg1KtvXQpXeSQrCifyoOSnAsWPEvRU7cBHtDYU7m0Xl5zGnpaumBKEd4
         CDvv3S6LSkveC1DNOzreh/Wnp/Js0WWHjrHKi/HnhM/V2Lw6vmr6iFFU29bOgcQ6B63/
         0E6K/TB+pSCtmQn6LFrOGr2nJAzvxBJNB28LReuC/XIka11D+zddS4+9oClvfTJGeyiu
         V8u3WLbzzzxX2TvGDafXEWzk7RSmsdeGPGmX9S69gxHgw4A6seVMmTSQoqWwYYQ13DOO
         sA+gXCowSmzs6H1HW4blHvZRpYXj0EXMLr4LduGEQlYEvFmCk6w6n6+QZh+Lwie3INmQ
         JTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5VxijY6Gf8SaKqzrwgpG4MRgiZY8jOS6McEjgmxWonY=;
        b=S33JravKXjGS9ZdT+DVtiTqWuJKjhbgQG6qHrQNLNf8wfBoC1QlDZxvyuiQKsuDu8w
         0Q6NKCjqWDXcMvASnIqeQrWHA+FCnzlt4cm9PXsgpwMlWn6EcDigBQ2a1Ttt6i3JahcO
         63YDtsb9bLDZ+w9oHTjek9cuR37IA3DNrPzazF9ABA0iAF1MGtjYTtVqSrXv9ds8jyx9
         0PSRw+USbcvbB8NVAPNoZC1tgxHB7Ir5YnMZoeqYf25PJw/7OIMtscXJhkpUi2lg97uG
         pFCLVv5AJfxU5/hjZAKOpwVzyTHX5OZhQICA2vvJqjKeeCffdlcDewAxZeDuiMPgU3lV
         Qg2A==
X-Gm-Message-State: AE9vXwMYTMzm/3xyHNUY6ofu0IbrE5MYvHpMRSNsVQa0cf46ODKlYtVPMYdkg0G5eLbWQoZd3a76XiZ4LhqzDGz3
X-Received: by 10.36.217.131 with SMTP id p125mr14981994itg.46.1472967093610;
 Sat, 03 Sep 2016 22:31:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Sat, 3 Sep 2016 22:31:33 -0700 (PDT)
In-Reply-To: <eb88af2c-d7b1-295e-5f23-a85045bde753@gmail.com>
References: <20160903033120.20511-1-sbeller@google.com> <20160903033120.20511-3-sbeller@google.com>
 <eb88af2c-d7b1-295e-5f23-a85045bde753@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 3 Sep 2016 22:31:33 -0700
Message-ID: <CAGZ79kYEieYGFAgORc8yaF3=8-L1E7K4afNGxDH5AgM5nHFgFw@mail.gmail.com>
Subject: Re: [RFC/PATCH 2/2] WIP xdiff: markup duplicates differently
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 3, 2016 at 5:25 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wrot=
e:
> W dniu 03.09.2016 o 05:31, Stefan Beller pisze:
>
>> When moving code (e.g. a function is moved to another part of the file o=
r
>> to a different file), the review process is different than reviewing new
>> code. When reviewing moved code we are only interested in the diff as
>> where there are differences in the moved code, e.g. namespace changes.
>>
>> However the inner part of these moved texts should not change.
>> To aid a developer reviewing such code, emit it with a different prefix
>> than the usual +,- to indicate it is overlapping code.
>
> What would be this different prefix?

I will discard the part of the different prefix as the design of 2/2
will change.



>
>
> Side note: I wonder if the cousin of unified diff, namely context diff[1]=
,
> is something that we can and should support.



>
> [1]: https://www.gnu.org/software/diffutils/manual/html_node/Context-Form=
at.html
>      https://www.gnu.org/software/diffutils/manual/html_node/Detailed-Con=
text.html
>
> *** lao 2002-02-21 23:30:39.942229878 -0800
> --- tzu 2002-02-21 23:30:50.442260588 -0800
> ***************
> *** 1,7 ****
> - The Way that can be told of is not the eternal Way;
> - The name that can be named is not the eternal name.
>   The Nameless is the origin of Heaven and Earth;
> ! The Named is the mother of all things.
>   Therefore let there always be non-being,
>     so we may see their subtlety,
>   And let there always be being,
> --- 1,6 ----
>   The Nameless is the origin of Heaven and Earth;
> ! The named is the mother of all things.
> !

So the line moved here?
Is it intentional that the line differs though?
(capitalisation of 'named")
Not sure I can read this diff correctly.

I think for this small side project I'd rather want
to 'just' support colors of moved code;)

>   Therefore let there always be non-being,
>     so we may see their subtlety,
>   And let there always be being,
> ***************
> *** 9,11 ****
> --- 8,13 ----
>   The two are the same,
>   But after they are produced,
>     they have different names.
> + They both may be called deep and profound.
> + Deeper and more profound,
> + The door of all subtleties!
