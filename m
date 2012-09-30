From: Hugh Esco <hesco@yourmessagedelivered.com>
Subject: bug report, v1.7.12.1 -- Documentation/git-bundle.xml:130: parser
 error
Date: Sun, 30 Sep 2012 03:08:19 -0400
Organization: YourMessageDelivered.com
Message-ID: <20120930030819.b5195ee0.hesco@yourmessagedelivered.com>
Reply-To: hesco@yourmessagedelivered.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 09:09:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIDf5-0001MM-Dl
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 09:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab2I3HJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 03:09:49 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:47707 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab2I3HJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 03:09:49 -0400
Received: from homiemail-a30.g.dreamhost.com (mailbigip.dreamhost.com [208.97.132.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id D903CDC478
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 00:09:48 -0700 (PDT)
Received: from homiemail-a30.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a30.g.dreamhost.com (Postfix) with ESMTP id C15E921DE58
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 00:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=yourmessagedelivered.com;
	 h=date:from:to:subject:message-id:reply-to:mime-version
	:content-type:content-transfer-encoding; s=
	yourmessagedelivered.com; bh=8vx6wZ8yTNj14aEuhHuaFTGorZQ=; b=lPY
	sxBoEnlf3BMvYNvGXQJG8lZRvlKdu/l+Wszxv5CrqnwmhW8EZo6nBsAHPyZmf9J7
	vl1K+A52PEuP4Ti/te9GwtPyFnk93uCY+ozFYfnxRhXQ4eV0eBix1+PlWpVGtk6M
	D5Eq2y6pHZRVm8s5Mh2pabsTa+PkivT1efeIvtHs=
Received: from debianmarcus9.campaignfoundations.com (c-174-48-250-91.hsd1.fl.comcast.net [174.48.250.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: hesco@yourmessagedelivered.com)
	by homiemail-a30.g.dreamhost.com (Postfix) with ESMTPSA id 6235821DE57
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 00:09:08 -0700 (PDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206670>

doing a source install of git v1.7.12.1, 
on the `make all doc` step, I get:

xmlto: input does not validate (status 1)
/usr/local/git-git-51993a4/Documentation/git-bundle.xml:130: parser error : Opening and ending tag mismatch: subscript line 130 and literal
such as <literal>master<subscript>1</literal> cannot be packaged, but are perfec
                                             ^
/usr/local/git-git-51993a4/Documentation/git-bundle.xml:134: parser error : Opening and ending tag mismatch: literal line 134 and subscript
specified explicitly (e.g. <literal>^master</subscript>10</literal>), or implici
                                                       ^
make[1]: *** [git-bundle.1] Error 1
make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
make: *** [doc] Error 2

-------------------------------------------
and the patch which permitted me to proceed
-------------------------------------------

130c130
> such as <literal>master</literal><subscript>1</subscript> cannot be packaged, but are perfectly suitable for
---
< such as <literal>master<subscript>1</literal> cannot be packaged, but are perfectly suitable for

134c134
> specified explicitly (e.g. <literal>^master</literal><subscript>10</subscript>), or implicitly (e.g.
---
< specified explicitly (e.g. <literal>^master</subscript>10</literal>), or implicitly (e.g.

-------------------------------------------
-------------------------------------------

Next bug encountered with:
Documentation/git-check-ref-format.xml

details to follow in next email.

-- 
Hugh Esco 
404-424-8701
YourMessageDelivered.com
Keeping Your Group in the Loop
No Matter How Large or How Small
