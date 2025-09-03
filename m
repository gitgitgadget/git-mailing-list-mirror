Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F482FB99D
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901981; cv=none; b=okrNvOsnqedpwvj9ugx8b5y3Trl4E0sIIk445q8QiykoaSj88KRi7T2jNw2wWRiKbXfjTHBsF7FkcWKsN4dn08xs6jDW37aW17WOxKlM/K9Ib2no8HE9GgIAahkGdDrpBmV+7j76HDLRdgZflWPRZrGmg5iumI76s8rQ6i3I3pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901981; c=relaxed/simple;
	bh=1J0bXSohuDZSsAyV+qomDeNzPHyu5L6hz3mCXvHtvJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm74ovyt6bsRdnURnbbsrIGijbqlyhvm93hEfYh51dgDozjP0r7GmO0SKIKoqzGP9Hmv27zVmsddv3a202U4loKPIt8T2nMzeJZvdKYNxjHXPCPFJt/AUIII3Cqt6YzG4U2iVQ1NFCdBiSNab1wAsJECJ8Ermtb0JKA/sI3ZpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hGx1ffAA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dYrtVErP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hGx1ffAA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dYrtVErP"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D27651400421;
	Wed,  3 Sep 2025 08:19:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 03 Sep 2025 08:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756901977;
	 x=1756988377; bh=lIROLNARJA2WbnExF3SDfZVZ8MiRTpDBGljj1+fr45Q=; b=
	hGx1ffAAwEH4dJ6zhu9yyowQ9mZcBdTvCCaZnEE782UyVR0CY9aZhInnxfnazBH1
	gvkbhg4HWOY3CBDdOfgKOV+cI37JS/6bVXiVB6rMoSTYNJYXC7RJSVJ5TQjTyqRg
	OzAOJAcw2oeG/h3IIvEjj5GvaNanwnkF+lhbR4s6qE9YJHzm0aBt3hAeiq8WTD+f
	r0fL/0naZ0OA7li8GYBgJMmfLFcedPlee+GZTv2D0frwPMUfesWETeBFDWr9gbhg
	wq5BcHz+aCI8SZL0Oc5Q5FWDo7bMrdYu3J3QKVXvi+cWzcRpj04ezWyaMmf9dHx5
	uq3BMUROQbBGZwwE3uisyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756901977; x=
	1756988377; bh=lIROLNARJA2WbnExF3SDfZVZ8MiRTpDBGljj1+fr45Q=; b=d
	YrtVErPQ9pivqxBsQMQZmAIDtwz8WaVGab5c0Zu36q6qY1Ih9ZK46xh555rD0GTF
	KvxbBbSzrY0KO0spzldfpL3ADff4DWGGohPE/sSMGRSxIiICsWu/TEjoy+6+Uukx
	YbHWyDfDGHMQKhkovP27Up5TfvOXAyOYGyhPlsyzryRod8B8lO8FGKFrBfsFdLdC
	o+F7MnNfcMunTRVrSHIJXigzx8fTSEClGJqbHH1O1AL+lIKO/bXMRWy2Lexk2SKe
	2T4E/gOQNV11psc8rQO/aN6/9zN9hZtqqGFHM3XI8BvEzhyt3bb7K6rgH+Hc/DEh
	Vcztxq5ZejnY+Rl9l6ZcQ==
X-ME-Sender: <xms:WTK4aABGKEsB8nx2ZVa4eIFfCOmmcQ31zc727-KspghqxGIcBdF80Q>
    <xme:WTK4aAGqTaJ2HtHrMt0130niUZhDoNqvqZN2wC_MA5-BTxm-YPudGAa4ACtiCujPg
    zJ9ODXmSSGeNLWN4w>
X-ME-Received: <xmr:WTK4aKC2aQeqZHBoyJg9IlKXeRMb1A6eTemYUNucIRhT4alG83nu-KBte1VRw7U-nWCHL7ji42oLi38NtsZlUBkRTyYgzcCEXftBGf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvoh
    hniiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WTK4aIVWS4UNLYmsXMg3thrTZsKXY_spKj3R2sSYXYJhsX6Q_oDxDQ>
    <xmx:WTK4aGq0uNsGtKqFZ0Ng-IOFZHKJ8X2IPRksSJTSMZF_zyFuhLPYVw>
    <xmx:WTK4aMRoTjHDKHnyNWtkK7PzaoW8YPRmUlPXoj6Q4IrakZ0CLJDMfw>
    <xmx:WTK4aI2um4sqADPXDkomuxGD8gCGrfh3hKaFNCo5D7f9mnMpiC-zjw>
    <xmx:WTK4aF-sc74UA_MV3tBGYn9ftoeXSpDevkUzD1kU4aHPQ1qvM3aT7UlL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 08:19:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d86e6c5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 12:19:34 +0000 (UTC)
Date: Wed, 3 Sep 2025 14:19:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v2 03/16] sequencer: introduce new history editing
 mode
Message-ID: <aLgyUw7wkxTYd1Dm@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <20250824-b4-pks-history-builtin-v2-3-964ac12f65bd@pks.im>
 <CALnO6CBgGNdD7eRsseXVmTCkfi9TU6S46MckC6her0FzJNa=Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CBgGNdD7eRsseXVmTCkfi9TU6S46MckC6her0FzJNa=Wg@mail.gmail.com>

On Tue, Aug 26, 2025 at 08:55:13AM -0400, D. Ben Knoble wrote:
> On Sun, Aug 24, 2025 at 1:42 PM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/sequencer.c b/sequencer.c
> > index bff181df76..898ac1a2a8 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -3052,17 +3087,29 @@ static int read_populate_todo(struct repository *r,
> >                 return error(_("no commits parsed."));
> >
> >         if (!is_rebase_i(opts)) {
> > -               enum todo_command valid =
> > -                       opts->action == REPLAY_PICK ? TODO_PICK : TODO_REVERT;
> > +               enum todo_command valid;
> >                 int i;
> >
> > -               for (i = 0; i < todo_list->nr; i++)
> > +               switch (opts->action) {
> > +               case REPLAY_PICK:
> > +               case REPLAY_HISTORY_EDIT:
> > +                       valid = TODO_PICK;
> > +                       break;
> > +               default:
> > +                       valid = TODO_REVERT;
> > +                       break;
> > +               }
> 
> I think I see this hunk repeated in a few places—maybe some
> leftoverbits for a refactor?

Fair enough. I don't really see a strong reason why we shouldn't fix
this in the same patch though. We can for example do something like the
below patch.

Patrick

-- >8 --

diff --git a/sequencer.c b/sequencer.c
index 898ac1a2a8..9a66e7d128 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3063,6 +3063,19 @@ static void todo_list_write_total_nr(struct todo_list *todo_list)
 	}
 }
 
+static enum todo_command action_to_command(enum replay_action action)
+{
+	switch (action) {
+	case REPLAY_PICK:
+	case REPLAY_HISTORY_EDIT:
+		return TODO_PICK;
+	case REPLAY_REVERT:
+		return TODO_REVERT;
+	default:
+		BUG("unsupported action %d", action);
+	}
+}
+
 static int read_populate_todo(struct repository *r,
 			      struct todo_list *todo_list,
 			      struct replay_opts *opts)
@@ -3087,19 +3100,9 @@ static int read_populate_todo(struct repository *r,
 		return error(_("no commits parsed."));
 
 	if (!is_rebase_i(opts)) {
-		enum todo_command valid;
+		enum todo_command valid = action_to_command(opts->action);
 		int i;
 
-		switch (opts->action) {
-		case REPLAY_PICK:
-		case REPLAY_HISTORY_EDIT:
-			valid = TODO_PICK;
-			break;
-		default:
-			valid = TODO_REVERT;
-			break;
-		}
-
 		for (i = 0; i < todo_list->nr; i++) {
 			if (valid == todo_list->items[i].command)
 				continue;
@@ -3408,16 +3411,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	if (prepare_revs(opts))
 		return -1;
 
-	switch (opts->action) {
-	case REPLAY_PICK:
-	case REPLAY_HISTORY_EDIT:
-		command = TODO_PICK;
-		break;
-	default:
-		command = TODO_REVERT;
-		break;
-	}
-
+	command = action_to_command(opts->action);
 	command_string = todo_command_info[command].str;
 	encoding = get_log_output_encoding();
 
@@ -5578,15 +5572,7 @@ static int single_pick(struct repository *r,
 	int check_todo;
 	struct todo_item item;
 
-	switch (opts->action) {
-	case REPLAY_PICK:
-	case REPLAY_HISTORY_EDIT:
-		item.command = TODO_PICK;
-		break;
-	default:
-		item.command = TODO_REVERT;
-		break;
-	}
+	item.command = action_to_command(opts->action);
 	item.commit = cmit;
 
 	return do_pick_commit(r, &item, opts, 0, &check_todo);

