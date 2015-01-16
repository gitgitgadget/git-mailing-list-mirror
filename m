From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Fri, 16 Jan 2015 04:16:49 -0500
Message-ID: <20150116091648.GA2450@peff.net>
References: <20150114211712.GE1155@peff.net>
 <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
 <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
 <20150115222719.GA19021@peff.net>
 <xmqqa91j6537.fsf@gitster.dls.corp.google.com>
 <20150115235752.GB25120@peff.net>
 <xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
 <20150116013256.GA25894@peff.net>
 <BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>
 <20150116033445.GA29572@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBBFO4OSQKGQEPN5HFRY@googlegroups.com Fri Jan 16 10:16:54 2015
Return-path: <msysgit+bncBDO2DJFKTEFBBBFO4OSQKGQEPN5HFRY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f183.google.com ([209.85.213.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBBFO4OSQKGQEPN5HFRY@googlegroups.com>)
	id 1YC31S-0007MV-OT
	for gcvm-msysgit@m.gmane.org; Fri, 16 Jan 2015 10:16:54 +0100
Received: by mail-ig0-f183.google.com with SMTP id hl2sf363756igb.0
        for <gcvm-msysgit@m.gmane.org>; Fri, 16 Jan 2015 01:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=bYYFbF14gIsw/vA8NG0/g8eAj00mONp8NcSqzXereZY=;
        b=GwyFzp+jG51N1B7qdrssn5MylBng9tjr+8DU2Yhzj0iPAgcyYDheDTAeWOppaoolSU
         CrhT5kGnpy1De9oNYAlaejc81kKe45sSIuqZ9AZ3PlBQpPxlcQszR9O1ir8peF0hmgCW
         Wl1TrKwLgAzYYCedCyXhKMKeZlQFhjNqvtZ90Ik1exuGYwthlTC/P4BFyH3v8fFIysJ7
         s5rz8j7TwttRZuO6Qd9QmTkpqtfuAC/hnm5vbp87lhgyfkBLkU8w3y2ScdmSFUvR5Y0S
         7IunJffZGKCwAaLbkJlYEwcYjwfddRI44226txaXD1zpLGUcM/5Fz8vnuFcGLuT7Y/7Y
         NQAA==
X-Received: by 10.50.127.232 with SMTP id nj8mr37787igb.0.1421399812767;
        Fri, 16 Jan 2015 01:16:52 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.114.33 with SMTP id jd1ls420419igb.2.canary; Fri, 16 Jan
 2015 01:16:52 -0800 (PST)
X-Received: by 10.42.22.145 with SMTP id o17mr12169681icb.17.1421399812183;
        Fri, 16 Jan 2015 01:16:52 -0800 (PST)
Received: from cloud.peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id q6si129689igr.3.2015.01.16.01.16.51
        for <msysgit@googlegroups.com>;
        Fri, 16 Jan 2015 01:16:52 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 3615 invoked by uid 102); 16 Jan 2015 09:16:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 03:16:52 -0600
Received: (qmail 23632 invoked by uid 107); 16 Jan 2015 09:17:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 04:17:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jan 2015 04:16:49 -0500
Content-Disposition: inline
In-Reply-To: <20150116033445.GA29572@peff.net>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted
 sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262547>

On Thu, Jan 15, 2015 at 10:34:46PM -0500, Jeff King wrote:

> > "id -u" works for me in MSYS and cygwin (each appears to have it's own
> > id.exe).
> 
> That's comforting. MSYS was the one I was most worried about. What UID
> do they report? I.e., do they correctly tell us if we are root (or
> more accurately, if we are not root)?

So here's a re-roll with `id -u`, as that may be the simplest way to get
people to test (with the patch applied, running t5550 as a normal user
should work, and as root should skip the tests).

-- >8 --
Subject: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT

The SANITY prerequisite is really about whether the
filesystem will respect the permissions we set, and being
root is only one part of that. But the httpd tests really
just care about not being root, as they are trying to avoid
weirdness in apache (see a1a3011 for details).

Let's switch out SANITY for a new NOT_ROOT prerequisite,
which will let us tweak SANITY more freely.

We implement NOT_ROOT by checking `id -u`, which is in POSIX
and seems to be available even on MSYS.  Note that we cannot
just call this "ROOT" and ask for "!ROOT". The possible
outcomes are:

  1. we know we are root

  2. we know we are not root

  3. we could not tell, because `id` was not available

We should conservatively treat (3) as "does not have the
prerequisite", which means that a naive negation would not
work.

Helped-by: Kyle J. McKay <mackyle@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh | 2 +-
 t/test-lib.sh  | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index fd53b57..d154d1e 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -37,7 +37,7 @@ then
 	test_done
 fi
 
-if ! test_have_prereq SANITY; then
+if ! test_have_prereq NOT_ROOT; then
 	test_skip_or_die $GIT_TEST_HTTPD \
 		"Cannot run httpd tests as root"
 fi
diff --git a/t/test-lib.sh b/t/test-lib.sh
index bb1402d..be50c77 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1040,3 +1040,8 @@ test_lazy_prereq UNZIP '
 	"$GIT_UNZIP" -v
 	test $? -ne 127
 '
+
+test_lazy_prereq NOT_ROOT '
+	uid=$(id -u) &&
+	test "$uid" != 0
+'
-- 
2.2.1.425.g441bb3c

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
