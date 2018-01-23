Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583F41F576
	for <e@80x24.org>; Tue, 23 Jan 2018 09:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeAWJ1w (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 04:27:52 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:39913 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeAWJ1u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 04:27:50 -0500
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Tue, 23 Jan 2018 10:27:59 +0100
  id 0000000000000057.000000005A67001F.000026B5
Date:   Tue, 23 Jan 2018 10:27:49 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 5/6] convert: add 'working-tree-encoding' attribute
Message-ID: <20180123092749.GA6308@ruderich.org>
References: <20180120152418.52859-1-lars.schneider@autodesk.com>
 <20180120152418.52859-6-lars.schneider@autodesk.com>
 <20180121142222.GA10248@ruderich.org>
 <05265803-BD74-4667-ABB5-9752E55A5015@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <05265803-BD74-4667-ABB5-9752E55A5015@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 01:35:25PM +0100, Lars Schneider wrote:
>>> +	enc->name = xstrdup_toupper(value);  /* aways use upper case names! */
>>
>> "aways" -> "always" and I think the comment should say why
>> uppercase is important.
>
> Would that be better?
>
> 	/* Aways use upper case names to simplify subsequent string comparison. */
> 	enc->name = xstrdup_toupper(value);
>
> AFAIK uppercase and lowercase names are both valid. I just wanted to
> ensure that we use one consistent casing. That reads better in error messages
> and I don't need to check for the letter case in has_prohibited_utf_bom()
> and friends in utf8.c

Sounds good (minus the "Aways" typo Eric already noticed).

>> Micro-nit: For consistency with the previous test, remove the
>> empty line and comment (or just keep the files generated from the
>> "setup test repo" phase and don't explicitly delete them)?
>
> I would rather add a new line and a comment to the previous test
> to be consistent.
>
> I know we could leave the files but these lingering files could
> always surprise writers of future tests (at least they surprised
> me in other tests).

Sure, that sounds good. Just noticed the inconsistency and wanted
to mention it.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
