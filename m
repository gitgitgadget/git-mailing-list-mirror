Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5627720802
	for <e@80x24.org>; Thu, 22 Jun 2017 21:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753607AbdFVVJm (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 17:09:42 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33997 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbdFVVJk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 17:09:40 -0400
Received: by mail-pf0-f173.google.com with SMTP id s66so14081206pfs.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 14:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nRU7BcuZfKwMm+PWYJ2NZDbv6snS2+B5FZPwM7/mn4E=;
        b=ShMGcto97gv1ZTsaXFoGW3v7RM3KgxOlKmhYMEcNYB4akCbJKeX9D/TNwbQ2OIHGhg
         joSEkFdu4FheHfQIMyfk8kfshT9com8JhwnYClkL5wCELmUiWBgrIOMkrLrPr7qVitVh
         EqKKbCd5x/2gRNRt4KAUyUhWAWDcaytK+RSAvVqurZ8RD3ZHC7T5ozcTKHGCifz2VQbs
         D0OpD058il7MPqw7aQkiqhC9NyR9I3kYZYDSQRjUuCzreoUDRCspflzlT5xKCaELQeBD
         2eRmZUYLSIh4ETmEX4N+xh6hupmNOWTVhhHQFrKahBLGu8nJcq0lWrBZe+QV6caHn1s1
         QzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nRU7BcuZfKwMm+PWYJ2NZDbv6snS2+B5FZPwM7/mn4E=;
        b=sWXxbYDYYyPnbcyeOh/b6kWxNkg7/Iww3qqZeWQYR+prJZIIKiRzullrH+DxsUZtHE
         kqZ3IxK/ri1kC1Kq1YfssFyB7v8HJsQToYFj4RNr2fjOqdSoODDiQWsM1DfCUOzMdSwQ
         8AlFNgk8k4xM18bOrbzVWhuA1wtw1b+Pka5M7Rz80eI8u4QE2S5CNu2h03g7CpiRWGiu
         1STM1+c8VSJ9cpa1aETC4fiCda/KmJEXdiq+4JXgJavA+cVNjnGX2ABDWs1piGqnx5AV
         YTzgdD3RUzVEzINTm2pt7DQBCetO7ap2UXVtQmBUDI9c3Hg9etv7GCw7ia+juo+HcQjG
         x1Mg==
X-Gm-Message-State: AKS2vOwxM4lxywOKzVbY/KkTsgfnZAF5amA0KqMeZghKuvcYBuWBSnrm
        eduDb2cqAulbWFr+QjesZs+KEjxfCTeFUT4=
X-Received: by 10.84.232.205 with SMTP id x13mr5148387plm.245.1498165779605;
 Thu, 22 Jun 2017 14:09:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Thu, 22 Jun 2017 14:09:39 -0700 (PDT)
In-Reply-To: <20170622210323.GC124061@google.com>
References: <20170607185354.10050-1-sbeller@google.com> <20170620225650.7573-1-sbeller@google.com>
 <20170622174659.GA124061@google.com> <xmqqlgojixjo.fsf@gitster.mtv.corp.google.com>
 <CAGZ79ka5MkpPSxR23Kz9DcxFkHNB-hz=n-teDXc6=eX4p473FQ@mail.gmail.com> <20170622210323.GC124061@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Jun 2017 14:09:39 -0700
Message-ID: <CAGZ79kbBO2NamPcO_G=AVFV5VRwVz9h_9h-cvOqw5UeMwiXTQg@mail.gmail.com>
Subject: Re: [PATCHv2] submodules: overhaul documentation
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 2:03 PM, Brandon Williams <bmwill@google.com> wrote:
> On 06/22, Stefan Beller wrote:
>> On Thu, Jun 22, 2017 at 1:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Brandon Williams <bmwill@google.com> writes:
>> >
>> >> On 06/20, Stefan Beller wrote:
>> >> ...
>> >>> +The configuration of submodules
>> >>> +-------------------------------
>> >>> +
>> >>> +Submodule operations can be configured using the following mechanisms
>> >>> +(from highest to lowest precedence):
>> >>> +
>> >>> + * the command line for those commands that support taking submodule specs.
>> >>> +
>> >>> + * the configuration file `$GIT_DIR/config` in the superproject.
>> >>> +
>> >>> + * the `.gitmodules` file inside the superproject. A project usually
>> >>> +   includes this file to suggest defaults for the upstream collection
>> >>> +   of repositories.
>> >>
>> >> I dislike this last point.  Realistically we don't want this right?  So
>> >> perhaps we shouldn't include it?
>> >
>> > I am not sure if I follow.  Without .gitmodules, how would you, as a
>> > downstream developer, bootstrap the whole thing?
>> >
>>
>> I think Brandon eludes to our long term vision of having a separate
>> magic ref containing these informations instead of carrying it in tree.
>>
>> As urls change over time, it is better to keep the urls out of the
>> actual history, but still versioned so maybe we'll want to have
>> a ref/submodule-config/master ref that contains all the bootstrapping
>> information. The .gitmodules file would degenerate to a pure
>> name<->path mapping.
>
> I was more eluding to having fetch.recurse and the other similar bits
> stored in the gitmodules file.

Well yes, but these configurations would also go onto the new magic ref
once implemented.

And to answer your question:
Yes we (you and me) dislike it, but it is the best we can do given
the current implementation. Once the implementation changes,
we may want to adapt this man page.


>
> --
> Brandon Williams
