Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8481F597
	for <e@80x24.org>; Sun, 29 Jul 2018 11:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeG2NZA (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 09:25:00 -0400
Received: from mout.web.de ([212.227.15.4]:33095 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeG2NY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 09:24:59 -0400
Received: from [192.168.178.36] ([79.237.249.67]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LsQDw-1g7pii1Ttg-01226r; Sun, 29
 Jul 2018 13:54:40 +0200
Subject: Re: Proposed approaches to supporting HTTP remotes in "git archive"
To:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
References: <CANq=j3tK7QeBJOC7VNWkh4+WBNibMJJp5YUkd9te5NaYwukAow@mail.gmail.com>
 <xmqqtvokjonm.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e769cd31-49cb-c49b-7653-5692e065f097@web.de>
Date:   Sun, 29 Jul 2018 13:54:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqtvokjonm.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T+rhXnvUXkaOz6poNhlfOS1BK9pCJ7lpUWE9d9W9kOMIXzt2cV6
 D0YNwMHa4j53quEXVuYZJ8nuVg8lDZx9OOlrC0nJP3mxr2p13iMhnMvbwU4LuqYwAWborLh
 33d7yOWfE/9QkHgFM3XubWElCt9gJ9QO3Poqjuhcj7mu2mR/T8H2gATokUp5FuhfkY/YmI8
 BEpbLJyfzhWQNvzg5k9rA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Jck5Es65BTM=:IxYlvpsKFtDcutIIKK76bX
 EpVybtlBW27ygecpaSoh0bMVbpDUofO2OznLrWYI/VWelv0uw/SRjzQR1e7jEzwFPqAXEpQN5
 KXUR1b0Xe6BB641JDlw9dG4E7tYR2Z6FHm7n9/jvXRFp0ljbtCRzFFv3BXS77a8FKRe7NBOxl
 mur5mAB85lECVb3ccchhAaAePxgKzjCdEdGM28bv6KQaF2HwB9LZUtsCK3xTg7jJFzQeTG21Y
 NwzvwjqOxlzCZjwlgF7Jgc73hqvIT1V9d9r59jRS8rg1r+VwTkShcQXB2VT0mI6NkGuBYmMLA
 eXM6iA5VKczpgVDQyV1SxfJJHaAhUsDEhd/oCtlTxer8zciyKo37K4dEEsgv9XE2y9axo52Ss
 cCxW3vRojw2TWw8ZPbXk6DFeNJq3GD9Pefd1nPZeZzGxiTHe+E0g9iSlPHtEgGWAtUNNXZlZF
 RDFSD0BCCXu5Y+XF+lOX/AtcaV0OJRbbe3x3dg4m/5tCgHpNNcNNi+TKPnNhv1+oaAmECE6sO
 J8It6gCGxSSorLeOEEmrjiOuQctg+FTRLBCSI9poYH4DAyKTAY7dolOCS0Wv/TZNzRIq2KEP8
 GsMRCwtJeLIEYlBspYywcpg6d4ZSBmd0cGd2iqSTIdsDEfEYEONQ3IzbPE+abXxwHBuYMufzp
 gVElCYWLOIJyHuUTtG+DtuS86EwnvUNs1HADKbCX2lw9+gxVEMr789LOQ5hZGD1M4N8FulpPD
 /wia24vSdSdcqtkZpmrbskITRVzHhdUI0AYtcP1Dj+k2i+DA+9ul2PyN+uSeXNKDoT3MhPD9e
 3m6aw1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.07.2018 um 00:32 schrieb Junio C Hamano:
> Josh Steadmon <steadmon@google.com> writes:
> 
>> # Supporting HTTP remotes in "git archive"
>>
>> We would like to allow remote archiving from HTTP servers. There are a
>> few possible implementations to be discussed:
>>
>> ## Shallow clone to temporary repo
>>
>> This approach builds on existing endpoints. Clients will connect to the
>> remote server's git-upload-pack service and fetch a shallow clone of the
>> requested commit into a temporary local repo. The write_archive()
>> function is then called on the local clone to write out the requested
>> archive.

A prototype would require just a few lines of shell script, I guess..

A downside that was only stated implicitly: This method needs temporary
disk space for the clone, while the existing archive modes only ever
write out the resulting file.  I guess the required space is in the same
order as the compressed archive.  This shouldn't be a problem if we
assume the user would eventually want to extract its contents, right?

>> ## Summary
>>
>> Personally, I lean towards the first approach. It could give us an
>> opportunity to remove server-side complexity; there is no reason that
>> the shallow-clone approach must be restricted to the HTTP transport, and
>> we could re-implement other transports using this method.  Additionally,
>> it would allow clients to pull archives from remotes that would not
>> otherwise support it.
> 
> I consider the first one (i.e. make a shallow clone and tar it up
> locally) a hack that does *not* belong to "git archive --remote"
> command, especially when it is only done to "http remotes".  The
> only reason HTTP remotes are special is because there is no ready
> "http-backend" equivalent that passes the "git archive" traffic over
> smart-http transport, unlike the one that exists for "git
> upload-pack".
> 
> It however still _is_ attractive to drive such a hack from "git
> archive" at the UI level, as the end users do not care how ugly the
> hack is ;-)  As you mentioned, the approach would work for any
> transport that allows one-commit shallow clone, so it might become
> more palatable if it is designed as a different _mode_ of operation
> of "git archive" that is orthogonal to the underlying transport,
> i.e.
> 
>    $ git archive --remote=<repo> --shallow-clone-then-local-archive-hack master
> 
> or
> 
>    $ git config archive.<repo>.useShallowCloneThenLocalArchiveHack true
>    $ git archive --remote=<repo> master

Archive-via-clone would also work with full clones (if shallow ones are
not available), but that would be wasteful and a bit cruel, of course.

Anyway, I think we should find a better (shorter) name for that option;
that could turn out to be the hardest part. :)

> It might turn out that it may work better than the native "git
> archive" access against servers that offer both shallow clone
> and native archive access.  I doubt a single-commit shallow clone
> would benefit from reusing of premade deltas and compressed bases
> streamed straight out of packfiles from the server side that much,
> but you'd never know until you measure ;-)

It could benefit from GIT_ALTERNATE_OBJECT_DIRECTORIES, but I guess
typical users of git archive --remote won't have any good ones lying
around.

René
