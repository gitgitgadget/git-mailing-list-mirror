Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CD2C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 20:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbhLOUi6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 15 Dec 2021 15:38:58 -0500
Received: from elephants.elehost.com ([216.66.27.132]:55113 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbhLOUi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 15:38:58 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BFKckHX030589
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 Dec 2021 15:38:47 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jacob Vosmaer'" <jacob@gitlab.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        <avarab@gmail.com>, <peff@peff.net>
References: <YbizfdGq+RSu9BGe@coredump.intra.peff.net> <20211214194626.33814-1-jacob@gitlab.com> <20211214194626.33814-2-jacob@gitlab.com> <xmqqa6h16414.fsf@gitster.g> <003001d7f1ee$48c88410$da598c30$@nexbridge.com> <CADMWQoPUEMGvhg-gqZHvsModKGomTYOP7h0SGv=9CaLMJdEm0g@mail.gmail.com>
In-Reply-To: <CADMWQoPUEMGvhg-gqZHvsModKGomTYOP7h0SGv=9CaLMJdEm0g@mail.gmail.com>
Subject: RE: [PATCH v2 1/1] upload-pack.c: increase output buffer size
Date:   Wed, 15 Dec 2021 15:38:40 -0500
Organization: Nexbridge Inc.
Message-ID: <003301d7f1f3$c1e24f20$45a6ed60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIouFwJmPFhmz4Fe3UZ8hmRUMo3gwJyt/wXAnwpaG4BGKhHDAG5f57uAcRI1QGrRkn0MA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 15, 2021 3:24 PM, Jacob Vosmaer wrote:
> To: rsbecker@nexbridge.com
> Cc: Junio C Hamano <gitster@pobox.com>; git@vger.kernel.org;
> avarab@gmail.com; peff@peff.net
> Subject: Re: [PATCH v2 1/1] upload-pack.c: increase output buffer size
> 
> On Wed, Dec 15, 2021 at 8:59 PM <rsbecker@nexbridge.com> wrote:
> 
> > This is likely to break NonStop as our sideband packet size is less
> > than 64K.
> 
> Could you elaborate on what you expect to break?

The maximum I/O size on the platform is 56Kb. Anything larger will fail. That's why we use xread and xwrite for non-buffered I/O.
-Randall

