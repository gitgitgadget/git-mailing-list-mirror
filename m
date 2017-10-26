Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 432EE202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 20:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbdJZUVB (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 16:21:01 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:7912 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbdJZUVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 16:21:01 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3yNJL34Y0fz5tlB;
        Thu, 26 Oct 2017 22:20:59 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id F136D306;
        Thu, 26 Oct 2017 22:20:58 +0200 (CEST)
Subject: Re: Consequences of CRLF in index?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com>
 <eda48d5e-a52c-9a39-8e55-a6828efdb3ef@kdbg.org>
 <alpine.DEB.2.21.1.1710251415040.6482@virtualbox>
 <5e962f69-f9cb-bd7e-481f-050e6239813f@kdbg.org>
 <30ED36AB-FAB1-4635-94AF-FCEC6F02CE01@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7a4396e8-7b97-9ec9-d028-c5ad29042c86@kdbg.org>
Date:   Thu, 26 Oct 2017 22:20:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <30ED36AB-FAB1-4635-94AF-FCEC6F02CE01@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.10.2017 um 13:01 schrieb Lars Schneider:
>> On 26 Oct 2017, at 09:09, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 25.10.2017 um 14:19 schrieb Johannes Schindelin:
>>> I envy you for the blessing of such a clean C++ source that you do not
>>> have any, say, Unix shell script in it. Try this, and weep:
>>> 	$ printf 'echo \\\r\n\t123\r\n' >a1
>>> 	$ sh a1
>>> 	a1: 2: a1: 123: not found
>>
>> I was bitten by that, too. For this reason, I ensure that shell scripts and Makefiles begin their life on Linux. Fortunately, modern editors on Windows, includ^Wand vi, do not force CRLF line breaks, and such files can be edited on Windows, too.
> 
> Wouldn't this kind of .gitattributes setup solve the problem?

But there is no problem. Don't have CRs in shell scripts and be done 
with it.

> 
> *     -text
> *.sh   text eol=lf

Why would that be necessary? I cannot have CRLF in shell scripts etc., 
not even on Windows. (And in addition I do not mind CR in C++ source 
code.) All I want is: Git, please, by all means, do not mess with my 
files, ever. Isn't the simplest way to achieve that to set *nothing* at 
all? Not even core.autocrlf?

-- Hannes
