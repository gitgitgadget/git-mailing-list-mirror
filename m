From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 4/9] gitk i18n: Initial German translation.
Date: Fri, 21 Dec 2007 11:50:25 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200712211150.25753.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 11:51:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5fT2-0001Kj-9J
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 11:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbXLUKuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 05:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbXLUKuh
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 05:50:37 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:56309 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbXLUKug (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 05:50:36 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lBLAoR6i002397
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 21 Dec 2007 11:50:27 +0100
Received: from [192.168.2.102] (p54903361.dip0.t-ipconnect.de [84.144.51.97])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lBLAoQHB031985
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Dec 2007 11:50:27 +0100
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69055>

Dear Paul,

thanks a lot for applying the i18n patches to the gitk master at 
git.kernel.org. This looks all fine, except for one mistake that slipped in: 
The character encoding of the newly added po/de.po translation was messed up. 
The file must be in UTF-8 encoding (and I submitted it this way), but the one 
that ended up in the repository is in ISO-8859 encoding.

Could you please do 

  recode latin1..utf8 po/de.po

and commit the result? Otherwise a simple "make" will fail, because when 
msgfmt tries to "compile" the de.po it rightfully complains about the file 
not being in valid utf8, although the po file header claims "Content-Type: 
text/plain; charset=UTF-8".

Thank you very much.

Christian
