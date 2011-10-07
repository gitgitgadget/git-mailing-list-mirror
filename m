From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: How pretty is pretty? git cat-file -p inconsistency
Date: Fri, 07 Oct 2011 10:44:48 +0200
Message-ID: <4E8EBC00.90909@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 07 10:44:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC635-0000TX-89
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 10:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759608Ab1JGIou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 04:44:50 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60101 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759595Ab1JGIot (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 04:44:49 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5312420D08
	for <git@vger.kernel.org>; Fri,  7 Oct 2011 04:44:49 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 07 Oct 2011 04:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:content-type:content-transfer-encoding; s=smtpout; bh=D
	kXUDyuzgZdb6z5FWJ4MOP1ltPY=; b=T1iDAkuxBzwlsoINbVtPfdXB6o7hqO/Y8
	A+67JoLZpAxYGNsUKjkGGJ0//pJ5MBQ2r80uKHF7cD5gz9ttUkejnhaQ4Ek+grli
	kRgaQmYT6hY7egc/S+uwIdXdJVdaF2k1s5ZqQ5IwC7ek2lplQfILCbSN/3uJ3zPz
	GRdJdYZVbY=
X-Sasl-enc: BOEJwTrCDY6Bc5sN2leaqu/JZiXj2jtWICUAKNjU/sdE 1317977089
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EC794C60D31
	for <git@vger.kernel.org>; Fri,  7 Oct 2011 04:44:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183066>

diff <(git cat-file -p tags/v1.7.7) <(git cat-file tag tags/v1.7.7)
4c4
< tagger Junio C Hamano <gitster@pobox.com> Fri Sep 30 14:21:06 2011 -0700
---
> tagger Junio C Hamano <gitster@pobox.com> 1317417666 -0700

vs.

diff <(git cat-file -p tags/v1.7.7^{}) <(git cat-file commit tags/v1.7.7^{})

(no diff)

That is, "cat file -p" pretty prints dates for tag objects but not for
commit objects. In fact, "-p" on commit objects does not prettify at all
compared to the raw content. Is that intentional? I'd suggest
prettifying dates with "-p" for commit objects also. But just how
plumbing is the "-p" mode of "cat-file"?

Michael
