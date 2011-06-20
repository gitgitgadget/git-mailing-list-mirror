From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: POSIX woes in t7810.87: dash bash or bash dash?
Date: Mon, 20 Jun 2011 11:58:28 +0200
Message-ID: <4DFF19C4.5070003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 11:58:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYbFd-00047E-Rx
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 11:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab1FTJ6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 05:58:31 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:39144 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753169Ab1FTJ6a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2011 05:58:30 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 41BB7206AE
	for <git@vger.kernel.org>; Mon, 20 Jun 2011 05:58:30 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 20 Jun 2011 05:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=KfnySvQYQkOckB+bihS8IOXMYpQ=; b=Ec5gN/IdokaPMbrEZ84HHuxrYCIppA1CXaASL3NQc6WtjsUoUApzJAvvgXGtDoMA0Zo7UwBQtmbpk5VEmO/gkh16ICVyfrMKeaffxgj93GW4D5yp7090s8rFeNA2mKDcUipgulzf3eyZTlEjaDH5yaOd/QK7GbKskrEroJGiDb8=
X-Sasl-enc: c6J9BLIf1OJJgRKDamo2W8UeGK+l2f7GSc+STYqSp+kp 1308563910
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DB0DC402B59
	for <git@vger.kernel.org>; Mon, 20 Jun 2011 05:58:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176059>

GNU bash, Version 4.2.10(1)-release (x86_64-redhat-linux-gnu):

echo "a\"b\n\"c"
a"b\n"c

dash-0.5.6:

echo "a\"b\n\"c"
a"b
"c

t7810.87 breaks with dash because of this. Escaping the \n does not make
the test work with both either. So I'd like to know which one's right
and (independently) how to make it work for both...

Cheers,
Michael
