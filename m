Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854E3C2BB9A
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 12:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BAF92396D
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 12:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgLQMPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 07:15:15 -0500
Received: from elephants.elehost.com ([216.66.27.132]:26320 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQMPP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 07:15:15 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0BHCEVaf024890
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 17 Dec 2020 07:14:32 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <20201216220752.6371-1-randall.s.becker@rogers.com>        <20201216220752.6371-2-randall.s.becker@rogers.com> <xmqq1rfp2uyo.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rfp2uyo.fsf@gitster.c.googlers.com>
Subject: RE: [Patch 1/1] config.mak.uname: remove old NonStop compatibility settings
Date:   Thu, 17 Dec 2020 07:14:25 -0500
Message-ID: <00d301d6d46e$2c7e63e0$857b2ba0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQD7jVI9Rq08gvwObJnGf6Ej55mkJAHVKcvXAf5lV0WrkyJQQA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 16, 2020 6:27 PM, Junio C Hamano wrote:
> To: randall.s.becker@rogers.com
> Cc: git@vger.kernel.org; Randall S. Becker <rsbecker@nexbridge.com>
> Subject: Re: [Patch 1/1] config.mak.uname: remove old NonStop
> compatibility settings
> 
> randall.s.becker@rogers.com writes:
> 
> > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> >
> > The MKDIR_WO_TRAILING_SLASH and NO_SETITIMER options are no
> longer
> > needed on the NonStop platforms as both are now supported by the
> > oldest supported operating system revision.
> 
> Nice to read "supported by the oldest supported version"; very assuring
that
> it is the right thing to unconditionally remove these settings.

The basic policy is that OS releases (platform calls them RVUs), are
supported for 5 years from the date of release. So we are very reluctant to
depend on any feature introduced in a more recent RVU. Once the oldest drops
off support, we can use newer APIs without concern of a customer hitting a
non-supported condition - they can use older versions of git. There are very
rare conditions where an incompatibility is introduced, which we try to work
around. The now current oldest drops out May 2022. At that point we can
prune a few more things. Some customers may stick with older releases (with
extra paid support) but my group is not bound to that - independent and
volunteers. Of course, if someone wants to pay... 

> 
> Will queue.  Thanks.

Thanks,
Randall

