From: =?utf-8?Q?J=C3=B6rg_B=C3=BChmann?= <joerg@evenly.io>
Subject: Bug: gitk crashes for single file with German environment
Date: Fri, 23 Oct 2015 15:32:10 +0200
Message-ID: <F43EBADE-ABBF-4CB7-A7C6-BDAA9791F7C1@evenly.io>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 23 15:32:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpcSI-0004Xs-QK
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 15:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbbJWNcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2015 09:32:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34616 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751894AbbJWNcN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 09:32:13 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id A714F209C6
	for <git@vger.kernel.org>; Fri, 23 Oct 2015 09:32:12 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 23 Oct 2015 09:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=evenly.io; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=qyy
	+2wrhqcdX+aGvxNr8n6Vcw64=; b=c0y3cfhPSSsGld2ZleUkmLWE2+RLxhtSgLv
	XDmu5IPCORIvfJk9CQzYXtAGexZVCmHKSfpSFf8uL4g84GrNNQm2wgD2yIwCOMEK
	dKDGOhZ1hlQZ9vLgBM+6ymBGD65A/J5CVeyeBRwUyXaiM8iEKM0SnnNM3ho6YL65
	53O/YAaE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=qyy+2wrhqcdX+aGvxNr8n6Vcw64=; b=U1Ake
	0Lvm0/8+vPtjAagtAdsYrkQawAnsDzKwsIvMHHf5lLqWsfJdt2l5nXs33BrwNE7P
	2BzrO7nHYUoYdki9dKjwPYPAUvP54mYxlTPgQRl9oSuW8ZJ76XwpNDpk0REK7cMm
	UxZhunQaGxVQi2dc0iBQ/I4ba7dD/pq1q29yis=
X-Sasl-enc: JfjyTcxsZlCfTBgr5VJWyiZuPdmUWcZyrpnvHr70tOsg 1445607132
Received: from thegibson.fritz.box (p5b2c4ebe.dip0.t-ipconnect.de [91.44.78.190])
	by mail.messagingengine.com (Postfix) with ESMTPA id B3A966800B6
	for <git@vger.kernel.org>; Fri, 23 Oct 2015 09:32:11 -0400 (EDT)
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280095>

gitk crashes for single file with German environment

Git 2.6.2                        =20
Installed with homebrew
Platform Apple OS X 10.10.5
shell: zsh 5.0.5 (x86_64-apple-darwin14.0)
environment: LANG=3Dde_DE.UTF-8
=20
gitk is very useful to show the commit history of one file. However it =
crashes on me.
gitk myfile
produces the following error:

Error in startup script: bad menu entry index "Ansicht bearbeiten ..."
    while executing
".bar.view entryconf [mca "Edit view..."] -state normal"
    invoked from within
"if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {=
}} {
    # create a view for the files/dirs specified on the command line
    se..."
    (file "/usr/local/bin/gitk" line 12442)

It seems the problem has to do with the start script trying to get the =
localized menu item of "Edit view..." in German "Ansicht bearbeiten ...=
" and that fails.

When I change the language in my environment=20
export LANG=3Den_US.UTF-8
everything works as expected.

If I start gitk without any arguments and German environment (LANG=3Dde=
_DE.UTF-8), it starts up fine. However the German localization is missi=
ng from the menubar, it's completely in English. Buttons and labels ins=
ide the window are localized into German properly. See screenshot http:=
//i.imgur.com/VZZljPb.png
It's apparent then, that the script does not get a menu entry that corr=
esponds to the localized string.

Thank you

J=C3=B6rg B=C3=BChmann
