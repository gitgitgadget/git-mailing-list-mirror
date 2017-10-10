Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A792036B
	for <e@80x24.org>; Tue, 10 Oct 2017 18:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932521AbdJJSOs (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 14:14:48 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:46484 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932114AbdJJSOp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 14:14:45 -0400
Received: by mail-pf0-f181.google.com with SMTP id p87so9017108pfj.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VgTQ46zE2rsTrcY6C6Jq03zMPIsbW+z9tq1g8RmJWDA=;
        b=OhT7fkZwj0jgMeU/9864gAQ19BCavErsH5p3AfrZiA5bDo+YEC/0LYbPlMrMNjXyUw
         +xQsuRBKv88pW8dXfsKVMZlfOqsHfroXKr5DkKY2n/QPD3qKFyUwH7/bnLVePeNxAaZH
         uoTwQIlwY18OACdPWuOF3GIKpZPT+TdXg/KF9nJB3+N5w4brPGG50da0eJAVG6MEHRwj
         5loY9XTwSveLU1v72DPtM8PvIThW/bEd3Erkvry+DvAqg6iIJ++DQtuO73M8Obzaeb9/
         D+hIEO7HkFEvi4bk+Nwpy0/ozDKw7YFFG8Jfx33eFaQridB1Ikk2gxWHjRRA4QI6p3CQ
         M3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VgTQ46zE2rsTrcY6C6Jq03zMPIsbW+z9tq1g8RmJWDA=;
        b=Qj5CB+SmUWQ1u4CX5uqg8GYIEjcBS+Qm2ZzR5ir2UZsT6yN+ZLD2T/8sSOo2g1t32W
         ui2rxsmRzFayUOND/6vDE2GCCaSg9UqjAuUQ4scl4zfMJ4PuBG1pz2MAj1ZM6sdltsky
         uYQvGmFeZLEHyB0sjffu/AFccWeK9h8yOT67QEfVAbBRpyW52Rg7GbbZKMbFiT0zWz89
         E0vvZ0/X+VSVr/weGaY7nMQA405xCeRx3Nj41l3RDCnUBOYG684IhK5+2MJ9r3qBOPXF
         PRJWEDeN16HiOjwNwy1peWi7cB0GHerbSTTXMkqiuD8iFV6JhhrWgKpX2l/X1+MjbU4x
         Pr2A==
X-Gm-Message-State: AMCzsaWTQJOk1TidmhD+Y3/8wOPLxMlX0dqJWxCyGU5S+mNL3PDL9TfB
        xbRob3TWmuVp7Umol8xw2IwCqGwadTQefmoGyNk=
X-Google-Smtp-Source: AOwi7QAig/UzartA2p+w/0hSQ69wJ+637m11ew5J3bdUavUkIceXIPKOnd0D5pAWybRSwrKZuwOxWG87WLZcX8hIwYs=
X-Received: by 10.84.233.66 with SMTP id k2mr5787182plt.45.1507659284985; Tue,
 10 Oct 2017 11:14:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Tue, 10 Oct 2017 11:14:44 -0700 (PDT)
In-Reply-To: <CAEe2ifX5+OUOWw75pFZN86pT1iwYk2vb6u+uEMYLDpxYzmJLEQ@mail.gmail.com>
References: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
 <CAN0heSqFSiev8BeZVu3KBA5vswsbQrrOH=tYYOSs_h_eq=8-3Q@mail.gmail.com>
 <CAGZ79ka7xo96MHaAUbkDuFjWMQaaD4j2UrRndcinAg6uzaP6Kw@mail.gmail.com>
 <7894534.MaGmRTisnX@cayenne> <xmqq7ew3rdxa.fsf@gitster.mtv.corp.google.com> <CAEe2ifX5+OUOWw75pFZN86pT1iwYk2vb6u+uEMYLDpxYzmJLEQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Oct 2017 20:14:44 +0200
Message-ID: <CAN0heSoetaKFsZ8b0kD5w=G4g3GJJHWwBzR9RreEQoaJz_YnTg@mail.gmail.com>
Subject: Re: [PATCH] submodule: avoid sentence-lego in translated string
To:     Changwoo Ryu <cwryu@debian.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jacques Viviers <jacques.viviers@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 October 2017 at 04:35, Changwoo Ryu <cwryu@debian.org> wrote:
> 2017-10-10 10:26 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
>> Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:
>>
>>> On Monday, 9 October 2017, 09:47:26 CEST Stefan Beller wrote:
>>>
>>>> I always assumed that translators are aware of these issues and sort o=
f
>>>> work around this somehow, maybe like this:
>>>>
>>>>   "submodule entry '%s' (%s) is not a commit. It is of type %s"
>>>
>>> Translators can be aware of the issue if the coder commented the
>>> internationalization string with some possible candidates for the place=
holders
>>> when it is not clear unless you check in the source code. Much effort w=
as
>>> poured into translating the technical terms in other parts of Git; it s=
eems
>>> awkward to just step back in this occurence.
>>
>> I do not see this particular case as "stepping back", though.
>>
>> Our users do not spell "git cat-file -t commit v2.0^{commit}" with
>> 'commit' translated to their language, right?  Shouldn't an error
>> message output use the same phrase the input side requests users to
>> use?

I thought Jean-No=C3=ABl meant at least partially the translator-experience=
,
not just the user-experience, but I might be wrong.

I prepared a patch to give a TRANSLATORS:-comment, but then I realized
that we have more instances like this with `typename()`. Actually, quite
often we avoid the issue (intentionally or unintentionally) by writing
"of type %s", but other times, we do the "is a %s". So I don't know,
maybe it all works anyway. The regular translators have now received 10
mails (11 counting this) so might be aware of this particular string by
now. :-/

> Users know the limit of command-line translation. They type "commit"
> to commit but they see translated "commit" in output messages. It is
> actually confusing. But the untranslated English literals in the
> middle of translated sentences does not remove the confusion but
> increase it in a different way.

What you describe seems plausible, but I have to admit that I don't use
i18n-ized software myself.

Martin
