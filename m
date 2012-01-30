From: =?iso-8859-1?Q?Thomas_R=F6fer?= <Thomas.Roefer@dfki.de>
Subject: git rebase and MacOS 10.7.2 file versions
Date: Mon, 30 Jan 2012 17:46:45 +0100
Message-ID: <A9AB7E23-3C22-4BCC-8E25-EF2D66B57E61@dfki.de>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 17:53:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RruUK-0006RK-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 17:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113Ab2A3Qxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 11:53:47 -0500
Received: from sea-mail.dfki.de ([134.96.191.185]:58153 "EHLO sea-mail.dfki.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927Ab2A3Qxr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 11:53:47 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jan 2012 11:53:47 EST
Received: from sea-mail.dfki.de (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id 6FF15A426A_F26C976B
	for <git@vger.kernel.org>; Mon, 30 Jan 2012 16:46:46 +0000 (GMT)
Received: from mail.dfki.de (lnv-104.sb.dfki.de [134.96.191.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by sea-mail.dfki.de (Sophos Email Appliance) with ESMTP id 55A709F225_F26C976F
	for <git@vger.kernel.org>; Mon, 30 Jan 2012 16:46:46 +0000 (GMT)
Received: from [10.0.1.102] (pD9FD61E7.dip.t-dialin.net [217.253.97.231])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.dfki.de (Postfix) with ESMTPSA id 25D0131093
	for <git@vger.kernel.org>; Mon, 30 Jan 2012 17:46:46 +0100 (CET)
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189374>

Hi,

I get mysterious behavior during git rebase on MacOS 10.7.x. git report=
s unresolvable conflicts, stops the rebase, but afterwards the list of =
files that needs to be fixed is empty. git rebase --skip does not help,=
 because then the commit is actually missing.

What helps is to abort the rebase, copy the conflicting files, delete t=
he originals and move back the copies instead. The files themselves are=
 identical before deleting and after restoring and their access rights =
are also unchanged. What is actually different is that all the conflict=
ing files so far had older versions stored by Lion's "file versions" fe=
ature. The restored copies do not have such a version history. Since "f=
ile versions" cannot be deactivated, editing a file with an application=
 that supports it (e.g. TextEdit) will basically result in strange git =
conflicts later.

I have tested this with a number of git versions, but the behavior is a=
lways the same.

All this may simply be a bug in MacOS 10.7.x, but maybe there is a work=
around for git to make this work again.

Best regards,

Thomas R=F6fer
