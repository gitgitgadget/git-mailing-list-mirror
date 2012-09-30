From: Hugh Esco <hesco@yourmessagedelivered.com>
Subject: bug report, v1.7.12.1 -- Documentation/gitcore-tutorial.xml:824:
 parser error
Date: Sun, 30 Sep 2012 04:21:59 -0400
Organization: YourMessageDelivered.com
Message-ID: <20120930042159.cd02dc1f.hesco@yourmessagedelivered.com>
Reply-To: hesco@yourmessagedelivered.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 10:23:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIEnk-0003tU-L0
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 10:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab2I3IWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 04:22:50 -0400
Received: from caiajhbdcbbj.dreamhost.com ([208.97.132.119]:37525 "EHLO
	homiemail-a30.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752565Ab2I3IWr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Sep 2012 04:22:47 -0400
Received: from homiemail-a30.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a30.g.dreamhost.com (Postfix) with ESMTP id A27D221DE58
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=yourmessagedelivered.com;
	 h=date:from:to:subject:message-id:reply-to:mime-version
	:content-type:content-transfer-encoding; s=
	yourmessagedelivered.com; bh=bkrLjH8lKxWctBoqq+MJUb29cn0=; b=LKU
	afV+I0jb6qx+weD2oNldqw+7yijtfH5+r0+/VxC42bvQ4grb2GAz/SRWFp/9Q18r
	fB0zH4ohLr5kRa8i/vHuxfgAo1yQ+n1qo/Gd6AwTsJn4YydT2dE7GlKRw2HrTgdq
	skpODV9xLuZzjbOiWd9FfxMQ74burI9USLmvmPm4=
Received: from debianmarcus9.campaignfoundations.com (c-174-48-250-91.hsd1.fl.comcast.net [174.48.250.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: hesco@yourmessagedelivered.com)
	by homiemail-a30.g.dreamhost.com (Postfix) with ESMTPSA id 574C521DE57
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 01:22:47 -0700 (PDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206683>

doing a source install of git v1.7.12.1, 
on the `make all doc` step, I get:

    XMLTO gitcore-tutorial.7
xmlto: input does not validate (status 1)
/usr/local/git-git-51993a4/Documentation/gitcore-tutorial.xml:824: parser error : Opening and ending tag mismatch: emphasis line 824 and literal
(notice the asterisk <literal><emphasis role="strong"></literal> character), and
                                                                ^
/usr/local/git-git-51993a4/Documentation/gitcore-tutorial.xml:828: parser error : Opening and ending tag mismatch: literal line 828 and emphasis
All of them have non blank characters in the first column (<literal></emphasis><
                                                                               ^
/usr/local/git-git-51993a4/Documentation/gitcore-tutorial.xml:1263: parser error : Opening and ending tag mismatch: emphasis line 1263 and literal
ra>You will see two files, <literal>pack-<emphasis role="strong">.pack</literal>
                                                                               ^
/usr/local/git-git-51993a4/Documentation/gitcore-tutorial.xml:1263: parser error : Opening and ending tag mismatch: literal line 1263 and emphasis
teral>pack-<emphasis role="strong">.pack</literal> and <literal>pack-</emphasis>
                                                                               ^
make[1]: *** [gitcore-tutorial.7] Error 1
make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
make: *** [doc] Error 2

-------------------------------------------
and the patch which permitted me to proceed
-------------------------------------------

824c824
< (notice the asterisk <literal></literal> character), and the first column for
---
> (notice the asterisk <literal><emphasis role="strong"></literal> character), and the first column for
828c828
< All of them have non blank characters in the first column (<literal></literal>
---
> All of them have non blank characters in the first column (<literal></emphasis></literal>
1263c1263
< <note><simpara>You will see two files, <literal>pack-.pack</literal> and <literal>pack-.idx</literal>,
---
> <note><simpara>You will see two files, <literal>pack-<emphasis role="strong">.pack</literal> and <literal>pack-</emphasis>.idx</literal>,

-- 
Hugh Esco 
404-424-8701
YourMessageDelivered.com
Keeping Your Group in the Loop
No Matter How Large or How Small
