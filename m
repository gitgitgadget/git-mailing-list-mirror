Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95991C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 21:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344535AbhLJV4u convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 10 Dec 2021 16:56:50 -0500
Received: from elephants.elehost.com ([216.66.27.132]:26433 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344563AbhLJV4s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 16:56:48 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BALr7dh066977
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 10 Dec 2021 16:53:07 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     "'Joel Holdsworth'" <jholdsworth@nvidia.com>, <git@vger.kernel.org>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>        <211210.86r1ale0o0.gmgdl@evledraar.gmail.com> <xmqqsfv0m9f5.fsf@gitster.g>
In-Reply-To: <xmqqsfv0m9f5.fsf@gitster.g>
Subject: RE: [PATCH 0/6] Transition git-p4.py to support Python 3 only
Date:   Fri, 10 Dec 2021 16:53:02 -0500
Organization: Nexbridge Inc.
Message-ID: <021001d7ee10$517309a0$f4591ce0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGEBha9kcKLYJkBk7w9RvIZH6yURAJuDwCBAU2fh6CstjN2sA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 10, 2021 4:34 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > On Thu, Dec 09 2021, Joel Holdsworth wrote:
> >
> >> Python 2 was discontinued in 2020, and there is no longer any
> >> officially supported interpreter. Further development of git-p4.py
> >> will require would-be developers to test their changes with all
> >> supported dialects of the language. However, if there is no longer
> >> any supported runtime environment available, this places an
> >> unreasonable burden on the Git project to maintain support for an
> obselete dialect of the language.
> >
> > Does it? I can still install Python 2.7 on Debian, presumably other
> > OS's have similar ways to easily test it.
> 
> Yes, that is a good point to make against "we cannot maintain the half meant
> to cater to Python2 of the script".  Developers should be able to keep and
> test Python2 support, if it is necessary.
> 
> So the more important question is if there are end-users that have no choice
> but sticking to Python2.  Is there distributions and systems that do not offer
> Python3, on which end-users have happily been using Python2?  If some
> users with vendor supported Python2 do not have access to Python3, cutting
> them off may be premature.
> 
> As the general direction, I do not mind deprecating support for Python2, and
> then eventually removing it.  I just do not know if 2 years is long enough for
> the latter (IIRC, the sunset happened at the beginning of 2020, and we are
> about to end 2021).

The HPE NonStop Itanium platform only provides Python 2.7. That is the last version that will be available on that platform until it goes off support some time in the next few years (there are known very large US companies who are git users on that platform but I cannot share their names here). The NonStop x86 platform is currently on Python 3.6.8 but I have to take action to select the python3 object - not a big deal. Since I am continually running the git test suite with each release, the python 2 code can continue to be tested. Python 2 is also available on our x86 machine for backward compatibility reasons - it may vanish at some point but that isn’t scheduled yet.

-Randall

