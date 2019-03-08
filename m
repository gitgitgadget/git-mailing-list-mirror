Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BAE520248
	for <e@80x24.org>; Fri,  8 Mar 2019 21:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfCHVzg (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 16:55:36 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33075 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfCHVzg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 16:55:36 -0500
Received: by mail-pf1-f201.google.com with SMTP id x23so23641200pfm.0
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 13:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=2fG7RimFqmpuaCJ9uRwLaoN5Ve2NBLuIIPKtUi6vEwI=;
        b=uQwsZvmSJ2fD/AAqRj0EP5ZZXlnKMQeave2Y0iMx2psg+elcVTAEvBZ0cVOtA9tn8c
         LGMsPwDwVtVV2yxLy6XzQrlPTndks7EHwFcVxGCD1xxNOUY4oiL0j+I4qG+shSS8K9iA
         6TqNb311wsjtpT8xRBNkbv482aaK2d8NWrsAeaglYqIiEPRSS4JWtCnW94ZTKLtmgRYy
         Ary5AEm0iYrT+BspLeq8nOjPIJkZ3UnRKHJ9P/bY2DCr4hLCrDmFTJ60qJzGCCwIBBf5
         VpnJJyF6u6SM15mLsbs/JWoQQsGPkgP7+pMPlLNcGr+i+JgZY9oXw8VUM//jPWnqPAMa
         pLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=2fG7RimFqmpuaCJ9uRwLaoN5Ve2NBLuIIPKtUi6vEwI=;
        b=FJiOnGZvuggx2rx/dece/nwIutPJuFK52sRXBrHBmrdhF7dJ+WeNKHhiPwjwRtWIqb
         lSYkjFsEhh9/+DliPNgsMNdEHeUcjVu+1FwyCPPacxzGOS8Q9ShsrYFM9xurKxDuFxEw
         9bGGQCAFhpSFUqyuY6FsoDsNxI6an51CNQkoU03B8MuS6jQc3sgVuG/mI//TE3O1Ze75
         ve5sCCXrE7ZsYSEYhWFF8LdVA/OBdi6ZtGZFj8mqDUnFGkZy4XcFCK3pTO5CVkAubfA7
         1qLX2q4nOHUvmx+w6iOOLIIc9ASmMefy/9+44+6fyEQdROxqL03uU68dHIWtpPlDP+ga
         x1WA==
X-Gm-Message-State: APjAAAXhugOiuIryzYYi3ZyCyNdeqdndmVTKzob0IYe/Ir3oS3MUbrEh
        jl7Sroagora5J/gKyyhZumdzkysvKd+Yz70Kw7kc
X-Google-Smtp-Source: APXvYqweRtw9L7H0v74HIF5AcqKjbEWMVax8a3bkFWnIj6bauT+CZzAr/1pr1Pl5pxRP/VxHJ8E7w8s4HcqRMDSCn0Og
X-Received: by 2002:a62:5c42:: with SMTP id q63mr8017923pfb.138.1552082134841;
 Fri, 08 Mar 2019 13:55:34 -0800 (PST)
Date:   Fri,  8 Mar 2019 13:55:12 -0800
In-Reply-To: <cover.1550963965.git.jonathantanmy@google.com>
Message-Id: <cover.1552073690.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 0/8] CDN offloading of fetch response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's my current progress - the only thing that is lacking is more
tests, maybe, so I think it's ready for review.

I wrote in version 1:

> I know
> that there are some implementation details that could be improved (e.g.
> parallelization of the CDN downloads, starting CDN downloads *after*
> closing the first HTTP request, holding on to the .keep locks until
> after the refs are set), but will work on those once the overall design
> is more or less finalized.

This code now starts CDN downloads after closing the first HTTP request,
and it holds on to the .keep files until after the refs are set. I'll
leave parallelization of the CDN downloads for later work.

One relatively significant change: someone pointed out that the issue fixed=
 by=20
50d3413740 ("http: make redirects more obvious", 2016-12-06) could also
occur here, so I have changed it so that the server is required to send
the packfile's hash along with the URI.

This does mean that =C3=86var's workflow described in [1] would not work.
Quoting =C3=86var:

> More concretely, I'd like to have a setup where a server can just dumbly
> point to some URL that probably has most of the data, without having any
> idea what OIDs are in it. So that e.g. some machine entirely
> disconnected from the server (and with just a regular clone) can
> continually generating an up-to-date-enough packfile.

With 50d3413740, it seems to me that it's important for the server to
know details about the URIs that it points to, so such a disconnection
would not work.

[1] https://public-inbox.org/git/87k1hv6eel.fsf@evledraar.gmail.com/

Jonathan Tan (8):
  http: use --stdin when getting dumb HTTP pack
  http: improve documentation of http_pack_request
  http-fetch: support fetching packfiles by URL
  Documentation: order protocol v2 sections
  Documentation: add Packfile URIs design doc
  upload-pack: refactor reading of pack-objects out
  fetch-pack: support more than one pack lockfile
  upload-pack: send part of packfile response as uri

 Documentation/git-http-fetch.txt         |   8 +-
 Documentation/technical/packfile-uri.txt |  78 ++++++++++++
 Documentation/technical/protocol-v2.txt  |  44 +++++--
 builtin/fetch-pack.c                     |  17 ++-
 builtin/pack-objects.c                   |  76 +++++++++++
 connected.c                              |   8 +-
 fetch-pack.c                             | 129 +++++++++++++++++--
 fetch-pack.h                             |   2 +-
 http-fetch.c                             |  64 ++++++++--
 http.c                                   |  82 +++++++-----
 http.h                                   |  32 ++++-
 t/t5550-http-fetch-dumb.sh               |  25 ++++
 t/t5702-protocol-v2.sh                   |  57 +++++++++
 transport-helper.c                       |   5 +-
 transport.c                              |  14 +-
 transport.h                              |   6 +-
 upload-pack.c                            | 155 +++++++++++++++++------
 17 files changed, 670 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/technical/packfile-uri.txt

Range-diff against v1:
1:  987c9b686b < -:  ---------- http: use --stdin and --keep when downloadi=
ng pack
-:  ---------- > 1:  87173d0ad1 http: use --stdin when getting dumb HTTP pa=
ck
2:  4b53a6f48c ! 2:  66d31720a0 http: improve documentation of http_pack_re=
quest
    @@ -45,4 +45,4 @@
     + */
      extern struct http_pack_request *new_http_pack_request(
      	struct packed_git *target, const char *base_url);
    - int finish_http_pack_request(struct http_pack_request *preq, char **l=
ockfile);
    + extern int finish_http_pack_request(struct http_pack_request *preq);
3:  afe73a282d ! 3:  02373f6afe http-fetch: support fetching packfiles by U=
RL
    @@ -31,7 +31,8 @@
     +--packfile::
     +	Instead of a commit id on the command line (which is not expected in
     +	this case), 'git http-fetch' fetches the packfile directly at the gi=
ven
    -+	URL and generates the corresponding .idx file.
    ++	URL and uses index-pack to generate corresponding .idx and .keep fil=
es.
    ++	The output of index-pack is printed to stdout.
     +
      --recover::
      	Verify that everything reachable from target is fetched.  Used after
    @@ -101,12 +102,12 @@
     +		struct http_pack_request *preq;
     +		struct slot_results results;
     +		int ret;
    -+		char *lockfile;
     +
     +		preq =3D new_http_pack_request(NULL, url);
     +		if (preq =3D=3D NULL)
     +			die("couldn't create http pack request");
     +		preq->slot->results =3D &results;
    ++		preq->generate_keep =3D 1;
     +
     +		if (start_active_slot(preq->slot)) {
     +			run_active_slot(preq->slot);
    @@ -118,9 +119,8 @@
     +			die("Unable to start request");
     +		}
     +
    -+		if ((ret =3D finish_http_pack_request(preq, &lockfile)))
    ++		if ((ret =3D finish_http_pack_request(preq)))
     +			die("finish_http_pack_request gave result %d", ret);
    -+		unlink(lockfile);
     +		release_http_pack_request(preq);
     +		rc =3D 0;
     +	} else {
    @@ -180,6 +180,20 @@
      	tmpfile_fd =3D xopen(preq->tmpfile.buf, O_RDONLY);
     =20
     @@
    + 	argv_array_push(&ip.args, "--stdin");
    + 	ip.git_cmd =3D 1;
    + 	ip.in =3D tmpfile_fd;
    +-	ip.no_stdout =3D 1;
    ++	if (preq->generate_keep) {
    ++		argv_array_pushf(&ip.args, "--keep=3Dgit %"PRIuMAX,
    ++				 (uintmax_t)getpid());
    ++		ip.out =3D 0;
    ++	} else {
    ++		ip.no_stdout =3D 1;
    ++	}
    +=20
    + 	if (run_command(&ip)) {
    + 		ret =3D -1;
      		goto cleanup;
      	}
     =20
    @@ -243,6 +257,19 @@
      	 * pack list that target is in. finish_http_pack_request() will remo=
ve
      	 * target from lst and call install_packed_git() on target.
      	 */
    + 	struct packed_git **lst;
    +=20
    ++	/*
    ++	 * If this is true, finish_http_pack_request() will pass "--keep" to
    ++	 * index-pack, resulting in the creation of a keep file, and will no=
t
    ++	 * suppress its stdout (that is, the "keep\t<hash>\n" line will be
    ++	 * printed to stdout).
    ++	 */
    ++	unsigned generate_keep : 1;
    ++
    + 	/*
    + 	 * State managed by functions in http.c.
    + 	 */
     @@
      };
     =20
    @@ -269,7 +296,14 @@
     +test_expect_success 'http-fetch --packfile' '
     +	git init packfileclient &&
     +	p=3D$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git && ls objects/pac=
k/pack-*.pack) &&
    -+	git -C packfileclient http-fetch --packfile "$HTTPD_URL"/dumb/repo_p=
ack.git/$p &&
    ++	git -C packfileclient http-fetch --packfile "$HTTPD_URL"/dumb/repo_p=
ack.git/$p >out &&
    ++
    ++	# Ensure that the expected files are generated
    ++	grep "^keep.[0-9a-f]\{16,\}$" out &&
    ++	cut -c6- out >packhash &&
    ++	test -e "packfileclient/.git/objects/pack/pack-$(cat packhash).pack"=
 &&
    ++	test -e "packfileclient/.git/objects/pack/pack-$(cat packhash).idx" =
&&
    ++	test -e "packfileclient/.git/objects/pack/pack-$(cat packhash).keep"=
 &&
     +
     +	# Ensure that it has the HEAD of repo_pack, at least
     +	HASH=3D$(git -C "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git rev-parse =
HEAD) &&
4:  15a00cd3e1 =3D 4:  2e0f2daba0 Documentation: order protocol v2 sections
5:  9df7f6e9a4 ! 5:  5ce56844d3 Documentation: add Packfile URIs design doc
    @@ -64,7 +64,7 @@
     +after the Minimum Viable Product (see "Future work").
     +
     +The client can inhibit this feature (i.e. refrain from sending the
    -+`packfile-urls` parameter) by passing --no-packfile-urls to `git fetc=
h`.
    ++`packfile-uris` parameter) by passing --no-packfile-uris to `git fetc=
h`.
     +
     +Future work
     +-----------
    @@ -93,6 +93,24 @@
      --- a/Documentation/technical/protocol-v2.txt
      +++ b/Documentation/technical/protocol-v2.txt
     @@
    + 	indicating its sideband (1, 2, or 3), and the server may send "0005\=
2"
    + 	(a PKT-LINE of sideband 2 with no payload) as a keepalive packet.
    +=20
    ++If the 'packfile-uris' feature is advertised, the following argument
    ++can be included in the client's request as well as the potential
    ++addition of the 'packfile-uris' section in the server's response as
    ++explained below.
    ++
    ++    packfile-uris <comma-separated list of protocols>
    ++	Indicates to the server that the client is willing to receive
    ++	URIs of any of the given protocols in place of objects in the
    ++	sent packfile. Before performing the connectivity check, the
    ++	client should download from all given URIs. Currently, the
    ++	protocols supported are "http" and "https".
    ++
    + The response of `fetch` is broken into a number of sections separated=
 by
    + delimiter packets (0001), with each section beginning with its sectio=
n
    + header. Most sections are sent only when the packfile is sent.
     =20
          output =3D acknowledgements flush-pkt |
      	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
    @@ -107,8 +125,25 @@
          wanted-ref =3D obj-id SP refname
     =20
     +    packfile-uris =3D PKT-LINE("packfile-uris" LF) *packfile-uri
    -+    packfile-uri =3D PKT-LINE("uri" SP *%x20-ff LF)
    ++    packfile-uri =3D PKT-LINE(40*(HEXDIGIT) SP *%x20-ff LF)
     +
          packfile =3D PKT-LINE("packfile" LF)
      	       *PKT-LINE(%x01-03 *%x00-ff)
     =20
    +@@
    + 	* The server MUST NOT send any refs which were not requested
    + 	  using 'want-ref' lines.
    +=20
    ++    packfile-uris section
    ++	* This section is only included if the client sent
    ++	  'packfile-uris' and the server has at least one such URI to
    ++	  send.
    ++
    ++	* Always begins with the section header "packfile-uris".
    ++
    ++	* For each URI the server sends, it sends a hash of the pack's
    ++	  contents (as output by git index-pack) followed by the URI.
    ++
    +     packfile section
    + 	* This section is only included if the client has sent 'want'
    + 	  lines in its request and either requested that no more
6:  639235562e =3D 6:  d487f46b0f upload-pack: refactor reading of pack-obj=
ects out
-:  ---------- > 7:  f46504a166 fetch-pack: support more than one pack lock=
file
7:  0e821b4427 ! 8:  c7546868cf upload-pack: send part of packfile response=
 as uri
    @@ -5,12 +5,12 @@
         Teach upload-pack to send part of its packfile response as URIs.
    =20
         An administrator may configure a repository with one or more
    -    "uploadpack.blobpackfileuri" lines, each line containing an OID an=
d a
    -    URI. A client may configure fetch.uriprotocols to be a comma-separ=
ated
    -    list of protocols that it is willing to use to fetch additional
    -    packfiles - this list will be sent to the server. Whenever an obje=
ct
    -    with one of those OIDs would appear in the packfile transmitted by
    -    upload-pack, the server may exclude that object, and instead send =
the
    +    "uploadpack.blobpackfileuri" lines, each line containing an OID, a=
 pack
    +    hash, and a URI. A client may configure fetch.uriprotocols to be a
    +    comma-separated list of protocols that it is willing to use to fet=
ch
    +    additional packfiles - this list will be sent to the server. Whene=
ver an
    +    object with one of those OIDs would appear in the packfile transmi=
tted
    +    by upload-pack, the server may exclude that object, and instead se=
nd the
         URI. The client will then download the packs referred to by those =
URIs
         before performing the connectivity check.
    =20
    @@ -35,6 +35,7 @@
     =20
     +struct configured_exclusion {
     +	struct oidmap_entry e;
    ++	char *pack_hash_hex;
     +	char *uri;
     +};
     +static struct oidmap configured_exclusions;
    @@ -60,6 +61,8 @@
     +
     +		if (!ex)
     +			BUG("configured exclusion wasn't configured");
    ++		write_in_full(1, ex->pack_hash_hex, strlen(ex->pack_hash_hex));
    ++		write_in_full(1, " ", 1);
     +		write_in_full(1, ex->uri, strlen(ex->uri));
     +		write_in_full(1, "\n", 1);
     +	}
    @@ -100,15 +103,25 @@
      	}
     +	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
     +		struct configured_exclusion *ex =3D xmalloc(sizeof(*ex));
    -+		const char *end;
    ++		const char *oid_end, *pack_end;
    ++		/*
    ++		 * Stores the pack hash. This is not a true object ID, but is
    ++		 * of the same form.
    ++		 */
    ++		struct object_id pack_hash;
     +
    -+		if (parse_oid_hex(v, &ex->e.oid, &end) || *end !=3D ' ')
    ++		if (parse_oid_hex(v, &ex->e.oid, &oid_end) ||
    ++		    *oid_end !=3D ' ' ||
    ++		    parse_oid_hex(oid_end + 1, &pack_hash, &pack_end) ||
    ++		    *pack_end !=3D ' ')
     +			die(_("value of uploadpack.blobpackfileuri must be "
    -+			      "of the form '<sha-1> <uri>' (got '%s')"), v);
    ++			      "of the form '<object-hash> <pack-hash> <uri>' (got '%s')"),=
 v);
     +		if (oidmap_get(&configured_exclusions, &ex->e.oid))
     +			die(_("object already configured in another "
     +			      "uploadpack.blobpackfileuri (got '%s')"), v);
    -+		ex->uri =3D xstrdup(end + 1);
    ++		ex->pack_hash_hex =3D xcalloc(1, pack_end - oid_end);
    ++		memcpy(ex->pack_hash_hex, oid_end + 1, pack_end - oid_end - 1);
    ++		ex->uri =3D xstrdup(pack_end + 1);
     +		oidmap_put(&configured_exclusions, ex);
     +	}
      	return git_default_config(k, v, cb);
    @@ -144,6 +157,42 @@
     =20
      /* Remember to update object flag allocation in object.h */
      #define COMPLETE	(1U << 0)
    +@@
    + }
    +=20
    + static int get_pack(struct fetch_pack_args *args,
    +-		    int xd[2], struct string_list *pack_lockfiles)
    ++		    int xd[2], struct string_list *pack_lockfiles,
    ++		    int only_packfile)
    + {
    + 	struct async demux;
    + 	int do_keep =3D args->keep_pack;
    +@@
    + 					"--keep=3Dfetch-pack %"PRIuMAX " on %s",
    + 					(uintmax_t)getpid(), hostname);
    + 		}
    +-		if (args->check_self_contained_and_connected)
    ++		if (only_packfile && args->check_self_contained_and_connected)
    + 			argv_array_push(&cmd.args, "--check-self-contained-and-connected")=
;
    ++		else
    ++			/*
    ++			 * We cannot perform any connectivity checks because
    ++			 * not all packs have been downloaded; let the caller
    ++			 * have this responsibility.
    ++			 */
    ++			args->check_self_contained_and_connected =3D 0;
    + 		if (args->from_promisor)
    + 			argv_array_push(&cmd.args, "--promisor");
    + 	}
    +@@
    + 		alternate_shallow_file =3D setup_temporary_shallow(si->shallow);
    + 	else
    + 		alternate_shallow_file =3D NULL;
    +-	if (get_pack(args, fd, pack_lockfiles))
    ++	if (get_pack(args, fd, pack_lockfiles, 1))
    + 		die(_("git fetch-pack: fetch failed."));
    +=20
    +  all_done:
     @@
      		warning("filtering not recognized by server, ignoring");
      	}
    @@ -175,27 +224,16 @@
      		die(_("error processing wanted refs: %d"), reader->status);
      }
     =20
    -+static void receive_packfile_uris(struct packet_reader *reader)
    ++static void receive_packfile_uris(struct packet_reader *reader,
    ++				  struct string_list *uris)
     +{
     +	process_section_header(reader, "packfile-uris", 0);
     +	while (packet_reader_read(reader) =3D=3D PACKET_READ_NORMAL) {
    -+		const char *p;
    -+		struct child_process cmd =3D CHILD_PROCESS_INIT;
    -+
    -+
    -+		if (!skip_prefix(reader->line, "uri ", &p))
    -+			die("expected 'uri <uri>', got: %s\n", reader->line);
    ++		if (reader->pktlen < the_hash_algo->hexsz ||
    ++		    reader->line[the_hash_algo->hexsz] !=3D ' ')
    ++			die("expected '<hash> <uri>', got: %s\n", reader->line);
     +
    -+		argv_array_push(&cmd.args, "http-fetch");
    -+		argv_array_push(&cmd.args, "--packfile");
    -+		argv_array_push(&cmd.args, p);
    -+		cmd.git_cmd =3D 1;
    -+		cmd.no_stdin =3D 1;
    -+		cmd.no_stdout =3D 1;
    -+		if (start_command(&cmd))
    -+			die("fetch-pack: unable to spawn");
    -+		if (finish_command(&cmd))
    -+			die("fetch-pack: unable to finish");
    ++		string_list_append(uris, reader->line);
     +	}
     +	if (reader->status !=3D PACKET_READ_DELIM)
     +		die("expected DELIM");
    @@ -205,15 +243,81 @@
      	FETCH_CHECK_LOCAL =3D 0,
      	FETCH_SEND_REQUEST,
     @@
    + 	int in_vain =3D 0;
    + 	int haves_to_send =3D INITIAL_FLUSH;
    + 	struct fetch_negotiator negotiator;
    ++	struct string_list packfile_uris =3D STRING_LIST_INIT_DUP;
    ++	int i;
    ++
    + 	fetch_negotiator_init(&negotiator, negotiation_algorithm);
    + 	packet_reader_init(&reader, fd[0], NULL, 0,
    + 			   PACKET_READ_CHOMP_NEWLINE |
    +@@
    + 			if (process_section_header(&reader, "wanted-refs", 1))
      				receive_wanted_refs(&reader, sought, nr_sought);
     =20
    - 			/* get the pack */
    -+			if (process_section_header(&reader, "packfile-uris", 1)) {
    -+				receive_packfile_uris(&reader);
    -+			}
    +-			/* get the pack */
    ++			/* get the pack(s) */
    ++			if (process_section_header(&reader, "packfile-uris", 1))
    ++				receive_packfile_uris(&reader, &packfile_uris);
      			process_section_header(&reader, "packfile", 0);
    - 			if (get_pack(args, fd, pack_lockfile))
    +-			if (get_pack(args, fd, pack_lockfiles))
    ++			if (get_pack(args, fd, pack_lockfiles,
    ++				     !packfile_uris.nr))
      				die(_("git fetch-pack: fetch failed."));
    +=20
    + 			state =3D FETCH_DONE;
    +@@
    + 		}
    + 	}
    +=20
    ++	for (i =3D 0; i < packfile_uris.nr; i++) {
    ++		struct child_process cmd =3D CHILD_PROCESS_INIT;
    ++		char packname[GIT_MAX_HEXSZ + 1];
    ++		const char *uri =3D packfile_uris.items[i].string +
    ++			the_hash_algo->hexsz + 1;
    ++
    ++		argv_array_push(&cmd.args, "http-fetch");
    ++		argv_array_push(&cmd.args, "--packfile");
    ++		argv_array_push(&cmd.args, uri);
    ++		cmd.git_cmd =3D 1;
    ++		cmd.no_stdin =3D 1;
    ++		cmd.out =3D -1;
    ++		if (start_command(&cmd))
    ++			die("fetch-pack: unable to spawn http-fetch");
    ++
    ++		if (read_in_full(cmd.out, packname, 5) < 0 ||
    ++		    memcmp(packname, "keep\t", 5))
    ++			die("fetch-pack: expected keep then TAB at start of http-fetch out=
put");
    ++
    ++		if (read_in_full(cmd.out, packname,
    ++				 the_hash_algo->hexsz + 1) < 0 ||
    ++		    packname[the_hash_algo->hexsz] !=3D '\n')
    ++			die("fetch-pack: expected hash then LF at end of http-fetch output=
");
    ++
    ++		packname[the_hash_algo->hexsz] =3D '\0';
    ++
    ++		close(cmd.out);
    ++
    ++		if (finish_command(&cmd))
    ++			die("fetch-pack: unable to finish http-fetch");
    ++
    ++		if (memcmp(packfile_uris.items[i].string, packname,
    ++			   the_hash_algo->hexsz))
    ++			die("fetch-pack: pack downloaded from %s does not match expected h=
ash %.*s",
    ++			    uri, (int) the_hash_algo->hexsz,
    ++			    packfile_uris.items[i].string);
    ++
    ++		string_list_append_nodup(pack_lockfiles,
    ++					 xstrfmt("%s/pack/pack-%s.keep",
    ++						 get_object_directory(),
    ++						 packname));
    ++	}
    ++	string_list_clear(&packfile_uris, 0);
    ++
    + 	negotiator.release(&negotiator);
    + 	oidset_clear(&common);
    + 	return ref;
     @@
      	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
      	git_config_get_string("fetch.negotiationalgorithm",
    @@ -237,6 +341,15 @@
      	test_i18ngrep "expected no other sections to be sent after no .ready=
." err
      '
     =20
    ++configure_exclusion () {
    ++	git -C "$1" hash-object "$2" >objh &&
    ++	git -C "$1" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >p=
ackh &&
    ++	git -C "$1" config --add \
    ++		"uploadpack.blobpackfileuri" \
    ++		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack"=
 &&
    ++	cat objh
    ++}
    ++
     +test_expect_success 'part of packfile response provided as URI' '
     +	P=3D"$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
     +	rm -rf "$P" http_child log &&
    @@ -250,32 +363,22 @@
     +	git -C "$P" add other-blob &&
     +	git -C "$P" commit -m x &&
     +
    -+	# Create a packfile for my-blob and configure it for exclusion.
    -+	git -C "$P" hash-object my-blob >h &&
    -+	git -C "$P" pack-objects --stdout <h \
    -+		>"$HTTPD_DOCUMENT_ROOT_PATH/one.pack" &&
    -+	git -C "$P" config \
    -+		"uploadpack.blobpackfileuri" \
    -+		"$(cat h) $HTTPD_URL/dumb/one.pack" &&
    -+
    -+	# Do the same for other-blob.
    -+	git -C "$P" hash-object other-blob >h2 &&
    -+	git -C "$P" pack-objects --stdout <h2 \
    -+		>"$HTTPD_DOCUMENT_ROOT_PATH/two.pack" &&
    -+	git -C "$P" config --add \
    -+		"uploadpack.blobpackfileuri" \
    -+		"$(cat h2) $HTTPD_URL/dumb/two.pack" &&
    ++	configure_exclusion "$P" my-blob >h &&
    ++	configure_exclusion "$P" other-blob >h2 &&
     +
    -+	GIT_TRACE_PACKET=3D"$(pwd)/log" GIT_TEST_SIDEBAND_ALL=3D1 \
    -+		git -c protocol.version=3D2 \
    ++	GIT_TRACE=3D1 GIT_TRACE_PACKET=3D"$(pwd)/log" GIT_TEST_SIDEBAND_ALL=
=3D1 \
    ++	git -c protocol.version=3D2 \
     +		-c fetch.uriprotocols=3Dhttp,https \
    -+		clone  "$HTTPD_URL/smart/http_parent" http_child &&
    ++		clone "$HTTPD_URL/smart/http_parent" http_child &&
     +
     +	# Ensure that my-blob and other-blob are in separate packfiles.
     +	for idx in http_child/.git/objects/pack/*.idx
     +	do
     +		git verify-pack --verbose $idx >out &&
    -+		if test "$(grep "^[0-9a-f]\{40\} " out | wc -l)" =3D 1
    ++		{
    ++			grep "^[0-9a-f]\{16,\} " out || :
    ++		} >out.objectlist &&
    ++		if test_line_count =3D 1 out.objectlist
     +		then
     +			if grep $(cat h) out
     +			then
    @@ -288,7 +391,11 @@
     +		fi
     +	done &&
     +	test -f hfound &&
    -+	test -f h2found
    ++	test -f h2found &&
    ++
    ++	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
    ++	ls http_child/.git/objects/pack/* >filelist &&
    ++	test_line_count =3D 6 filelist
     +'
     +
      stop_httpd
    @@ -335,7 +442,7 @@
     +				packet_write_fmt(1, "\1packfile-uris\n");
     +			}
     +			*p =3D '\0';
    -+			packet_write_fmt(1, "\1uri %s\n", os->buffer);
    ++			packet_write_fmt(1, "\1%s\n", os->buffer);
     +
     +			os->used -=3D p - os->buffer + 1;
     +			memmove(os->buffer, p + 1, os->used);
8:  2c31d71166 < -:  ---------- SQUASH???
--=20
2.19.0.271.gfe8321ec05.dirty

