From: Michael J Gruber <michaeljgruber+moznews@fastmail.fm>
Subject: Re: fast forward a branch from another
Date: Thu, 12 May 2011 17:31:33 +0200
Message-ID: <4DCBFD55.9050005@fastmail.fm>
References: <BANLkTi=PtkDp8PNdMNi3hTwHPjFg+Jtftw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 17:31:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKXrZ-0007fx-M7
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 17:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab1ELPbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 11:31:36 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:52629 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755208Ab1ELPbg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2011 11:31:36 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8EA8B20717;
	Thu, 12 May 2011 11:31:35 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 12 May 2011 11:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LcOKggZQvMato0djVT87gJg++TA=; b=ALx+X7Ml+soXys1b0Z5ObMCVyDEnHoqyuXOLPwetdvisQn7Vk0GyloglTNkL8kRFkAjh/24Pxb2C7kon4cv4F+P9dI4+IcCqmABjtCvW87KfgM+jl/88qAiWSVvene+99WIcj6EZXKz7cGRxkfhkYPMuOjLUzZTo2R1UikuArso=
X-Sasl-enc: IhTpcSiq1XcVPYrA+wQ2DdMYpdPN/jQ7isoAjQwrGcqd 1305214295
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ECC8F4036FA;
	Thu, 12 May 2011 11:31:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BANLkTi=PtkDp8PNdMNi3hTwHPjFg+Jtftw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173476>

Eric Frederich venit, vidit, dixit 12.05.2011 16:40:
> Often times I get into a situation where I have a "development" branch
> that gets ahead of say a "stable" branch.
> When I am ready to call the development branch stable this is what I do.
> 
> $ git checkout stable
> $ git merge development
> $ git checkout development
> 
> The problem here is that the act of going backwards (via checking out
> stable) really messes up my IDE and or Text editors.
> Is there any way to do this without switching branches, which modifies
> my working directory, which messes up my IDE?

I assume this is a ff-situation, i.e. stable is fully contained in
developement? then you can reset branch stable like this:

test 0 -eq $(git rev-list  --count ^development stable) && git branch -f
stable development

(I thought you could git rev-list --quiet but I'm too dumb :|)

Michael
