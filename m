Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187224B28
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122294; cv=none; b=UGLuMT0GMzTUrjurrP2Wa2dk38cer3WD472gpDkDxFhCB6b5ENnZFzdu0tIfxto7YlmYWXMbzWXdfM19R1NLJaIiU+Md89SpGVEUVdSlcu96DlQdEW1d3WB45yekPcU9isZL9Bpoze6iXbc1iROjFJA8X4sN10Q4PH1x3pTSCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122294; c=relaxed/simple;
	bh=JvFs6/0p3DV01WAdTqi0V75QpljsRaE5K4bMss/+l9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDhLAvvYBUB/KAMSXJCTfoMB8YYwoZ8bnCJNbpOMLSbYtHh2IJmb0ZwR9QX3NY0eV4Kpu84XNYyjTMFIoXqS8CQKB2g3IXj1KYH5rRmnvQmL30I8bidsS/zBRsMf2efprpai4zr9/l+rHpoF/CVCEuDDRMSlOU9rwNyC4nWqN54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoILDtwk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoILDtwk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cb7139d9dso24859375ad.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 09:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732122292; x=1732727092; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LKg2xMw23Tbnox1Jb+oz+WCWQ4LwF+f6f4yOTX6BqE8=;
        b=HoILDtwkPEpIRTYfys11YMTW9pk3ijU6yz/NQr7wX1k3eQFGeT6h1ABTG4T2XopewF
         WU4WFGN6l/EKfRZYIic30ZE4r1Kv7z1voQeZ1i6F2eNjM0bqVixjSoWNo0QvTO/L9r54
         Rccfn5Dr8xQT/UIDygbxpRzu48VtS9wyi7Xhj5Cbgvu1HnXXdPq5IwHN2l8aOgUFIwYl
         n56A8ed1cip4HJrV4beVrxrzLhsMao5WfUo+BBmk4Zwpy/+3evMncdw0IOQV7Fp0hKtk
         gpC84zoEjGB2/foci8LJ1RF3l7/xpkFgtEbehsc4VFPs+HFTC5JBpKnuXWtq9RwEMhXr
         sTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732122292; x=1732727092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKg2xMw23Tbnox1Jb+oz+WCWQ4LwF+f6f4yOTX6BqE8=;
        b=a+Lc1aDNxA5MAcMNdiyzBc0nkF7qLGtqJ7CmM+wVG67N52kJ8qzDr+ksfPqhG05voJ
         71ki8Z6RlSx2gU/CIuDyGc+BdDxAW2OJjb6nqW9nubHcwLAb/p79iBMXUFoeKbn8y7ev
         5qdydjNRvLONhu4xBRHeC9zkLK2N/Rb9WlPGRozdkg6GnLZKf3ncZbqqYaQ0NUcwZlob
         X8LR9TBZby5h6W2//Kj290KofDAasZs3RnQLJA9zTGndzYL18M7kfxhofkoibPrV4C1D
         4Zug0RwzDAcQ09sHyLdgun5X8zRb2xTxc5sqzfJPREpYqkEDOYwjrgukr9gQEkXJruPF
         S96w==
X-Forwarded-Encrypted: i=1; AJvYcCVCQdhNKXuoZ594/ccOEFfYO3Dod5iGAT6A/IhKnJnV4ZnvFwwLKgDIpB+khHvy+Q5W+dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5l09cD+4GRHO0GNhAej0rEKaT3rQK7gBYguudYGFBSFn31P5p
	oSTEhEpxQUhXcytpk1gz8E08F12cuSZtKAlRzyfTp+5Ava2cl7WbYEUGMQ==
X-Gm-Gg: ASbGnctzgfy58988vVqypBnepQVY7ppMVVEj2hRfuOnigiHA/P4YgduGHC/q7OFJevD
	mMWus4f5DCIPsYr5c8KqglluHIQHQTgZGN7KJ1tMQ6z8CM2/GXUoYP+tVGla5yYZ1D7LzFZ8GMh
	LgYuW9gKEuCACShoQgBvtSsPBLYiULBByi1dPlrDx4P7X2f3C0YCUQTnzYc4bjP7IGl0rR3Kl0r
	k7Pe0DduuPy709vXA9ZVQl7X7zNC1jQZkC5qubJWP2fLDMGqYrL
X-Google-Smtp-Source: AGHT+IF/g4qa87o3u0Y6uVXJZ/VgpqaxAV1wEenUQaD913WEdZ+qmeNG/VliMu+LNyF2SmkrbIDAWQ==
X-Received: by 2002:a17:903:298f:b0:211:fcad:d6d0 with SMTP id d9443c01a7336-2126a456d4dmr48819695ad.36.1732122291496;
        Wed, 20 Nov 2024 09:04:51 -0800 (PST)
Received: from five231003 ([2405:201:c006:3236:b8c0:221f:85e0:a708])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f47adbsm93909415ad.223.2024.11.20.09.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:04:51 -0800 (PST)
Date: Wed, 20 Nov 2024 22:34:47 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] ref-filter: add "notes" atom
Message-ID: <Zz4Wr1YY7HxRARoc@five231003>
References: <D5N39IJA0WDQ.2WH1MNIP77X2J@ferdinandy.com>
 <xmqqsersyrch.fsf@gitster.g>
 <D5NP6QUUBWBL.7OUG34RUIE2S@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D5NP6QUUBWBL.7OUG34RUIE2S@ferdinandy.com>

On Sat, Nov 16, 2024 at 04:11:17PM +0100, Bence Ferdinandy wrote:
> 
> On Sat Nov 16, 2024 at 01:06, Junio C Hamano <gitster@pobox.com> wrote:
> > "Bence Ferdinandy" <bence@ferdinandy.com> writes:
> >
> >> based on the man pages it doesn't seem possible, but maybe I'm missing something.
> >>
> >> I would like to put together a "log --format=" which is similar to --oneline,
> >> but where if there's a note for the commit it's marked with e.g. a notebook
> >> symbol. There's %N, but that prints the entire note, so it doesn't work well
> >> with one commit per line.
> >
> > I do not think it is doable.  Unlike the format language in the
> > for-each-ref/branch --list family of commands, the pretty-format
> > language in the log family of commands lack more involved
> > conditional formatting features.
> >
> > Unifying these two formatting languages to port features from one to
> > the other would be needed, I guess.  
> 
> Is this already on the roadmap with a plan on how to do it? It sounds like
> switching log format to the same formatting as the other commands would make
> life easier in the long run.

Yes, but a fixed plan doesn't exist really.  There has been effort in
the past (and even now) to re-implement formats from pretty in ref-filter
and when that is done, change everything to use ref-filter, but the parsing
mechanism in ref-filter is a bit broken in some really really rare cases [1].

> > If we had a note support in the
> > latter,  something like
> >
> > $ git branch -l --format='%(subject)%(if)%(note:amlog)%(then)📓%(end)'
> >
> > may have worked.
> 
> Conditional formatting definitely would sound useful for logs as well :)

I agree that having the "%(if)..." would be good in pretty.

[1] See thread

	https://lore.kernel.org/git/20241105190235.13502-1-five231003@gmail.com/



In the meantime, here is an implementation of "%(notes)" atom in
ref-filter.  I know this doesn't really address the "log" family since
we are not adding this format in pretty, but we can now do

	$ git branch -l --format='%(subject)%(if)%(notes:amlog)%(then)📓%(end)'

------------------------ >8 ------------------------
Subject: [PATCH] ref-filter: add "notes" atom

Introduce new "%(notes)" format which is capable of showing the notes
associated with any particular ref.  This new atom may also be given an
argument specifying where to look for the notes, for example
refs/notes/amlog, associated with the ref.

The behavior is the same as doing

	$ git notes show <refname>

for the bare "%(notes)" format and

	$ git notes --ref <notes-ref> show <refname>

for the "%(notes:notes-ref)" format.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 Documentation/git-for-each-ref.txt |  7 ++++
 ref-filter.c                       | 54 ++++++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 28 ++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d3764401a2..406e4a0390 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -329,6 +329,13 @@ exclude=<pattern>;;
 	in linkgit:git-describe[1] for details.
 --
 
+notes:<notes-ref>::
+	Show notes associated with a ref.  Defaults to getting notes
+	from `refs/notes/commits`.  If `"notes-ref"` is given then notes
+	retrieved from that ref are shown; for the given ref.  For
+	example, `%(notes:amlog)` will retrieve the notes from
+	`refs/notes/amlog` for the given ref.  See linkgit:git-notes[1].
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/ref-filter.c b/ref-filter.c
index 84c6036107..76c06178f2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -155,6 +155,7 @@ enum atom_type {
 	ATOM_TRAILERS,
 	ATOM_CONTENTS,
 	ATOM_SIGNATURE,
+	ATOM_NOTES,
 	ATOM_RAW,
 	ATOM_UPSTREAM,
 	ATOM_PUSH,
@@ -235,6 +236,7 @@ static struct used_atom {
 			       S_FINGERPRINT, S_PRI_KEY_FP, S_TRUST_LEVEL } option;
 		} signature;
 		struct strvec describe_args;
+		const char *notes_refname;
 		struct refname_atom refname;
 		char *head;
 	} u;
@@ -712,6 +714,15 @@ static int describe_atom_parser(struct ref_format *format UNUSED,
 	return 0;
 }
 
+static int notes_atom_parser(struct ref_format *format UNUSED,
+			     struct used_atom *atom,
+			     const char *arg, struct strbuf *err UNUSED)
+{
+	if (arg)
+		atom->u.notes_refname = arg;
+	return 0;
+}
+
 static int raw_atom_parser(struct ref_format *format UNUSED,
 			   struct used_atom *atom,
 			   const char *arg, struct strbuf *err)
@@ -974,6 +985,7 @@ static struct {
 	[ATOM_TRAILERS] = { "trailers", SOURCE_OBJ, FIELD_STR, trailers_atom_parser },
 	[ATOM_CONTENTS] = { "contents", SOURCE_OBJ, FIELD_STR, contents_atom_parser },
 	[ATOM_SIGNATURE] = { "signature", SOURCE_OBJ, FIELD_STR, signature_atom_parser },
+	[ATOM_NOTES] = { "notes", SOURCE_OBJ, FIELD_STR, notes_atom_parser },
 	[ATOM_RAW] = { "raw", SOURCE_OBJ, FIELD_STR, raw_atom_parser },
 	[ATOM_UPSTREAM] = { "upstream", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
 	[ATOM_PUSH] = { "push", SOURCE_NONE, FIELD_STR, remote_ref_atom_parser },
@@ -1957,6 +1969,44 @@ static void grab_describe_values(struct atom_value *val, int deref,
 	}
 }
 
+static void grab_notes_values(struct atom_value *val, int deref,
+			      struct object *obj)
+{
+	for (int i = 0; i < used_atom_cnt; i++) {
+		struct used_atom *atom = &used_atom[i];
+		const char *name = atom->name;
+		struct atom_value *v = &val[i];
+
+		struct child_process cmd = CHILD_PROCESS_INIT;
+		struct strbuf out = STRBUF_INIT;
+		struct strbuf err = STRBUF_INIT;
+
+		if (atom->atom_type != ATOM_NOTES)
+			continue;
+
+		if (!!deref != (*name == '*'))
+			continue;
+
+		cmd.git_cmd = 1;
+		strvec_push(&cmd.args, "notes");
+		if (atom->u.notes_refname) {
+			strvec_push(&cmd.args, "--ref");
+			strvec_push(&cmd.args, atom->u.notes_refname);
+		}
+		strvec_push(&cmd.args, "show");
+		strvec_push(&cmd.args, oid_to_hex(&obj->oid));
+		if (pipe_command(&cmd, NULL, 0, &out, 0, &err, 0) < 0) {
+			error(_("failed to run 'notes'"));
+			v->s = xstrdup("");
+			continue;
+		}
+		strbuf_rtrim(&out);
+		v->s = strbuf_detach(&out, NULL);
+
+		strbuf_release(&err);
+	}
+}
+
 /* See grab_values */
 static void grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data)
 {
@@ -2076,6 +2126,7 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		grab_sub_body_contents(val, deref, data);
 		grab_person("tagger", val, deref, buf);
 		grab_describe_values(val, deref, obj);
+		grab_notes_values(val, deref, obj);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
@@ -2084,14 +2135,17 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, s
 		grab_person("committer", val, deref, buf);
 		grab_signature(val, deref, obj);
 		grab_describe_values(val, deref, obj);
+		grab_notes_values(val, deref, obj);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
 		grab_sub_body_contents(val, deref, data);
+		grab_notes_values(val, deref, obj);
 		break;
 	case OBJ_BLOB:
 		/* grab_blob_values(val, deref, obj, buf, sz); */
 		grab_sub_body_contents(val, deref, data);
+		grab_notes_values(val, deref, obj);
 		break;
 	default:
 		die("Eh?  Object of type %d?", obj->type);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c39d4e7e9c..cf2ff26fd1 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -847,6 +847,34 @@ test_expect_success 'err on bad describe atom arg' '
 	)
 '
 
+test_expect_success 'bare notes atom' '
+	test_when_finished "git checkout main && git branch -D notes-atom " &&
+
+	git checkout -b notes-atom &&
+	test_commit --no-tag "commit on notes-atom" &&
+
+	git notes add -m "some msg" refs/heads/notes-atom &&
+	git notes show refs/heads/notes-atom >expect &&
+	git for-each-ref --format="%(notes)" refs/heads/notes-atom >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'notes atom with notes ref' '
+	test_when_finished \
+		"git checkout main && git branch -D notes-atom-refname" &&
+
+	git checkout -b notes-atom-refname &&
+	test_commit --no-tag "commit on notes-atom-refname" &&
+
+	git notes --ref notes-ref add -m "some msg" \
+		 refs/heads/notes-atom-refname &&
+	git notes --ref notes-ref show \
+		refs/heads/notes-atom-refname >expect &&
+	git for-each-ref --format="%(notes:notes-ref)" \
+		refs/heads/notes-atom-refname >actual &&
+	test_cmp expect actual
+'
+
 cat >expected <<\EOF
 heads/main
 tags/main
-- 
2.47.0.289.g3d75e57c9c

