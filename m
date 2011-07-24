From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] tests: print failed test numbers at the end of the
 test run
Date: Sun, 24 Jul 2011 21:21:15 +0200
Message-ID: <4E2C70AB.2060306@web.de>
References: <4E2B1DF2.4000003@web.de> <7vmxg4w2fm.fsf@alter.siamese.dyndns.org> <4E2C1FBA.3010606@web.de> <20110724153950.GB7805@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 24 21:21:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql4F0-0003vx-OG
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 21:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915Ab1GXTVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 15:21:21 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:40194 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab1GXTVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 15:21:20 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id BCD541A717710;
	Sun, 24 Jul 2011 21:21:18 +0200 (CEST)
Received: from [93.246.46.13] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Ql4Eo-0003ub-00; Sun, 24 Jul 2011 21:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <20110724153950.GB7805@sigill.intra.peff.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX196Z59sSSb+fu5EZxN94Nm9o8f/qlUprLOb0N6a
	9MljF/QMzw9uUz70G9L6X3bVPeS8PtFUioZhv7LYW2e9TPSSAl
	H0n9bX2cttC61O84HjuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177773>

Am 24.07.2011 17:39, schrieb Jeff King:
> On Sun, Jul 24, 2011 at 03:35:54PM +0200, Jens Lehmann wrote:
> 
>> Am 24.07.2011 09:41, schrieb Junio C Hamano:
>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>
>>>> Maybe I'm missing something completely obvious, but I always have a hard
>>>> time finding out which test scripts did fail in a test run with -j30.
>>>
>>> I run "ls -d t/trash*" for that ;-)
>>
>> Yup. But that won't work when you use "-i" to continue to run all tests
>> even when some fail, as all trash directories get deleted in the end. Or
>> did I manage to overlook an option which stops that? ;-)
> 
> I used to use:
> 
>   make -k -j30
>   grep 'failed [^0]' test-results/*

Ah, now I understand how I managed to shoot myself in the foot when I tried
that: I used "-i" instead of "-k" for make, so the test-results directory
always was deleted after the tests ran.

> but these days I use the "prove" tool, which has much nicer output. You
> can get Makefile support for it with:
> 
>   GIT_PROVE_OPTS = -j30
>   DEFAULT_TEST_TARGET = prove
> 
> in your config.mak.

Thanks, the output really is nicer and it even runs a bit faster! :-)
