Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00006C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 16:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDGQsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 12:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDGQst (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 12:48:49 -0400
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E014976F
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 09:48:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 6AE183C020F7C;
        Fri,  7 Apr 2023 09:48:44 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kPQurlYB1bY0; Fri,  7 Apr 2023 09:48:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.cs.ucla.edu (Postfix) with ESMTP id 7DDA13C097AFC;
        Fri,  7 Apr 2023 09:48:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 7DDA13C097AFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
        s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1680886122;
        bh=F+PW77ErQhFQHkkfv0GgRGwScVA/JOfmevt2y4yx7FU=;
        h=Message-ID:Date:MIME-Version:To:From;
        b=WlG/Z6XGA9EERDV2TMyOvewGtofk1t15OtmMu2AjQK5Ud/wxn6Av2FWxVJSODV9xt
         LnOD34IwqAt0s1QtFmVR75c4nJgyc8OepvFXwwlIlnvYjnicUgnD+ueWuRz962V9pw
         NOQ0pxL35251f5jxoMCRl6hRdxm8N9hCz61yeMIav5YYGhcJ6Vw6um2439yOFuZ5jV
         hPujxPTSPbKG0lWlYxVVC2Uqeg4hn6cgGODsALqjl5WP55qeoiY/leXchm/fVlu5WZ
         mETBAPuvzrmFIz6tZ6mdD2hXrn1ft6S0CAGXL0bSYpyQetP4l38QnOxaGQmAGl0J8K
         VdpEfWuq2Vt7w==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
        by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qML49UNS655D; Fri,  7 Apr 2023 09:48:42 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com [172.91.119.151])
        by mail.cs.ucla.edu (Postfix) with ESMTPSA id 385E83C020F7C;
        Fri,  7 Apr 2023 09:48:42 -0700 (PDT)
Message-ID: <767d3617-e35a-a693-6ec8-f65421c68e5f@cs.ucla.edu>
Date:   Fri, 7 Apr 2023 09:48:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To:     demerphq <demerphq@gmail.com>
Cc:     Philip.Hazel@gmail.com, 60690@debbugs.gnu.org,
        mega lith01 <megalith01@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, pcre-dev@exim.org,
        =?UTF-8?Q?Tukusej=e2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        git@vger.kernel.org
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
 <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
 <96358c4e-7200-e5a5-869e-5da9d0de3503@cs.ucla.edu>
 <xmqqttxvzbo8.fsf@gitster.g>
 <6d86214a-1b80-eb88-1efb-36e61fd3203e@cs.ucla.edu>
 <CANgJU+XoyptS8NU+f6uMLrKjQakv=iN2c4DQydVaBVH3dK3s-w@mail.gmail.com>
Content-Language: en-US
From:   Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: bug#60690: -P '\d' in GNU and git grep
In-Reply-To: <CANgJU+XoyptS8NU+f6uMLrKjQakv=iN2c4DQydVaBVH3dK3s-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-04-06 08:45, demerphq wrote:
>> Although this causes pcre2grep to mishandle Unicode characters:
>>
>>     $ echo '=C3=86var' | pcre2grep '[Ss=C3=9F]'
>>     =C3=86var
>>
>> it mimics Perl 5.36:
>>
>>     $ echo '=C3=86var' | perl -ne 'print $_ if /[Ss=C3=9F]/'
>>     =C3=86var
>>
>> so this seems to be what Perl users expect, despite its infelicities.
> Actually no, I think you have misunderstood what is happening at the
> different layers involved here.

No, I understood what was going on. My point was that Perl users seem to=20
have accepted this behavior, even though it does not match what people=20
would ordinarily expect.


> What you should have done is something like this:

No, for two reasons. First, I'm no Perl expert and so I don't know (and=20
don't particularly want to learn) its complicated Unicode options and=20
calls. Second, /[Ss\x{DF}]/u is hard to read. If I want the S letters of=20
traditional German, I'll write them in the obvious way, as [Ss=C3=9F]. No=
=20
doubt Perl will let me do this somehow - but it is telling that none of=20
your examples do it in such a straightforward way.

> $ echo '=C3=86var' | perl -ne 'utf8::decode($_); print $_ if /[Ss\x{DF}=
]/u'
> $ echo 'ba=C3=9F' | perl -MEncode -ne 'utf8::decode($_); print
> encode_utf8($_) if /[Ss\x{DF}]/u'
> ba=C3=9F
> $ echo '=C3=86var' | perl -MEncode -ne 'utf8::decode($_); print
> encode_utf8($_) if /[Ss\x{C6}]/u'
> =C3=86var
> $ echo '=C3=86var' | perl -MEncode -ne 'utf8::decode($_); print
> encode_utf8($_) if /[Ss\x{e6}]/ui'
> =C3=86var


