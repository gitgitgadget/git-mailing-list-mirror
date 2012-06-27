From: faux@goeswhere.com
Subject: Re: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 10:57:35 +0100
Message-ID: <20120627095735.GA19118@goeswhere.com>
References: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
 <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 12:07:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjpA9-0004QB-Oo
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 12:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756854Ab2F0KHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jun 2012 06:07:49 -0400
Received: from fau.xxx ([78.47.200.108]:52824 "EHLO reg.goeswhere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756697Ab2F0KHs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 06:07:48 -0400
X-Greylist: delayed 612 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jun 2012 06:07:48 EDT
Received: by reg.goeswhere.com (Postfix, from userid 1000)
	id 2D7F12E0B4A; Wed, 27 Jun 2012 10:57:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=goeswhere.com;
	s=default; t=1340791055;
	bh=GeHMwNdLNiezgca3S/pXiyQ/lyKce5qn/Qyqt0saE/4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:In-Reply-To;
	b=f84e7SYvQPwoNS7bA1db+aLqW3tB3LdOQN48A/WA4nLylCH97FIYFeGqqpjQycSAY
	 ZK84TDMWjIBFnNnHj4A4kjFDVkLDAips+nPT0iWKiDIvtL4Oc1KIh/D1rtkqzQ02P6
	 0fAqTA93QRIePm34ps51gudXQgb5znsDExMYM2Jc=
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200712>

On Wed, Jun 27, 2012 at 09:32:21AM +0200, Daniel Lyubomirov -|- Digital=
us Bulgaria wrote:
> Hi,
>=20
> =D0=90ccidentally my colleague created a file in the root dir of the =
git repo called - (just dash).
> As result for every commit having this file, diff , merge, cherry-pic=
k maybe others just hang.
> I tried to make rebase interactive to edit the commit and remove the =
file but that fails too.

Haha, it tries to read from standard in:

$ git init && printf '' >- && git add -- - && git commit -m "lol"

Pressing ^D allows it to continue.
