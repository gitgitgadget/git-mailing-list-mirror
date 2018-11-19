Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469741F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 02:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeKSMdn convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 19 Nov 2018 07:33:43 -0500
Received: from elephants.elehost.com ([216.66.27.132]:12729 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeKSMdn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 07:33:43 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wAJ2BbCn062031
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 18 Nov 2018 21:11:37 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?UTF-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>
Cc:     "'Steven Penny'" <svnpenn@gmail.com>, <git@vger.kernel.org>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>        <20181118154124.GA21680@tor.lan>        <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>        <20181118171525.GA25854@tor.lan> <xmqqsgzydj6n.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgzydj6n.fsf@gitster-ct.c.googlers.com>
Subject: RE: Cygwin Git with Windows paths
Date:   Sun, 18 Nov 2018 21:11:32 -0500
Message-ID: <005801d47fad$345d5a70$9d180f50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH41KATsX/7qhjRDEgG7Ouzkp8ghwKIVmc5AYAQD80BkHSBHgDZYg/spNoei3A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf Of
> Junio C Hamano
> Sent: November 18, 2018 19:07
> To: Torsten Bögershausen <tboegi@web.de>
> Cc: Steven Penny <svnpenn@gmail.com>; git@vger.kernel.org
> Subject: Re: Cygwin Git with Windows paths
> 
> Torsten Bögershausen <tboegi@web.de> writes:
> 
> > And it may even be that we need a special handling for the "\" to be
> > treated as "/".
> 
> I do not do Windows, but is_dir_sep() needs to be tweaked if you want to do
> that.

Heavy Cygwin user here. It is used in my environment for cross-compilation. Everything should be done using / separators in Cygwin, not \. So /cygdrive/c, /cygdrive/d always prefaces the path rather than C:\ or D:\, which won't parse. It is, essentially, a bash environment, including that git completions work properly. Backslash ends up doing what it would in bash.

