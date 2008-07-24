From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v2] t6030 (bisect): work around Mac OS X "ls"
Date: Thu, 24 Jul 2008 18:54:34 +0200
Organization: glandium.org
Message-ID: <20080724165434.GA26660@glandium.org>
References: <Pine.GSO.4.62.0807232014030.14945@harper.uchicago.edu> <200807240757.26290.chriscool@tuxfamily.org> <20080724060647.GA24587@glandium.org> <Pine.GSO.4.62.0807240233310.27074@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:55:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM46P-00070N-DX
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 18:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbYGXQyl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 12:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYGXQyl
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:54:41 -0400
Received: from vuizook.err.no ([194.24.252.247]:60736 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836AbYGXQyl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 12:54:41 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KM45G-0000x1-RQ; Thu, 24 Jul 2008 18:54:37 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KM45K-0006z0-E5; Thu, 24 Jul 2008 18:54:34 +0200
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.62.0807240233310.27074@harper.uchicago.edu>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89909>

On Thu, Jul 24, 2008 at 02:43:51AM -0500, Jonathan Nieder wrote:
> t6030-bisect-porcelain.sh relies on "ls" exiting with nonzero
> status when asked to list nonexistent files.  Unfortunately,
> /bin/ls on Mac OS X 10.3 exits with exit code 0.  So look at
> its output instead.
>=20
> Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
> ---
>=20
> Mike Hommey wrote:
>=20
> > On Thu, Jul 24, 2008 at 07:57:26AM +0200, Christian Couder wrote:
> >> Le jeudi 24 juillet 2008, Jonathan Nieder a =E9crit :
> >>> -	test_must_fail ls .git/BISECT_* &&
> >>> +	echo .git/BISECT_* | test_must_fail grep BISECT_[^*] &&
> >>=20
> >> Perhaps the following is simpler:
> >>=20
> >> +	test -z "$(ls .git/BISECT_*)" &&
> >=20
> > That is still a useless use of ls ;)
>=20
> It is much better than what I wrote, at least.

But could also be written with echo instead of ls.

Mike
