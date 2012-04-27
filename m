From: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
Subject: Bug in git-stash(.sh) ?
Date: Fri, 27 Apr 2012 18:57:36 -0400
Message-ID: <20379.9312.943088.350379@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: magit+bncCOHCzKWgHRDjyOz8BBoEeP8LDQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sat Apr 28 00:57:41 2012
Return-path: <magit+bncCOHCzKWgHRDjyOz8BBoEeP8LDQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-vx0-f186.google.com ([209.85.220.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCOHCzKWgHRDjyOz8BBoEeP8LDQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SNu6e-0006dS-Ne
	for gcvgm-magit-3@m.gmane.org; Sat, 28 Apr 2012 00:57:41 +0200
Received: by vcbfo14 with SMTP id fo14sf1187290vcb.3
        for <gcvgm-magit-3@m.gmane.org>; Fri, 27 Apr 2012 15:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:mime-version:message-id:date:to
         :subject:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=Uyoukq6kHypmhpIYDrjz3YARV/VTMJ7r+G2wdxkdLkw=;
        b=k1tQmNznMwIF0t6DO7XsZTJnjIEuaPMRcHXTwAGarTEnCtRYaVgh0SxfgTLv4XFuyY
         kEcMwN7sQ2783CklAl/8uIablmv+3+U4Y5/2OJKGL5nq/QaIEWgcJsXYDOkQISacBRme
         o9NWrBqy7EjyrwQqziVzFkR9zk4Qq23SGeWy8=
Received: by 10.50.36.200 with SMTP id s8mr324401igj.5.1335567459590;
        Fri, 27 Apr 2012 15:57:39 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.50.217.197 with SMTP id pa5ls860209igc.4.canary; Fri, 27 Apr
 2012 15:57:38 -0700 (PDT)
Received: by 10.50.188.232 with SMTP id gd8mr4449320igc.4.1335567458432;
        Fri, 27 Apr 2012 15:57:38 -0700 (PDT)
Received: by 10.50.188.232 with SMTP id gd8mr4449319igc.4.1335567458421;
        Fri, 27 Apr 2012 15:57:38 -0700 (PDT)
Received: from winooski.ccs.neu.edu (winooski.ccs.neu.edu. [129.10.115.117])
        by gmr-mx.google.com with ESMTPS id t9si1969391igb.1.2012.04.27.15.57.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Apr 2012 15:57:38 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates 129.10.115.117 as permitted sender) client-ip=129.10.115.117;
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id q3RMvbEt019273;
	Fri, 27 Apr 2012 18:57:37 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id q3RMvbHJ019269;
	Fri, 27 Apr 2012 18:57:37 -0400
X-Mailer: VM 8.2.0a under 23.2.1 (x86_64-redhat-linux-gnu)
X-Original-Sender: eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates
 129.10.115.117 as permitted sender) smtp.mail=eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:googlegroups-manage+752745291123+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196487>

[Note: cross-posted to the magit list to see if anyone else has this
problem.]

For a while now I had a problem when I try to do stash operations via
magit -- for example, it shows this in the process buffer:

  $ git --no-pager stash apply stash@{2012-04-27 08:53:30 -0400}
  Too many revisions specified: stash@{2012-04-27 08:53:30 -0400}

I tracked this down to this part of the script:

	REV=$(git rev-parse --no-flags --symbolic "$@") || exit 1
	...
	set -- $REV

where $REV has one symbolic name but the name has spaces in it.  (This
was introduced two years ago, in ef76312.)

Removing the --symbolic flag could solve this but it looks like it's
needed for error reporting.  Instead, I tweaked IFS so it's split
correctly and added some quotations later in the script where $1 and
$REV are used without quotes.  (I also moved the "REV=..." line next
to the "set -- $REV", since the chunk of code between them isn't using
$REV.)

The following is the diff -- if it looks right I can send a properly
formatted patch.


-------------------------------------------------------------------------------
diff --git a/git-stash.sh b/git-stash.sh
index 4e2c7f8..10a264b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -33,6 +33,8 @@ else
        reset_color=
 fi
 
+NEWLINE="
+"
 no_changes () {
 	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
 	git diff-files --quiet --ignore-submodules &&
@@ -327,8 +329,6 @@ parse_flags_and_rev()
 	i_tree=
 	u_tree=
 
-	REV=$(git rev-parse --no-flags --symbolic "$@") || exit 1
-
 	FLAGS=
 	for opt
 	do
@@ -345,7 +345,9 @@ parse_flags_and_rev()
 		esac
 	done
 
-	set -- $REV
+	REV=$(git rev-parse --no-flags --symbolic "$@") || exit 1
+
+	OIFS="$IFS"; IFS="$NEWLINE"; set -- $REV; IFS="$OIFS"
 
 	case $# in
 		0)
@@ -360,13 +362,13 @@ parse_flags_and_rev()
 		;;
 	esac
 
-	REV=$(git rev-parse --quiet --symbolic --verify $1 2>/dev/null) || {
+	REV=$(git rev-parse --quiet --symbolic --verify "$1" 2>/dev/null) || {
 		reference="$1"
 		die "$(eval_gettext "\$reference is not valid reference")"
 	}
 
-	i_commit=$(git rev-parse --quiet --verify $REV^2 2>/dev/null) &&
-	set -- $(git rev-parse $REV $REV^1 $REV: $REV^1: $REV^2: 2>/dev/null) &&
+	i_commit=$(git rev-parse --quiet --verify "$REV^2" 2>/dev/null) &&
+	set -- $(git rev-parse "$REV" "$REV^1" "$REV:" "$REV^1:" "$REV^2:" 2>/dev/null) &&
 	s=$1 &&
 	w_commit=$1 &&
 	b_commit=$2 &&
@@ -377,8 +379,8 @@ parse_flags_and_rev()
 	test "$ref_stash" = "$(git rev-parse --symbolic-full-name "${REV%@*}")" &&
 	IS_STASH_REF=t
 
-	u_commit=$(git rev-parse --quiet --verify $REV^3 2>/dev/null) &&
-	u_tree=$(git rev-parse $REV^3: 2>/dev/null)
+	u_commit=$(git rev-parse --quiet --verify "$REV^3" 2>/dev/null) &&
+	u_tree=$(git rev-parse "$REV^3:" 2>/dev/null)
 }
 
 is_stash_like()
-------------------------------------------------------------------------------

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
