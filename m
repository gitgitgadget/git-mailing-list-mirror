From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git: ideas and libgit2
Date: Sat, 2 Apr 2011 20:01:05 -0500
Message-ID: <20110403010040.GA25840@elie>
References: <AANLkTimry9cvwQZ1bJYeUK6xafahtw-FgOWnDggfLdxJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 03:01:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Bh3-00058j-KC
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 03:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757570Ab1DCBBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 21:01:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33355 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757465Ab1DCBBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 21:01:11 -0400
Received: by iyb14 with SMTP id 14so4780863iyb.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 18:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tCblE/M7Mto9Catj4qr+sQt+NdXg/7oaERunhnWSt1k=;
        b=Gbhsq4sctGpsxSiEHFlIH3884pXWShWF9f6DwHFSQ540sBJA29H3Q9lDB7MaMzGCy1
         Ajii70CRF30c40uMI8xj2bGxkZ8g3wBRYQkJGLm7disf4kzl5muu7x7KM4QI2gIcHJOo
         6NGan3air4KFSNdCIP9fAgFM+n4eguOxRd5Rs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=F4OWjPaUyVRPrPAKV7XYhH4oTeTIDRbIzr/3Qh2E+eYPhdcv7PykRXkyyrrXgxitmk
         pQBhwdPopyLkY0zbkEWQw5w1A40kMp6RfKmTxofYUIyMl/IZTmVkYfC4CSEnDPWoKU3j
         d8iUzTxGexzOo7SYCrUcbjRLJtxKgdMI4I+IE=
Received: by 10.231.80.193 with SMTP id u1mr5583629ibk.87.1301792470850;
        Sat, 02 Apr 2011 18:01:10 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id y10sm2579063iba.46.2011.04.02.18.01.09
        (version=SSLv3 cipher=OTHER);
        Sat, 02 Apr 2011 18:01:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimry9cvwQZ1bJYeUK6xafahtw-FgOWnDggfLdxJ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170670>

(cc-ing the git list; hoping that's okay.)
Hi Thiago,

Thiago Farina wrote:

> Would you help me to find some ideas to work on git? I'd also be
> interested in working in some API related to libgit2.

I'm probably not a good bet for that, since I'm not familiar with
libgit2 at all.  You'd probably want to contact the libgit2 list at
<libgit2@librelist.org>.

Because of Google's summer program there's a list of potential
projects at <https://git.wiki.kernel.org/index.php/SoC2011Ideas>.
Some people were mentioning the possibility of keeping a list like
this year-round, to give people something to hack on.

I can help find a project in the field of merge, remote helpers,
documentation processing, or startup procedure (repository discovery
and option parsing).  Or you can steal a project from me, if you'd
like.  Here's a few:

 - glibc: <http://sourceware.org/bugzilla/show_bug.cgi?id=6530>.
   This is desperately needed before translated output from the
   git cli becomes possible.

 - unifdef: split into coroutines following the stages of
   preprocessing described by the C standard, so it can handle more
   real-life preprocessor conditionals.  This should help with
   understanding the #ifdef-ed mess that is glibc's printf (see
   above).

 - various git commands: support --patience, for patience diff.
   Make a simple test script to demonstrate that it's turned on.
   Especially nice would be "git add -p".
   http://bugs.debian.org/522361

 - daemon: add some tests (using daemon --inetd, presumably).
   Let the client know when the repository is inaccessible:
   http://thread.gmane.org/gmane.comp.version-control.git/145456/focus=145573

 - daemon: add an option to stop tolerating inability to listen
   on one of the supplied interfaces.  Make a sysvinit / systemd /
   runit / whatever script describing best practices for running a
   persistent git daemon for contrib.

 - git test suite: find the remaining missing "&&"-s, fix them, and
   make future tests without them automatically fail.
   http://thread.gmane.org/gmane.comp.version-control.git/157903/focus=158265

 - scripts: use "set -u" in git-sh-setup, and fix the errors that
   result.  Some of the fixes won't be suitable for mainline: e.g.
   use of GIT_ variables would have to change to

	if test "${GIT_FOO:+set}"
	then
		... use GIT_ variable ...
	fi

   to suppress the error, but I doubt mainline git wants it.  Other
   fixes (protecting against the environment by initializing local
   variables to be empty) would be very much suitable for mainline.

 - contrib: make a Makefile so the invoker can install all the crazy
   contributed goodies at once if she wants to.

 - look for interesting (possibly old) patch series on the list
   (like the whole-directory-rename series!) and nudge them forward.

Hope that helps,
Jonathan
