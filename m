Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66D461F600
	for <e@80x24.org>; Sun, 23 Jul 2017 21:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbdGWVrT (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 17:47:19 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:36732 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbdGWVrS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 17:47:18 -0400
Received: by mail-ua0-f182.google.com with SMTP id k43so29566588uaf.3
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 14:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n2WZB2AoHauqCczhcOXoTqVy5qzJ9/wBso6rWtOI3hY=;
        b=X4k69qJnUgxgqSK40CIqQ0M2MsWDD8CBYOO2c1Ate6W5BgZ/UXspE1fVR2m8SobLEh
         aRsbwvKTidxFHo29uK/dyR2gh7I8bGp7rWwYdX7KsFZ45D0n1A6sUonKmpjUDoWRrtEB
         K20SILxepkLr7Nonw0YDZnsUgnLfpnOzjOT3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n2WZB2AoHauqCczhcOXoTqVy5qzJ9/wBso6rWtOI3hY=;
        b=jpHL4vZoLTyg2//laXa3YTMA654n/pcFMPvJUWqbeuC/wZVG3lkKLhh8mIcj5JlZhC
         aeZactP7WVpwHAkm7/u9fCzAPf7F4F+jkkeOuX9t3Z4fDgOWL6Bu9M/5et9GdgjQoPNq
         xuyeaN2IsvhnI5LZkLVbRnmFwnb6+MNClYb4kc7MF8tOEhyO9KNCRg2cRu+TY+OwAAyR
         TnqP7pKvF/D+GVfr406KS0UFCvQ8kc5bORUPbVZOJK869D7+WTP4rfwBi2EFCaa4hA8G
         mvCXdadRPwPhtC7htuEQw2PTDpzudiAxSBw2OsJlqTmFUCWOaKluz65hOu4G052aHXMp
         AZzA==
X-Gm-Message-State: AIVw111pl4UxXm7ljdy3g3PNQKJEtezyUTyCk1+dCe+SXkTc6EYhsPTF
        DoF3QOuvBzKPoYBBzBlcYO6GRGwGkLBG
X-Received: by 10.31.128.141 with SMTP id b135mr7960376vkd.22.1500846437693;
 Sun, 23 Jul 2017 14:47:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Sun, 23 Jul 2017 14:46:57 -0700 (PDT)
In-Reply-To: <87k234tti7.fsf@gmail.com>
References: <CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com>
 <xmqqlgnmhmep.fsf@gitster.mtv.corp.google.com> <CAJo=hJuP9GdudFsA_ToFQwx-zESaDHRDXHLxmvAXSX5CKmh7JQ@mail.gmail.com>
 <87k234tti7.fsf@gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Sun, 23 Jul 2017 14:46:57 -0700
Message-ID: <CAJo=hJtCL6ZH2DPgCAkQptouM0xSbSnfwMX-f+RM=1wCucay9g@mail.gmail.com>
Subject: Re: reftable [v2]: new ref storage format
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My apologies for not responding to this piece of feedback earlier.

On Wed, Jul 19, 2017 at 7:02 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Jul 18 2017, Shawn Pearce jotted:
>> On Mon, Jul 17, 2017 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>>> Shawn Pearce <spearce@spearce.org> writes:
>>>> where `time_sec` is the update time in seconds since the epoch.  The
>>>> `reverse_int32` function inverses the value so lexographical ordering
>>>> the network byte order time sorts more recent records first:
>>>>
>>>>     reverse_int(int32 t) {
>>>>       return 0xffffffff - t;
>>>>     }
>>>
>>> Is 2038 an issue, or by that time we'd all be retired together with
>>> this file format and it won't be our problem?
>>
>> Based on discussion with Michael Haggerty, this is now an 8 byte field
>> storing microseconds since the epoch. We should be good through year
>> 9999.
>
> I think this should be s/microseconds/nanoseconds/, not because there's
> some great need to get better resolution than nanoseconds, but because:
>
>  a) We already have WIP code (bp/fsmonitor) that's storing 64 bit
>     nanoseconds since the epoch, albeit for the index, not for refs.
>
>  b) There are several filesystems that have nanosecond resolution now,
>     and it's likely more will start using that.

The time in a reflog and the time returned by lstat(2) to detect dirty
files in the working tree are unrelated. Of course we want the
dircache to be reflecting the highest precision available from lstat,
to reduce the number of files that must be content hashed for racily
clean detection. So if a filesystem is using nanoseconds, dircache
maybe should support it.

> Thus:
>
>  x) If you use such a filesystem you'll lose time resolution with this
>     ref backend v.s. storing them on disk, which isn't itself a big
>     deal, but more importantly you lose 1=3D1 time mapping as you
>     transition and convert between the two.

No, you won't. The reflog today ($GIT_DIR/logs) is storing second
precision in the log record. What precision the filesystem is using as
an mtime is irrelevant.

Further, microsecond is sufficient resolution for reflog data. From my
benchmarking just reading a reference from a very hot reftable costs
~20.2 usec. Any update of a reference requires a read-compare-modify
cycle, and so updates aren't going to be more frequent than 20 usec.

>  y) Our own code will need to juggle second resolution epochs
>     (traditional FSs, any 32bit epoch format), microseconds (this
>     proposal), and nanoseconds (new FSs, bp/fsmonitor) internally in
>     various places.

But these are also unrelated areas. IMHO, the nanosecond stuff should
be confined to the dircache management code and working tree
comparison code, and not be leaking out of there. Commit objects are
still recorded with second precision, and that isn't going to change.

Therefore I decided to stick with microseconds in the reftable v3
draft that I posted on July 22nd.
