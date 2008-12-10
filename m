From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: A bit of code cleanup in git_blame()
Date: Wed, 10 Dec 2008 03:13:24 +0100
Organization: At home
Message-ID: <ghn8jv$hg9$1@ger.gmane.org>
References: <20081209223703.28106.29198.stgit@localhost.localdomain> <20081209224814.28106.83387.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 03:14:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAEbC-0003lV-RE
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 03:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbYLJCNd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2008 21:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbYLJCNd
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 21:13:33 -0500
Received: from main.gmane.org ([80.91.229.2]:56742 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbYLJCNc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 21:13:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LAEZp-0000vS-W7
	for git@vger.kernel.org; Wed, 10 Dec 2008 02:13:26 +0000
Received: from absh60.neoplus.adsl.tpnet.pl ([83.8.127.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 02:13:25 +0000
Received: from jnareb by absh60.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 02:13:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: absh60.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102664>

Jakub Narebski wrote:

I'm sorry, there should be

  +       my $ftype =3D "blob";
> =A0=A0=A0=A0=A0=A0=A0=A0if (!defined $hash) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$hash =3D git_get_has=
h_by_path($hash_base, $file_name, "blob")
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0or die_error(404, "Error looking up file");
> +=A0=A0=A0=A0=A0=A0=A0} else {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$ftype =3D git_get_type=
($hash);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if ($ftype !~ "blob") {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
die_error(400, "Object is not a blob");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
