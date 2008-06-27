From: Simon Holm =?ISO-8859-1?Q?Th=F8gersen?= <odie@cs.aau.dk>
Subject: Re: bug related to branches using / in name
Date: Fri, 27 Jun 2008 10:32:12 +0200
Message-ID: <1214555532.10090.18.camel@odie.local>
References: <1214509350.28344.31.camel@odie.local>
	 <20080627030245.GA7144@sigill.intra.peff.net>
	 <20080627030422.GB7144@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 27 10:33:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC9Od-0004xk-Cx
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 10:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbYF0IcA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2008 04:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755423AbYF0Ib7
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 04:31:59 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:37010 "EHLO smtp.cs.aau.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755340AbYF0Ib5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 04:31:57 -0400
Received: from [10.0.0.2] (port939.ds1-abc.adsl.cybercity.dk [212.242.156.194])
	(authenticated bits=0)
	by smtp.cs.aau.dk (8.14.1/8.14.1) with ESMTP id m5R8VOoa011464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Jun 2008 10:31:26 +0200
In-Reply-To: <20080627030422.GB7144@sigill.intra.peff.net>
X-Mailer: Evolution 2.22.2 
X-Spam-Level: () 0.262
X-Scanned-By: MIMEDefang 2.62 on 130.225.194.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86532>

Jeff King wrote:
> Jeff King wrote:
>=20
> > So to summarize, the problem is that you have an old tracking branc=
h
> > "refs/remotes/sched" that exists on the client, but upstream has si=
nce
> > removed it in favor of "sched/devel", which you are now trying to f=
etch.
> > And of course there is a conflict, because of the ref naming rules.
> >=20
> > This doesn't work seamlessly because git-fetch never removes old
> > tracking branches, even if they have been deleted upstream. And nor=
mally
> > there is no conflict; leaving the old branches means they don't
> > disappear from under you.
>=20
Your summary is correct, but I cannot entirely convince myself that
leaving old branches available is valid in any work flow. But what do I
know.

> BTW, you can get the opposite problem, too. If you have
> "refs/remotes/origin/foo/bar", and then the remote removes "foo/bar" =
in
> favor of "foo", you will have a conflict on fetch.
>=20
Yes, and you can also hit a similar problem using git-push, but I guess
that the user is a bit more aware about what is going on in that case
and is able resolve the problem without hints.

I tested the two patches and they did indeed seem to do what you
intended them to for my test case. The solution is not exactly pretty,
but it is better than nothing and it is admittedly a corner case.

Thank you for your time on this Jeff.


=EF=BB=BFSimon Holm Th=C3=B8gersen
