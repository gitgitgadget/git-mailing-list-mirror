From: Phil Hord <hordp@cisco.com>
Subject: Re: ''git submodule sync'' should not add uninitialized submodules
 to .git/config
Date: Thu, 23 Jun 2011 19:06:31 -0400
Message-ID: <4E03C6F7.2010506@cisco.com>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com> <7v7h8c4nv3.fsf@alter.siamese.dyndns.org> <4E039BA7.8060302@cisco.com> <7vhb7g2pbf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Maarten Billemont <lhunath@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Andreas_K=F6hle?= =?ISO-8859-1?Q?r?= 
	<andi5.py@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 24 01:06:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZsys-0004Vo-HJ
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 01:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933959Ab1FWXGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 19:06:33 -0400
Received: from sj-iport-2.cisco.com ([171.71.176.71]:46028 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933210Ab1FWXGc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 19:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=944; q=dns/txt;
  s=iport; t=1308870392; x=1310079992;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=yFLkWg1djkksOz4t+IwQDaFCIJynR+dxUM2hDnM6E+Y=;
  b=IFegbbSbLGe04NkPv34KICkDRJvue3SfK3j0ACRtOL0n1sIbTQM0tfLH
   mQtCdfAJ6swVVhjM7wduOJIBg7wsKuDWfesMlTGV1GkjoeSrnD9jK791Z
   Zih+jMUfb/5CquX++nv7Efq8SNk/aMPjVnMB9q1hgMwxzvFP3vuCMyUqM
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EALLGA06tJXG+/2dsb2JhbABSpy13rSmde4YtBJFyhGWLRQ
X-IronPort-AV: E=Sophos;i="4.65,415,1304294400"; 
   d="scan'208";a="384854380"
Received: from rcdn-core2-3.cisco.com ([173.37.113.190])
  by sj-iport-2.cisco.com with ESMTP; 23 Jun 2011 23:06:32 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core2-3.cisco.com (8.14.3/8.14.3) with ESMTP id p5NN6Vgd012059;
	Thu, 23 Jun 2011 23:06:31 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vhb7g2pbf.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110623190631365
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176300>

On 06/23/2011 05:47 PM, Junio C Hamano wrote:
> Phil Hord <hordp@cisco.com> writes:
>
>> On 06/23/2011 10:35 AM, Junio C Hamano wrote:
>>>> Now, when I run git submodule update, it starts checking out the third
>>>> module and my workflow is broken.
>>> See 33f072f (submodule sync: Update "submodule.<name>.url" for empty
>>> directories, 2010-10-08), which introduced this behaviour.
>>>
>>> cmd_update considers anything that has submodule.<name>.url defined as
>>> "the user is interested", so I suspect "git submodule sync" should not do
>>> this.
>> What about a compromise?  Change git-submodule-sync to skip submodules
>> which are not already initialized.
> You completely lost me. How's that different from reverting 33f072f? I do
> not see a room for "compromise" here.

Your patch does what I meant, so I assume you figured out my compromise.

My patch was simpler, but I haven't tested it properly yet.

Phil
