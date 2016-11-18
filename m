Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496EE1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 14:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbcKROeN (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 09:34:13 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37414 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbcKROeM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 09:34:12 -0500
Received: by mail-wm0-f41.google.com with SMTP id t79so41339901wmt.0
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 06:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b4vRNTT9GzFs9SOilN8OdvEE9jfukg0lS8LfyO/E9L4=;
        b=fNs7zDQIYaES/Gu9pMdWxipUue61i6ipn3v8UBsWay/37MeH+Q7dfJYFv3q8Ecq/RL
         /Pw+N2pr9J11/XugYmsAv+LnKXIWjBHYZIZswaKuN6tLTYmlxcACp5sZ8rLDflbkzodT
         S8Y8OsWldbwOEYieeK4gQQUCQcjqKKZOx1hdMiu/wtGfhsH+1NcX0rV3Bp4qroCpivj4
         5RZjRR7Q+qH8bmpGJRoXNMs2wY/Xz9Y7GQuDFoUPUMpgcduV+uOthX9yXDapQfMPJJX+
         wdm6DzOyh50u49alT700KUiAZV+BuMyJOGMq7X0vr7PRA9iRZhpG1SG9GQsWztPTuXoV
         /V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b4vRNTT9GzFs9SOilN8OdvEE9jfukg0lS8LfyO/E9L4=;
        b=AAQO9cSN89xWInMQSPDxKFOHMCpE1PAOobQlXOnCnT3hy4mlA28sd+M8Otot8kXQmT
         avVxHr5FrOTloI9qPNfns6hcUvzsW+E0zitXOemQGMS5fqvUSTO7o8LrzNtVUHRDYH1J
         fex1axqdBmVv52fy7s5ZhWYWBLxcZ7LgwdNKWxo3phxGJ0q2ef4e/C4zhUMMsaagD6Vb
         XCJJZliDzSC/QvPoHTD6ZpZpM0oqYsNWe0XilcACm5G77zMFICd6y8mE/L+sZ6YXJyyK
         2YSc+ZD3QV3bFT8P+dgqmCSwwlIGQZAwP1OIMZ0vg+Hgqex2fFDmYuFWwcizVOtSso7N
         QfMw==
X-Gm-Message-State: AKaTC034gQ2+F+IYPLnZDYGnTcPqAcD5wLEUeC2885TsWN+1wRm/yWgEigoM1J5KHhGOhwxyK8/Nv2NO61l2Xw==
X-Received: by 10.46.69.11 with SMTP id s11mr6701lja.44.1479479650758; Fri, 18
 Nov 2016 06:34:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.25.142 with HTTP; Fri, 18 Nov 2016 06:34:10 -0800 (PST)
In-Reply-To: <CACsJy8BZNfESmFv=V89Cq-b+aMJWLH=qhXHNE8inZZRjvXB33Q@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-13-chriscool@tuxfamily.org> <xmqq8tt3ovnp.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD2H6rZNQqg1VGNkes65KAk-4P160rjQSjFY3NjgZydZmA@mail.gmail.com>
 <xmqqoa1scyuy.fsf@gitster.mtv.corp.google.com> <CAP8UFD1YL+RgdqbV0V1OnC=sJHJFc_an02Q9JeDNapW+u1CZcA@mail.gmail.com>
 <CACsJy8BZNfESmFv=V89Cq-b+aMJWLH=qhXHNE8inZZRjvXB33Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 18 Nov 2016 15:34:10 +0100
Message-ID: <CAP8UFD1mun7wz2WqV8GCj6MODVjP2mPEBRGbJTf_ypiGCgtb9Q@mail.gmail.com>
Subject: Re: [PATCH v1 12/19] Documentation/config: add splitIndex.maxPercentChange
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2016 at 10:38 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> (sorry I got sick in the last few weeks and could not respond to this ear=
lier)

(Yeah, I have also been sick during the last few weeks.)

> On Mon, Nov 7, 2016 at 4:44 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Le 6 nov. 2016 09:16, "Junio C Hamano" <gitster@pobox.com> a =C3=A9crit =
:
>>>
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>> > I think it is easier for user to be able to just set core.splitIndex
>>> > to true to enable split-index.
>>>
>>> You can have that exact benefit by making core.splitIndex to
>>> bool-or-more.  If your default is 20%, take 'true' as if the user
>>> specified 20% and take 'false' as if the user specified 100% (or is
>>> it 0%?  I do not care about the details but you get the point).
>
>> Then if we ever add 'auto' and the user wants for example 10% instead of=
 the
>> default 20%, we will have to make it accept things like "auto,10".

(Sorry for writing the above on my phone which added HTML, so that it
didn't reach the list.)

> In my opinion, "true" _is_ auto, which is a way to say "I trust you to
> do the right thing, just re-split the index when it makes sense", "no"
> is disabled of course. If the user wants to be specific, just write
> "10" or some other percentage.(and either 0 or 100 would mean enable
> split-index but do not re-split automatically, let _me_ do it when I
> want it)

The meaning of a future "auto" option for "core.splitIndex" could be
"use the split-index feature only if the number of entries in whole
index is greater than 10000 (by default)".

If there is no difference between "true" and "auto" then, when users
who have "core.splitIndex=3Dtrue" will migrate to the git version that
adds the "auto" feature, their repos with under 10000 entires will not
use the split-index feature anymore. These users may then be annoyed
that the behavior has been switched under them, and that the
split-index feature is not always used despite having
"core.splitIndex=3Dtrue" in their config.
