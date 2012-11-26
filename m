From: Timur Tabi <timur@freescale.com>
Subject: Re: git-fetch does not work from .git subdirectory
Date: Mon, 26 Nov 2012 10:09:18 -0600
Organization: Freescale
Message-ID: <50B3942E.2020001@freescale.com>
References: <50AC0316.7090002@freescale.com> <50AD77F3.3080702@mail.pgornicz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Patrik Gornicz <patrik-git@mail.pgornicz.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 17:09:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td1Fn-00017F-MC
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 17:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab2KZQJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 11:09:36 -0500
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:37504
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753450Ab2KZQJf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2012 11:09:35 -0500
Received: from mail37-am1-R.bigfish.com (10.3.201.239) by
 AM1EHSOBE004.bigfish.com (10.3.204.24) with Microsoft SMTP Server id
 14.1.225.23; Mon, 26 Nov 2012 16:09:34 +0000
Received: from mail37-am1 (localhost [127.0.0.1])	by mail37-am1-R.bigfish.com
 (Postfix) with ESMTP id 2BD193E0068;	Mon, 26 Nov 2012 16:09:34 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190;KIP:(null);UIP:(null);IPV:NLI;H:mail.freescale.net;RD:none;EFVD:NLI
X-SpamScore: 3
X-BigFish: VS3(z37d4lz98dIzz1de0h1202h1d1ah1d2ahzzz2dh2a8h668h839hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh162dh1631h1155h)
Received: from mail37-am1 (localhost.localdomain [127.0.0.1]) by mail37-am1
 (MessageSwitch) id 1353946172392044_23405; Mon, 26 Nov 2012 16:09:32 +0000
 (UTC)
Received: from AM1EHSMHS019.bigfish.com (unknown [10.3.201.240])	by
 mail37-am1.bigfish.com (Postfix) with ESMTP id 5DD5960045;	Mon, 26 Nov 2012
 16:09:32 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by AM1EHSMHS019.bigfish.com
 (10.3.207.157) with Microsoft SMTP Server (TLS) id 14.1.225.23; Mon, 26 Nov
 2012 16:09:23 +0000
Received: from tx30smr01.am.freescale.net (10.81.153.31) by
 039-SN1MMR1-003.039d.mgd.msft.net (10.84.1.16) with Microsoft SMTP Server
 (TLS) id 14.2.318.3; Mon, 26 Nov 2012 16:09:21 +0000
Received: from [10.82.123.3] (efes.am.freescale.net [10.82.123.3])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id qAQG9Ihg009518;	Mon,
 26 Nov 2012 09:09:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Firefox/16.0 SeaMonkey/2.13.1
In-Reply-To: <50AD77F3.3080702@mail.pgornicz.com>
X-OriginatorOrg: freescale.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210455>

Patrik Gornicz wrote:
> Just a hunch but your remote's location uses a relative path 
> '../linux-2.6.git', perhaps git is messing up what the path is relative 
> to.

That makes sense.  Git is looking at the URL and not realizing that it's
relative to the home directory.

[remote "upstream"]
	url = ../linux-2.6.git/
	fetch = +refs/heads/*:refs/remotes/upstream/*

> Note sure what the fix will be though as it'll likely break existing 
> repositories that use relative paths either way. Can you try an 
> absolute path to see if that fixes thing?

If I change that to

[remote "upstream"]
	url = /home/b04825/git/linux-2.6.git/
	fetch = +refs/heads/*:refs/remotes/upstream/*

then everything works.

IMHO, this is a bug in git.

-- 
Timur Tabi
Linux kernel developer at Freescale
