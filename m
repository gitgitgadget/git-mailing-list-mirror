Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011D1C433FE
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 02:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346596AbiAKCZU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 10 Jan 2022 21:25:20 -0500
Received: from elephants.elehost.com ([216.66.27.132]:21662 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346593AbiAKCZT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 21:25:19 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 20B2PB4l002078
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Jan 2022 21:25:11 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <rsbecker@nexbridge.com>, <git@vger.kernel.org>
References: <00ef01d80691$82df3380$889d9a80$@nexbridge.com>
In-Reply-To: <00ef01d80691$82df3380$889d9a80$@nexbridge.com>
Subject: RE: [BUG] Re: Git 2.35.0-rc0
Date:   Mon, 10 Jan 2022 21:25:06 -0500
Organization: Nexbridge Inc.
Message-ID: <00fe01d80692$75d0ce00$61726a00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGsANR0OT4W4IUHkHguGppHXx6wmqy1IxYw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Died a quick death. Someone added a call to uncompress2, which is not
POSIX-compliant.

> -----Original Message-----
> From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>
> Sent: January 10, 2022 9:20 PM
> To: 'git@vger.kernel.org' <git@vger.kernel.org>
> Subject: [BUG] Re: Git 2.35.0-rc0
> 
> Hi All,
> 
> Git 2.35.0-rc0 is not portable:
> 
> uncompress2(uncompressed + block_header_skip, &dst_len,
>                    ^
>
"/home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/reftable/bloc
> k.c", line 213: error(114):
>           identifier "uncompress2" is undefined
> 
> This is not a POSIX compliant call.
> 
> --Randall

