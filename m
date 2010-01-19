From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Branch merge bug
Date: Tue, 19 Jan 2010 14:58:35 +0100
Message-ID: <4B55BA8B.5010600@drmicha.warpmail.net>
References: <f3271551001182322p86a02d8p8b9ceb49e930d333@mail.gmail.com> <4B55A080.7010705@drmicha.warpmail.net> <20100119123915.GB28667@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 19 15:00:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXEdD-0006DG-LI
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 15:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577Ab0ASOA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 09:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336Ab0ASOA1
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 09:00:27 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60643 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751190Ab0ASOA0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2010 09:00:26 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C5828CE0E1;
	Tue, 19 Jan 2010 09:00:25 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 19 Jan 2010 09:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Y0aiFWHu8RyIvhOlnWosunzuTjU=; b=lNWozBH3az4YxbIL3Zbl8kTI4jlboV37jtoo+olUywkWUi8FBWxlLUvdBOavAtIekmXxwICIbt4Z6O5do1hCJYS9PanESQLYGM7DHUFZjKIXIvdWf7r5Y1Jd8Ykg4+d22hJrJzdrCNe13AhRdWMeRZRPiGUM0CN2cVvY4IXHLow=
X-Sasl-enc: 8FLLqYf1sZ71KiwnObdB0TSPqQuSeKUrqpViLMj1MrLw 1263909625
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E80B74B3F5A;
	Tue, 19 Jan 2010 09:00:24 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <20100119123915.GB28667@inner.home.ulmdo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137458>

Andreas Krey venit, vidit, dixit 19.01.2010 13:39:
> On Tue, 19 Jan 2010 13:07:28 +0000, Michael J Gruber wrote:
> ...
>> If you really mean to modify and rename an existing file, then tell Git so:
>>
>> git mv fil fila
>> git commit -m 'we need a new name'
>>
>> instead of your 'git rm fil' will record your intentions (not only for
>> Git, but also for everyone else reading your log, such as you a year
>> from now) and will make the merge succeed.
> 
> The intention would only be known informally in the commit message,
> as 'git mv' just removes the old and adds the new file, and still
> leave the work to the rename detection.
> 
> Indeed, changing
>   >: git rm fil
>   >: echo asjhdajkhsdkajhs >fila
>   >: git add fila
> to
>   >: git mv fil fila
>   >: echo asjhdajkhsdkajhs >fila
>   >: git add fila
> and even to
>   >: git mv fil fila
>   >: git cm 'other mv'
>   >: echo asjhdajkhsdkajhs >fila
>   >: git add fila
> still gives the same rename/delete conflict because the rename
> detection does not look at every single commit but only at
> the total changes.

Well, the solution I proposed (mv + commit rather than rm) certainly
works for me, I tested it before. I have diff.renames=copies in my
config but I don't think it should matter.

Michael
