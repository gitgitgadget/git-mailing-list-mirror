From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 13/27] fetch-pack.c: mark strings for translating
Date: Sun, 12 Jun 2016 17:53:55 +0700
Message-ID: <20160612105409.22156-14-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:55:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC33b-0003Za-Uy
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbcFLKzw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:55:52 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36406 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbcFLKzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:55:51 -0400
Received: by mail-pa0-f68.google.com with SMTP id fg1so8409993pad.3
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aplgUS12toZek34DF0itV6Q9vvyiponnCvRmnvVEIrI=;
        b=CY+KGHQNIL3F8w+UCziFng1G6xUTtVaTikNGGkpW+8PR72huH4ZeyasnsV9t520SZQ
         b86Aw7Zq84iU/iQE5hi4DqihJkxpWNAYwLvzeroJ8txoDXFuvPVZm5MvVU1pWcdwWUu0
         3ae1G2fJUdJQuq6IriL7I+cyAT3740XlI5WyNt8YM6P3xVkCNXeLsi1dsMZqft0zpiMt
         f6PTlVCeDZfs/iEAEhJGfIzY5oxzWvIGn/0s8/pLrJyoDGPePDgUBTbLCw1XMAX2KrZf
         AlMqgI4+r2YcqzWtUOFi6+UacdK/RdJ0I8VIEq3solukKlSvoyP5UKLO0SEbBEflqNtW
         YSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aplgUS12toZek34DF0itV6Q9vvyiponnCvRmnvVEIrI=;
        b=bm+VXm+RNXafb/94nAWiZpkZk48EzaySun1FowOYiFSRahvOJEX7sIQY/c6+XKerTI
         zbgJBEpsmhyV5XMK0ufcLI/Fj04y+e7/lvWeA2c0+fmB2vtovra+VGTYGg2IZosTWFOF
         4auG/cZ6+91D0VjPE4qJ/zzqS3oZx7uSS3zJqDHHEcxOX7FDnrAuwjqz2FKOiuv7mNLq
         GOoJRiWYLB8vQIKTIiuM4sHSbZxbPb4iQ5CQRdRCy/uD8oCsWYVC1yp6oNVh2rNEPSZT
         UyX4hGc6OgXOVD1/A/662KDzGqdD3D8kECAVQBuoDv9bXi4QbPmaPun9VfeFZG8caauT
         3NhQ==
X-Gm-Message-State: ALyK8tIv1YCbKaMMmq31SpWfB+siBngd1oeYuW4JvyA/0l9+MFDLHVWl5/yRi87WiHc6EA==
X-Received: by 10.67.3.227 with SMTP id bz3mr14615316pad.67.1465728950089;
        Sun, 12 Jun 2016 03:55:50 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id 7sm29838154pfn.30.2016.06.12.03.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:55:49 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:55:45 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297120>

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
