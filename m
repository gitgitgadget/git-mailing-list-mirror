From: Peter Hartlich <wwsgj@hartlich.com>
Subject: Wrong time in git-log when using right/ timezone
Date: Wed, 18 Jul 2007 17:36:14 +0200
Message-ID: <20070718153614.GA28815@hartlich.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 17:43:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBBgf-0005WY-Ka
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 17:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933349AbXGRPnZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 11:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933341AbXGRPnY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 11:43:24 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:50083 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933322AbXGRPnW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 11:43:22 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jul 2007 11:43:22 EDT
Received: (qmail 16399 invoked from network); 18 Jul 2007 15:36:39 -0000
Received: from unknown (HELO port-87-234-148-89.dynamic.qsc.de) (278559@[87.234.148.89])
          (envelope-sender <wwsgj@hartlich.com>)
          by smtprelay04.ispgateway.de (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 18 Jul 2007 15:36:39 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52870>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

My timezone is set to right/Europe/Berlin. git-log 1.5.2.2 gives me output
such as:

| Date:   Wed Jul 18 16:17:31 2007 +0159

Note the timezone, which should be +0200.

I'm using tzcode/tzdata 2007f from <ftp://elsie.nci.nih.gov/pub/>. A small
test script is attached.

Regards,
Peter Hartlich

--huq684BweRXVnRxX
Content-Type: application/x-sh
Content-Disposition: attachment; filename="tz.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Atztest() {=0A	echo with timezone $TZ:=0A	>foo=0A	{ git init =
&& git add foo && git commit -m foo; } >/dev/null=0A	git log | grep ^Date:=
=0A}=0A=0Aexport TZ=0A=0ATZ=3DEurope/Berlin=0A(mkdir posix && cd posix && t=
ztest)=0A=0ATZ=3Dright/Europe/Berlin =0A(mkdir right && cd right && tztest)=
=0A
--huq684BweRXVnRxX--
