From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 5/6] t7510: test verify-commit
Date: Fri, 13 Jun 2014 14:14:57 +0200
Message-ID: <539AEB41.6090306@drmicha.warpmail.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net> <3aaf65288733117909150771cc62508f3236d107.1402655839.git.git@drmicha.warpmail.net> <20140613115125.GG14066@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 14:15:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQNy-0005eM-2Q
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbaFMMPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 08:15:03 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55181 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751310AbaFMMPB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 08:15:01 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7BCD620F41;
	Fri, 13 Jun 2014 08:14:59 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Fri, 13 Jun 2014 08:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=tWFb02uk7jy7TDJEL3f4AJ
	B5IFc=; b=XjSBOOQiZbOj6b5eQEwgLd4xz+x1Oj734giG9jrvlSST1t/Pma46l6
	xJY5cWQHP0mdK+7A2xNT5XaXMZLHWA7/G8cKq4Y3coDyRmm+XVJ6vzcOw5y4devm
	a+ejDuuICP7bNyJPT5urBWt2dnE7MiJwnKpAvIkTSJd/Qg/An1kog=
X-Sasl-enc: hbN0ZtmkVvJh7a2P9FQHQYiS6o5/OexYIFrQ1xf7RghT 1402661698
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 71F016800F2;
	Fri, 13 Jun 2014 08:14:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140613115125.GG14066@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251553>

Jeff King venit, vidit, dixit 13.06.2014 13:51:
> On Fri, Jun 13, 2014 at 12:42:47PM +0200, Michael J Gruber wrote:
> 
>>  test_expect_success GPG 'detect fudged signature' '
>>  	git cat-file commit master >raw &&
>>  
>>  	sed -e "s/seventh/7th forged/" raw >forged1 &&
>>  	git hash-object -w -t commit forged1 >forged1.commit &&
>> +	! git verify-commit $(cat forged1.commit) &&
> 
> Please use test_must_fail here (and further down), which will catch
> things like signal death.

Again, that is an issue of keeping the style of the surrounding code
(which is relatively new) vs. doing it differently. I don't mind
changing t7510 to a different style, though.

Michael
