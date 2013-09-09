From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PULL REQUEST] initial pack v4 support
Date: Mon, 09 Sep 2013 15:52:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309091526430.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_oMhl41b7U70y+TsKeUjXrA)"
Cc: =?ISO-8859-15?Q?Nguyn_Th=E1i_Ngc_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 21:52:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ7VQ-0004dx-7n
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 21:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433Ab3IITwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 15:52:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38994 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab3IITwL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 15:52:11 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSV00DHBJ6YYB40@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Sep 2013 15:52:10 -0400 (EDT)
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234364>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_oMhl41b7U70y+TsKeUjXrA)
Content-type: TEXT/PLAIN; charset=VISCII
Content-transfer-encoding: 8BIT

Junio, would you please pull the following into pu:

	git://git.linaro.org/people/nico/git

This is the pack v4 work to date which is somewhat getting usable.  It 
is time it gets more exposure, and possibly some more people's attention 
who would like to work on the missing parts as I need to scale down my 
own involvement.

I've included the latest patches from Nguyn Thái Ngc Duy (sorry for not 
handling your name properly) as well.  There is no test suite for this 
yet, but the added code doesn't seem to regress the existing tests.

Nguy­n Thái Ng÷c Duy (31):
      Document pack v4 format
      pack v4: allocate dicts from the beginning
      pack v4: stop using static/global variables in packv4-create.c
      pack v4: move packv4-create.c to libgit.a
      pack v4: split pv4_create_dict() out of load_dict()
      pack v4: add pv4_free_dict()
      index-pack: add more comments on some big functions
      index-pack: split out varint decoding code
      index-pack: do not allocate buffer for unpacking deltas in the first pass
      index-pack: split inflate/digest code out of unpack_entry_data
      index-pack: parse v4 header and dictionaries
      index-pack: make sure all objects are registered in v4's SHA-1 table
      index-pack: parse v4 commit format
      index-pack: parse v4 tree format
      index-pack: move delta base queuing code to unpack_raw_entry
      index-pack: record all delta bases in v4 (tree and ref-delta)
      index-pack: skip looking for ofs-deltas in v4 as they are not allowed
      index-pack: resolve v4 one-base trees
      pack v4: add version argument to write_pack_header
      pack_write: tighten valid object type check in encode_in_pack_object_header
      pack-write.c: add pv4_encode_object_header
      pack-objects: add --version to specify written pack version
      list-objects.c: add show_tree_entry callback to traverse_commit_list
      pack-objects: do not cache delta for v4 trees
      pack-objects: exclude commits out of delta objects in v4
      pack-objects: create pack v4 tables
      pack-objects: prepare SHA-1 table in v4
      pack-objects: support writing pack v4
      pack v4: support "end-of-pack" indicator in index-pack and pack-objects
      index-pack: use nr_objects_final as sha1_table size
      index-pack: support completing thin packs v4

Nicolas Pitre (41):
      pack v4: initial pack dictionary structure and code
      export packed_object_info()
      pack v4: scan tree objects
      pack v4: add tree entry mode support to dictionary entries
      pack v4: add commit object parsing
      pack v4: split the object list and dictionary creation
      pack v4: move to struct pack_idx_entry and get rid of our own struct idx_entry
      pack v4: basic SHA1 reference encoding
      introduce get_sha1_lowhex()
      pack v4: commit object encoding
      pack v4: tree object encoding
      pack v4: dictionary table output
      pack v4: creation code
      pack v4: object headers
      pack v4: object data copy
      pack v4: object writing
      pack v4: tree object delta encoding
      pack v4: load delta candidate for encoding tree objects
      packv4-create: optimize delta encoding
      pack v4: honor pack.compression config option
      pack v4: relax commit parsing a bit
      packv4-create: don't transcode tree objects with zero-padded file modes
      pack index v3
      packv4-create: normalize pack name to properly generate the pack index file name
      packv4-create: add progress display
      pack v4: initial pack index v3 support on the read side
      pack v4: object header decode
      pack v4: code to obtain a SHA1 from a sha1ref
      pack v4: code to load and prepare a pack dictionary table for use
      pack v4: code to retrieve an ident entry
      pack v4: code to recreate a canonical commit object
      sha1_file.c: make use of decode_varint()
      pack v4: parse delta base reference
      pack v4: we can read commit objects now
      pack v4: code to retrieve a path component
      pack v4: decode tree objects
      pack v4: we can read tree objects now
      packv4-create: add a command line argument to limit tree copy sequences
      pack v4: allow canonical commit and tree objects
      packv4-parse.c: get rid of snprintf()
      packv4-parse.c: allow tree entry copying from a canonical tree object

 Documentation/technical/pack-format.txt | 138 ++++-
 Makefile                                |   5 +
 builtin/index-pack.c                    | 781 ++++++++++++++++++++++----
 builtin/pack-objects.c                  | 230 +++++++-
 builtin/rev-list.c                      |   4 +-
 bulk-checkin.c                          |   2 +-
 cache.h                                 |  13 +
 hex.c                                   |  11 +
 list-objects.c                          |   9 +-
 list-objects.h                          |   3 +-
 pack-check.c                            |   4 +-
 pack-revindex.c                         |   7 +-
 pack-write.c                            |  57 +-
 pack.h                                  |   6 +-
 packv4-create.c                         | 685 ++++++++++++++++++++++
 packv4-create.h                         |  39 ++
 packv4-parse.c                          | 576 +++++++++++++++++++
 packv4-parse.h                          |  18 +
 sha1_file.c                             | 116 +++-
 test-packv4.c                           | 476 ++++++++++++++++
 upload-pack.c                           |   2 +-
 21 files changed, 3007 insertions(+), 175 deletions(-)


--Boundary_(ID_oMhl41b7U70y+TsKeUjXrA)--
