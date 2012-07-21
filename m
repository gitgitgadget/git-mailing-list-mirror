From: Nick <oinksocket@letterboxes.org>
Subject: Re: git with large files...
Date: Sat, 21 Jul 2012 22:04:52 +0100
Message-ID: <500B1974.5070508@letterboxes.org>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com> <86fw8mf3gp.fsf@red.stonehenge.com> <CACPiFC+a=46n-igTUBSDdpgDQyL4cz5vrcpurNBSsb+D1c0UnA@mail.gmail.com> <CAJDDKr5vZz_DepYKvdu34G60fmm8V_Sv8FU+J6O-DLoum07+jA@mail.gmail.com> <CA+EOSBk8XjA5=BO_kVOmfCPT-n2vKV1rbqUHnOnGi-ORF7wKLw@mail.gmail.com> <CACPiFCLTPi5i3RZHwOD-+OJ_zSbtOwe7VLy=NMO1MUKPVyPHEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Darek Bridges <darek.bridges@me.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 23:05:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsgrE-0006fd-W3
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 23:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab2GUVEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 17:04:54 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37852 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751570Ab2GUVEx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2012 17:04:53 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 51CC9209E8;
	Sat, 21 Jul 2012 17:04:52 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 21 Jul 2012 17:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=letterboxes.org;
	 h=message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=mesmtp;
	 bh=AOq375VP1TWGdPMzZI7wONJzaH8=; b=UJ84Cji4sfsw+umjO4BDWBvq9pId
	2xFwp0+KuD7TPQ2o0xm17uw5t8hBlUcd08RmZc9SGlMnr8l9l2gj5lwM176LVyXu
	vcidyW0dgHj33K/k6gLcyhJNQRWkJyMsjPmaD0TUgHXPiQ1ghUF2toWBvljhypAG
	MXqLQ9Zs1RRbtx8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=AOq375VP1TWGdPMzZI7wON
	JzaH8=; b=uG5C+Mlw19xz8sAXroLBVeMKRCDGD5z+qK1SfQwuiJSrui7HAJUcmG
	Wn1lwQqZ1HIAaayhf1ITBdsrPf3Duxjru2Eh5QzSA3tDiyb63DWonILpLLmMeNyT
	/hxwHfTVCnWpApZXHBGrUa+8L95ZgqphISrP/oPlm8tOlMJDZujNA=
X-Sasl-enc: q/34V2RtUHAcozZrcLkx+tQX8Yw0fpCi2debrn24DrRu 1342904691
Received: from [192.168.0.103] (unknown [87.194.154.6])
	by mail.messagingengine.com (Postfix) with ESMTPA id A0676483525;
	Sat, 21 Jul 2012 17:04:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <CACPiFCLTPi5i3RZHwOD-+OJ_zSbtOwe7VLy=NMO1MUKPVyPHEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201831>

On 21/07/12 15:42, Martin Langhoff wrote:
> On Sat, Jul 21, 2012 at 3:11 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
>> Well, many folks use puppet in serverless configuration pushing the
>> manifest from a central git server via cron and applying locally the
>> configuration fetched. In this sense git IS used for deployement. And,
>> for a configuration management system as puppet this could be a
>> sensible thing to do - reduce load, scalability ecc.
> 
> That's a great thing to know, and timely too. I am looking at Puppet,
> and worried a bit about reported memory load on the server side (and
> some rumours of memory footprint issues on the client side too).
> 
> Can you point me to more information & discussion?

We use "masterless" puppet, deployed using gitolite post-receive hooks.  The
most useful clues I found are here.

 http://groups.google.com/group/puppet-users/browse_thread/thread/ed9a4032b31bd8d4/e1a68aa8ea91305d

 http://semicomplete.com/presentations/puppet-at-loggly/puppet-at-loggly.pdf.html

 http://current.workingdirectory.net/posts/2011/puppet-without-masters/

 http://bitfieldconsulting.com/scaling-puppet-with-distributed-version-control

We had to join the dots ourselves. Works for us so far, but it's only about six
months old.  We don't have lots of servers or very exacting requirements, just a
inclination against the pull orthodoxy and the freedom to experiment. Can't
comment about memory footprint, except it's not been a problem for us.  (On the
other hand I am not that enamoured with Puppet's DSL design, I might prefer to
avoid it if I could.)


N
