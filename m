From: Hugh Esco <hesco@yourmessagedelivered.com>
Subject: bug report, v1.7.12.1 -- Documentation/git-remote-helpers.xml:135:
 element literal: validity error
Date: Sun, 30 Sep 2012 03:56:37 -0400
Organization: YourMessageDelivered.com
Message-ID: <20120930035637.fb5d0fc1.hesco@yourmessagedelivered.com>
Reply-To: hesco@yourmessagedelivered.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 09:57:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIEPB-0002GQ-VJ
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 09:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab2I3H51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 03:57:27 -0400
Received: from caiajhbdcbbj.dreamhost.com ([208.97.132.119]:59430 "EHLO
	homiemail-a95.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752384Ab2I3H50 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Sep 2012 03:57:26 -0400
Received: from homiemail-a95.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a95.g.dreamhost.com (Postfix) with ESMTP id 727FC1E05C
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 00:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=yourmessagedelivered.com;
	 h=date:from:to:subject:message-id:reply-to:mime-version
	:content-type:content-transfer-encoding; s=
	yourmessagedelivered.com; bh=XRuPzLkkivc0Y7J221ekQiIrivM=; b=KBT
	gu8QI4+ED/QemPhraN7ze2YWcWFigPH4+IJsXazYKIuCop7ptf78wZMkoXOQeflW
	WNm8h2NuIxrWFXW/Ll0tLz59FuBawgHGlTvQNAFbIbPTLU9Nbr5hvt35OD5VW+/n
	5tv5lGpAH1SyPqjwaBcB5oFQQQVGJW+snqdSvva0=
Received: from debianmarcus9.campaignfoundations.com (c-174-48-250-91.hsd1.fl.comcast.net [174.48.250.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: hesco@yourmessagedelivered.com)
	by homiemail-a95.g.dreamhost.com (Postfix) with ESMTPSA id 361211E059
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 00:57:26 -0700 (PDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206678>

doing a source install of git v1.7.12.1, 
on the `make all doc` step, I get:

    XMLTO git-remote-helpers.1
xmlto: input does not validate (status 3)
/usr/local/git-git-51993a4/Documentation/git-remote-helpers.xml:135: element literal: validity error : Element emphasis is not declared in literal list of possible children
/usr/local/git-git-51993a4/Documentation/git-remote-helpers.xml:144: element literal: validity error : Element emphasis is not declared in literal list of possible children
/usr/local/git-git-51993a4/Documentation/git-remote-helpers.xml:246: element literal: validity error : Element emphasis is not declared in literal list of possible children
/usr/local/git-git-51993a4/Documentation/git-remote-helpers.xml:255: element literal: validity error : Element emphasis is not declared in literal list of possible children
Document /usr/local/git-git-51993a4/Documentation/git-remote-helpers.xml does not validate
make[1]: *** [git-remote-helpers.1] Error 3
make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
make: *** [doc] Error 2

-------------------------------------------
and the patch which permitted me to proceed
-------------------------------------------

135c135
< <literal>refspec refs/heads/:refs/svn/origin/branches/</literal>
---
> <literal>refspec refs/heads/<emphasis role="strong">:refs/svn/origin/branches/</emphasis></literal>
144c144
< there is an implied <literal>refspec :</literal>.</simpara>
---
> there is an implied <literal>refspec <emphasis role="strong">:</emphasis></literal>.</simpara>
246c246
< <literal>refspec refs/heads/:refs/svn/origin/branches/</literal>
---
> <literal>refspec refs/heads/<emphasis role="strong">:refs/svn/origin/branches/</emphasis></literal>
255c255
< there is an implied <literal>refspec :</literal>.</simpara>
---
> there is an implied <literal>refspec <emphasis role="strong">:</emphasis></literal>.</simpara>

-- 
Hugh Esco 
404-424-8701
YourMessageDelivered.com
Keeping Your Group in the Loop
No Matter How Large or How Small
