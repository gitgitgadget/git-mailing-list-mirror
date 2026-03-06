Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10212641C6
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775091; cv=none; b=FR1k0CjvgjvT6GfE+zbhzMVlOOR5PYZg1QUEyTC5UPIQeijDva8Tr9yvSyhB66Rqd/8NpueomqvkStVc4MWCSUXmRX/yokWI16sXAJrhl8y2IgTfOoc6fPoORgqPNEudO7CezyRzEd+TtH8UqHkG2OgRr9XJVPza8/CiiyrddKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775091; c=relaxed/simple;
	bh=/py1TxWA1TL3ASzIIYL5DqEzCz3th6BTOLg0U9qhf88=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RCG3xcQWQtbe2hupR5erii6hbQA4xVJrlxGHAqS+hkLueORhnz+CSYvUyQMBFEoqve9RuUrvf3z92IDWh+j7tbWIWnliJpskc4j9sSqo9+4chfjHQ/InDvDwmLGlHjjwskH8wclvCpgkUcCIsTWiZD0eulNdHqXkiYIdlr6j9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com; spf=pass smtp.mailfrom=wolfgangfaust.com; dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b=yFbSASN+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iXGtqYAk; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b="yFbSASN+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iXGtqYAk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3276C1400167;
	Fri,  6 Mar 2026 00:31:29 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-01.internal (MEProxy); Fri, 06 Mar 2026 00:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wolfgangfaust.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772775089; x=1772861489; bh=6GyDDlFmaE
	PDlE1d+I1fwKj6ANXr7Nvea64JHGCx5mc=; b=yFbSASN+UuFBPSF7Ze2RCPwaBH
	MaCVrEHkdRGQ95X6VixoW4KPSq2MrwqlKFhd5p3CfOO+mhO24XZinYEnxIvNXsGp
	1mQmF7alv5RWaENXeQJoqh2nkykv+0Z7uE2Sc4TUyfvhvI7dLiTRZxDBB2ExeINZ
	E+8ZiY5y2JAmVg5cAV/vEIpg8zeJFFBR0kuejemVFebY3oHHoNN48kuNMzdxGxvs
	yTZz/vWpJnvwIxkDv1vcMxJDvzQ8jmsgYbMnL17PEqjpYwGk+DV2PWlBI0iJa4xo
	AgLaEQJHArElUnBMNyp+nqnJLcy0cz3PrOFdM9pN6TewaYrGru9+E38u4k/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772775089; x=
	1772861489; bh=6GyDDlFmaEPDlE1d+I1fwKj6ANXr7Nvea64JHGCx5mc=; b=i
	XGtqYAkClZoHeHB4TUetXivqkzl81lu0Zs/bwalD2pyPGumdkfHEZbGlPabSzUzb
	t+LmNSnFQPA20gylMSM2ynXM55qsZ3mr/FvMlEyMqOvTHtQT3JO6eGWMNoMSqg9W
	/SDFz/HpV+nYWRDB1guX1rHOstZ0lvVKkCs1SIiujMRSmksMY14IEi9z9wsoX847
	pNMw78altHy8qriKkl8kDLS+jN9KKzedH7aJLIgG8Zxhoxw/DoDmFOsRS8SfS8xw
	F5owAUCz3kctsYztETI+uoAPYwwp7P1RiPbtYx5XjqP7LT0QZOHLLiJBArPa9t4z
	4PoJWR5XX269LrVfsFHrg==
X-ME-Sender: <xms:sWaqaaU9dfKOKoBnIgKShF0o6TCZHCkQpGdxdTjgDb1iSEMoXDEN0w>
    <xme:sWaqaRZR-FZGg_RUP3EEdlPV8ROFZCbCNg8KzO4NE8ySDzbuqj2eXJbu_Dffk_vBl
    uAMFPOB8CK1QuYZmqv3Wuv1g6IMehk1CYFG2gWF8OTUzgreKlHWBao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieekgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdghohhlfhhgrghnghcuhfgruhhsthdfuceotghonhhtrhhi
    sgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomheqnecuggftrfgrthhtvghrnh
    epvdeifedthedvgfdtjeduteeuvddutddvvdffffegudduudetueffieeuffdtvdetnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghonhhtrh
    hisgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sWaqadcnFK-ZL7KX9h5VovpPw-34N3b3f5k-Wm1vA-WNbjnEVZxwrA>
    <xmx:sWaqaUKeWr2NvkDUlZEL1lkE8iTiOvTrKcFefCbwDZVCRIemNaKeUQ>
    <xmx:sWaqaYeZNMhmMJ3GFqatxz5AHDtUwuIm4MpFv-xVQM4GCT_vH6Yq4Q>
    <xmx:sWaqaT1bXfa-OaCiJrVuZaFu2cWonKc1nP6UGtJVndPBxTVBYdolmQ>
    <xmx:sWaqaYAYfFXB1xxvWeVt6FyjrEObDi1GKAe9egQck5b5scr_7oNEFh0l>
Feedback-ID: ifd814412:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0081B2CE0072; Fri,  6 Mar 2026 00:31:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AX21AeLsmHX3
Date: Thu, 05 Mar 2026 21:30:47 -0800
From: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
To: git@vger.kernel.org
Cc: "Johannes Sixt" <j6t@kdbg.org>
Message-Id: <0b3b83e4-c77e-4cd1-9ab8-0a1eaad53983@app.fastmail.com>
In-Reply-To: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
References: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
Subject: [PATCH 2/4] git-gui: remove hint_gc dialog
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Now that git-gui runs auto maintenance on commit, large piles of loose o=
bjects
are no longer a concern so we don't need to bother the user about them.

Signed-off-by: Wolfgang Faust <contrib-git@wolfgangfaust.com>
---
 Documentation/config/gui.adoc |  5 -----
 git-gui/git-gui.sh            |  3 ---
 git-gui/lib/database.tcl      | 26 --------------------------
 git-gui/po/bg.po              | 16 ----------------
 git-gui/po/de.po              | 17 -----------------
 git-gui/po/el.po              | 17 -----------------
 git-gui/po/fr.po              | 18 ------------------
 git-gui/po/hu.po              | 17 -----------------
 git-gui/po/it.po              | 16 ----------------
 git-gui/po/ja.po              | 16 ----------------
 git-gui/po/nb.po              | 17 -----------------
 git-gui/po/pt_br.po           | 17 -----------------
 git-gui/po/pt_pt.po           | 17 -----------------
 git-gui/po/ru.po              | 10 ----------
 git-gui/po/sv.po              | 17 -----------------
 git-gui/po/vi.po              | 17 -----------------
 git-gui/po/zh_cn.po           | 16 ----------------
 17 files changed, 262 deletions(-)

diff --git a/Documentation/config/gui.adoc b/Documentation/config/gui.ad=
oc
index 1565c0af19..171be774d2 100644
--- a/Documentation/config/gui.adoc
+++ b/Documentation/config/gui.adoc
@@ -55,8 +55,3 @@ gui.blamehistoryctx::
 	linkgit:gitk[1] for the selected commit, when the `Show History
 	Context` menu item is invoked from 'git gui blame'. If this
 	variable is set to zero, the whole history is shown.
-
-gui.GCWarning::
-	Determines whether linkgit:git-gui[1] should prompt for garbage
-	collection when git detects a large number of loose objects in
-	the repository. The default value is "true".
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index d3d3aa14a9..29b708f9c8 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3940,9 +3940,6 @@ after 1 {
 		$ui_comm configure -state disabled -background gray
 	}
 }
-if {[is_enabled multicommit] && ![is_config_false gui.gcwarning]} {
-	after 1000 hint_gc
-}
 if {[is_enabled retcode]} {
 	bind . <Destroy> {+terminate_me %W}
 }
diff --git a/git-gui/lib/database.tcl b/git-gui/lib/database.tcl
index 78732d8651..9b4cc98df5 100644
--- a/git-gui/lib/database.tcl
+++ b/git-gui/lib/database.tcl
@@ -86,29 +86,3 @@ proc do_fsck_objects {} {
 	lappend cmd --strict
 	console::exec $w $cmd
 }
-
-proc hint_gc {} {
-	set ndirs 1
-	set limit 8
-	if {[is_Windows]} {
-		set ndirs 4
-		set limit 1
-	}
-
-	set count [llength [glob \
-		-nocomplain \
-		-- \
-		[gitdir objects 4\[0-[expr {$ndirs-1}]\]/*]]]
-
-	if {$count >=3D $limit * $ndirs} {
-		set objects_current [expr {$count * 256/$ndirs}]
-		if {[ask_popup \
-			[mc "This repository currently has approximately %i loose objects.
-
-To maintain optimal performance it is strongly recommended that you com=
press the database.
-
-Compress the database now?" $objects_current]] eq yes} {
-			do_gc
-		}
-	}
-}
diff --git a/git-gui/po/bg.po b/git-gui/po/bg.po
index ff5adb25cc..2670bbb4ef 100644
--- a/git-gui/po/bg.po
+++ b/git-gui/po/bg.po
@@ -1167,22 +1167,6 @@ msgstr "=D0=9A=D0=BE=D0=BC=D0=BF=D1=80=D0=B5=D1=81=
=D0=B8=D1=80=D0=B0=D0=BD=D0=B5 =D0=BD=D0=B0 =D0=B1=D0=B0=D0=B7=D0=B0=D1=82=
=D0=B0 =D1=81 =D0=B4=D0=B0=D0=BD=D0=BD=D0=B8 =D0=B7=D0=B0 =D0=BE=D0=B1=D0=
=B5=D0=BA=D1=82
 msgid "Verifying the object database with fsck-objects"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=BD=D0=B0 =D0=
=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D1=81 =D0=B4=D0=B0=D0=BD=D0=BD=D0=B8 =
=D0=B7=D0=B0 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8=D1=82=D0=B5 =D1=81 =D0=
=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=B0=D1=82=D0=B0 =E2=80=9Efsck-=
objects=E2=80=9C"
=20
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"=D0=92 =D1=82=D0=BE=D0=B2=D0=B0 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D0=BB=D0=
=B8=D1=89=D0=B5 =D0=B2 =D0=BC=D0=BE=D0=BC=D0=B5=D0=BD=D1=82=D0=B0 =D0=B8=
=D0=BC=D0=B0 =D0=BA=D1=8A=D0=BC %i =D0=BD=D0=B5=D0=BF=D0=B0=D0=BA=D0=B5=D1=
=82=D0=B8=D1=80=D0=B0=D0=BD=D0=B8 =D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8.\=
n"
-"\n"
-"=D0=97=D0=B0 =D0=B4=D0=BE=D0=B1=D1=80=D0=B0 =D0=BF=D1=80=D0=BE=D0=B8=D0=
=B7=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D0=BD=D0=BE=D1=81=D1=82 =D1=
=81=D0=B5 =D0=BF=D1=80=D0=B5=D0=BF=D0=BE=D1=80=D1=8A=D1=87=D0=B2=D0=B0 =D0=
=B4=D0=B0 =D0=BA=D0=BE=D0=BC=D0=BF=D1=80=D0=B5=D1=81=D0=B8=D1=80=D0=B0=D1=
=82=D0=B5 =D0=B1=D0=B0=D0=B7=D0=B0=D1=82=D0=B0 =D1=81 =D0=B4=D0=B0=D0=BD=
=D0=BD=D0=B8 =D0=B7=D0=B0 "
-"=D0=BE=D0=B1=D0=B5=D0=BA=D1=82=D0=B8=D1=82=D0=B5.\n"
-"\n"
-"=D0=94=D0=B0 =D1=81=D0=B5 =D0=B7=D0=B0=D0=BF=D0=BE=D1=87=D0=BD=D0=B5 =D0=
=BB=D0=B8 =D0=BA=D0=BE=D0=BC=D0=BF=D1=80=D0=B5=D1=81=D0=B8=D1=80=D0=B0=D0=
=BD=D0=B5=D1=82=D0=BE?"
-
 #, tcl-format
 msgid "Invalid date from Git: %s"
 msgstr "=D0=9D=D0=B5=D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=BD=D0=B8 =D0=
=B4=D0=B0=D0=BD=D0=BD=D0=B8 =D0=BE=D1=82 Git: %s"
diff --git a/git-gui/po/de.po b/git-gui/po/de.po
index a8d5f61ca3..490ed25e0d 100644
--- a/git-gui/po/de.po
+++ b/git-gui/po/de.po
@@ -2682,23 +2682,6 @@ msgstr "Objektdatenbank komprimieren"
 msgid "Verifying the object database with fsck-objects"
 msgstr "Die Objektdatenbank durch =C2=BBfsck-objects=C2=AB =C3=BCberpr=C3=
=BCfen lassen"
=20
-#: lib/database.tcl:107
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"Dieses Repository enth=C3=A4lt ungef=C3=A4hr %i nicht verkn=C3=BCpfte =
Objekte.\n"
-"\n"
-"F=C3=BCr eine optimale Performance wird empfohlen, die Datenbank des R=
epository "
-"zu komprimieren.\n"
-"\n"
-"Soll die Datenbank jetzt komprimiert werden?"
-
 #: lib/error.tcl:20
 #, tcl-format
 msgid "%s: error"
diff --git a/git-gui/po/el.po b/git-gui/po/el.po
index 3634ba469d..1c77b98b14 100644
--- a/git-gui/po/el.po
+++ b/git-gui/po/el.po
@@ -1410,23 +1410,6 @@ msgid "Verifying the object database with fsck-ob=
jects"
 msgstr ""
 "=CE=93=CE=AF=CE=BD=CE=B5=CF=84=CE=B1=CE=B9 =CE=B5=CF=80=CE=B1=CE=BB=CE=
=AE=CE=B8=CE=B5=CF=85=CF=83=CE=B7 =CF=84=CE=B7=CF=82 =CE=B2=CE=AC=CF=83=CE=
=B7=CF=82 =CE=B4=CE=B5=CE=B4=CE=BF=CE=BC=CE=AD=CE=BD=CF=89=CE=BD =CE=B1=CE=
=BD=CF=84=CE=B9=CE=BA=CE=B5=CE=B9=CE=BC=CE=AD=CE=BD=CF=89=CE=BD =CE=BC=CE=
=B5 =CE=B1=CE=BD=CF=84=CE=B9=CE=BA=CE=B5=CE=AF=CE=BC=CE=B5=CE=BD=CE=B1 f=
sck"
=20
-#: lib/database.tcl:108
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database when more than %i loose objects exist.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"=CE=91=CF=85=CF=84=CF=8C =CF=84=CE=BF =CE=B1=CF=80=CE=BF=CE=B8=CE=B5=CF=
=84=CE=AE=CF=81=CE=B9=CE=BF =CE=AD=CF=87=CE=B5=CE=B9 =CE=B1=CF=85=CF=84=CE=
=AE =CF=84=CE=B7 =CF=83=CF=84=CE=B9=CE=B3=CE=BC=CE=AE =CF=80=CE=B5=CF=81=
=CE=AF=CF=80=CE=BF=CF=85 %i =CE=B5=CE=BB=CE=B5=CF=8D=CE=B8=CE=B5=CF=81=CE=
=B1 =CE=B1=CE=BD=CF=84=CE=B9=CE=BA=CE=B5=CE=AF=CE=BC=CE=B5=CE=BD=CE=B1.\=
n"
-"\n"
-"=CE=93=CE=B9=CE=B1 =CF=84=CE=B7 =CE=B4=CE=B9=CE=B1=CF=84=CE=AE=CF=81=CE=
=B7=CF=83=CE=B7 =CE=B2=CE=AD=CE=BB=CF=84=CE=B9=CF=83=CF=84=CF=89=CE=BD =CE=
=B5=CF=80=CE=B9=CE=B4=CF=8C=CF=83=CE=B5=CF=89=CE=BD =CF=83=CF=85=CE=BD=CE=
=B9=CF=83=CF=84=CE=AC=CF=84=CE=B1=CE=B9 =CE=BD=CE=B1 =CF=83=CF=85=CE=BC=CF=
=80=CE=B9=CE=AD=CF=83=CE=B5=CF=84=CE=B5 =CF=84=CE=B7 =CE=B2=CE=AC=CF=83=CE=
=B7 "
-"=CE=B4=CE=B5=CE=B4=CE=BF=CE=BC=CE=AD=CE=BD=CF=89=CE=BD =CF=8C=CF=84=CE=
=B1=CE=BD =CF=85=CF=80=CE=AC=CF=81=CF=87=CE=BF=CF=85=CE=BD =CF=80=CE=B5=CF=
=81=CE=B9=CF=83=CF=83=CF=8C=CF=84=CE=B5=CF=81=CE=B1 =CE=B1=CF=80=CF=8C %=
i =CE=B5=CE=BB=CE=B5=CF=8D=CE=B8=CE=B5=CF=81=CE=B1 =CE=B1=CE=BD=CF=84=CE=
=B9=CE=BA=CE=B5=CE=AF=CE=BC=CE=B5=CE=BD=CE=B1.\n"
-"\n"
-"=CE=A3=CF=85=CE=BC=CF=80=CE=AF=CE=B5=CF=83=CE=B7 =CF=84=CE=B7=CF=82 =CE=
=B2=CE=AC=CF=83=CE=B7=CF=82 =CE=B4=CE=B5=CE=B4=CE=BF=CE=BC=CE=AD=CE=BD=CF=
=89=CE=BD =CF=84=CF=8E=CF=81=CE=B1;"
-
 #: lib/date.tcl:25
 #, tcl-format
 msgid "Invalid date from Git: %s"
diff --git a/git-gui/po/fr.po b/git-gui/po/fr.po
index 878df65399..9da3e09ba2 100644
--- a/git-gui/po/fr.po
+++ b/git-gui/po/fr.po
@@ -1556,24 +1556,6 @@ msgstr "Compression de la base des objets"
 msgid "Verifying the object database with fsck-objects"
 msgstr "V=C3=A9rification de la base des objets avec fsck-objects"
=20
-#: lib/database.tcl:107
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"Ce d=C3=A9p=C3=B4t comprend actuellement environ %i objets ayant leur =
fichier "
-"particulier.\n"
-"\n"
-"Pour conserver une performance optimale, il est fortement recommand=C3=
=A9 de "
-"comprimer la base de donn=C3=A9e.\n"
-"\n"
-"Comprimer la base maintenant ?"
-
 #: lib/date.tcl:25
 #, tcl-format
 msgid "Invalid date from Git: %s"
diff --git a/git-gui/po/hu.po b/git-gui/po/hu.po
index d106dadac8..4404af74d6 100644
--- a/git-gui/po/hu.po
+++ b/git-gui/po/hu.po
@@ -1505,23 +1505,6 @@ msgstr "Az objektum adatb=C3=A1zis t=C3=B6m=C3=B6=
r=C3=ADt=C3=A9se"
 msgid "Verifying the object database with fsck-objects"
 msgstr "Az objektum adatb=C3=A1zis ellen=C5=91rz=C3=A9se az fsck-object=
s haszn=C3=A1lat=C3=A1val"
=20
-#: lib/database.tcl:108
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database when more than %i loose objects exist.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"Ennek a rep=C3=B3nak jelenleg %i k=C3=BCl=C3=B6n=C3=A1ll=C3=B3 objektu=
ma van.\n"
-"\n"
-"Az optim=C3=A1lis teljes=C3=ADtm=C3=A9nyhez er=C5=91sen aj=C3=A1nlott =
az adatb=C3=A1zis t=C3=B6m=C3=B6r=C3=ADt=C3=A9se, ha "
-"t=C3=B6bb mint %i objektum l=C3=A9tezik.\n"
-"\n"
-"Lehet most t=C3=B6m=C3=B6r=C3=ADteni az adatb=C3=A1zist?"
-
 #: lib/date.tcl:25
 #, tcl-format
 msgid "Invalid date from Git: %s"
diff --git a/git-gui/po/it.po b/git-gui/po/it.po
index 1bd8b8e04f..b590dfbbd0 100644
--- a/git-gui/po/it.po
+++ b/git-gui/po/it.po
@@ -1552,22 +1552,6 @@ msgstr "Compressione dell'archivio in corso"
 msgid "Verifying the object database with fsck-objects"
 msgstr "Verifica dell'archivio con fsck-objects in corso"
=20
-#: lib/database.tcl:107
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"Questo archivio attualmente ha circa %i oggetti slegati.\n"
-"\n"
-"Per mantenere buone prestazioni si raccomanda di comprimere l'archivio=
.\n"
-"\n"
-"Comprimere l'archivio ora?"
-
 #: lib/date.tcl:25
 #, tcl-format
 msgid "Invalid date from Git: %s"
diff --git a/git-gui/po/ja.po b/git-gui/po/ja.po
index 2f61153ab9..d52bcd7f8c 100644
--- a/git-gui/po/ja.po
+++ b/git-gui/po/ja.po
@@ -1939,22 +1939,6 @@ msgstr "=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=
=BC=E3=82=B9=E5=9C=A7=E7=B8=AE"
 msgid "Verifying the object database with fsck-objects"
 msgstr "fsck-objects =E3=81=A7=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=
=AF=E3=83=88=E3=83=BB=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=
=B9=E3=82=92=E6=A4=9C=E8=A8=BC=E3=81=97=E3=81=A6=E3=81=84=E3=81=BE=E3=81=
=99"
=20
-#: lib/database.tcl:107
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"=E3=81=93=E3=81=AE=E3=83=AA=E3=83=9D=E3=82=B8=E3=83=88=E3=83=AA=E3=81=AB=
=E3=81=AF=E3=81=8A=E3=81=8A=E3=82=88=E3=81=9D %i =E5=80=8B=E3=81=AE=E5=80=
=8B=E5=88=A5=E3=82=AA=E3=83=96=E3=82=B8=E3=82=A7=E3=82=AF=E3=83=88=E3=81=
=8C=E3=81=82=E3=82=8A=E3=81=BE=E3=81=99\n"
-"\n"
-"=E6=9C=80=E9=81=A9=E3=81=AA=E6=80=A7=E8=83=BD=E3=82=92=E4=BF=9D=E3=81=A4=
=E3=81=9F=E3=82=81=E3=81=AB=E3=80=81=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=
=E3=83=BC=E3=82=B9=E3=82=92=E5=9C=A7=E7=B8=AE=E3=81=99=E3=82=8B=E3=81=93=
=E3=81=A8=E3=82=92=E6=8E=A8=E5=A5=A8=E3=81=97=E3=81=BE=E3=81=99\n"
-"\n"
-"=E3=83=87=E3=83=BC=E3=82=BF=E3=83=99=E3=83=BC=E3=82=B9=E3=82=92=E5=9C=A7=
=E7=B8=AE=E3=81=97=E3=81=BE=E3=81=99=E3=81=8B=EF=BC=9F"
-
 #: lib/transport.tcl:6 lib/remote_add.tcl:132
 #, tcl-format
 msgid "fetch %s"
diff --git a/git-gui/po/nb.po b/git-gui/po/nb.po
index d66aa50263..4b6e5136b0 100644
--- a/git-gui/po/nb.po
+++ b/git-gui/po/nb.po
@@ -1462,23 +1462,6 @@ msgstr "Komprimerer objektdatabasen"
 msgid "Verifying the object database with fsck-objects"
 msgstr "Verifiserer objektdatabasen med fsck-objects"
=20
-#: lib/database.tcl:108
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database when more than %i loose objects exist.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"Dette arkivet inneholder omtrent %i 'l=C3=B8se' objekter.\n"
-"\n"
-"For =C3=A5 sikre en optimal ytelse er det sterkt anbefalt at du kompri=
merer "
-"databasen n=C3=A5r det er flere enn %i 'l=C3=B8se' objekter i den.\n"
-"\n"
-"Komprimere databasen n=C3=A5?"
-
 #: lib/date.tcl:25
 #, tcl-format
 msgid "Invalid date from Git: %s"
diff --git a/git-gui/po/pt_br.po b/git-gui/po/pt_br.po
index bad116c780..8580aaaece 100644
--- a/git-gui/po/pt_br.po
+++ b/git-gui/po/pt_br.po
@@ -1541,23 +1541,6 @@ msgstr "Compactando banco de dados de objetos"
 msgid "Verifying the object database with fsck-objects"
 msgstr "Verificando banco de dados de objetos com fsck-objects"
=20
-#: lib/database.tcl:107
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"Este reposit=C3=B3rio possui aproximadamente %i objetos soltos.\n"
-"\n"
-"Para manter o desempenho =C3=B3timo =C3=A9 altamente recomendado que v=
oc=C3=AA compacte o "
-"banco de dados.\n"
-"\n"
-"Compactar o banco de dados agora?"
-
 #: lib/date.tcl:25
 #, tcl-format
 msgid "Invalid date from Git: %s"
diff --git a/git-gui/po/pt_pt.po b/git-gui/po/pt_pt.po
index 0ef3c7927d..e6354ce5c0 100644
--- a/git-gui/po/pt_pt.po
+++ b/git-gui/po/pt_pt.po
@@ -2537,23 +2537,6 @@ msgstr "A comprimir a base de dados de objetos"
 msgid "Verifying the object database with fsck-objects"
 msgstr "A verificar a base de dados de objetos com fsck-objects"
=20
-#: lib/database.tcl:107
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"Este reposit=C3=B3rio tem aproximadamente %i objetos soltos.\n"
-"\n"
-"Para manter o desempenho =C3=B3timo =C3=A9 veemente recomendado que co=
mprima a base de "
-"dados.\n"
-"\n"
-"Comprimir a base de dados agora?"
-
 #: lib/error.tcl:20 lib/error.tcl:116
 msgid "error"
 msgstr "erro"
diff --git a/git-gui/po/ru.po b/git-gui/po/ru.po
index 7aebaf809d..4761cc1adb 100644
--- a/git-gui/po/ru.po
+++ b/git-gui/po/ru.po
@@ -2507,16 +2507,6 @@ msgstr "=D0=A1=D0=B6=D0=B0=D1=82=D0=B8=D0=B5 =D0=B1=
=D0=B0=D0=B7=D1=8B =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2"
 msgid "Verifying the object database with fsck-objects"
 msgstr "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=D0=B0 =D0=B1=D0=B0=D0=
=B7=D1=8B =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2 =D0=BF=D1=80=D0=
=B8 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D0=B8 fsck"
=20
-#: lib/database.tcl:107
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress the database.\n"
-"\n"
-"Compress the database now?"
-msgstr "=D0=AD=D1=82=D0=BE=D1=82 =D1=80=D0=B5=D0=BF=D0=BE=D0=B7=D0=B8=D1=
=82=D0=BE=D1=80=D0=B8=D0=B9 =D1=81=D0=B5=D0=B9=D1=87=D0=B0=D1=81 =D1=81=D0=
=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D1=82 =D0=BF=D1=80=D0=B8=D0=BC=D0=B5=D1=
=80=D0=BD=D0=BE %i =D1=81=D0=B2=D0=BE=D0=B1=D0=BE=D0=B4=D0=BD=D1=8B=D1=85=
 =D0=BE=D0=B1=D1=8A=D0=B5=D0=BA=D1=82=D0=BE=D0=B2\n\n=D0=94=D0=BB=D1=8F =
=D0=BB=D1=83=D1=87=D1=88=D0=B5=D0=B9 =D0=BF=D1=80=D0=BE=D0=B8=D0=B7=D0=B2=
=D0=BE=D0=B4=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE=D1=81=D1=82=D0=B8=
 =D1=80=D0=B5=D0=BA=D0=BE=D0=BC=D0=B5=D0=BD=D0=B4=D1=83=D0=B5=D1=82=D1=81=
=D1=8F =D1=81=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=B0=D0=B7=D1=83 =D0=B4=D0=
=B0=D0=BD=D0=BD=D1=8B=D1=85.\n\n=D0=A1=D0=B6=D0=B0=D1=82=D1=8C =D0=B1=D0=
=B0=D0=B7=D1=83 =D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D1=85 =D1=81=D0=B5=D0=B9=D1=
=87=D0=B0=D1=81?"
-
 #: lib/error.tcl:20
 #, tcl-format
 msgid "%s: error"
diff --git a/git-gui/po/sv.po b/git-gui/po/sv.po
index de65c18584..06835f133a 100644
--- a/git-gui/po/sv.po
+++ b/git-gui/po/sv.po
@@ -1612,23 +1612,6 @@ msgstr "Komprimerar objektdatabasen"
 msgid "Verifying the object database with fsck-objects"
 msgstr "Verifierar objektdatabasen med fsck-objects"
=20
-#: lib/database.tcl:107
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"Arkivet har f=C3=B6r n=C3=A4rvarande omkring %i l=C3=B6sa objekt.\n"
-"\n"
-"F=C3=B6r att bibeh=C3=A5lla optimal prestanda rekommenderas det =C3=A5=
 det best=C3=A4mdaste att "
-"du komprimerar databasen.\n"
-"\n"
-"Komprimera databasen nu?"
-
 #: lib/date.tcl:25
 #, tcl-format
 msgid "Invalid date from Git: %s"
diff --git a/git-gui/po/vi.po b/git-gui/po/vi.po
index d956b59a9e..ad0ec7816c 100644
--- a/git-gui/po/vi.po
+++ b/git-gui/po/vi.po
@@ -1598,23 +1598,6 @@ msgstr "N=C3=A9n c=C6=A1 s=E1=BB=9F d=E1=BB=AF li=
=E1=BB=87u =C4=91=E1=BB=91i t=C6=B0=E1=BB=A3ng"
 msgid "Verifying the object database with fsck-objects"
 msgstr "=C4=90ang ki=E1=BB=83m tra c=C6=A1 s=E1=BB=9F d=E1=BB=AF li=E1=BB=
=87u =C4=91=E1=BB=91i t=C6=B0=E1=BB=A3ng b=E1=BA=B1ng l=E1=BB=87nh fsck"
=20
-#: lib/database.tcl:107
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"Hi=E1=BB=87n kho n=C3=A0y m=E1=BA=A5t =C6=B0=E1=BB=9Bc ch=E1=BB=ABng k=
ho=E1=BA=A3ng %i =C4=91=E1=BB=91i t=C6=B0=E1=BB=A3ng.\n"
-"\n"
-"=C4=90=E1=BB=83 t=E1=BB=91i =C6=B0u h=C3=B3a hi=E1=BB=87u su=E1=BA=A5t=
, khuy=E1=BA=BFn ngh=E1=BB=8B b=E1=BA=A1n n=C3=AAn n=C3=A9n c=C6=A1 s=E1=
=BB=9F d=E1=BB=AF li=E1=BB=87u c=E1=BB=A7a m=C3=ACnh "
-"l=E1=BA=A1i.\n"
-"\n"
-"N=C3=A9n c=C6=A1 s=E1=BB=9F d=E1=BB=AF li=E1=BB=87u ch=E1=BB=A9?"
-
 #: lib/date.tcl:25
 #, tcl-format
 msgid "Invalid date from Git: %s"
diff --git a/git-gui/po/zh_cn.po b/git-gui/po/zh_cn.po
index 91c1be23c2..4412d4ea44 100644
--- a/git-gui/po/zh_cn.po
+++ b/git-gui/po/zh_cn.po
@@ -1388,22 +1388,6 @@ msgstr "=E5=8E=8B=E7=BC=A9=E5=AF=B9=E8=B1=A1=E6=95=
=B0=E6=8D=AE=E5=BA=93"
 msgid "Verifying the object database with fsck-objects"
 msgstr "=E4=BD=BF=E7=94=A8 fsck-objects =E9=AA=8C=E8=AF=81=E5=AF=B9=E8=B1=
=A1=E6=95=B0=E6=8D=AE=E5=BA=93"
=20
-#: lib/database.tcl:108
-#, tcl-format
-msgid ""
-"This repository currently has approximately %i loose objects.\n"
-"\n"
-"To maintain optimal performance it is strongly recommended that you co=
mpress "
-"the database when more than %i loose objects exist.\n"
-"\n"
-"Compress the database now?"
-msgstr ""
-"=E8=AF=A5=E7=89=88=E6=9C=AC=E5=BA=93=E5=BD=93=E5=89=8D=E7=BA=A6=E6=9C=89=
 %i =E4=B8=AA=E6=9D=BE=E6=95=A3=E5=AF=B9=E8=B1=A1.\n"
-"\n"
-"=E4=B8=BA=E8=BE=BE=E5=88=B0=E8=BE=83=E4=BC=98=E7=9A=84=E6=80=A7=E8=83=BD=
=EF=BC=8C=E5=BC=BA=E7=83=88=E5=BB=BA=E8=AE=AE=E4=BD=A0=E5=9C=A8=E6=9D=BE=
=E6=95=A3=E5=AF=B9=E8=B1=A1=E5=A4=9A=E4=BA=8E %i =E6=97=B6=E5=8E=8B=E7=BC=
=A9=E6=95=B0=E6=8D=AE=E5=BA=93.\n"
-"\n"
-"=E7=8E=B0=E5=9C=A8=E5=B0=B1=E5=8E=8B=E7=BC=A9=E6=95=B0=E6=8D=AE=E5=BA=93=
=E4=B9=88?"
-
 #: lib/date.tcl:25
 #, tcl-format
 msgid "Invalid date from Git: %s"
--=20
2.52.0
