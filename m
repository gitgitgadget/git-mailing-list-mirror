Received: from spamfilter1.renyi.hu (spamfilter1.renyi.hu [193.224.79.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E3618C35A
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.224.79.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725921629; cv=none; b=CPmcelUUNretWinQb4L1t5fVwMlevL/sHz86kmC5Z/C2WU2xiC0Dh2rarxKS87RDSrZAkzK6vjxKKbk0Ut1FoOr5XT0HQ/hKXqWq/HOGDI1gBILctPgOWtZvpGfzwdtAbvFcjZb3ukq9J9ZWESs+gbNeNmSW3Rd2Ho5mt7N1lxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725921629; c=relaxed/simple;
	bh=IV4wpXptl9YZNgCIJBpVi0j5u/ZgCLV8uv24pksi3ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzUhVx2EQtIU8JuS8V4t8o546IcHHjkiP5vD8cTcL2H5JbmMPnARAlWGvZBFfmOiCxCzwU7avjSMtn/jqqWqQHlnFudI0YFF17drJLcQM9awTnI8D7DI0KQeT6BLX6WGXt0vBxA4+QSXaPHQqdCvFBTPVcDGGxu8rUg/mBXTY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=renyi.hu; spf=pass smtp.mailfrom=renyi.hu; dkim=pass (1024-bit key) header.d=renyi.mta.hu header.i=@renyi.mta.hu header.b=oMZFRfVW; dkim=pass (1024-bit key) header.d=renyi.hu header.i=@renyi.hu header.b=Rl5tV+4d; dkim=pass (1024-bit key) header.d=mta.renyi.hu header.i=@mta.renyi.hu header.b=lstRBob7; arc=none smtp.client-ip=193.224.79.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=renyi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renyi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renyi.mta.hu header.i=@renyi.mta.hu header.b="oMZFRfVW";
	dkim=pass (1024-bit key) header.d=renyi.hu header.i=@renyi.hu header.b="Rl5tV+4d";
	dkim=pass (1024-bit key) header.d=mta.renyi.hu header.i=@mta.renyi.hu header.b="lstRBob7"
Received-SPF: pass (spamfilter1.renyi.hu: 193.224.79.19 is whitelisted) receiver=spamfilter1.renyi.hu; client-ip=193.224.79.19; helo=smtp.renyi.hu; envelope-from=gilyen.andras@renyi.hu; x-software=spfmilter 2.001 http://www.acme.com/software/spfmilter/ with libspf2-1.2.10;
Received: from smtp.renyi.hu (smtp.renyi.hu [193.224.79.19])
	by spamfilter1.renyi.hu (8.15.2/8.15.2/Debian-8) with ESMTPS id 489MRunQ018562
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 00:27:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=renyi.mta.hu; s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kMxeQE5Tfouzg2FhNG8t5cI5Xk7tJcgk/W1KEBX+VZk=; b=oMZFRfVWtYVLFePEWCzo0Gkacr
	E7/oVSqgDO26XDvwa+Mn3BoeVOrxBlq9Dzs+yVEe904mTes76IFOYlxFtrJRa4DxSzARfrQTqwcb4
	PAOP1JC28RLQyUUunCdvY9BTt00Nyn84FLwk9UR3P1B1ug1XtgeHmVU7p4YQspgrc6ks=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=renyi.hu;
	 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kMxeQE5Tfouzg2FhNG8t5cI5Xk7tJcgk/W1KEBX+VZk=; b=Rl5tV+4dlyCkgek631q78mnGrB
	KYTkgTPU/t95u2FEixc0/BrjTApaNtBpMIxCcDU0qrT4kkxOK0qOfxaMLiudbqg+K4JjjTkZ2QSSM
	2K1kuA+uPyTkrlEf6CNutdo+LFUPXMX2WJNVYjeRWnl68HSvuRe9LjpDCypxCdSlXOBU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mta.renyi.hu; s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kMxeQE5Tfouzg2FhNG8t5cI5Xk7tJcgk/W1KEBX+VZk=; b=lstRBob7UXWkDyJTV8eQuUqA8L
	uRUvhwZHptKu778E8ucHunXzKxzBjSmcP8JgqBH7IUW8M5AoGfUKTxN+HqLrrTqDJ6Jg5ad/IQcxD
	qT/15t5+cQzEKB9SZ0uj8HYfTuJZKQREXNBT2Ta2knH33SwT2olIzsniFojFfhmqWzwE=;
Received: (Authenticated sender: gilyen)
	by smtp.renyi.hu with esmtpsa(TLSv1.3:TLS_AES_128_GCM_SHA256:128) (Exim)
	from <gilyen.andras@renyi.hu>id 1snmtc-0006fw-6u; Tue, 10 Sep 2024 00:30:08 +0200
Message-ID: <c5445b68-9e22-4320-b3a7-53cd17e848b6@renyi.hu>
Date: Tue, 10 Sep 2024 00:30:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] gitk: new config options for wrapping and diff modes
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Paul Mackerras <paulus@ozlabs.org>,
        Sergey Vlasov <vsu@altlinux.ru>
References: <909d2af2-9395-5b13-7049-097237826032@renyi.hu>
Content-Language: en-US
From: =?UTF-8?B?QW5kcsOhcyBHaWx5w6lu?= <gilyen.andras@renyi.hu>
In-Reply-To: <909d2af2-9395-5b13-7049-097237826032@renyi.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.2 at spamfilter1
X-Virus-Status: Clean
X-Scanned-By: MIMEDefang 2.79 on 10.0.2.87

Using gitk for tracking changes in large text files,
which often have very long lines consisting of, e.g.,
a paragarph of an article, it is highly desirable to
wrap the lines in the diff view and also to set the
default diff mode to "Markup words" or "Color lines".

There is a configurable option "wrapcomment" to make the
comments wrap in gitk, and now an additional "wraplines"
option is introduced for warpping lines in the source files.
Similarly, an option "worddiffdefault" is introduced which
sets the default diff view mode to "Markup words" or
"Color lines". These options can be set by editing gitk's
configuration file. The default behaviours are unchanged.

The new options are documented in Documentation/gitk.txt,
where the formerly undocumented feature "wrapcomment"
also got explained, which was introduced by Commit f1b8629453
([PATCH] gitk: Display commit messages with word wrap, 2006-05-15).

Suggested-by: Ailin Nemui <ailin.nemui@xxxxxxxxx>
(https://www.spinics.net/lists/git/msg274761.html )
Signed-off-by: András P Gilyén <gilyen@renyi.hu>
---
I fixed a typo in the documentation and made some cosmetic
edits to the patch in order to improve its readability.

  Documentation/gitk.txt | 26 ++++++++++++++++++++++++--
  gitk-git/gitk          | 18 +++++++++++++-----
  2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 35b3996029..82ff7e5370 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -161,10 +161,32 @@ If neither of the above exist then `$XDG_CONFIG_HOME/git/gitk` is created and
  used by default. If '$XDG_CONFIG_HOME' is not set it defaults to
  `$HOME/.config` in all cases.

+The following are some options that are configurable by updating the contents
+of the above configuration file. To set an option to a specific value add a
+line containing "set <option> <value>".
+
+wrapcomment::
+
+	Describes whether the comment section of a commit should be displayed
+	with (word) wrapded lines or without any wrapping of the lines.
+	Vaild options are none (default setting) and word.
+
+wraplines::
+
+	Describes whether the source section in the gitk viewer should be
+	displayed with (word) wrapded lines or should be scrollaple with
+	unwrapped lines. Vaild options are none (default setting) and word.
+
+worddiffdefault::
+
+	Sets the default diff view mode for gitk. Valid options are:
+	line -- for "Line diff" (default setting)
+	markup -- for "Markup words"
+	color -- for "Color words"
+
  History
  -------
-Gitk was the first graphical repository browser. It's written in
-tcl/tk.
+Gitk was the first graphical repository browser. It's written in tcl/tk.

  'gitk' is actually maintained as an independent project, but stable
  versions are distributed as part of the Git suite for the convenience
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 7a087f123d..4bcb989bb7 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2089,7 +2089,7 @@ proc makewindow {} {
      global diffcontextstring diffcontext
      global ignorespace
      global maincursor textcursor curtextcursor
-    global rowctxmenu fakerowmenu mergemax wrapcomment
+    global rowctxmenu fakerowmenu mergemax wrapcomment wraplines
      global highlight_files gdttype
      global searchstring sstring
      global bgcolor fgcolor bglist fglist diffcolors diffbgcolors selectbgcolor
@@ -2101,7 +2101,7 @@ proc makewindow {} {
      global rprogitem rprogcoord rownumsel numcommits
      global have_tk85 use_ttk NS
      global git_version
-    global worddiff
+    global worddiff worddiffdefault

      # The "mc" arguments here are purely so that xgettext
      # sees the following string as needing to be translated
@@ -2420,7 +2420,13 @@ proc makewindow {} {
          -command changeignorespace -variable ignorespace
      pack .bleft.mid.ignspace -side left -padx 5

-    set worddiff [mc "Line diff"]
+    if {$worddiffdefault == "color" && [package vcompare $git_version "1.7.2"] >= 0} {
+        set worddiff [mc "Color words"]
+    } elseif {$worddiffdefault == "markup" && [package vcompare $git_version "1.7.2"] >= 0} {
+        set worddiff [mc "Markup words"]
+    } else {
+        set worddiff [mc "Line diff"]
+    }
      if {[package vcompare $git_version "1.7.2"] >= 0} {
          makedroplist .bleft.mid.worddiff worddiff [mc "Line diff"] \
              [mc "Markup words"] [mc "Color words"]
@@ -2431,7 +2437,7 @@ proc makewindow {} {
      set ctext .bleft.bottom.ctext
      text $ctext -background $bgcolor -foreground $fgcolor \
          -state disabled -undo 0 -font textfont \
-        -yscrollcommand scrolltext -wrap none \
+        -yscrollcommand scrolltext -wrap $wraplines \
          -xscrollcommand ".bleft.bottom.sbhorizontal set"
      if {$have_tk85} {
          $ctext conf -tabstyle wordprocessor
@@ -12392,6 +12398,7 @@ set downarrowlen 5
  set mingaplen 100
  set cmitmode "patch"
  set wrapcomment "none"
+set wraplines "none"
  set showneartags 1
  set hideremotes 0
  set maxrefs 20
@@ -12438,6 +12445,7 @@ set diffbgcolors {"#fff3f3" "#f0fff0"}
  set diffcontext 3
  set mergecolors {red blue "#00ff00" purple brown "#009090" magenta "#808000" "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" "#f0b070" "#ff70b0"}
  set ignorespace 0
+set worddiffdefault "line"
  set worddiff ""
  set markbgcolor "#e0e0ff"

@@ -12506,7 +12514,7 @@ set config_variables {
      filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
      linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
      indexcirclecolor circlecolors linkfgcolor circleoutlinecolor diffbgcolors
-    web_browser
+    web_browser wraplines worddiffdefault
  }
  foreach var $config_variables {
      config_init_trace $var
-- 
2.34.1

