From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [GIT PULL] vcs-svn housekeeping
Date: Fri, 6 Jul 2012 12:10:40 -0500
Message-ID: <20120706171040.GA31001@burratino>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
 <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
 <20120607003904.GB4065@burratino>
 <7vtxynk81p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 19:10:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnC3V-0008Jd-HI
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 19:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756258Ab2GFRKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 13:10:52 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:50111 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab2GFRKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 13:10:51 -0400
Received: by gglu4 with SMTP id u4so8820901ggl.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=k3XDLZeyX1QyYo7N2h2PA4mB4pcXpuqYfFqfHpR9D6M=;
        b=YOVwJMEpYjZDDeUBwoikzbdpa5NQOc3TdQECJB3ncvLV4qbujfWaJPa3Ja6gowMg4I
         mttmMO1w0OIhLcsWa7E1Mocn4znC0s0tpoooBflIYKjSZg1lo+A95hdMuEzog/bXDMNa
         10+1ys0WaZjc8blaaIaFHEfbuNB+vzdpL+bLR3P+DkhihwOXcOP8OE8xyT2RrOpHgPZX
         InilsAM1ytGpacLEjXtQwbsEkUwZnZLrGM6ADzDEesGoAwBTaFt/DdinNT501nWSBdd3
         Kw0dOisca3nKAHTZE3I4/tJZcfqSZIffWptoKYxYuDUTSEqluS+ryB2MwQVa6qRgg8SH
         bQog==
Received: by 10.42.158.10 with SMTP id f10mr16020188icx.51.1341594649969;
        Fri, 06 Jul 2012 10:10:49 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z3sm2811747igc.7.2012.07.06.10.10.48
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 10:10:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtxynk81p.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201124>

Hi Junio,

The following changes since commit 58ebd9865d2bb9d42842fbac5a1c4eae49e92859:

  vcs-svn/svndiff.c: squelch false "unused" warning from gcc (2012-01-27 11:58:56 -0800)

are available at:

  git://repo.or.cz/git/jrn.git svn-fe

The first three commits duplicate changes that are already in master
but were committed independently on the svn-fe branch last February.
The rest are David's db/vcs-svn series which aims to address various
nits noticed when merging the code back into svn-dump-fast-export:
unnecessary use of git-specific functions (prefixcmp, memmem) and
warnings reported by clang.

Some of the patches had to change a little since v2 of db/vcs-svn, so
I'll be replying with a copy of the patches for reference.

David has looked the branch over and acked and tested it.

Thoughts welcome, as usual.  I think these are ready for pulling into
master.  Sorry to be so slow at this.

David Barr (7):
      vcs-svn: drop no-op reset methods
      vcs-svn: avoid self-assignment in dummy initialization of pre_off
      vcs-svn: simplify cleanup in apply_one_window
      vcs-svn: use constcmp instead of prefixcmp
      vcs-svn: use strstr instead of memmem
      vcs-svn: suppress signed/unsigned comparison warnings
      vcs-svn: suppress a signed/unsigned comparison warning

Jonathan Nieder (4):
      vcs-svn: allow import of > 4GiB files
      vcs-svn: suppress -Wtype-limits warning
      vcs-svn: suppress a signed/unsigned comparison warning
      vcs-svn: allow 64-bit Prop-Content-Length

Ramsay Allan Jones (1):
      vcs-svn: rename check_overflow and its arguments for clarity

 test-line-buffer.c       |    1 -
 test-svn-fe.c            |    2 --
 vcs-svn/fast_export.c    |   26 ++++++++++++--------------
 vcs-svn/fast_export.h    |    5 ++---
 vcs-svn/line_buffer.c    |    4 ----
 vcs-svn/line_buffer.h    |    1 -
 vcs-svn/sliding_window.c |   16 ++++++++--------
 vcs-svn/svndiff.c        |   15 ++++++++-------
 vcs-svn/svndump.c        |   46 ++++++++++++++++++++++++++++------------------
 9 files changed, 58 insertions(+), 58 deletions(-)
