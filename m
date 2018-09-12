Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1E61F404
	for <e@80x24.org>; Wed, 12 Sep 2018 20:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeIMCAO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 12 Sep 2018 22:00:14 -0400
Received: from elephants.elehost.com ([216.66.27.132]:50259 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeIMCAO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 22:00:14 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8CKroAo013950
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Sep 2018 16:53:51 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Sixt'" <j6t@kdbg.org>
Cc:     <git@vger.kernel.org>
References: <003901d44acd$12c2bb90$384832b0$@nexbridge.com> <4102803b-d5de-5812-4cef-569c9869fed1@kdbg.org>
In-Reply-To: <4102803b-d5de-5812-4cef-569c9869fed1@kdbg.org>
Subject: RE: [Question] Signature calculation ignoring parts of binary files
Date:   Wed, 12 Sep 2018 16:53:43 -0400
Message-ID: <004e01d44ada$b4a11ad0$1de35070$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL1dHr/8n7yCB9UeIXEGLjm31C4owFRfwXboqA/rpA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf
> Of Johannes Sixt
> Sent: September 12, 2018 4:48 PM
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: git@vger.kernel.org
> Subject: Re: [Question] Signature calculation ignoring parts of binary files
> 
> Am 12.09.18 um 21:16 schrieb Randall S. Becker:
> > I feel really bad asking this, and I should know the answer, and yet.
> >
> > I have a binary file that needs to go into a repo intact (unchanged).
> > I also have a program that interprets the contents, like a textconv,
> > that can output the relevant portions of the file in whatever format I
> > like - used for diff typically, dumps in 1K chunks by file section.
> > What I'm looking for is to have the SHA1 signature calculated with
> > just the relevant portions of the file so that two actually different
> > files will be considered the same by git during a commit or status. In
> > real terms, I'm trying to ignore the Creator metadata of a JPG because
> > it is mutable and irrelevant to my repo contents.
> >
> > I'm sorry to ask, but I thought this was in .gitattributes but I can't
> > confirm the SHA1 behaviour.
> 
> You are looking for a clean filter. See the 'filter' attribute in gitattributes(5).
> Your clean filter program or script should strip the unwanted metadata or set
> it to a constant known-good value.
> 
> (You shouldn't need a smudge filter.)
> 
> -- Hannes

Thanks Hannes. I thought about the clean filter, but I don't actually want to modify the file when going into git, just for SHA calculation. I need to be able to keep some origin metadata that might change with subsequent copies, so just cleaning the origin is not going to work - actually knowing the original author is important to our process. My objective is to keep the original file 100% exact as supplied and then ignore any changes to the metadata that I don't care about (like Creator) if the remainder of the file is the same.

Regards,
Randall


