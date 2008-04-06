From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Sun, 6 Apr 2008 15:58:20 -0700
Message-ID: <20080406225819.GE5822@adamsimpkins.net>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net> <alpine.DEB.1.00.0804062204580.12583@eeepc-johanness> <20080406220447.GB5822@adamsimpkins.net> <alpine.DEB.1.00.0804062315090.12583@eeepc-johanness>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 07 00:59:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JidpL-0007y1-Qy
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 00:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbYDFW6Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2008 18:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755578AbYDFW6X
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 18:58:23 -0400
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:56799 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbYDFW6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 18:58:23 -0400
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 890F672BBF9;
	Sun,  6 Apr 2008 18:58:21 -0400 (EDT)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 46D8172D3FE;
	Sun,  6 Apr 2008 18:58:21 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 589DF14100BB; Sun,  6 Apr 2008 15:58:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804062315090.12583@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78940>

On Sun, Apr 06, 2008 at 11:15:58PM +0100, Johannes Schindelin wrote:
> On Sun, 6 Apr 2008, Adam Simpkins wrote:
> > On Sun, Apr 06, 2008 at 10:06:24PM +0100, Johannes Schindelin wrote=
:
> > > On Sun, 6 Apr 2008, Adam Simpkins wrote:
> > >=20
> > > > +/* Defined in commit.h */
> > > > +struct commit;
> > > > +/* Defined in strbuf.h */
> > > > +struct strbuf;
> > >=20
> > > You do not need those.
> >=20
> > I added them so that graph.h can be included without including any =
other=20
> > header files first.  They can be taken out if we assume that all us=
ers=20
> > of graph.h will include commit.h and strbuf.h first.
>=20
> AFAICT you do not even need them then.  Using "struct strbuf *" witho=
ut=20
> ever declaring struct strbuf before that is perfectly valid.

Trying to compile the following test code with gcc 4.1.2 results in a
warning.

test.c:
	#include <stdio.h>
=09
	void test(struct strbuf *sb);
	int main(int argc, char **argv)
	{
		test(NULL);
		return 0;
	}

$ gcc -c test.c
test.c:3: warning: =E2=80=98struct strbuf=E2=80=99 declared inside para=
meter list
test.c:3: warning: its scope is only this definition or declaration, wh=
ich is probably not what you want

--=20
Adam Simpkins
adam@adamsimpkins.net
