From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] setup: Provide GIT_PREFIX to built-ins
Date: Tue, 24 May 2011 09:23:42 +0200
Message-ID: <4DDB5CFE.4090409@drmicha.warpmail.net>
References: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org> <1306058055-93672-1-git-send-email-davvid@gmail.com> <4DDA0044.2060207@drmicha.warpmail.net> <FE7878D1-20E4-4CD4-B3FB-96322AA75855@gmail.com> <7v8vtxweoh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Heitz?= =?ISO-8859-1?Q?mann?= 
	<frederic.heitzmann@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 09:23:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOly1-00042i-FD
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 09:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363Ab1EXHXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 03:23:44 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:47098 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753049Ab1EXHXo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2011 03:23:44 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C492E2094F;
	Tue, 24 May 2011 03:23:43 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 24 May 2011 03:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5abwdY+dO29qUMgfx6iPx4ocGto=; b=DxudcFbxqCQ+c/a1hZEBLFmGrErYmt+j6w7ufaYYvUMZ3uRPUyMapde2yHJmag6B3k0hVudarLAdMK+frJL5nBcEKwnX5GZC/eOGbISN9+xO3jexxdhe2vvEcA2HpeyPC51dk7RhiI6sSgrpL7v5vBPa0IXAYwl5aPR7Xbbhgkc=
X-Sasl-enc: 1e5ofuV/GFBeGNkzgdU3Rh0QESO4PAfEd+yBHmBOvyyY 1306221823
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1B25B40594D;
	Tue, 24 May 2011 03:23:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7v8vtxweoh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174316>

Junio C Hamano venit, vidit, dixit 23.05.2011 18:43:
> David Aguilar <davvid@gmail.com> writes:
> 
>> I guess external scripts can call rev-parse --show-prefix themselves?
> 
> That has always been the case, I think, and it shouldn't be a problem.
> 
> The real reason you want the new GIT_PREFIX for alias/hooks is otherwise
> they would not have a way to even say --show-prefix to figure it out
> themselves.
> 
>>> Overall I think it's a good change, btw. But it leaves it up to the
>>> (script) user to know whether git has actually changed the cwd or not,
>>> i.e.: Is $(pwd) where the user called us from or $(pwd)/$GIT_PREFIX?
> 
> As long as there is a way for a script to figure it out when it wants to
> know, I think it should be Ok.
> 
> Isn't it just the matter of reading --show-prefix and comparing it with
> what came in $GIT_PREFIX?

Yep, one is before and one is after any eventual cd'ing which git may
do. I just wanted to point out the difference. And the technical
difference (env var. vs. rev-parse option) is due to that difference
(and thus natural).

Michael
