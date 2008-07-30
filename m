From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 1/3] git-gui: Adapt discovery of oguilib to execdir 'libexec/git-core'
Date: Wed, 30 Jul 2008 07:39:57 +0200
Message-ID: <59D4282F-7744-4FE2-92FC-11E72386BDEF@zib.de>
References: <1217177383-25272-1-git-send-email-prohaska@zib.de> <1217177383-25272-2-git-send-email-prohaska@zib.de> <20080727212405.GA10075@spearce.org> <AF6C526A-57ED-4386-A4CF-5260D82026B7@zib.de> <20080730052517.GF7225@spearce.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 07:41:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO4R5-0005JC-NW
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 07:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbYG3FkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 01:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbYG3FkS
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 01:40:18 -0400
Received: from mailer.zib.de ([130.73.108.11]:34097 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbYG3FkR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 01:40:17 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6U5e37t009238;
	Wed, 30 Jul 2008 07:40:08 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db94fee.pool.einsundeins.de [77.185.79.238])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6U5e2D8011340
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 30 Jul 2008 07:40:03 +0200 (MEST)
In-Reply-To: <20080730052517.GF7225@spearce.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90746>


On Jul 30, 2008, at 7:25 AM, Shawn O. Pearce wrote:

> Steffen Prohaska <prohaska@zib.de> wrote:
>> Isn't only the computation of sharedir based on gitexecdir wrong?
>>
>>> ifndef sharedir
>>> 	sharedir := $(dir $(gitexecdir))share
>>
>> and could be replaced with this (instead of your patch):
>>
>> ifndef sharedir
>> +ifeq (git-core,$(notdir $(gitexecdir)))
>> +       sharedir := $(dir $(patsubst %/,%,$(dir $(gitexecdir))))share
>> +else
>>        sharedir := $(dir $(gitexecdir))share
>> endif
>> +endif
>
> Oh, damn good catch.  Thanks.
>
> How about this then?  Its your patch above, my message, and me
> forging your SOB...

looks good.  SOB ok.

Thanks,
Steffen
