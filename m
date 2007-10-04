From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH] Add a simple option parser.
Date: Thu, 04 Oct 2007 10:57:58 -0400
Message-ID: <1191509878.29379.2.camel@hinata.boston.redhat.com>
References: <1191447902-27326-1-git-send-email-krh@redhat.com>
	 <20071003231145.GF28188@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 16:58:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdS9l-0005f4-Kr
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 16:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbXJDO6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 10:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756464AbXJDO6V
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 10:58:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60790 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756378AbXJDO6U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 10:58:20 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id l94Ew41F031043;
	Thu, 4 Oct 2007 10:58:04 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l94Ew4wZ005398;
	Thu, 4 Oct 2007 10:58:04 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l94Ew38G001557;
	Thu, 4 Oct 2007 10:58:03 -0400
In-Reply-To: <20071003231145.GF28188@artemis.corp>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59959>


On Thu, 2007-10-04 at 01:11 +0200, Pierre Habouzit wrote:
> On Wed, Oct 03, 2007 at 09:45:01PM +0000, Kristian H=C3=B8gsberg wrot=
e:
> > The option parser takes argc, argv, an array of struct option
> > and a usage string.  Each of the struct option elements in the arra=
y
> > describes a valid option, its type and a pointer to the location wh=
ere the
> > value is written.  The entry point is parse_options(), which scans =
through
> > the given argv, and matches each option there against the list of v=
alid
> > options.  During the scan, argv is rewritten to only contain the
> > non-option command line arguments and the number of these is return=
ed.
>=20
>   if we are going in that direction (and I believe it's a good one), =
we
> should be sure that the model fits with other commands as well. And a=
s I
> said on IRC, I believe the most "horrible" (as in complex) option par=
ser
> in git is the one from git-grep.
>=20
>   A migration of git-grep on that API should be tried first. If this
> works well enough, I believe that the rest of the git commands will b=
e
> migrated easily enough. (with maybe small addition to parse-option.[h=
c]
> but the hardcore things should have been met with git-grep already I
> think).

I'm not sure - we can go with the current proposal and add new options
types and probably the callback option type I suggested as we go.  I
don't want to block builtin-commit on figuring out what the perfect
option parser should look like and what I sent out earlier work for
commit.  I think the way you handled the strbuf rewrites worked pretty
well; extending and rewriting the API as you put it to use in more and
more places.  We can do the same thing with parse_options().

cheers,
Kristian
