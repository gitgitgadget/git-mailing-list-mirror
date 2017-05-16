Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373A11FAA8
	for <e@80x24.org>; Tue, 16 May 2017 20:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbdEPUsl (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 16:48:41 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:35543 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbdEPUsk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 16:48:40 -0400
Received: by mail-it0-f53.google.com with SMTP id c15so69932500ith.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 13:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1wO9ZB6slsB0vZt5SuxKaiJNhrts35IMsSVM5IFSUig=;
        b=OMgNaW/E2ZAg3Rbtq+Cm5n3XM88Iy057+L6FBeoOHUG85khhFKtfL1GS/B7Ynbfj6/
         ZFmAZvH9YEyyoiI4Dnu+PU1omHJcsyuJZXvzixosyVw9tr+znpty9TMDY7WmccicMT1s
         tg4VaQsBet8W8Q36FILIC1yc3oRNO2QmEAMCOb/QNxcRbReJWZeQfjcSDQewAxQcWxwn
         YESOdcufRIXIAnSdwICmpjoSnbAOfmzg84GXLlk7mkoMch6XW3aeBRZMgqfuXVVez4T0
         KJUL2vpZCCgDpOH4Duaoqu6sosbQhFny/87Le7dP496uPHA9qUlCjq2i5pjV0KZ/nSNz
         MFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1wO9ZB6slsB0vZt5SuxKaiJNhrts35IMsSVM5IFSUig=;
        b=BRi8kAhaGUU/Pt9yct83uzI8hMTNVppKDphSpbNgL8mcNpmtRHNjjFHtNQtwJVOYG8
         ng4ljBKVuN/mxuOSProtl23isP5JblUUxIze74RflNz9f4CqOQoApGUNf5rSIq8Por1a
         LdrG9bcJEK6PGRHzmOd0qvvdw4rPl4f9UsRrlWd7qa8J87nNXFNnl87vOgufE0v+1wHA
         +bkiRtI7v1IOfIVjEyk3rV2gSNouHUjgPmj7A0cvKazAnp3Q72ixLzjsJO8gvQncPonT
         6i8eYE76HpFOEG43EOf+vUfrCbtkxnVX6paPCgkALsXU1EYpFjfHSzctcdO4YwpCcVCI
         SOqg==
X-Gm-Message-State: AODbwcC7JuboOzLjAg1HZs1S77OCVXNJRr/YXbYs3aJD2MQX0xsf67w9
        5+CrZAFbKpG/PCmM3eNJspwCMjaNoYvgHEw=
X-Received: by 10.36.37.78 with SMTP id g75mr671461itg.94.1494967709427; Tue,
 16 May 2017 13:48:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 16 May 2017 13:48:08 -0700 (PDT)
In-Reply-To: <CAPYmS35nxV2mgvhwOxwh_0bjbR6PrjEPmLbAZd0kDFN_rpccsw@mail.gmail.com>
References: <CAPYmS36e40gb6_2updPKvzo8EJj7+f5npZy9nPDkz1ou8a80_g@mail.gmail.com>
 <CAPYmS37KTeQDM+iugnEpcxFdPdBxEg3Khg8woptGPE7K-nyjGw@mail.gmail.com> <CAPYmS35nxV2mgvhwOxwh_0bjbR6PrjEPmLbAZd0kDFN_rpccsw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 16 May 2017 22:48:08 +0200
Message-ID: <CACBZZX7ZNUUVWC2dWij-U=UAGgbuvVbhSQhVggtSWHcL8D+K5g@mail.gmail.com>
Subject: Re: clone vs submodule operation with HTTP cURL
To:     Jean-Francois Bouchard <jfbouchard@accedian.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 8:15 PM, Jean-Francois Bouchard
<jfbouchard@accedian.com> wrote:
> Hello,
>
> Anyone can help with this ? The workaround is hardly possible in a
> medium environment as it needs editing and adding env to everyone and
> in every clone.

According to git-config anyauth is the default, see http.proxyAuthMethod.

Do you have something setting http.proxyAuthMethod in the environment
beforehand? What does:

    git config http.proxyAuthMethod

Return, in the same environment where your cloning fails? Same for
GIT_HTTP_PROXY_AUTHMETHOD.



> Thanks !!
> JF
>
> On Mon, May 15, 2017 at 5:38 PM, Jean-Francois Bouchard
> <jfbouchard@accedian.com> wrote:
>> Hello,
>>
>> Follow-up to this post.
>>
>> I seems that setting GIT_HTTP_PROXY_AUTHMETHOD=3Danyauth is a workaround
>> to this issue.
>>
>> So now the issue is : git is not setting AUTHMETHOD correctly when
>> doing a submodule update
>>
>> Note that a user is needed in the URL string. :@ does not work,
>> empty.auth variable does not work.
>>
>> Any ideas ?
>>
>> Thanks,
>> JF
>>
>> On Thu, May 11, 2017 at 6:04 PM, Jean-Francois Bouchard
>> <jfbouchard@accedian.com> wrote:
>>> Hello everyone,
>>>
>>> In our usage of GSSAPI via HTTPS, all our operation with git are very
>>> well handle, however, when trying to update a submodule, git seems to
>>> be managing cURL differently. cURL drop the ball quickly.
>>>
>>> Example (No other setup needed on the client) :
>>> git clone HTTPrepo -> GET -> 401 -> GET -> 401 -> GET (this time with
>>> Authorization: Negotiate)  -> 200 OK
>>>
>>> git submodule update -> GET -> 401 -> git prompt for username
>>>
>>> Is the codepath for clone regarding cURL is different than with submodu=
le ?
>>>
>>> Using : 2.13.0, I have also tried the emptyAuth stuff with no avail.
>>>
>>> Thanks,
>>> JF
>
> --
>
>
> Avis de confidentialit=C3=A9
>
> Les informations contenues dans le pr=C3=A9sent message et dans toute pi=
=C3=A8ce qui
> lui est jointe sont confidentielles et peuvent =C3=AAtre prot=C3=A9g=C3=
=A9es par le secret
> professionnel. Ces informations sont =C3=A0 l=E2=80=99usage exclusif de s=
on ou de ses
> destinataires. Si vous recevez ce message par erreur, veuillez s=E2=80=99=
il vous
> plait communiquer imm=C3=A9diatement avec l=E2=80=99exp=C3=A9diteur et en=
 d=C3=A9truire tout
> exemplaire. De plus, il vous est strictement interdit de le divulguer, de
> le distribuer ou de le reproduire sans l=E2=80=99autorisation de l=E2=80=
=99exp=C3=A9diteur.
> Merci.
>
> Confidentiality notice
>
> This e-mail message and any attachment hereto contain confidential
> information which may be privileged and which is intended for the exclusi=
ve
> use of its addressee(s). If you receive this message in error, please
> inform sender immediately and destroy any copy thereof. Furthermore, any
> disclosure, distribution or copying of this message and/or any attachment
> hereto without the consent of the sender is strictly prohibited. Thank yo=
u.
