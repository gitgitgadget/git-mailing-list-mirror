Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438281F462
	for <e@80x24.org>; Wed,  5 Jun 2019 21:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfFEVKA (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 17:10:00 -0400
Received: from smtp-o-2.desy.de ([131.169.56.155]:46185 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfFEVKA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 17:10:00 -0400
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 0D33516052A
        for <git@vger.kernel.org>; Wed,  5 Jun 2019 23:09:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 0D33516052A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1559768997; bh=bUzjhHtNEOskFJlMlyX4XKa46RnDDqjw+W9oRWaHug0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=GfNOvlbDtGHmY80GCfLTJY70f7yPi4SKhcfh09vMNq97BBLF0Ev13N9l0knkWyJtm
         7JLrirH3UcWF/zjXE8iIw8N6wLlHxPqS47NT1pMxwqTbi6rLBcIAtvl3XsgFjxas4l
         0pnhxJhh9tlh6/hH1MD7mZvC/ZI7sYFjB7KALaDk=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id 06BDA1A00B8;
        Wed,  5 Jun 2019 23:09:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id CF59380041;
        Wed,  5 Jun 2019 23:09:56 +0200 (CEST)
Date:   Wed, 5 Jun 2019 23:09:56 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <2146612842.10496277.1559768996738.JavaMail.zimbra@desy.de>
In-Reply-To: <xmqqzhmvrbr5.fsf@gitster-ct.c.googlers.com>
References: <139144069.10140489.1559664262817.JavaMail.zimbra@desy.de> <20190605155300.26506-1-tigran.mkrtchyan@desy.de> <xmqqv9xkroc5.fsf@gitster-ct.c.googlers.com> <1933659713.10490718.1559765529240.JavaMail.zimbra@desy.de> <xmqqblzbsquq.fsf@gitster-ct.c.googlers.com> <xmqqzhmvrbr5.fsf@gitster-ct.c.googlers.com>
Subject: Re: [PATCH v3] tag: add tag.gpgSign config option to force all tags
 be GPG-signed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF67 (Linux)/8.8.10_GA_3786)
Thread-Topic: add tag.gpgSign config option to force all tags be GPG-signed
Thread-Index: T8Dce+GV6iMfgXD8GuIN77mGh3SYJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "git" <git@vger.kernel.org>, "Jonathan Nieder" <jrnieder@gmail.com>, "Johannes Schindelin"
> <Johannes.Schindelin@gmx.de>
> Sent: Wednesday, June 5, 2019 10:57:34 PM
> Subject: Re: [PATCH v3] tag: add tag.gpgSign config option to force all tags be GPG-signed

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de> writes:
>>
>>>> But more importantly, I think we should justify why this "not
>>>> allowed" makes sense as the design of the feature. A plausible
>>>> alternative design would simply follow the "last one wins" paradigm,
>>>> ...
>>> This is matter of convention.
>>
>> Oh, if you put it that way, it is quite clear that we should redo
>> this part, as the rest of Git command line processing all pretty
>> much follow "last one wins".  I was mostly curious if there was any
>> strong reason why this combination has to be different.
> 
> One reason why "last one wins" aka "you have a chance to correct
> yourself" is so useful is because people can then use alias to
> define leading options, e.g. with
> 
>    [alias] myfoo = foo --option1 --option2 --option3
> 
> a user can say "git myfoo" to save typing, but in a rare occasion
> where only options 2 and 3 (but not option 1) are desired, can use
> "git myfoo --no-option1" to countermand it.
> 
> Unfortunately, I do not think we can use the same technique for
> options that is given to the "git" potty, e.g. with
> 
>    [alias] paged-status = --paginate status
> 
> you can say "git paged-status" to have your "git status" output sent
> to the pager, but you cannot say "git paged-status --no-pager" to
> defeat that leading option.  We may want to find a way to correct
> it, but it is rather low on the priority scale ;-)


Makes sense. Thanks for that use case, which I actually use myself :).

BTW, `--no-sign` currently doesn't affects `-u <key>` in any order:

```
    if (keyid) {
        opt.sign = 1;
        set_signing_key(keyid);
    }
```

IOW, `-u <key>` is another way to enable signing, what is, actually,
consistent with man page:

```
       -u <keyid>, --local-user=<keyid>
           Make a GPG-signed tag, using the given key.
```

I will leave it as-is, I will just describe that tag.gpgSign options
doesn't affect '-u' behavior.

Tigran.
