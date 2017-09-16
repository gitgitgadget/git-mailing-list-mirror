Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35CE20A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbdIPIHs (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:07:48 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:56621 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdIPIHo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:07:44 -0400
Received: by mail-wr0-f174.google.com with SMTP id r74so3156570wrb.13
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NK0L8fg9Mp8k4R1tC5y9iG2B0TfLs7eyrpDVhL4NTzs=;
        b=RKdNsUhg/cHzlB5TVTlnFe3evTNnIjA6xHZc4dfyAcCbU3KLlvdmGkWCTfLYZ1ewWx
         5HFPpdhtwCv6A0CO6AhTuHvcoKVo4cKfXviO6OtGDnDfpDqxKOKEDH49c4YuruqWfAyy
         F8MHUARXnd1Y7UFRsHtJX0k0gxoyF0IHBBsNl4OgB+Yi0dVmAQFBhYQkuXjL1/2pOy4K
         WZxCDc9CzXXfQ+clPCbof5ch/tKchRpKmbeCrxky7Pg+ATsNGu+oyy6sozgvYnC4JxU/
         UKE1f/4FgXq1shX4VJvvnIdxQAFTDDgLfTDbRIZrSpSL5VYnDqQ1rF33pczFYkVdtcHt
         YUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NK0L8fg9Mp8k4R1tC5y9iG2B0TfLs7eyrpDVhL4NTzs=;
        b=cECmCCWFIOJncINKNH9dYS2K+quCm4BMD1BLfNK8UdHgTgnA+eOuPrpemyWBRx7dhK
         gM34IQS/yQC9eb7EPFabH+AiS0u19JzYmO4bpJVEjMtfySzxdibKW6d7VUvk0Kiz5jv9
         o4fPibWAJI/yJjxb9DzaD0cD5eB9wAY5uv9VZ9KIYoQq54Kjw+UHHX5W48xOsTV+8wxt
         JCQqgDXXgBWFJnRGF7MzH5N9LmotklE5UwuzV9PUd2VjoXm5z8R9SizwjaUeQeg9YqJm
         q07acUAiH/or2njyL9OMPo/y0ItX+mB4zh03lGouSFhIKDP93zjMudSRh07h9k+LwUDs
         /R8A==
X-Gm-Message-State: AHPjjUgTQWn/IDz0DNaVS7fb62+NbJz8r3/xS5wAdVBDljdQpcCotzSj
        QKI+mPxrMjVtqhXA
X-Google-Smtp-Source: AOwi7QBMnV000wTbpEX19THtduW/T3wNsE6edGfhHXXPYwPZRoN3UMskA9d4kbu3AXmw08NEZpRCSQ==
X-Received: by 10.223.177.139 with SMTP id q11mr4659893wra.269.1505549262280;
        Sat, 16 Sep 2017 01:07:42 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:07:41 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 00/40] Add initial experimental external ODB support
Date:   Sat, 16 Sep 2017 10:06:51 +0200
Message-Id: <20170916080731.13925-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: a lot of information about the goals, the design and how things
work is now in the followin patches:

  - [PATCH v6 34/40] Add Documentation/technical/external-odb.txt
  - [PATCH v6 40/40] Doc/external-odb: explain transfering objects and metadata

Goal
~~~~

Git can store its objects only in the form of loose objects in
separate files or packed objects in a pack file.

To be able to better handle some kind of objects, for example big
blobs, it would be nice if Git could store its objects in other object
databases (ODB).

To do that, this patch series makes it possible to register commands,
also called "helpers", using "odb.<odbname>.scriptCommand" or
"odb.<odbname>.subprocessCommand" config variables, to access external
ODBs where objects can be stored and retrieved.

Design
~~~~~~

* The "helpers" (registered commands)

Each helper manages access to one external ODB.

There are 2 different modes for helper:

  - Helpers configured using "odb.<odbname>.scriptCommand" are
    launched each time Git wants to communicate with the <odbname>
    external ODB. This is called "script mode".

  - Helpers configured using "odb.<odbname>.subprocessCommand" are
    launched launched once as a sub-process (using sub-process.h), and
    Git communicates with them using packet lines. This is called
    "process mode".

A helper can be given different instructions by Git. The instructions
that are supported are negociated at the beginning of the
communication using a capability mechanism.

See patch 34/40 and 40/40 (the documentation patchs) for more
information about the different instructions and their arguments.

* Performance

The process mode has been implemented using the refactoring that Ben
Peart did on top of Lars Schneider's work on using sub-processes and
packet lines in the smudge/clean filters for git-lfs.

This also uses further work from Ben Peart called "read object
process".

See:

https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
https://public-inbox.org/git/20170322165220.5660-1-benpeart@microsoft.com/

Ben recently sent an update of this work but this update has not been
integrated into the current patch series. See:

https://public-inbox.org/git/20170714132651.170708-1-benpeart@microsoft.com/

Anyway thanks to this, the external ODB mechanism should in the end perform
as well as the git-lfs mechanism when many objects should be
transfered.

Implementation
~~~~~~~~~~~~~~

* Mechanism to call the registered commands

A set of function in external-odb.{c,h} are called by the rest of Git
to manage all the external ODBs.

These functions use 'struct odb_helper' and its associated functions
defined in odb-helper.{c,h} to talk to the different external ODBs by
launching the configured "odb.<odbname>.*command" commands and writing
to or reading from them.

* Transfering information

To tranfer information about the blobs stored in external ODB, some
special refs, called "odb ref", similar as replace refs, are used in
the tests of this series, but in general nothing forces the helper to
use that mechanism.

The external odb helper is responsible for using and creating the refs
in refs/odbs/<odbname>/, if it wants to do that. It is free for example
to just create one ref, as it is also free to create many refs. Git
would just transmit the refs that have been created by this helper, if
Git is asked to do so.

For now in the tests there is one odb ref per blob, as it is simple
and as it is similar to what git-lfs does. Each ref name is
refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob stored
in the external odb named <odbname>.

These odb refs point to a blob that is stored in the Git
repository and contain information about the blob stored in the
external odb. This information can be specific to the external odb.
The repos can then share this information using commands like:

`git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`

At the end of the current patch series, "git clone" is teached a
"--initial-refspec" option, that asks it to first fetch some specified
refs. This is used in the tests to fetch the odb refs first.

This way only one "git clone" command can setup a repo using the
external ODB mechanism as long as the right helper is installed on the
machine and as long as the following options are used:

  - "--initial-refspec <odbrefspec>" to fetch the odb refspec
  - "-c odb.<odbname>.command=<helper>" to configure the helper

There is also a test script (t0430) that shows that the
"--initial-refspec" option along with the external ODB mechanism can
be used to implement cloning using bundles.

* ODB refs

For now odb ref management is only implemented in a helper in t0410.

When a new blob is added to an external odb, its sha1, size and type
are writen in another new blob and the odb ref is created.

When the list of existing blobs is requested from the external odb,
the content of the blobs pointed to by the odb refs can also be used
by the odb to claim that it can get the objects.

When a blob is actually requested from the external odb, it can use
the content stored in the blobs pointed to by the odb refs to get the
actual blobs and then pass them.

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    - Patch 1/40 is a small code cleanup that I already sent to the
      mailing list but may be removed in the end due to ongoing work
      on "git clone".

    - Patches 02/40 to 07/40 create a "Git/Packet.pm" module by
      refactoring "t0021/rot13-filter.pl". Functions from this new
      module will be used later in test scripts. According to Junio's
      suggestion compared to v5 we now first fully refactor
      "t0021/rot13-filter.pl" before creating the "Git/Packet.pm"
      module.

    - Patches 08/40 to 16/40 create the external ODB insfrastructure
      in external-odb.{c,h} and odb-helper.{c,h} for the script mode.
      The main changes compared to v5 are the following:
        - we mark as "extern" functions in *.h files
	- we use sha1_pos() instead of sha1_entry_pos()
	- we check the size in the header when we 'get' a Git object

    - Patches 17/40 to 23/40 improve lib-http to make it possible to
      use it as an external ODB to test storing blobs in an HTTP
      server. The "upload.sh" and "list.sh" files are now properly
      indented and they use %% instead of % in parameter
      substitutions compared to v5.

    - Patches 24/40 to 32/40 improve the external ODB insfrastructure
      to support sub-processes and make everything work using
      them. The main changes compared to v5 are the following:
        - we mark as "extern" functions in *.h files
	- we use the new subprocess_handshake() function
	- we check the size in the header when we 'get' a Git object

    - Patch 33/40 uses attributes to mark blobs that should be handled
      by an external odb.

    - Patch 34/40 adds documentation about the external odb
      mechanism. This patch has been much improved since v5.

    - Patches 35/40 to 39/40 add the --initial-refspec to git clone
      along with tests.

    - Patch 40/40 adds documentation about transfering objects and
      metadata when using the external odb mechanism. This patch is
      new since v5.

Future work
~~~~~~~~~~~

There are still things that could be cleaned or improved. I think I
may work on:

  - Integrate changes in recent "read-object-process" work by Ben Peart.

  - Better test all the combinations of the different modes with and
    without "have" and "put_*" instructions.

  - Maybe implement the missing kinds of 'put' ('put_git_obj' and
    'put_direct'), so that Git could pass either a git object a plain
    object or ask the helper to retreive it directly from Git's object
    database.

  - Add more long running tests and improve tests in general.

Previous work and discussions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

(Sorry for the old Gmane links, I hope I will try to replace them with
public-inbox.org at one point.)

Peff started to work on this and discuss this some years ago:

http://thread.gmane.org/gmane.comp.version-control.git/206886/focus=207040
http://thread.gmane.org/gmane.comp.version-control.git/247171
http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020

His work, which is not compile-tested any more, is still there:

https://github.com/peff/git/commits/jk/external-odb-wip

Initial discussions about this new series are there:

http://thread.gmane.org/gmane.comp.version-control.git/288151/focus=295160

Version 1, 2, 3, 4 and 5 of this series are here:

https://public-inbox.org/git/20160613085546.11784-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20160628181933.24620-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20161130210420.15982-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.org/
https://public-inbox.org/git/20170803091926.1755-1-chriscool@tuxfamily.org/

Some of the discussions related to Ben Peart's work that is used by
this series are here:

https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/
https://public-inbox.org/git/20170322165220.5660-1-benpeart@microsoft.com/
https://public-inbox.org/git/20170714132651.170708-1-benpeart@microsoft.com/

Links
~~~~~

This patch series is available here:

https://github.com/chriscool/git/commits/external-odb

Version 1, 2, 3, 4 and 5 are here:

https://github.com/chriscool/git/commits/gl-external-odb12
https://github.com/chriscool/git/commits/gl-external-odb22
https://github.com/chriscool/git/commits/gl-external-odb61
https://github.com/chriscool/git/commits/gl-external-odb239
https://github.com/chriscool/git/commits/gl-external-odb373


Ben Peart (2):
  odb-helper: add init_object_process()
  Add t0450 to test 'get_direct' mechanism

Christian Couder (38):
  builtin/clone: get rid of 'value' strbuf
  t0021/rot13-filter: refactor packet reading functions
  t0021/rot13-filter: improve 'if .. elsif .. else' style
  t0021/rot13-filter: improve error message
  t0021/rot13-filter: add packet_initialize()
  t0021/rot13-filter: add capability functions
  Add Git/Packet.pm from parts of t0021/rot13-filter.pl
  sha1_file: prepare for external odbs
  Add initial external odb support
  odb-helper: add odb_helper_init() to send 'init' instruction
  t0400: add 'put_raw_obj' instruction to odb-helper script
  external odb: add 'put_raw_obj' support
  external-odb: accept only blobs for now
  t0400: add test for external odb write support
  Add GIT_NO_EXTERNAL_ODB env variable
  Add t0410 to test external ODB transfer
  lib-httpd: pass config file to start_httpd()
  lib-httpd: add upload.sh
  lib-httpd: add list.sh
  lib-httpd: add apache-e-odb.conf
  odb-helper: add odb_helper_get_raw_object()
  pack-objects: don't pack objects in external odbs
  Add t0420 to test transfer to HTTP external odb
  external-odb: add 'get_direct' support
  odb-helper: add 'script_mode' to 'struct odb_helper'
  Add t0460 to test passing git objects
  odb-helper: add put_object_process()
  Add t0470 to test passing raw objects
  odb-helper: add have_object_process()
  Add t0480 to test "have" capability and raw objects
  external-odb: use 'odb=magic' attribute to mark odb blobs
  Add Documentation/technical/external-odb.txt
  clone: add 'initial' param to write_remote_refs()
  clone: add --initial-refspec option
  clone: disable external odb before initial clone
  Add tests for 'clone --initial-refspec'
  Add t0430 to test cloning using bundles
  Doc/external-odb: explain transfering objects and metadata

 Documentation/technical/external-odb.txt |  447 +++++++++++++
 Makefile                                 |    2 +
 builtin/clone.c                          |   91 ++-
 builtin/pack-objects.c                   |    4 +
 cache.h                                  |   18 +
 environment.c                            |    4 +
 external-odb.c                           |  196 ++++++
 external-odb.h                           |   12 +
 odb-helper.c                             | 1076 ++++++++++++++++++++++++++++++
 odb-helper.h                             |   45 ++
 perl/Git/Packet.pm                       |  118 ++++
 sha1_file.c                              |  155 +++--
 t/lib-httpd.sh                           |    8 +-
 t/lib-httpd/apache-e-odb.conf            |  214 ++++++
 t/lib-httpd/list.sh                      |   41 ++
 t/lib-httpd/upload.sh                    |   45 ++
 t/t0021/rot13-filter.pl                  |  110 +--
 t/t0400-external-odb.sh                  |   85 +++
 t/t0410-transfer-e-odb.sh                |  147 ++++
 t/t0420-transfer-http-e-odb.sh           |  152 +++++
 t/t0430-clone-bundle-e-odb.sh            |   85 +++
 t/t0450-read-object.sh                   |   28 +
 t/t0450/read-object                      |   68 ++
 t/t0460-read-object-git.sh               |   28 +
 t/t0460/read-object-git                  |   78 +++
 t/t0470-read-object-http-e-odb.sh        |  119 ++++
 t/t0470/read-object-plain                |   83 +++
 t/t0480-read-object-have-http-e-odb.sh   |  119 ++++
 t/t0480/read-object-plain-have           |  103 +++
 t/t5616-clone-initial-refspec.sh         |   48 ++
 30 files changed, 3588 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/technical/external-odb.txt
 create mode 100644 external-odb.c
 create mode 100644 external-odb.h
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 perl/Git/Packet.pm
 create mode 100644 t/lib-httpd/apache-e-odb.conf
 create mode 100644 t/lib-httpd/list.sh
 create mode 100644 t/lib-httpd/upload.sh
 create mode 100755 t/t0400-external-odb.sh
 create mode 100755 t/t0410-transfer-e-odb.sh
 create mode 100755 t/t0420-transfer-http-e-odb.sh
 create mode 100755 t/t0430-clone-bundle-e-odb.sh
 create mode 100755 t/t0450-read-object.sh
 create mode 100755 t/t0450/read-object
 create mode 100755 t/t0460-read-object-git.sh
 create mode 100755 t/t0460/read-object-git
 create mode 100755 t/t0470-read-object-http-e-odb.sh
 create mode 100755 t/t0470/read-object-plain
 create mode 100755 t/t0480-read-object-have-http-e-odb.sh
 create mode 100755 t/t0480/read-object-plain-have
 create mode 100755 t/t5616-clone-initial-refspec.sh

-- 
2.14.1.576.g3f707d88cd

