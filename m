From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Mon, 15 Feb 2016 22:39:52 +0000
Message-ID: <56C253B8.1070702@ramsayjones.plus.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
 <1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
 <56C244D7.1030503@ramsayjones.plus.com>
 <20160215214049.GA10094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	sschuberth@gmail.com, sunshine@sunshineco.com, hvoigt@hvoigt.net,
	sbeller@google.com, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 23:40:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVRoT-0002pi-AP
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 23:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbcBOWkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 17:40:06 -0500
Received: from avasout07.plus.net ([84.93.230.235]:37655 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbcBOWj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 17:39:57 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id Jmft1s0044mu3xa01mfutf; Mon, 15 Feb 2016 22:39:55 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=ZnfBLkw0K6DMxoGhM0oA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160215214049.GA10094@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286281>



On 15/02/16 21:40, Jeff King wrote:
> On Mon, Feb 15, 2016 at 09:36:23PM +0000, Ramsay Jones wrote:
> 
>>> +test_expect_success '--show-origin stdin' '
>>> +	cat >expect <<-\EOF &&
>>> +		stdin:	user.custom=true
>>
>> So, as with the previous patch, I think this should be:
>> 		file:<stdin>	user.custom=true
> 
> That's ambiguous with a file named "<stdin>", which was the point of
> having the two separate prefixes in the first place.
> 
> I think in practice we _could_ get by with an ambiguous output (it's not
> like "<stdin>" is a common filename), but that was discussed earlier in
> the thread, and Lars decided to go for something unambiguous.

sure, I just don't think it would cause a problem in practice.
How about using '-' for <stdin>? Hmm, you can actually create
such a file in the filesystem! Oh well, I guess its not a big deal.

> 
> That doesn't necessarily have to bleed over into the error messages,
> though (which could continue to use "<stdin>" if we want to put in a
> little extra code to covering the cases separately.

Yep.

ATB,
Ramsay Jones
