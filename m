From: Stefan Sperling <stsp@elego.de>
Subject: Re: [PATCH 0/9] Get svnrdump merged into git.git
Date: Wed, 14 Jul 2010 09:03:23 +0200
Message-ID: <20100714070323.GB25630@jack.stsp.name>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <20100713235825.GC12639@debian>
 <20100714001530.GB2308@burratino>
 <20100714002235.GF12639@debian>
 <20100714002843.GC2308@burratino>
 <20100714004959.GG12639@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 10:00:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYwsz-0001hM-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 10:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab0GNIAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 04:00:04 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:55530 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab0GNIAB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 04:00:01 -0400
X-Envelope-From: stsp@stsp.name
Received: from jack.stsp.name (i577B52DC.versanet.de [87.123.82.220])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o6E73Z7c006739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Jul 2010 09:03:35 +0200
Received: from jack.stsp.name (stsp@localhost [127.0.0.1])
	by jack.stsp.name (8.14.3/8.14.3) with ESMTP id o6E73YUe025211;
	Wed, 14 Jul 2010 09:03:34 +0200 (CEST)
Received: (from stsp@localhost)
	by jack.stsp.name (8.14.3/8.14.3/Submit) id o6E73NgJ027690;
	Wed, 14 Jul 2010 09:03:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100714004959.GG12639@debian>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150970>

On Wed, Jul 14, 2010 at 02:49:59AM +0200, Ramkumar Ramachandra wrote:
> Hi,
> 
> Jonathan Nieder writes:
> > As long as the relevant licenses permit that.  svnrdump only links to
> > libsvnclient, right?

It links against a couple of Subversion libraries and against APR.

> I can see another problem coming: things are likely to move around
> quite a bit after the code gets into the ASF. For instance, Stefan's
> recent review points out that write_hash_to_stringbuf should probably
> be in a reusable library. If these changes happen soon, svnrdump will
> be tightly integrated into Subversion, and it'll be hard to separate
> out an independent program. Then again, we don't know how soon this
> will happen.
> 
> If you get this series merged into git.git, Git people will be able to
> read and review it easily and it'll be guaranteed to compile against
> SVN 1.6. In other words, it won't be a moving part. The downside being
> that it's too painful to backport changes from the ASF version, so
> it'll remain outdated atleast until the next Subversion release, and
> we don't know how soon that'll happen and be widely available.
> 
> If the former option is preferred, I'll send one large patch to the
> list for mirroring the version in ASF.

Git devs will want a version of svnrdump that compiles against
the 1.6.x libraries. We'll want a version that compiles against
the trunk (so we can release it with 1.7).

So depending on which APIs svnrdump is using, it's likely that
you'll have to maintain 2 slightly differing versions anyway,
until 1.7 is released. (The current ETA for 1.7 is autumn, BTW).

> Also, could the Subversion
> people confirm that licensing isn't an issue?

I didn't catch any licensing discussion. What's the issue?

Stefan
