From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: does clone --depth work?
Date: Sun, 29 Nov 2009 17:32:42 +0100
Message-ID: <20091129163242.GA7921@atjola.homenet>
References: <20091129160352.GO10640@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 17:32:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEmhg-000051-KA
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 17:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbZK2Qcm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 11:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbZK2Qcl
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 11:32:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:35207 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752060AbZK2Qcl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 11:32:41 -0500
Received: (qmail invoked by alias); 29 Nov 2009 16:32:45 -0000
Received: from i59F55C61.versanet.de (EHLO atjola.homenet) [89.245.92.97]
  by mail.gmx.net (mp068) with SMTP; 29 Nov 2009 17:32:45 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19CJmoCsN1CGsCn37LMZIEBpG0AtHQ9JTeG2M6GX3
	mhm3hrQPVjfwJD
Content-Disposition: inline
In-Reply-To: <20091129160352.GO10640@bicker>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134021>

On 2009.11.29 18:03:52 +0200, Dan Carpenter wrote:
> I do: `git clone --depth 0 ./repo1/ repo2`  I expected that=20
> "git log" in repo2 wouldn't show any revisions, but it does.
>=20
> I'm using 1.6.5.3.171.ge36e.dirty (small unrelated modification).
>=20
> Am I doing something incorrectly?

Two problems:
a) IIRC depth =3D 0 is like not specifying depth at all
b) When using plain paths, clone optimizes the process by just doing a
copy, that doesn't apply the depth setting at all

git clone --depth=3D1 file://$PWD/repo1 repo2

That should work. Of course you still got some commits, so "git log"
will show them. You just don't get all of them, but only to a certain
depth.

Bj=F6rn
