From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: A few "linked checkout" niggles
Date: Fri, 17 Jul 2015 14:27:29 +0200
Message-ID: <55A8F4B1.9060304@drmicha.warpmail.net>
References: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 14:27:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG4jw-0007cp-H8
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 14:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946078AbbGQM1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 08:27:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41387 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755946AbbGQM1c (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2015 08:27:32 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 1196020C0A
	for <git@vger.kernel.org>; Fri, 17 Jul 2015 08:27:32 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 17 Jul 2015 08:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=t3Jlrr0R3wh5O9DZQVzaFhHkXq8=; b=MmFcG5
	eHuJA3wSpYEJs/14CRm97yY2MUN6DYwSjnfhKa4qcM5WXT+q0RmDPYSj3V8GZ+XX
	xgVFm2t2ikAuVPjP0vfSPxYJPpGVlEa3iaMNkCPRcHQADFNk1VR6Wx8lbS53uBlZ
	HAouMr/ZJKqbZ0Tmxa3UFM7N04BtAC1ViO0UU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=t3Jlrr0R3wh5O9D
	ZQVzaFhHkXq8=; b=bVdtsRSN1cg5AHTL59mwnjr6kp67HlXNTyzQE+g3McSNcxg
	C022iWKXvu+XkCWDbstXQ5/NumN0rYGz5YgDIpXK6fvjEF34ZHpTkse1PiDHjm+Q
	JHBgEF61QJxGyOWfa8yKt+S7Q+kdT2cLff61Zq7E4rchpDqbH57GRZrS/qtI=
X-Sasl-enc: tKJaApsC4UXTlaISwL9p1xHiZ0YZAcNvNS1GBgyjGsAr 1437136051
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 578D3680179;
	Fri, 17 Jul 2015 08:27:31 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274067>

Two more observations:

$ git worktree add /tmp/gitwt
Enter /tmp/gitwt (identifier gitwt)
Switched to a new branch 'gitwt'

Now I'm in /tmp/gitwt at branch gitwt. Right? No. I'm in the original wd
at the original branch.

So either we cd to the new location or quelch these messages or add a
message that we're actually back.

The other:

linked worktrees are prefect for short term tests on detached heads.
Even the manual page advertises detach. But:

$ git worktree add  --detach /tmp/gitwtt
Enter /tmp/gitwtt (identifier gitwtt)
fatal: '--detach' cannot be used with '-b/-B/--orphan'

Maybe it's the auto-naming logic stepping on detached toes ;)

Michael
