From: "Zivkov, Sasa" <sasa.zivkov@sap.com>
Subject: Unreachable code in builtin-merge.c ?
Date: Fri, 23 Oct 2009 17:03:53 +0200
Message-ID: <B221C4384AE5104EB414A877DFD0372C0B0092C0C5@DEWDFECCR04.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 23 17:04:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1LgS-0008AR-Hr
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 17:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbZJWPDy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 11:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbZJWPDy
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 11:03:54 -0400
Received: from smtpde01.sap-ag.de ([155.56.68.171]:52371 "EHLO
	smtpde01.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbZJWPDy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 11:03:54 -0400
Received: from mail.sap.corp
	by smtpde01.sap-ag.de (26) with ESMTP id n9NF3vVZ026894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 23 Oct 2009 17:03:57 +0200 (MEST)
Thread-Topic: Unreachable code in builtin-merge.c ?
Thread-Index: AcpT8gk8v+25z+eLRaiy/0pO3nwOOA==
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, de-DE
X-Scanner: Virus Scanner virwal08
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131106>

In the try_merge_strategy function the expression in the following if s=
tatement seems to always evaluate to TRUE:

        if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtre=
e")) {

If strategy is "recursive" then !strcmp(strategy, "subtree") evaluates =
to TRUE.
If strategy is "subtree" then !strcmp(strategy, "recursive") evaluates =
to TRUE.
If strategy is neither "recursive" nor "subtree" then any side of || ev=
aluates to TRUE.

Looks like the code in the else block is unreachable?


Sa=B9a =AEivkov
