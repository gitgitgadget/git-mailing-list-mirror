From: Titus Barik <titus@barik.net>
Subject: Where does http.sslcainfo get set in Windows (2.6.3)?
Date: Mon, 14 Dec 2015 10:45:45 -0500
Message-ID: <1450107945.1012555.467004601.1D76923E@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: titus@barik.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 16:52:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8VQk-0008J6-Pl
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 16:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbbLNPwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 10:52:50 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:44082 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbbLNPwt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 10:52:49 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2015 10:52:49 EST
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailnew.nyi.internal (Postfix) with ESMTP id B6037A50
	for <git@vger.kernel.org>; Mon, 14 Dec 2015 10:45:45 -0500 (EST)
Received: from web4 ([10.202.2.214])
  by compute2.internal (MEProxy); Mon, 14 Dec 2015 10:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=barik.net; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=PyT
	T25tEZvhgEIODTwz//Zrl5wE=; b=AOGvSg2uba+7XxzNRVfyTeklg8Ed2q7UWa4
	tnJPZvs1Lg//VGmvcaQcAVr5pZKqDmaqmzQiYd+4qCxtQn7wExaaeXaWtmgR4lYG
	xnAvxPpwMgafvAk/Kl2YX/me+jBPVb6sLGX8aI6dXyC0SZtqXI54Y3Ha75XYbG2E
	QTIxZwso=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=PyTT25tEZvhgEIODTwz//Zrl5wE=; b=JPP0B
	Ozrp3pXcNwVO6ExWRuN+dnfYq5++Opex9E85P7Mj8E9Qhq+DHoxPuzxPx4pkQcv+
	KpWIYmZnUFxdEdRK5eRs1Ne/aXub4sr8Xu0nN2DatIHfxkt+6D2Q2h/kghwMHDb6
	QZUcMVShypzCiSAOnoexQLTI0JwDjHU4w9YIfw=
Received: by web4.nyi.internal (Postfix, from userid 99)
	id 674E1101EE7; Mon, 14 Dec 2015 10:45:45 -0500 (EST)
X-Sasl-Enc: nyXIFaNm8tEvfBAwIXOTQO+BOZbZR+RjwnJdnDHQBv0T 1450107945
X-Mailer: MessagingEngine.com Webmail Interface - ajax-5c8c9c89
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282367>

Hi all,

I'm in Windows using git version: git version 2.6.3.windows.1. Git is
installed to /c/Users/tbarik/AppData/Local/Programs/Git/cmd/git.

However, when I look for the config name http.sslcainfo, it returns:

$ git config --get-all http.sslcainfo
C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt

Although I can override the name, I'm trying to figure out where this is
being set, since the correct location should be (in this case)
C:/Users/tbarik/AppData/Local/Programs/Git/mingw64/ssl/certs/ca-bundle.crt.

I don't see C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt in
either --global, --system, or --local, hence my confusion as to where
this path is coming from.

Thanks,

Titus

-- 
Titus Barik, PE <titus@barik.net>
