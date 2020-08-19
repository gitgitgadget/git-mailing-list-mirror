Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5534DC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DE42078D
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgHSTQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:16:35 -0400
Received: from elephants.elehost.com ([216.66.27.132]:13243 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgHSTQe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 15:16:34 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 07JJGPoY030692
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Aug 2020 15:16:25 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Lukas Straub'" <lukasstraub2@web.de>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'git'" <git@vger.kernel.org>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Brandon Williams'" <bwilliams.eng@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Jeff King'" <peff@peff.net>
References: <cover.1597853634.git.lukasstraub2@web.de>        <xmqqr1s2tswd.fsf@gitster.c.googlers.com> <20200819204750.6ce87f7c@luklap>
In-Reply-To: <20200819204750.6ce87f7c@luklap>
Subject: RE: [RFC PATCH 0/2] Allow adding .git files and directories
Date:   Wed, 19 Aug 2020 15:16:19 -0400
Message-ID: <04bb01d6765d$3bb67e20$b3237a60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJUwsi1t0kYcCu+MG1WzKjrMbhjgQKo5EueAh/vIPSoHOz9cA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 19, 2020 2:48 PM, Lukas Straub wrote:
> To: Junio C Hamano <gitster@pobox.com>
> Cc: git <git@vger.kernel.org>; Elijah Newren <newren@gmail.com>;
> Brandon Williams <bwilliams.eng@gmail.com>; Johannes Schindelin
> <Johannes.Schindelin@gmx.de>; Jeff King <peff@peff.net>
> Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
> 
> On Wed, 19 Aug 2020 11:03:30 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
> 
> > Lukas Straub <lukasstraub2@web.de> writes:
> >
> > > These patches allow this and work well in a quick test. Of course
> > > some tests fail because with this the handling of nested git repos
> changed.
> >
> > In other words, this breaks the workflow existing users rely on,
> > right?  I do not know if such a behaviour ever needs to exist even as
> > an opt-in feature, but it definitely feels wrong to make the behaviour
> > these patches introduce the default.
> 
> Well, the current behavior is that nested repos (that are not submodules)
are
> completely ignored and none of the files within can be added. So the old
> behavior can be restored with .gitignore. The same goes for files/dirs
named
> .git.
> 
> Of course I don't know what the current policy for behavioral changes in
git
> is, but I see that there have been such changes in the past.

I honestly am concerned about a repeat of things like
https://nvd.nist.gov/vuln/detail/CVE-2019-19604 (the submodule update
problem). This change in behaviour is of serious concern from a risk
standpoint. To be blunt, I don't think users on my platform will move to a
version of git that supports this by default.

Sincerely,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



