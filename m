From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 08 Jun 2010 17:56:00 +0200
Message-ID: <4C0E6810.3070301@viscovery.net>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>	<1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>	<AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>	<20100608053507.GB15156@coredump.intra.peff.net>	<AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>	<4C0E5103.7030501@viscovery.net> <AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 18:28:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM1ex-0004u4-Vy
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 18:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab0FHQ2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 12:28:10 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:35646 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755061Ab0FHQ2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 12:28:08 -0400
Received: from bsmtp.bon.at (unknown [172.18.12.54])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 4A582119431
	for <git@vger.kernel.org>; Tue,  8 Jun 2010 17:56:55 +0200 (CEST)
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 00F8A2C401F;
	Tue,  8 Jun 2010 17:56:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148686>

Am 08.06.2010 16:39, schrieb Dario Rodriguez:
> On Tue, Jun 8, 2010 at 11:17 AM, Johannes Sixt<j.sixt@viscovery.net>  wrote:
>>   $ GIT_PAGER=/is/not/there git log
>>   $ echo $?
>>   141
>>
>> That's SIGPIPE, just as I would expect.
>
> As I said in the original thread...
>
> $ PAGER=/nothing/here ../git log
> $ echo $?
> 0

That's no surprise with your toy repository: git-log has run to completion 
(without overrunning the pipe buffer) before the pager process that it 
forked can even execute its first instruction.

> btw: I still think 'more' is much more sane fallback default than
> 'less'... look (with your patch applied):
>
> $ ../git log
> error: cannot run less: No such file or directory
> commit 3274a12f940680612e3bfd3d022a0eab460c0f1f
> Author: #######<#######@Maquina01.(none)>
> Date:   Thu Jun 3 20:02:23 2010 +0200
>
>      OtherCom
>
> commit acf110f7c878a37e4a5af8499134df28da0e8ab3
> Author: #######<#######@Maquina01.(none)>
> Date:   Thu Jun 3 20:01:37 2010 +0200
>
>      inicial
>

How is this an argument for 'more'? (Just asking; I don't see your point.)

-- Hannes
