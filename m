From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: tip tree clone fail
Date: Sun, 12 Oct 2008 21:07:36 -0700
Message-ID: <48F2C988.1010104@zytor.com>
References: <20081010072951.GB16016@elte.hu> <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <20081012124105.GA26988@elte.hu> <48F20663.2040407@zytor.com> <20081012152427.GA4607@elte.hu> <20081012153952.GV10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, Wang Chen <wangchen@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Oct 13 06:09:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpEkK-0000ce-4b
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 06:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbYJMEIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 00:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbYJMEIP
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 00:08:15 -0400
Received: from terminus.zytor.com ([198.137.202.10]:45269 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbYJMEIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 00:08:14 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m9D47dBe013778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Oct 2008 21:07:39 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m9D47dAV006509;
	Sun, 12 Oct 2008 21:07:39 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m9D47awq023859;
	Sun, 12 Oct 2008 21:07:37 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20081012153952.GV10544@machine.or.cz>
X-Virus-Scanned: ClamAV 0.93.3/8416/Sun Oct 12 20:12:39 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98078>

Petr Baudis wrote:
> On Sun, Oct 12, 2008 at 05:24:27PM +0200, Ingo Molnar wrote:
>> hm, -tip's .git/hooks/post-update already contained this, for the last 2 
>> months:
>>
>>   exec git update-server-info
>>
>> so ... _despite_ us having this in the git repo, the HTTP protocol still 
>> does not work. Why?
> 
> I think your problem is that HTTP does not know where to look for
> objects coming from alternates; IIRC this would work if you used
> relative paths in objects/info/alternates, or you can create
> objects/info/http-alternates like
> 
> 	/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
> 	/pub/scm/linux/kernel/git/sfr/linux-next.git/objects
> 

Yes, alternates must not contain paths referencing /home/ftp.

	-hpa
