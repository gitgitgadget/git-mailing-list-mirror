From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-remote: distinguish between default and configured
 URLs
Date: Wed, 16 Jan 2013 11:27:06 +0100
Message-ID: <50F6807A.6080800@drmicha.warpmail.net>
References: <7v4nii5tp2.fsf@alter.siamese.dyndns.org> <a5bf3511b3ecf4e9243d550d11ab977f95ecea30.1358331096.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 11:27:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvQDS-0000pl-CL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 11:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758757Ab3APK1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 05:27:08 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54825 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758678Ab3APK1G (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 05:27:06 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C079420B65;
	Wed, 16 Jan 2013 05:27:05 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 16 Jan 2013 05:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=LJLFDouZ0KM5bhVabeQSar
	oJy4w=; b=hYKXHu5SkyMWYwxtI0+Y+Q485MjHVTmZTvXMQxC3eHYhLnitj008YL
	H5SqqdDDH4QaC6mBZ3fdS7ZgErKzp9c1cCuuLtCh9St0APvki9CuIXnlta8WNcS+
	szTJ83Nl0o2kZXkuIGM0PYR4MXzq/RuvMwvoVd36OWeApaeDy6SEY=
X-Sasl-enc: bf+bRl2DhDgymGoHdC70OwZ3XC/Hlrv+EBYswE5g2KLT 1358332025
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EEF6D8E0801;
	Wed, 16 Jan 2013 05:27:04 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <a5bf3511b3ecf4e9243d550d11ab977f95ecea30.1358331096.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213744>

Michael J Gruber venit, vidit, dixit 16.01.2013 11:14:
> The current output of "git remote -v" does not distinguish between
> explicitly configured push URLs and those coming from fetch lines.
> 
> Revise the output so so that URLs are distinguished by their labels:
> 
> (fetch): fetch config used for fetching only
> (fetch/push): fetch config used for fetching and pushing
> (fetch fallback/push): fetch config used for pushing only
> (fetch fallback): fetch config which is unused
> (push): push config used for pushing
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Maybe something like this? It even seems to make the code in get_one_entry
> clearer.
> 
> I yet have to look at the tests, doc and other git-remote invocations.

Okay, so "git remote show remotename" copied the logic from "git remote
-v" but neither reused the code nor the output format. I guess we'd have
to implement the new logic and keep the old format? Refactoring would
require settling on a common format. Both outputs should be
ui-as-ui-can, but I'm afraid people are still grepping the output in
their scripts :(

Michael
