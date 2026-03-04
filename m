Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFA41D6BB
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587856; cv=none; b=j0yBxQJ6VHgfZjszrBQNxbOCRgJuhBun+OGkRmkyrHGhRIQltXNwlTkOp2oRGZKX4oCzXV/mC2J47vvkfoZiTfoou+CoF4jPph+GmkTTvrSaWLujLxMAMiuCt79759TZgLgwXCeU63mqbWJvzFim9IW1/giS7gqhghRQ1iPND30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587856; c=relaxed/simple;
	bh=UXtgxVhVN6W9q5Ya+Ls9wr/9sXuPvedcOXvKis3YLgY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N85ytbc7UBUVUZReS6qMJDKAjyHMC8BtYBFoOvdJnm/Vc7l/o0XqxX5AeFPuo8C37dUngna890IwFmmUEOmz+rT3qIvYHoAUAcrE6SdFcDjahzOhOTowWF6ZmdXFli/2tj/ADv8mjnIjJWAT+BHna7q7ljhlrrbgaTz3LhXyLTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com; spf=pass smtp.mailfrom=wolfgangfaust.com; dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b=LsJKNZY+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=COjEs+VY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfgangfaust.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wolfgangfaust.com header.i=@wolfgangfaust.com header.b="LsJKNZY+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="COjEs+VY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CCA0AEC0BDA;
	Tue,  3 Mar 2026 20:30:52 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-01.internal (MEProxy); Tue, 03 Mar 2026 20:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	wolfgangfaust.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772587852; x=1772674252; bh=vBHNvwQEgS
	oVeq0YdEqp238fOOwTJylEhrrY4pyp8BQ=; b=LsJKNZY+dloz65DHJ3tK7SccVN
	llC11/wIz6vnxhI8XQA9JQVeT+PfKaCYMZr+0qTaThZTvJBv6iUgItmeXdYkeBYP
	Uu3E28ReyRfSSBjpRkCsJ7g70xHh8jDYHBj/fE3Pg15lVpYo8Akka6oXLLejAUw9
	RFQPPkDRJ0qMvDoQFRLX+Nod/UhIUd7XD/17NPOpI+GJ7EYNz1RRByFVnQ/n5JyV
	t6nyM+uDlLvcyI/sPmDjvagv2qwPGCTL/OSmbadJrN6IzDXPScrLd2A2PBl3e9gQ
	1ZqrGHEfRkWgpvcsAJzvjuNe7K181aCw7esUnh6XIdN7bEBynzDqaEJya36g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772587852; x=
	1772674252; bh=vBHNvwQEgSoVeq0YdEqp238fOOwTJylEhrrY4pyp8BQ=; b=C
	OjEs+VYR0du8EnXJaCfyL+HvbWcw1mn1sbxiqoeGIfXoG/NpFt92KcF8r3Gz80ce
	8jd9ZmEjr3GlEdhxhHTuEx26CnpoWn2gKmw1dLSlgUouZq2q1+aVmbQexv5SltG1
	O2pSD4TXMt3hQb33ZnekO6q8BKVPNanzvJRDh8wz3Xi5ndjOtecwgEULqZe3A6k+
	JjzLu42E289u8AKfpqN4QXxnjJ5jpdMUSnL//+3eSUbli7x/qjJf1L6LuB+xXx29
	uK/j+RqVQnzPyDnNpSCya0GwsWljCobkT6ZaNPI+kkGa16Aj57LyzucSakNqbe+S
	xvuLrNK5uPT+PWs3Dsvhw==
X-ME-Sender: <xms:TIunaWw-aFAw3hLGeTZACG4e03_FgAKhK0ry1-snkBEiqH-N9wfPRA>
    <xme:TIunadFvlvPUuJYrrqBKCzEfoEYMMXso07nWjk-tuS48y_L4ZKqNrYFXscQNuqc7C
    SjJq761WtxC4KbLAaom4mxKnvDCKsH7jxfAOrZr74F6jL-RDh7yJ-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdghohhlfhhgrghnghcuhfgruhhsthdfuceotghonhhtrhhi
    sgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomheqnecuggftrfgrthhtvghrnh
    epleejkedujeeuffetgeevkefgfeegvedtffejhefghfegieettedttdfgtdefvdefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghonhhtrh
    hisgdqghhithesfiholhhfghgrnhhgfhgruhhsthdrtghomhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TIunaZcYL_9Swr2onIpgGM_YhmPqk-dejCe7xqjD4e_9CoOwLtWCBg>
    <xmx:TIunaVJrM7xAcqyIeXHhWS7gPTT9gDUQ6KEh6ZUOMPu70YbL6pWlAw>
    <xmx:TIunaaHbrkmMi35jDLU5jolPe9gLYZN31z7J4c7n1zTxwL6hISZC1Q>
    <xmx:TIunafoUyixedCjvLCpRl455Z-WStHWJRZzG4_pcMOCKIMNl3OBuyw>
    <xmx:TIunadh0CLa6G5-yofK6vmJaDbhVSfGoLUTWewQvIHFf6RgAKdWvqSXg>
Feedback-ID: ifd814412:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 96FD92CE0072; Tue,  3 Mar 2026 20:30:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AT0JpTLFp3rB
Date: Tue, 03 Mar 2026 17:30:52 -0800
From: "Wolfgang Faust" <contrib-git@wolfgangfaust.com>
To: "Johannes Sixt" <j6t@kdbg.org>
Cc: git@vger.kernel.org
Message-Id: <c2416342-dbb8-4003-b959-cb0ed2b00eeb@app.fastmail.com>
In-Reply-To: <08da87b1-32c6-43c2-be1f-d60bc93ea135@kdbg.org>
References: <a72715e2-c3ae-4050-95e3-7fc7f9b74b5d@app.fastmail.com>
 <08da87b1-32c6-43c2-be1f-d60bc93ea135@kdbg.org>
Subject: Re: [PATCH] git-gui: highlight comment lines in commit message
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

These lines are stripped by wash_commit_message, but there is no indication
in the UI that they are special and will be removed.
Add highlighting to make it clear these lines are special.

Signed-off-by: Wolfgang Faust <contrib-git@wolfgangfaust.com>
---
Updated per your comments, plus a couple of other minor tweaks.
Thank you for bearing with me as I figure out how to properly
send patches :-)

> please don't call it highlight, because we
> actually want to do the opposite, dim or grey out the text.

Thank you, "dim" is a better term.

> The regular expression can be simplified if we use -line matching.
> ... and we can turn this into a simple foreach loop...

Done, that looks much cleaner!

> (I wonder why we need the +1char, though.)

Without it, putting the cursor at the end of a comment line and typing
causes the newly inserted text to flash black briefly. Adding +1 puts
the tag on the other side of the cursor, so the newly added text is dim.
(The tradeoff is that putting the cursor at the end of the comment,
pressing enter, and typing causes the newly inserted text to be grey
briefly. I think this looks somewhat less bad than the other way around.)

 git-gui/git-gui.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index d3d3aa14a9..23fe76e498 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3900,6 +3900,24 @@ if {[winfo exists $ui_comm]} {
 
 	backup_commit_buffer
 
+	# Grey out comment lines (which are stripped from the final commit message by
+	# wash_commit_message).
+	$ui_comm tag configure commit_comment -foreground gray
+	proc dim_commit_comment_lines {} {
+		global ui_comm comment_string
+		$ui_comm tag remove commit_comment 1.0 end
+		set text [$ui_comm get 1.0 end]
+		# See also cmt_rx in wash_commit_message
+		set cmt_rx [strcat {^} [regsub -all {\W} $comment_string {\\&}]]
+		set ranges [regexp -all -indices -inline -line -- $cmt_rx $text]
+		foreach pair $ranges {
+			set idx "1.0 + [lindex $pair 0] chars"
+			$ui_comm tag add commit_comment $idx "$idx lineend + 1 char"
+		}
+	}
+	dim_commit_comment_lines
+	bind $ui_comm <<Modified>> { after idle dim_commit_comment_lines }
+
 	# -- If the user has aspell available we can drive it
 	#    in pipe mode to spellcheck the commit message.
 	#

base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
-- 
2.52.0
