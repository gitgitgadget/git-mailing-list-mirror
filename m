Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD9F020248
	for <e@80x24.org>; Wed, 27 Feb 2019 19:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfB0TyH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 27 Feb 2019 14:54:07 -0500
Received: from elephants.elehost.com ([216.66.27.132]:39057 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfB0TyH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 14:54:07 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1RJrv55061983
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 14:53:57 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Sixt'" <j6t@kdbg.org>,
        "=?UTF-8?Q?'Michal_Such=C3=A1nek'?=" <msuchanek@suse.de>
Cc:     <git@vger.kernel.org>
References: <001e01d4ce9c$eff07400$cfd15c00$@nexbridge.com> <20190227150836.495f1692@kitsune.suse.cz> <000001d4ceb4$b930df50$2b929df0$@nexbridge.com> <20190227171103.4cbc735a@kitsune.suse.cz> <000a01d4ceb8$3cd19720$b674c560$@nexbridge.com> <20190227172841.3a74fa60@kitsune.suse.cz> <000b01d4ceba$39cfddf0$ad6f99d0$@nexbridge.com> <20190227175135.4392e9d7@kitsune.suse.cz> <001101d4cebe$7119a080$534ce180$@nexbridge.com> <20190227181458.4f019d91@kitsune.suse.cz> <001b01d4cec3$364149e0$a2c3dda0$@nexbridge.com> <20190227185044.120c0ba7@kitsune.suse.cz> <002501d4cec6$2a5e5a20$7f1b0e60$@nexbridge.com> <20190227191814.054c2f3c@kitsune.suse.cz> <003301d4cecd$4bced250$e36c76f0$@nexbridge.com> <d3b76f4f-29b7-663e-ca3b-c15b1345a133@kdbg.org>
In-Reply-To: <d3b76f4f-29b7-663e-ca3b-c15b1345a133@kdbg.org>
Subject: RE: Need multibyte advice - Shift-JIS
Date:   Wed, 27 Feb 2019 14:53:50 -0500
Message-ID: <004601d4ced6$2c6692f0$8533b8d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHTicsscbHaF10FfRV1Fywnm3yWvQI6Vn4cAU1TeogAvaPrzgJNYIqVAiFSY3EB0BWivQJ1IT1oAi/nFNcBwefUwQCu/1jjAZLyU/0BVY4EjQHabncGAoqBMNACITQLDaUeUxzQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 27, 2019 14:36, Johannes Sixt wrote:
> Am 27.02.19 um 19:50 schrieb Randall S. Becker:
> > On February 27, 2019 13:18, Michal Suchánek wrote:
> >> What are your requirements, exactly?
> > Source code and comments contain SJIS content. The requirement is to
> > be able to move seamlessly in and out of git, and have git
> > show/diff/log display SJIS as well as ASCII content. How that happens
> > is open. The
> > UTF-16 is a red-herring, only as an attempt at getting at SJIS content
> > differently than the limitation imposed by less.
> 
> When your file content contains ShiftJIS, you should set an attribute in
> .gitattributes:
> 
> *.sourcecode	encoding=ShiftJIS
> 
> When your git commits messages contain ShiftJIS, you should configure
> 
>  git config i18n.commitEncoding ShiftJIS
> 
> More precisely, this assumes that your editor that composes to commits
> messages writes the .git/COMMIT_MSG in ShiftJIS.
> 
> When your terminal or pager is configured that it interprets the byte stream
> that it receives from applications for display as ShiftJIS, then you should
> configure
> 
>  git config i18n.logOutputEncoding ShiftJIS
> 
> You can set this independently from the other settings. In particular, when it
> is not set, UTF-8 is assumed. That is, if your terminal or pager supports UTF-
> 8, you should *NOT* set this configuration (or set it to UTF-8).
> 
> And, of course, you must have built Git with iconv, which must have support
> for ShiftJIS.

Thanks. I will forward this along and check the iconv build and rev-level we have used in git. Many thanks.


