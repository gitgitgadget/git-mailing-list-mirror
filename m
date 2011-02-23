From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: gitk with the latest branch makes the system unusable for some
 time
Date: Wed, 23 Feb 2011 12:28:48 +0100
Message-ID: <4D64EF70.9060600@drmicha.warpmail.net>
References: <AANLkTim3MW0PmD5_tra4nmRapfgHJ9K_usJWGVK3AOUC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Justin Mattock <justinmattock@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 12:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsCx3-0002Ki-Di
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 12:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab1BWLcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 06:32:08 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60591 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752847Ab1BWLcG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 06:32:06 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B96682087D;
	Wed, 23 Feb 2011 06:32:05 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 23 Feb 2011 06:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=uVGbSL3jDoEpu7SC8XKJG3eex1k=; b=KmC0HRvTfZiF2smKCVWAph+/G1C69ARhPJ4Jm7Sa3ZZCUgkXLMoAVSZ69lDGWl6HEiQP8Zwk/WE0Z/0hXKa0LPlVxVtv437eV486qJNiLwxoHH5o9s/O2rCoPRs7EH2dl26hmCFFm6/iRxLfjitsJgkffOz7osjhMJFUx3ekBkg=
X-Sasl-enc: 6ah7WhFQiZjdWAgtYud5uRnGhpKQekwUPR6sOejiC9JI 1298460724
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CA4B0403F90;
	Wed, 23 Feb 2011 06:32:02 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTim3MW0PmD5_tra4nmRapfgHJ9K_usJWGVK3AOUC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167690>

Justin Mattock venit, vidit, dixit 23.02.2011 00:53:
> not sure if there is any reports of this or not, basically using gitk
> on my macbookpro2,2 makes the system extremely slow and unusable
> (after a while can finally use the system)

..and "the latest branch" is master,next or pu from when?

Is that gitk on the (which) kernel repo?

I have no trouble with gitk (today's next) on git.git (nor on the
LibreOffice beast).

> in dmesg I am seeing this:
> 
> [ 6089.363045] NetworkManager invoked oom-killer: gfp_mask=0x84d0,
> order=0, oom_adj=0, oom_score_adj=0
> [ 6089.363050] Pid: 2107, comm: NetworkManager Not tainted
> 2.6.38-rc5-00101-gebad2c2 #2
> [ 6089.363052] Call Trace:
> [ 6089.363062]  [<ffffffff810c563c>] ? T.547+0x6a/0x180
> [ 6089.363066]  [<ffffffff810c5799>] ? T.544+0x47/0x24c
> [ 6089.363070]  [<ffffffff810c5beb>] ? out_of_memory+0x24d/0x2f8
> [ 6089.363074]  [<ffffffff810c9142>] ? __alloc_pages_nodemask+0x55c/0x696
> [ 6089.363079]  [<ffffffff810dc985>] ? handle_pte_fault+0x2cd/0x73f
> [ 6089.363084]  [<ffffffff8104e522>] ? pte_alloc_one+0x1e/0x3c
> [ 6089.363088]  [<ffffffff810c8406>] ? __free_pages+0x1b/0x24
> [ 6089.363091]  [<ffffffff810ddfc1>] ? __pte_alloc+0x1d/0xcd
> [ 6089.363094]  [<ffffffff810de185>] ? handle_mm_fault+0x114/0x164
> [ 6089.363099]  [<ffffffff8144973d>] ? do_page_fault+0x3dc/0x401
> [ 6089.363104]  [<ffffffff81112eef>] ? mntput_no_expire+0x8d/0x13f
> [ 6089.363108]  [<ffffffff81112fc2>] ? mntput+0x21/0x23
> [ 6089.363112]  [<ffffffff810fb8dc>] ? fput+0x20e/0x21d
> [ 6089.363116]  [<ffffffff81446a25>] ? page_fault+0x25/0x30

So you think gitk took down your Networkmanager?

Michael
