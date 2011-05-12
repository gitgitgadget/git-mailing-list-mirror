From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Adds 'stash.index' configuration option
Date: Thu, 12 May 2011 09:14:09 +0200
Message-ID: <4DCB88C1.20105@drmicha.warpmail.net>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIt Mailing List <git@vger.kernel.org>,
	Git Maintainer <gitster@pobox.com>
To: David Pisoni <dpisoni@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 09:14:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKQ6D-0001MO-Qq
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 09:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab1ELHOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 03:14:12 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37046 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752218Ab1ELHOL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2011 03:14:11 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6E19E20AF8;
	Thu, 12 May 2011 03:14:11 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 12 May 2011 03:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=/cutUCv4+6D8ogx8i2AC6hDaaQY=; b=aeDdn4uVEgWdat+oqq6mFcA8z7Wizuvsbd2oBqEffsOWcig3CjvIX2YqlxrU4aKvawXvtzrc/nFkfHb4SCebGDGP+U0dKBwimVu4H1X7LHnOv7/ogyOW1BAMK5NYuN//x9w2c6tMHlw0l5BlTsgR/nfTSUAa59/E2BeFskkjgAM=
X-Sasl-enc: lUsKLz4sofdf7zt9fqQwWDy/0PviEcR6oHXXfv2REiqT 1305184451
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C47424414F2;
	Thu, 12 May 2011 03:14:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173444>

David Pisoni venit, vidit, dixit 12.05.2011 00:57:
> 
> Setting 'stash.index' config option changes 'git-stash pop|apply' to  
> behave
> as if '--index' switch is always supplied.
> 'git-stash pop|apply' provides a --no-index switch to circumvent  
> config default.

This is yet another incarnation of

foo.bar = true

meaning that command "git foo" defaults to "git foo --bar". (Admittedly,
this is about subcommands of foo.)

It has the same problems (possibly breaking scripts). But more
importantly, it inflates the code with every such incarnation we add.
Have we really agreed that we introduce these one-by-one rather than
doing something generic like

uiopts.<cmd> = <optionlist>

with which you would do

uiopts.stash = "--index"

and hopefully be script-safe (again, ignoring the subcommand issue)?

Michael
