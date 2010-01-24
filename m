From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: git-gui: Using "Stage To Commit" does not always stage all selected files.
Date: Sun, 24 Jan 2010 22:05:03 +0100
Organization: 
Message-ID: <201001242205.03412.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 24 22:06:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ9fY-0007SP-7g
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 22:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab0AXVGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 16:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463Ab0AXVGh
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 16:06:37 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:43062 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753320Ab0AXVGh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2010 16:06:37 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id E1E5A3FE2CE
	for <git@vger.kernel.org>; Sun, 24 Jan 2010 22:06:35 +0100 (CET)
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net [151.189.21.57])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id C0393347174
	for <git@vger.kernel.org>; Sun, 24 Jan 2010 22:06:35 +0100 (CET)
Received: from oberndorfer.lan (91-113-112-161.adsl.highway.telekom.at [91.113.112.161])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-17.arcor-online.net (Postfix) with ESMTPSA id 8FF4E3B26F2
	for <git@vger.kernel.org>; Sun, 24 Jan 2010 22:06:35 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-17.arcor-online.net 8FF4E3B26F2
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1264367195; bh=S8Ni6qdriLJO/Hm0021bpsvxeYB08W9sq3I27tPWWoc=;
	h=From:To:Subject:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id;
	b=Hx0NpjP+gEiEfMelGfO0deIioOzeFHv6z8qML0JvC1r4H+8Sezdd8Drvk3E+3JT4Q
	 iPQUlH/RWyFJjwkRGdwKG3Yn9RnyzpECz645OynWns/0RoVQoYYE5IabTlU2usfk1I
	 4CSIBHFRqWQvlFfBOPBemmALjj5xxcHBmew4hQfI=
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137919>

Hello,

Using "Stage To Commit" in git-gui does not always stage all selected files.

After startup of git-gui the first modified file is automatically selected.
Selecting another file and then using "Stage to Commit" only the second file is actually staged.

It looks like the reason for this is that selected_paths is not set when a file is automatically selected after startup/refresh/scanning.

How to reproduce:
echo >> userdiff.h
echo >> userdiff.c
git gui&
-> userdiff.c is automatically selected
hold Ctrl and select userdiff.h
Ctrl-T
-> only userdiff.h is staged, userdiff.h remains unstaged

Greetings Peter
