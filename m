From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: How do I make git-format-patch reject 8-bit encodings?
Date: Tue, 22 Feb 2011 00:27:19 +0000
Message-ID: <4D6302E6.1070602@freescale.com>
References: <4D62E315.7040506@freescale.com>
 <7vbp24hqez.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 01:42:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrgKt-0003ft-BK
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 01:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab1BVAmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 19:42:25 -0500
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.182]:28261
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751881Ab1BVAmZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 19:42:25 -0500
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Feb 2011 19:42:25 EST
Received: from mail50-ch1-R.bigfish.com (216.32.181.169) by
 CH1EHSOBE001.bigfish.com (10.43.70.51) with Microsoft SMTP Server id
 14.1.225.8; Tue, 22 Feb 2011 00:27:20 +0000
Received: from mail50-ch1 (localhost.localdomain [127.0.0.1])	by
 mail50-ch1-R.bigfish.com (Postfix) with ESMTP id 887D8E080B1;	Tue, 22 Feb
 2011 00:27:20 +0000 (UTC)
X-SpamScore: -9
X-BigFish: VS-9(zz146fK98dNzz1202hzzz2dh2a8h637h668h62h)
X-Spam-TCS-SCL: 1:0
X-Forefront-Antispam-Report: KIP:(null);UIP:(null);IPVD:NLI;H:mail.freescale.net;RD:none;EFVD:NLI
Received: from mail50-ch1 (localhost.localdomain [127.0.0.1]) by mail50-ch1
 (MessageSwitch) id 1298334440417857_21778; Tue, 22 Feb 2011 00:27:20 +0000
 (UTC)
Received: from CH1EHSMHS031.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.253])	by mail50-ch1.bigfish.com (Postfix) with ESMTP id
 61D40328050;	Tue, 22 Feb 2011 00:27:20 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by CH1EHSMHS031.bigfish.com
 (10.43.70.31) with Microsoft SMTP Server (TLS) id 14.1.225.8; Tue, 22 Feb
 2011 00:27:20 +0000
Received: from 039-SN1MPN1-005.039d.mgd.msft.net ([169.254.7.102]) by
 039-SN1MMR1-003.039d.mgd.msft.net ([10.84.1.16]) with mapi id 14.01.0270.002;
 Mon, 21 Feb 2011 18:27:19 -0600
Thread-Topic: How do I make git-format-patch reject 8-bit encodings?
Thread-Index: AcvSFEz0K44fu7yxS6KVc6Qp/xb/LQAEdxTaAAzZFgA=
In-Reply-To: <7vbp24hqez.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US;
 rv:1.9.1.16) Gecko/20101123 SeaMonkey/2.0.11
x-originating-ip: [68.203.10.197]
Content-ID: <AC6457F3F7A70345973596465EFDA743@freescale.net>
X-OriginatorOrg: freescale.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167518>

Junio C Hamano wrote:
> Feels like an X-Y problem, but wouldn't it be an option to let
> format-patch write into individual files, check these files and reject
> ones that are not 8-bit clean, and then send the result out via
> send-email?  You should be proofreading the format-patch output to catch
> and fix typos before hading them to send-email anyway, so the above would
> be the natural thing to do.

The problem is that it appears that git-send-email is taking normal-looking patches and encoding them as base64, and I don't know about it until after the email is sent.  It also appears to be inconsistent.  I've seen some utf-8 patches emailed as normal text, and other patches emailed as base64.

I don't have any real problem with utf-8, but I want to prevent git-send-email from doing base64 encodings on its own.

-- 
Timur Tabi
Linux kernel developer
