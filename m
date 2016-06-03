From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: --orphan erases HEAD reflog
Date: Fri,  3 Jun 2016 22:38:18 +0200
Message-ID: <20160603203818.7654-1-szeder@ira.uka.de>
References: <f51f9df7-d6d7-3a45-736f-ca2e2c9eb2cb@textalk.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Patrik Gustafsson <pvn@textalk.se>
X-From: git-owner@vger.kernel.org Fri Jun 03 22:39:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8vrv-0003Yf-FP
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 22:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbcFCUis convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 16:38:48 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:36052 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422689AbcFCUij (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 16:38:39 -0400
Received: from x4db1ec54.dyn.telefonica.de ([77.177.236.84] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1b8vrX-0004BF-K3; Fri, 03 Jun 2016 22:38:36 +0200
X-Mailer: git-send-email 2.9.0.rc1.66.ge2c3978
In-Reply-To: <f51f9df7-d6d7-3a45-736f-ca2e2c9eb2cb@textalk.se>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1464986317.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296369>

> after running the command:
>=20
> git checkout --orphan fuleFix
>=20
> my HEAD reflog is emptied.
> I would like to have my reflog intact :)

No worries, your reflog is still intact :)  It's just the reflog
walker stopping prematurely upon encountering the null sha1 of the new
root commit's reflog entry.  Patch follows in a minute.

Of course you still won't be able to list the reflog right after 'git
checkout --orphan', because HEAD is invalid.  You have to create a new
root commit or switch to an existing branch first.


G=C3=A1bor
