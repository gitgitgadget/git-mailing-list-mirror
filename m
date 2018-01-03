Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D731F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeACQfc (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:35:32 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35730 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeACQf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:35:29 -0500
Received: by mail-wm0-f42.google.com with SMTP id a79so3648094wma.0
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tEHbTfDyRyCfolO2QRJtPLKFMGNyY01xvGUvG/UDnoI=;
        b=AEem25lz84BN+5foAI39fokwZzf2q2S+KLNqoWSoviELG8DBLs2KJVcJUHLTpf6FzB
         2c506Q1B8IgdmwsxQGZTaQQVfod6QtKLscxbua7dcMtPjglxwqJwRnzOwBMGrxeyCwOO
         MZRboJTeJm918CITqzLWwhFtcWsySRhNahbF8O5N3ZzftUQ82h2KdfJX2WGeQI+RnsD8
         1opH2mBxfOS0xdTcUcaBkInfEBn45k5+OJRyg/9sTMp+L2c59h7xc/UWTDvyW+xz8KLA
         GiEsMp2NQaHRLi2PsDOkLx7074gFd8inOot1GJIWubepVeziPvprV5XsdhVdp4CeB5fU
         Nrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tEHbTfDyRyCfolO2QRJtPLKFMGNyY01xvGUvG/UDnoI=;
        b=KzDzJUZVgDwFyBn1idxr7z2/mmA5odCfsC6S9QRglWF2R8b1comqsnBW9QwutIJ8Db
         RvhKzrYZFH3RsPRC+oQjgUw41MXy79FFBb13k5E/Z7OAFfcZV5ujVezL8QXwGUkQU/Ui
         rZyN4apaFiKCQtFjJ4IaRZgP1gB7rUfrVivNWZ4l+/d5lHHii6e77vZr7ah5nhn6WzSV
         7it3gEDdheto5/by/UL9ty5/aExryNtzSXJfgfp32cQOwap1gdR5LZJuiYM0O+PBuPs2
         jnFjjW3RsTwhVibS6eoQ0WLBMSsZEasM2EWvFGbH3PEYGbCVbaNQMqxsv0bWZJD0+2sL
         X5Cw==
X-Gm-Message-State: AKGB3mLarCO8pC0KOg/NWSLACY6KHdAuNyQpG4VsQREiuIDzw3eq/Ukb
        Lqdpvwr3uHEVplRLFm+fKgMiAYTG
X-Google-Smtp-Source: ACJfBovPTfv153IDxKvqxrdNWvmMZfGSIIKMSN+VTHvnD0JYdIdoVs/lTEm/co3qXVnJRbJN4jgmig==
X-Received: by 10.28.229.213 with SMTP id c204mr2039985wmh.57.1514997327148;
        Wed, 03 Jan 2018 08:35:27 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:35:26 -0800 (PST)
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
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 40/40] Add Documentation/technical/external-odb.txt
Date:   Wed,  3 Jan 2018 17:34:03 +0100
Message-Id: <20180103163403.11303-41-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This describes the external odb mechanism's purpose and
how it works.

Helped-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/technical/external-odb.txt | 342 +++++++++++++++++++++++++++++++
 1 file changed, 342 insertions(+)
 create mode 100644 Documentation/technical/external-odb.txt

diff --git a/Documentation/technical/external-odb.txt b/Documentation/technical/external-odb.txt
new file mode 100644
index 0000000000..58ec8a8145
--- /dev/null
+++ b/Documentation/technical/external-odb.txt
@@ -0,0 +1,342 @@
+External ODBs
+^^^^^^^^^^^^^
+
+The External ODB mechanism makes it possible for Git objects, only
+blobs for now though, to be stored in an "external object database"
+(External ODB).
+
+An External ODB can be any object store as long as there is an helper
+program called an "odb helper" that can communicate with Git to
+transfer objects to/from the external odb and to retrieve information
+about available objects in the external odb.
+
+Purpose
+=======
+
+The purpose of this mechanism is to make possible to handle Git
+objects, especially blobs, in much more flexible ways.
+
+Currently Git can store its objects only in the form of loose objects
+in separate files or packed objects in a pack file. These existing
+object stores cannot be easily optimized for many different kind of
+contents.
+
+So the current stores are not flexible enough for some important use
+cases like handling really big binary files or handling a really big
+number of files that are fetched only as needed. And it is not
+realistic to expect that Git could fully natively handle many of such
+use cases. Git would need to natively implement different internal
+stores which would be a huge burden and which could lead to
+re-implement things like HTTP servers, Docker registries or artifact
+stores that already exist outside Git.
+
+Furthermore many improvements that are dependent on specific setups
+could be implemented in the way Git objects are managed if it was
+possible to customize how the Git objects are handled. For example a
+restartable clone using the bundle mechanism has often been requested,
+but implementing that would go against the current strict rules under
+which the Git objects are currently handled.
+
+What Git needs is a mechanism to make it possible to customize in a
+lot of different ways how the Git objects are handled. Though this
+mechanism should try as much as possible to avoid interfering with the
+usual way in which Git handle its objects.
+
+Helpers
+=======
+
+ODB helpers are commands that have to be registered using either the
+"odb.<odbname>.subprocessCommand" or the "odb.<odbname>.scriptCommand"
+config variables.
+
+Registering such a command tells Git that an external odb called
+<odbname> exists and that the registered command should be used to
+communicate with it.
+
+The communication happens through instructions that are sent by Git
+and that the commands should answer. If it makes sense, Git can send
+the same instruction to many commands in the order in which they are
+configured.
+
+There are 2 kinds of commands. Commands registered using the
+"odb.<odbname>.subprocessCommand" config variable are called "process
+commands" and the associated mode is called "process mode". Commands
+registered using the "odb.<odbname>.scriptCommand" config variables
+are called "script commands" and the associated mode is called "script
+mode".
+
+Early on git commands send an 'init' instruction to the registered
+commands. A capability negociation will take place during this
+request/response exchange which will let Git and the helpers know how
+they can further collaborate. The attribute system can also be used to
+tell Git which objects should be handled by which helper.
+
+Process Mode
+============
+
+In process mode the command is started as a single process invocation
+that should last for the entire life of the single Git command that
+started it.
+
+A packet format (pkt-line, see technical/protocol-common.txt) based
+protocol over standard input and standard output is used for
+communication between Git and the helper command.
+
+After the process command is started, Git sends a welcome message
+("git-read-object-client"), a list of supported protocol version
+numbers, and a flush packet. Git expects to read a welcome response
+message ("git-read-object-server"), exactly one protocol version
+number from the previously sent list, and a flush packet. All further
+communication will be based on the selected version.
+
+The remaining protocol description below documents "version=1". Please
+note that "version=42" in the example below does not exist and is only
+there to illustrate how the protocol would look with more than one
+version.
+
+After the version negotiation Git sends a list of all capabilities
+that it supports and a flush packet. Git expects to read a list of
+desired capabilities, which must be a subset of the supported
+capabilities list, and a flush packet as response:
+
+------------------------
+packet: git> git-read-object-client
+packet: git> version=1
+packet: git> version=42
+packet: git> 0000
+packet: git< git-read-object-server
+packet: git< version=1
+packet: git< 0000
+packet: git> capability=get_raw_obj
+packet: git> capability=have
+packet: git> capability=put_raw_obj
+packet: git> capability=not-yet-invented
+packet: git> 0000
+packet: git< capability=get_raw_obj
+packet: git< 0000
+------------------------
+
+Afterwards Git sends a list of "key=value" pairs terminated with a
+flush packet. The list will contain at least the instruction (based on
+the supported capabilities) and the arguments for the
+instruction. Please note, that the process must not send any response
+before it received the final flush packet.
+
+In general any response from the helper should end with a status
+packet. See the documentation of the 'get_*' instructions below for
+examples of status packets.
+
+After the helper has processed an instruction, it is expected to wait
+for the next "key=value" list containing another instruction.
+
+On exit Git will close the pipe to the helper. The helper is then
+expected to detect EOF and exit gracefully on its own. Git will wait
+until the process has stopped.
+
+Script Mode
+===========
+
+In this mode Git launches the script command each time it wants to
+communicates with the helper. There is no welcome message and no
+protocol version in this mode.
+
+The instruction and associated arguments are passed as arguments when
+launching the script command and if needed further information is
+passed between Git and the command through stdin and stdout.
+
+Capabilities/Instructions
+=========================
+
+The following instructions are currently supported by Git:
+
+- init
+- get_git_obj
+- get_raw_obj
+- get_direct
+- put_raw_obj
+- have
+
+The plan is to also support 'put_git_obj' and 'put_direct' soon, for
+consistency with the 'get_*' instructions.
+
+ - 'init'
+
+All the process and script commands must accept the 'init'
+instruction. It should be the first instruction sent to a command. It
+should not be advertised in the capability exchange. Any argument
+should be ignored.
+
+In process mode, after receiving the 'init' instruction and a flush
+packet, the helper should just send a status packet and then a flush
+packet. See the 'get_*' instructions below for examples of status
+packets.
+
+In script mode the command should print on stdout the capabilities
+that it supports if any. This is the only time in script mode when a
+capability exchange happens.
+
+For example a script command could use the following shell code
+snippet to handle the 'init' instruction:
+
+------------------------
+case "$1" in
+init)
+	echo "capability=get_git_obj"
+	echo "capability=put_raw_obj"
+	echo "capability=have"
+	;;
+------------------------
+
+ - 'get_git_obj <sha1>' and 'get_raw_obj <sha1>'
+
+These instructions should have a hexadecimal <sha1> argument to tell
+which object the helper should send to git.
+
+In process mode the sha1 argument should be followed by a flush packet
+like this:
+
+------------------------
+packet: git> command=get_git_obj
+packet: git> sha1=0a214a649e1b3d5011e14a3dc227753f2bd2be05
+packet: git> 0000
+------------------------
+
+After reading that the helper should send the requested object to Git in a
+packet series followed by a flush packet. If the helper does not experience
+problems then the helper must send a "success" status like the following:
+
+------------------------
+packet: git< status=success
+packet: git< 0000
+------------------------
+
+In case the helper cannot or does not want to send the requested
+object as well as any other object for the lifetime of the Git
+process, then it is expected to respond with an "abort" status at any
+point in the protocol:
+
+------------------------
+packet: git< status=abort
+packet: git< 0000
+------------------------
+
+Git neither stops nor restarts the helper in case a
+"notfound"/"error"/"abort" status is set. An "error" status means a
+possibly more transient error than an abort. The helper should also
+send a "notfound" error in case of a "get_*" instruction, which means
+that the requested object cannot be found.
+
+If the helper dies during the communication or does not adhere to the
+protocol then Git will stop and restart it with the next instruction.
+
+In script mode the helper should just send the requested object to Git
+by writing it to stdout and should then exit. The exit code should
+signal to Git if a problem occured or not.
+
+The only difference between 'get_git_obj' and 'get_raw_obj' is that in
+case of 'get_git_obj' the requested object should be sent as a Git
+object (that is in the same format as loose object files). In case of
+'get_raw_obj' the object should be sent in its raw format (that is the
+same output as `git cat-file <type> <sha1>`).
+
+ - 'get_direct <sha1>'
+
+This instruction is similar as the other 'get_*' instructions except
+that no object should be sent from the helper to Git. Instead the
+helper should directly write the requested object into a loose object
+file in the ".git/objects" directory.
+
+After the helper has sent the "status=success" packet and the
+following flush packet in process mode, or after it has exited in the
+script mode, Git will lookup again for the requested sha1 in its loose
+object files and pack files.
+
+ - 'put_raw_obj <sha1> <size> <type>'
+
+This instruction should be following by three arguments to tell which
+object the helper will receive from git: <sha1>, <size> and
+<type>. The hexadecimal <sha1> argument describes the object that will
+be sent from Git to the helper. The <type> is the object type ("blob",
+"tree", "commit" or "tag") of this object. The <size> is the size in
+bytes of the (decompressed) object content.
+
+In process mode the last argument (the type) should be followed by a
+flush packet.
+
+After reading that the helper should read the announced object from
+Git in a packet series followed by a flush packet.
+
+If the helper does not experience problems when receiving and storing
+or processing the object, then the helper must send a "success" status
+as described for the 'get_*' instructions.
+
+In script mode the helper should just receive the announced object
+from its standard input. After receiving and processing the object,
+the helper should exit and its exit code should signal to Git if a
+problem occured or not.
+
+- 'have'
+
+In process mode this instruction should be followed by a flush
+packet. After receiving this packet the helper should send the sha1,
+size and type, in this order, of all the objects it can provide to Git
+(through a 'get_*' instruction). There should be a space character
+between the sha1 and the size and between the size and the type, and
+then a new line character after the type.
+
+If many packets are needed to send back all this information, the
+split between packets should be made after the new line characters.
+
+If the helper does not experience problems, then it must then send a
+"success" status as described for the 'get_*' instructions.
+
+In script mode the helper should send to its standard output the sha1,
+size and type, in this order of all the objects it can provide to
+Git. There should also be a space character between the sha1 and the
+size and between the size and the type, and then a new line character
+after the type.
+
+After sending this, the script helper should exit and its exit code
+should signal to Git if a problem occured or not.
+
+Order of instructions
+=====================
+
+For get_*_object instructions the regular code to find objects is
+called before the odb helpers.
+
+For put_*_object instructions the regular code to store the objects is
+called after the odb helpers.
+
+For now this order is not configurable.
+
+Object caching
+==============
+
+If a helper returns the object data as requested by get_git_obj or
+get_raw_obj, then Git will itself store the object locally in its
+regular object store, so it is redundant for the helper to also store
+or try to store the object in the regular object store.
+
+Yeah, this seems to defeat the goal of enabling specialized object
+handlers to handle large or other "unusual" objects that git normally
+doesn't deal well with. So in the long run there should be a way to
+make this configurable.
+
+Selecting objects
+=================
+
+To select objects that should be handled by an external odb, one can
+use the git attributes system. For now this will only work with blobs
+and this will only work along with the 'put_raw_obj' instruction.
+
+For example if one has an external odb called "magic" and has
+registered an associated a process command helper that supports the
+'put_raw_obj' instruction, then one can tell Git that all the .jpg
+files should be handled by the "magic" odb using a .gitattributes file
+can that contains:
+
+------------------------
+*.jpg           odb=magic
+------------------------
+
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

