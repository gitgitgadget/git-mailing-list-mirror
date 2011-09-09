From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: RFD: leveraging GitHub's asciidoc rendering for our Documentation/
Date: Fri, 09 Sep 2011 16:34:03 +0200
Message-ID: <4E6A23DB.1040606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 09 16:34:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R229o-0000gz-Dr
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 16:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759018Ab1IIOeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 10:34:09 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:49077 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759083Ab1IIOeG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 10:34:06 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4543025200
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 10:34:06 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 09 Sep 2011 10:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:content-type:content-transfer-encoding; s=smtpout; bh=F
	18weCQliwntM9iBLLKKkdfi1Vo=; b=qoqaAxAKFOK6T5vPSUVuh/1FE1L0Sbasf
	BruSN4Kce08ljcouYBsBfzca38IwTi0rG1x3Wkd7HZvd1KGFZ7I4pwsKE0hTLWeO
	5TZDOF3aLwsAlEIXm+KlIju1sv95aiz8A/i6aqOVdUasZjeOd3VZA7DpvKFLbwPg
	74xMU8WX0U=
X-Sasl-enc: rDopdXTWwQ9WtpvQ3Ggpf0ETgxijMHzJWB59Y1te/nk1 1315578845
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 93E8876032C
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 10:34:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181073>

Hi there,

I've been looking more to GitHub lately and was wondering whether it is
worth to leverage their automatic asciidoc rendering for our asciidoc
files. I have put up a test tree at

https://github.com/gitigit/git/tree/githubtest

which has all the renaming (*.txt -> *.asciidoc) and Makefile and script
changes, but is missing some include changes (because include breaks
anyway, see below).

The simple renaming already gives a rendered display of blobs for
simpler asciidoc files like release notes

https://github.com/gitigit/git/blob/githubtest/Documentation/RelNotes/1.7.7.asciidoc

and api documentation

https://github.com/gitigit/git/blob/githubtest/Documentation/technical/api-credentials.asciidoc

For the man pages, there are several problems as can be seen here:

https://github.com/gitigit/git/blob/githubtest/Documentation/git-blame.asciidoc

Our own customisation is not loaded (of course) so that, e.g., the
linkgit macro does not work; and the include statement makes GitHub's
parser unhappy and choke.

Does anybody feel this is worth pursuing?

+ Nicer blob view
+ Simpler way to judge documentation changes
- Need to get our asciidoc config in there
- GitHub's parser neeeds to learn include

Michael
