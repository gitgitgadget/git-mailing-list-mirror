From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/27] fetch-pack.c: mark strings for translating
Date: Fri, 10 Jun 2016 19:27:00 +0700
Message-ID: <20160610122714.3341-14-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:32:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLYf-0001BX-QX
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932858AbcFJM3B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:29:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35707 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843AbcFJM27 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id t190so5071391pfb.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aplgUS12toZek34DF0itV6Q9vvyiponnCvRmnvVEIrI=;
        b=prYBJDklRNLGV7oROh0tvrmOlMEUolsCEryPNbZ4G+U2ENm27/SWfA3WRhS8d+SvNO
         k28XtAcPfvQ2j4df3pY1X2xmx0DuDsHK3+sblIA3Xd6/9zpbZHDJZDwYgQAd1TgXEOOR
         /gh+oenoeW1m36TBvSNDyzQa8HVhLvtyDYsU/utxlNxtW3xwMHAbCrQD7qU2Gook4iEj
         oqsnBcGTln7yOry73/DbMZdU623+9+vPdSLNKAWZ2UUbeVhgZ9MrfhjBtqvHVYcqM0kh
         OpQki9+CM/tuIXwFjMEsKJbQLdgBgxSSY8BFAiPgDjQg1ijdXXc/V1mHj3irLEUnURBJ
         fmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aplgUS12toZek34DF0itV6Q9vvyiponnCvRmnvVEIrI=;
        b=H+oxVsoJH2BSAyV5XecfGPubC1UE74rBCQN/vq4QQ5iHdP4LxGMZklxRVWMsm+UEkJ
         LG72R0duzx63ciIC3/jrOd8ooxsOD+YI6KmIWWDle8NXeIYmylmmOBA7hJgoY6ITzk2R
         e52L/EsGdPvguVUisuoAA9i+BVjNHJZzElUlBRKwdw8p6pYW/byRb/NKGEqxxwyYiEOc
         kNCx5uaiZmXzyYqJ1ZlCZDSeNueRXmkS0YwqIPblS8v9qAfl+Ji9O0r4ereAuUu7oc/0
         oTxAZBgIgQOoH6hVyIdd5/Spwbd94LTLG4wOnlRi0k+w89h02qWi6lur/NMsfhwNIXH2
         4uxw==
X-Gm-Message-State: ALyK8tJPZmI7blrKCY/SbACUoIQT0hGzJaYSeLFtwkREKkVdLQ2HiD7zkDn9PRCeiTLp2Q==
X-Received: by 10.98.87.149 with SMTP id i21mr2103131pfj.50.1465561733384;
        Fri, 10 Jun 2016 05:28:53 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id r85sm17510795pfr.48.2016.06.10.05.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:52 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:28:48 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297001>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fetch-pack.c | 75 ++++++++++++++++++++++++++++++----------------------=
--------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 4020744..08caf1d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -208,7 +208,7 @@ static void consume_shallow_list(struct fetch_pack_=
args *args, int fd)
 				continue;
 			if (starts_with(line, "unshallow "))
 				continue;
-			die("git fetch-pack: expected shallow list");
+			die(_("git fetch-pack: expected shallow list"));
 		}
 	}
 }
@@ -220,7 +220,7 @@ static enum ack_type get_ack(int fd, unsigned char =
*result_sha1)
 	const char *arg;
=20
 	if (!len)
-		die("git fetch-pack: expected ACK/NAK, got EOF");
+		die(_("git fetch-pack: expected ACK/NAK, got EOF"));
 	if (!strcmp(line, "NAK"))
 		return NAK;
 	if (skip_prefix(line, "ACK ", &arg)) {
@@ -238,7 +238,7 @@ static enum ack_type get_ack(int fd, unsigned char =
*result_sha1)
 			return ACK;
 		}
 	}
-	die("git fetch_pack: expected ACK/NAK, got '%s'", line);
+	die(_("git fetch_pack: expected ACK/NAK, got '%s'"), line);
 }
=20
 static void send_request(struct fetch_pack_args *args,
@@ -285,7 +285,7 @@ static int find_common(struct fetch_pack_args *args=
,
 	size_t state_len =3D 0;
=20
 	if (args->stateless_rpc && multi_ack =3D=3D 1)
-		die("--stateless-rpc requires multi_ack_detailed");
+		die(_("--stateless-rpc requires multi_ack_detailed"));
 	if (marked)
 		for_each_ref(clear_marks, NULL);
 	marked =3D 1;
@@ -357,23 +357,23 @@ static int find_common(struct fetch_pack_args *ar=
gs,
 		while ((line =3D packet_read_line(fd[0], NULL))) {
 			if (skip_prefix(line, "shallow ", &arg)) {
 				if (get_sha1_hex(arg, sha1))
-					die("invalid shallow line: %s", line);
+					die(_("invalid shallow line: %s"), line);
 				register_shallow(sha1);
 				continue;
 			}
 			if (skip_prefix(line, "unshallow ", &arg)) {
 				if (get_sha1_hex(arg, sha1))
-					die("invalid unshallow line: %s", line);
+					die(_("invalid unshallow line: %s"), line);
 				if (!lookup_object(sha1))
-					die("object not found: %s", line);
+					die(_("object not found: %s"), line);
 				/* make sure that it is parsed as shallow */
 				if (!parse_object(sha1))
-					die("error in object: %s", line);
+					die(_("error in object: %s"), line);
 				if (unregister_shallow(sha1))
-					die("no shallow found: %s", line);
+					die(_("no shallow found: %s"), line);
 				continue;
 			}
-			die("expected shallow/unshallow, got %s", line);
+			die(_("expected shallow/unshallow, got %s"), line);
 		}
 	} else if (!args->stateless_rpc)
 		send_request(args, fd[1], &req_buf);
@@ -412,8 +412,8 @@ static int find_common(struct fetch_pack_args *args=
,
 			do {
 				ack =3D get_ack(fd[0], result_sha1);
 				if (ack)
-					print_verbose(args, "got ack %d %s", ack,
-						      sha1_to_hex(result_sha1));
+					print_verbose(args, _("got %s %d %s"), "ack",
+						      ack, sha1_to_hex(result_sha1));
 				switch (ack) {
 				case ACK:
 					flushes =3D 0;
@@ -426,7 +426,7 @@ static int find_common(struct fetch_pack_args *args=
,
 					struct commit *commit =3D
 						lookup_commit(result_sha1);
 					if (!commit)
-						die("invalid commit %s", sha1_to_hex(result_sha1));
+						die(_("invalid commit %s"), sha1_to_hex(result_sha1));
 					if (args->stateless_rpc
 					 && ack =3D=3D ACK_common
 					 && !(commit->object.flags & COMMON)) {
@@ -452,7 +452,7 @@ static int find_common(struct fetch_pack_args *args=
,
 			} while (ack);
 			flushes--;
 			if (got_continue && MAX_IN_VAIN < in_vain) {
-				print_verbose(args, "giving up");
+				print_verbose(args, _("giving up"));
 				break; /* give up */
 			}
 		}
@@ -462,7 +462,7 @@ done:
 		packet_buf_write(&req_buf, "done\n");
 		send_request(args, fd[1], &req_buf);
 	}
-	print_verbose(args, "done");
+	print_verbose(args, _("done"));
 	if (retval !=3D 0) {
 		multi_ack =3D 0;
 		flushes++;
@@ -474,8 +474,8 @@ done:
 	while (flushes || multi_ack) {
 		int ack =3D get_ack(fd[0], result_sha1);
 		if (ack) {
-			print_verbose(args, "got ack (%d) %s", ack,
-				      sha1_to_hex(result_sha1));
+			print_verbose(args, _("got %s (%d) %s"), "ack",
+				      ack, sha1_to_hex(result_sha1));
 			if (ack =3D=3D ACK)
 				return 0;
 			multi_ack =3D 1;
@@ -520,7 +520,7 @@ static void mark_recent_complete_commits(struct fet=
ch_pack_args *args,
 					 unsigned long cutoff)
 {
 	while (complete && cutoff <=3D complete->item->date) {
-		print_verbose(args, "Marking %s as complete",
+		print_verbose(args, _("Marking %s as complete"),
 			      oid_to_hex(&complete->item->object.oid));
 		pop_most_recent_commit(&complete, COMPLETE);
 	}
@@ -666,7 +666,7 @@ static int everything_local(struct fetch_pack_args =
*args,
 				      ref->name);
 			continue;
 		}
-		print_verbose(args, "already have %s (%s)", sha1_to_hex(remote),
+		print_verbose(args, _("already have %s (%s)"), sha1_to_hex(remote),
 			      ref->name);
 	}
 	return retval;
@@ -702,8 +702,7 @@ static int get_pack(struct fetch_pack_args *args,
 		demux.data =3D xd;
 		demux.out =3D -1;
 		if (start_async(&demux))
-			die("fetch-pack: unable to fork off sideband"
-			    " demultiplexer");
+			die(_("fetch-pack: unable to fork off sideband demultiplexer"));
 	}
 	else
 		demux.out =3D xd[0];
@@ -711,7 +710,7 @@ static int get_pack(struct fetch_pack_args *args,
 	if (!args->keep_pack && unpack_limit) {
=20
 		if (read_pack_header(demux.out, &header))
-			die("protocol error: bad pack header");
+			die(_("protocol error: bad pack header"));
 		pass_header =3D 1;
 		if (ntohl(header.hdr_entries) < unpack_limit)
 			do_keep =3D 0;
@@ -767,7 +766,7 @@ static int get_pack(struct fetch_pack_args *args,
 	cmd.in =3D demux.out;
 	cmd.git_cmd =3D 1;
 	if (start_command(&cmd))
-		die("fetch-pack: unable to fork off %s", cmd_name);
+		die(_("fetch-pack: unable to fork off %s"), cmd_name);
 	if (do_keep && pack_lockfile) {
 		*pack_lockfile =3D index_pack_lockfile(cmd.out);
 		close(cmd.out);
@@ -783,9 +782,9 @@ static int get_pack(struct fetch_pack_args *args,
 			args->check_self_contained_and_connected &&
 			ret =3D=3D 0;
 	else
-		die("%s failed", cmd_name);
+		die(_("%s failed"), cmd_name);
 	if (use_sideband && finish_async(&demux))
-		die("error in sideband demultiplexer");
+		die(_("error in sideband demultiplexer"));
 	return 0;
 }
=20
@@ -812,34 +811,34 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
 	qsort(sought, nr_sought, sizeof(*sought), cmp_ref_by_name);
=20
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports(=
"shallow"))
-		die("Server does not support shallow clients");
+		die(_("Server does not support shallow clients"));
 	if (server_supports("multi_ack_detailed")) {
-		print_verbose(args, "Server supports multi_ack_detailed");
+		print_verbose(args, _("Server supports multi_ack_detailed"));
 		multi_ack =3D 2;
 		if (server_supports("no-done")) {
-			print_verbose(args, "Server supports no-done");
+			print_verbose(args, _("Server supports no-done"));
 			if (args->stateless_rpc)
 				no_done =3D 1;
 		}
 	}
 	else if (server_supports("multi_ack")) {
-		print_verbose(args, "Server supports multi_ack");
+		print_verbose(args, _("Server supports multi_ack"));
 		multi_ack =3D 1;
 	}
 	if (server_supports("side-band-64k")) {
-		print_verbose(args, "Server supports side-band-64k");
+		print_verbose(args, _("Server supports side-band-64k"));
 		use_sideband =3D 2;
 	}
 	else if (server_supports("side-band")) {
-		print_verbose(args, "Server supports side-band");
+		print_verbose(args, _("Server supports side-band"));
 		use_sideband =3D 1;
 	}
 	if (server_supports("allow-tip-sha1-in-want")) {
-		print_verbose(args, "Server supports allow-tip-sha1-in-want");
+		print_verbose(args, _("Server supports allow-tip-sha1-in-want"));
 		allow_unadvertised_object_request |=3D ALLOW_TIP_SHA1;
 	}
 	if (server_supports("allow-reachable-sha1-in-want")) {
-		print_verbose(args, "Server supports allow-reachable-sha1-in-want");
+		print_verbose(args, _("Server supports allow-reachable-sha1-in-want"=
));
 		allow_unadvertised_object_request |=3D ALLOW_REACHABLE_SHA1;
 	}
 	if (!server_supports("thin-pack"))
@@ -849,14 +848,14 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
 	if (!server_supports("include-tag"))
 		args->include_tag =3D 0;
 	if (server_supports("ofs-delta"))
-		print_verbose(args, "Server supports ofs-delta");
+		print_verbose(args, _("Server supports ofs-delta"));
 	else
 		prefer_ofs_delta =3D 0;
=20
 	if ((agent_feature =3D server_feature_value("agent", &agent_len))) {
 		agent_supported =3D 1;
 		if (agent_len)
-			print_verbose(args, "Server version is %.*s",
+			print_verbose(args, _("Server version is %.*s"),
 				      agent_len, agent_feature);
 	}
=20
@@ -869,7 +868,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 			/* When cloning, it is not unusual to have
 			 * no common commit.
 			 */
-			warning("no common commits");
+			warning(_("no common commits"));
=20
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
@@ -881,7 +880,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 	else
 		alternate_shallow_file =3D NULL;
 	if (get_pack(args, fd, pack_lockfile))
-		die("git fetch-pack: fetch failed.");
+		die(_("git fetch-pack: fetch failed."));
=20
  all_done:
 	return ref;
@@ -1043,7 +1042,7 @@ struct ref *fetch_pack(struct fetch_pack_args *ar=
gs,
=20
 	if (!ref) {
 		packet_flush(fd[1]);
-		die("no matching remote head");
+		die(_("no matching remote head"));
 	}
 	prepare_shallow_info(&si, shallow);
 	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought,
--=20
2.8.2.524.g6ff3d78
