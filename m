Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5CD2021E
	for <e@80x24.org>; Sun, 20 Nov 2016 15:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbcKTPQg (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 10:16:36 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33699 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbcKTPQf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 10:16:35 -0500
Received: by mail-yw0-f193.google.com with SMTP id s68so24823292ywg.0
        for <git@vger.kernel.org>; Sun, 20 Nov 2016 07:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SKDDGepXt26koaxTH5UTI+uSPDxcjpWYszy6ILG4Usg=;
        b=Gi+cBujinxf1bRx5QrEtUhzmm7ZYGXAt716OEycoVJXmiQ1ODdTjouIb25dE3h1n36
         0DXrvwk2RShISkEkaHStcYibclkXnGkWzsFa64ZG2Fm8AHRcxCX2LDjxyQae7jRCKI7l
         eIeNkHHV/m7N039Wo5p7SURXczcZQ7nX/OJL5V5z+w1V9XdWWWfnLQNJSXTVThoV0PTv
         R8TSBAA1zgQ6/SCUGL+FrXr1xX8V/+2EUWM8P9am9+2QGZ42ibm/xEtV9l845iqjw7Ea
         G2dBPKKvcdwsS1F5G+ZRQt6uFDrG0641EY2IwfFZIJ5QvHS8XBiuEZHFukzhU6XOvbQ0
         I/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SKDDGepXt26koaxTH5UTI+uSPDxcjpWYszy6ILG4Usg=;
        b=cawxGhQ7hByLe5Umq9f3LIYkEI0vkSweYQjw4zgK+qILEhFUT/JIl6YoznH5I3SYUS
         er4E/etkZQR0aMLM9m65/OdKHoP9UyPUj5e2rHjoHxScbH6NY1qDLYkgVyDv0MFFvbyY
         VShUx47Fxps2n08+qA8KHcxvL4CRvBj4KcuqE8o2kwgIv2icPRqLNAg4WWN1tWBr0Rz2
         iypysB6/x7+BHdRnomFzdTl6wJ+LNkFO57kdRBVRlruGl3pKJ2WyLcIk+xXkU+FFaG3o
         XFWkNKKD1Rjd4vq/PTccPIJ6pdMy0FG6rdzhhsthAnvZedxTD4rlOJo2RvMv/HU0yMjC
         xAQA==
X-Gm-Message-State: AKaTC02nL630liajbeyJdOQvGNRJvkARZeqLCL5uTA71wCpXy+zcmU5f+lN/yfdB9r8+2ikychETXG2HXVFO3A==
X-Received: by 10.129.121.1 with SMTP id u1mr8883189ywc.146.1479654993988;
 Sun, 20 Nov 2016 07:16:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sun, 20 Nov 2016 07:16:03 -0800 (PST)
In-Reply-To: <20d067ef-9e2c-0d1f-f81a-06c154e95e4f@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
 <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
 <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
 <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
 <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
 <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com> <20d067ef-9e2c-0d1f-f81a-06c154e95e4f@gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sun, 20 Nov 2016 20:46:03 +0530
Message-ID: <CAOLa=ZRf+vPOPK=ovP7JmJ52qdgwuqkpGH4UfP=+caQeyu9Ucw@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2016 at 11:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>>>> to get remotes from /refs/foo/abc/xyz we'd need to do
>>>>> strip=3D1,strip=3D-1, which could be
>>>>> done but ...
>>>>
>>>> ... would be unnecessary if this is the only use case:
>>>>
>>>>> strbuf_addf(&fmt,
>>>>> "%%(if:notequals=3Dremotes)%%(refname:base)%%(then)%s%%(else)%s%%(end=
)",
>>>>> local.buf, remote.buf);
>>>>
>>>> You can "strip to leave only 2 components" and compare the result
>>>> with refs/remotes instead, no?
>>>>
>>>
>>> Of course, my only objective was that someone would find it useful to
>>> have these two additional
>>> atoms. So if you think it's unnecessary we could drop it entirely :D
>>>
>>> --
>>> Regards,
>>> Karthik Nayak
>>
>> I think having strip and rstrip make sense, (along with support for
>> negative numbers) I don't think we need to make them work together
>> unless someone is interested, since we can use strip=3D-2 to get the
>> behavior we need today.
>
> I am OK with multiple strips Karthik suggests, e.g.
>
>     %(refname:strip=3D1,rstrip=3D-1)
>
> if it is cleanly implemented.
>
> I have a bit of trouble with these names, though.  If we call one
> strip and the other rstrip, to only those who know about rstrip it
> would be clear that strip is about stripping from the left.  Perhaps
> we should call it lstrip for symmetry and ease-of-remembering?
>
>     refs/heads/master:lstrip=3D-1 =3D> master (strip all but one level
>     from the left)
>
>     refs/heads/master:rstrip=3D-2 =3D> refs/heads (strip all but two
>     levels from the right)
>
>     refs/heads/master:lstrip=3D1,rstrip=3D-1 =3D> heads (strip one level
>     from the left and then strip all but one level from the right)
>
> I dunno.

We could have lstrip and rstrip as you suggested and perhaps make it work
together too. But I see this going off the scope of this series. Maybe
I'll follow up
with another series introducing these features. Since we can currently
make do with
'strip=3D2' I'll drop this patch from v8 of this series and pursue this
idea after this.

On Sat, Nov 19, 2016 at 3:19 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 15.11.2016 o 18:42, Junio C Hamano pisze:
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>>> dirname makes sense. What about implementing a reverse variant of
>>> strip, which you could perform stripping of right-most components and
>>> instead of stripping by a number, strip "to" a number, ie: keep the
>>> left N most components, and then you could use something like
>>> ...
>>> I think that would be more general purpose than basename, and less conf=
using?
>>
>> I think you are going in the right direction.  I had a similar
>> thought but built around a different axis.  I.e. if strip=3D1 strips
>> one from the left, perhaps we want to have rstrip=3D1 that strips one
>> from the right, and also strip=3D-1 to mean strip everything except
>> one from the left and so on?.  I think this and your keep (and
>> perhaps you'll have rkeep for completeness) have the same expressive
>> power.  I do not offhand have a preference one over the other.
>>
>> Somehow it sounds a bit strange to me to treat 'remotes' as the same
>> class of token as 'heads' and 'tags' (I'd expect 'heads' and
>> 'remotes/origin' would be at the same level in end-user's mind), but
>> that is probably an unrelated tangent.  The reason this series wants
>> to introduce :base must be to emulate an existing feature, so that
>> existing feature is a concrete counter-example that argues against
>> my "it sounds a bit strange" reaction.
>
> If it is to implement the feature where we select if to display only
> local branches (refs/heads/**), only remote-tracking branches
> (refs/remotes/**/**), or only tags (refs/tags/**), then perhaps
> ':category' or ':type' would make sense?
>
> As in '%(refname:category)', e.g.
>
>   %(if:equals=3Dheads)%(refname:category)%(then)...%(end)
>

This is also a good idea but would bring about the same confusion that Juni=
o
was referring to, i.e.

"Somehow it sounds a bit strange to me to treat 'remotes' as the same
class of token as 'heads' and 'tags' (I'd expect 'heads' and
'remotes/origin' would be at the same level in end-user's mind), but
that is probably an unrelated tangent.  The reason this series wants
to introduce :base must be to emulate an existing feature, so that
existing feature is a concrete counter-example that argues against
my "it sounds a bit strange" reaction."

So right now the rstrip/lstrip idea seems to be a good way to go about
this, but I
think that'd be after this series.

--=20
Regards,
Karthik Nayak
