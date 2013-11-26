From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] bash prompt: add option to disable for a repository
Date: Tue, 26 Nov 2013 01:26:25 +0100
Message-ID: <20131126002625.GA9061@goldbirke>
References: <1385212703-9611-1-git-send-email-hoxu@users.sf.net>
 <5290BEE7.2070901@kdbg.org>
 <CAOpY_XvN9GJw592MpbcZZ2hzUvSvTHNLebwMmQBK+N-Ez4xM_Q@mail.gmail.com>
 <20131125234344.GA4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heikki Hokkanen <hoxu@users.sf.net>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 01:26:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl6UG-0002wL-9X
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 01:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab3KZA0k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 19:26:40 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:64820 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab3KZA0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 19:26:39 -0500
Received: from localhost6.localdomain6 (g227076111.adsl.alicedsl.de [92.227.76.111])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MSlXs-1WCVFt2X3s-00RdAa; Tue, 26 Nov 2013 01:26:25 +0100
Content-Disposition: inline
In-Reply-To: <20131125234344.GA4212@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:N3Hal2lQatnzIovY1MStuLmiJbma90CCK367sLS0cdE
 A/z23LW6DuHlWoePXxPy0+2vXXCXN0z8zdlt/7HM39VLsSXyey
 LO4q6T4hzn1agmhyKC8G/FVAPQ229TmcsYbqZjNEgMzE06tnjW
 Ymmhm/v2hJxkO1eybKPAUyT5SqPNubMHAgnvNDbKmLOMXg5I01
 elWjDqPKaAWHw7Ch0KVRifidbTwFOfM5454lJxR9pWPzsO6Exl
 u5/lyzPlk+0pF5mdKI1ubTZSlHwczaikEic5Iv+p3hDgZxzd1X
 MD176mTRigAEWbujMWNzRhAD5o7dbaOvVcKVYDb+DLf9gVid1X
 wt3t8XSdb3smCX3qN/mE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238366>

On Mon, Nov 25, 2013 at 03:43:44PM -0800, Jonathan Nieder wrote:
> Heikki Hokkanen wrote:
>=20
> > If running git config on each prompt seems too expensive, do you ha=
ve
> > any better ideas?
>=20
> Perhaps a GIT_PS1_NOT_FOR_THESE_REPOS=3Drepo1:repo2:repo3 setting wou=
ld
> work.
>=20
> __git_ps1 would do the one 'git rev-parse --git-dir --...' to find th=
e
> repo corresponding to the cwd and then could match against the
> configured list to decide whether to return early.

That would be a better interface, but the implementation must cope
with colons in paths on Unixes, case insensitive file systems, and
different path representations on Windows (C:\path\to\repo vs.
/c/PaTh/To/RePo).  I'm not sure we want to go there.

G=E1bor
