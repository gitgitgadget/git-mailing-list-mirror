Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8176F1FF30
	for <e@80x24.org>; Tue, 22 Nov 2016 10:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932897AbcKVKfw (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 05:35:52 -0500
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34674 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbcKVKfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 05:35:50 -0500
Received: by mail-yw0-f171.google.com with SMTP id t125so10800016ywc.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 02:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eJW6hPlFF2nHEpoYkGqS5gR3FFmO7o1OlFM9DD3EO9c=;
        b=wzq7BBBObJjSIcPoQzs3QY8wr4meiEXJ6zxZujKMpX7zcX7pz13H5VpNeE5yYqzjer
         cs+7NxHdfw57cpxtT4DeFHfTFCKWh8JPXZHXBxYG46/X72uPMq7dbZbXMaGtLv/fk26Z
         hppN9ka0jGE31BHYLRlGrXHKtVAjszon8gWpUxKZ8jNAkviqfKmZWrlCHayXTCHbXXr9
         SOwzpl2PZOZSdLLCO0iuWUv8Gmm/D336k+kwBzvGnaYDWgwKW/LJGL1X048x8TVcP1ZM
         gB0FNJ0XYvZvTBLp0woljEFge8Evkhe96culAs23xGMSf6F3HYsaFbWpWLx4UhcJ2ftq
         iIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eJW6hPlFF2nHEpoYkGqS5gR3FFmO7o1OlFM9DD3EO9c=;
        b=OAky/2QIVI7jXFT4IZpHBdLqn6+J5YtyrC33AFv79h5O93fiPU9HoozOMLhI2wB/EG
         upXNh96IJqRVXtoTk5fTR2EkBT65Y/ItOxepyWaD85WLd/fzAGi6nEabxwFwY6YkXKAw
         CikGsxA0woUurKA9kG3jNJejLmUknTF2ciotzgmmqDHvnpXQ0z6/qj6TSOCpjqrqESKo
         0bw/KVRlJBNY3+3SPtM+ua5UXAAJJtH9PlJgn5hPIZnj30kuOXjqe4GORrZI0F7V2lt1
         7O3UicuCF8Zkn4mb+6/SGlEZwqKHXR+otJdsIa4nrUnAdBy/Nj4co9btHu6o3/1PZCbz
         OTUQ==
X-Gm-Message-State: AKaTC00O4zqb/I+j2VRo515lqwrm0eNB606FAL+qQsf3WZFH88s0DxS/g9GKZ4RZiKPwnU1WAXkzmi7QmT3a1g==
X-Received: by 10.13.224.3 with SMTP id j3mr20691776ywe.46.1479810949306; Tue,
 22 Nov 2016 02:35:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Tue, 22 Nov 2016 02:35:17 -0800 (PST)
In-Reply-To: <CAP8UFD1mun7wz2WqV8GCj6MODVjP2mPEBRGbJTf_ypiGCgtb9Q@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-13-chriscool@tuxfamily.org> <xmqq8tt3ovnp.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD2H6rZNQqg1VGNkes65KAk-4P160rjQSjFY3NjgZydZmA@mail.gmail.com>
 <xmqqoa1scyuy.fsf@gitster.mtv.corp.google.com> <CAP8UFD1YL+RgdqbV0V1OnC=sJHJFc_an02Q9JeDNapW+u1CZcA@mail.gmail.com>
 <CACsJy8BZNfESmFv=V89Cq-b+aMJWLH=qhXHNE8inZZRjvXB33Q@mail.gmail.com> <CAP8UFD1mun7wz2WqV8GCj6MODVjP2mPEBRGbJTf_ypiGCgtb9Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 22 Nov 2016 17:35:17 +0700
Message-ID: <CACsJy8BazeR=4tz3q2f35x=fCfp-Ld9LJz0mQh_CZoR_iXKEEQ@mail.gmail.com>
Subject: Re: [PATCH v1 12/19] Documentation/config: add splitIndex.maxPercentChange
To:     Christian Couder <christian.couder@gmail.com>
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

On Fri, Nov 18, 2016 at 9:34 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Nov 7, 2016 at 10:38 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> (sorry I got sick in the last few weeks and could not respond to this ea=
rlier)
>
> (Yeah, I have also been sick during the last few weeks.)
>
>> On Mon, Nov 7, 2016 at 4:44 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> Le 6 nov. 2016 09:16, "Junio C Hamano" <gitster@pobox.com> a =C3=A9crit=
 :
>>>>
>>>> Christian Couder <christian.couder@gmail.com> writes:
>>>>
>>>> > I think it is easier for user to be able to just set core.splitIndex
>>>> > to true to enable split-index.
>>>>
>>>> You can have that exact benefit by making core.splitIndex to
>>>> bool-or-more.  If your default is 20%, take 'true' as if the user
>>>> specified 20% and take 'false' as if the user specified 100% (or is
>>>> it 0%?  I do not care about the details but you get the point).
>>
>>> Then if we ever add 'auto' and the user wants for example 10% instead o=
f the
>>> default 20%, we will have to make it accept things like "auto,10".
>
> (Sorry for writing the above on my phone which added HTML, so that it
> didn't reach the list.)
>
>> In my opinion, "true" _is_ auto, which is a way to say "I trust you to
>> do the right thing, just re-split the index when it makes sense", "no"
>> is disabled of course. If the user wants to be specific, just write
>> "10" or some other percentage.(and either 0 or 100 would mean enable
>> split-index but do not re-split automatically, let _me_ do it when I
>> want it)
>
> The meaning of a future "auto" option for "core.splitIndex" could be
> "use the split-index feature only if the number of entries in whole
> index is greater than 10000 (by default)".

Well.. with the "just re-split the index when it makes sense" part,
the user entrusts git to do something sensible in all cases, and going
with absolute numbers might not be the best way, I think. It's big
responsibility :)

> If there is no difference between "true" and "auto" then, when users
> who have "core.splitIndex=3Dtrue" will migrate to the git version that
> adds the "auto" feature, their repos with under 10000 entires will not
> use the split-index feature anymore. These users may then be annoyed
> that the behavior has been switched under them, and that the
> split-index feature is not always used despite having
> "core.splitIndex=3Dtrue" in their config.
--=20
Duy
