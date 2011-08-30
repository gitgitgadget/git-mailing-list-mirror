From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Add a remote helper to interact with mediawiki
 (fetch & push)
Date: Mon, 29 Aug 2011 22:56:08 -0500
Message-ID: <20110830035608.GB6647@elie.gateway.2wire.net>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
 <7v4o14dppz.fsf@alter.siamese.dyndns.org>
 <CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com>
 <7v4o1092hn.fsf@alter.siamese.dyndns.org>
 <CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Sylvain =?utf-8?Q?Boulm=C3=A9?= <sylvain.boulme@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 05:56:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyFQy-0000ms-28
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 05:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab1H3D4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 23:56:14 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61730 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab1H3D4N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 23:56:13 -0400
Received: by gwaa12 with SMTP id a12so5349951gwa.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 20:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=R/Q1iTFdfYAiHBMiwj888ZWr5KPM3Aq4/1laipJVZsM=;
        b=xYhNt50qn8ZJx4vcVaiGO4Z1IQ9c80ekvlstCzijWOoMKfXCjDsGimNBUcSuE40JXm
         HvUBGA4hFRrNW6XVSqUlyw6FO3kRxQWfZQW6qwXJyX+5uRcALbMDbiGJ1jGzzy5YnlRJ
         MVxEtZLmGf731d2N3LclL968cJycC0aYOYpoI=
Received: by 10.91.206.7 with SMTP id i7mr4676071agq.119.1314676573002;
        Mon, 29 Aug 2011 20:56:13 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-62-70.dsl.chcgil.ameritech.net [69.209.62.70])
        by mx.google.com with ESMTPS id c40sm5563291anp.26.2011.08.29.20.56.10
        (version=SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 20:56:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180389>

Sverre Rabbelier wrote:
> On Mon, Aug 29, 2011 at 08:05, Junio C Hamano <gitster@pobox.com> wrote:

>> Does this exchange suggest that at least we would need an update to
>> documentation around "done", as Matthieu's "why is 'done' needed even
>> though I am not calling with --done?" sounds like a very fair question.
>
> No I think the documentation for fast-import is correct.

However, the documentation for git-remote-helpers is hopelessly outdated.

Here's an old attempt to make the documentation a little easier to read,
and hopefully also to add to.  The text from "Capabilities for Pushing"
on needs help to avoid seeming redundant in light of the list of
capabilities before, but I'm sending it now to get comments and
hopefully help from other interested people.

It does _not_ document recent changes; patches for that would
presumably come on top.  Last time I sent this to list[1], it brought
to life some inconsistencies in how the various "list" commands are
used.  Another response was to flesh out what a capability for
fetching a single tree ("git archive --remote") would look like[2],
for which I was very grateful (and I'd happy to see it come to life).

[1] http://thread.gmane.org/gmane.comp.version-control.git/169341
[2] http://colabti.org/irclogger/irclogger_log/git-devel?date=2011-03-19#l434

-- >8 --
Subject: Documentation/remote-helpers: explain capabilities first

The current remote helper documentation is from the perspective of
git, so to speak: it presents a full menu of commands for a person
invoking a remote helper to choose from.  In practice, that's less
useful than it could be, since the daunted novice remote-helper author
probably just wanted a list of commands needs to implement to get
started.  So preface the command list with an overview of each
capability, its purpose, and what commands it requires.

As a side effect, this makes it a little clearer that git doesn't
choose arbitrary commands to run, even if the remote helper advertises
all capabilities --- instead, there are well defined command sequences
for various tasks.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-remote-helpers.txt |  159 +++++++++++++++++++++++++++-------
 1 files changed, 129 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 58f6ad49..f3fd63a4 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -23,22 +23,141 @@ output. Because a remote helper runs as an independent process from
 git, there is no need to re-link git to add a new helper, nor any
 need to link the helper with the implementation of git.
 
-Every helper must support the "capabilities" command, which git will
-use to determine what other commands the helper will accept.  Other
-commands generally concern facilities like discovering and updating
-remote refs, transporting objects between the object database and
-the remote repository, and updating the local object store.
-
-Helpers supporting the 'fetch' capability can discover refs from the
-remote repository and transfer objects reachable from those refs to
-the local object store. Helpers supporting the 'push' capability can
-transfer local objects to the remote repository and update remote refs.
+Every helper must support the "capabilities" command, which git
+uses to determine what other commands the helper will accept.  Those
+other commands can be used to discover and update remote refs,
+transport objects between the object database and the remote repository,
+and update the local object store.
 
 Git comes with a "curl" family of remote helpers, that handle various
 transport protocols, such as 'git-remote-http', 'git-remote-https',
 'git-remote-ftp' and 'git-remote-ftps'. They implement the capabilities
 'fetch', 'option', and 'push'.
 
+INPUT FORMAT
+------------
+
+Git sends the remote helper a list of commands on standard input, one
+per line.  The first command is always the 'capabilities' command, in
+response to which the remote helper must print a list of the
+capabilities it supports (see below) followed by a blank line.  The
+response to the capabilities command determines what commands Git uses
+in the remainder of the command stream.
+
+The command stream is terminated by a blank line.  In some cases
+(indicated in the documentation of the relevant commands), this blank
+line is followed by a payload in some other protocol (e.g., the pack
+protocol), while in others it indicates the end of input.
+
+Capabilities
+~~~~~~~~~~~~
+
+Each remote helper is expected to support only a subset of commands.
+The operations a helper supports are declared to git in the response
+to the `capabilities` command (see COMMANDS, below).
+
+'option'::
+	For specifying settings like `verbosity` (how much output to
+	write to stderr) and `depth` (how much history is wanted in the
+	case of a shallow clone) that affect how other commands are
+	carried out.
+
+'connect'::
+	For fetching and pushing using git's native packfile protocol
+	that requires a bidirectional, full-duplex connection.
+
+'push'::
+	For listing remote refs and pushing specified objects from the
+	local object store to remote refs.
+
+'fetch'::
+	For listing remote refs and fetching the associated history to
+	the local object store.
+
+'import'::
+	For listing remote refs and fetching the associated history as
+	a fast-import stream.
+
+'refspec' <refspec>::
+	This modifies the 'import' capability, allowing the produced
+	fast-import stream to modify refs in a private namespace
+	instead of writing to refs/heads or refs/remotes directly.
+	It is recommended that all importers providing the 'import'
+	capability use this.
++
+A helper advertising the capability
+`refspec refs/heads/{asterisk}:refs/svn/origin/branches/{asterisk}`
+is saying that, when it is asked to `import refs/heads/topic`, the
+stream it outputs will update the `refs/svn/origin/branches/topic`
+ref.
++
+This capability can be advertised multiple times.  The first
+applicable refspec takes precedence.  The left-hand of refspecs
+advertised with this capability must cover all refs reported by
+the list command.  If no 'refspec' capability is advertised,
+there is an implied `refspec {asterisk}:{asterisk}`.
+
+Capabilities for Pushing
+~~~~~~~~~~~~~~~~~~~~~~~~
+'connect'::
+	Can attempt to connect to 'git receive-pack' (for pushing),
+	'git upload-pack', etc for communication using the
+	packfile protocol.
++
+Supported commands: 'connect'.
+
+'push'::
+	Can discover remote refs and push local commits and the
+	history leading up to them to new or existing remote refs.
++
+Supported commands: 'list for-push', 'push'.
+
+If a helper advertises both 'connect' and 'push', git will use
+'connect' if possible and fall back to 'push' if the helper requests
+so when connecting (see the 'connect' command under COMMANDS).
+
+Capabilities for Fetching
+~~~~~~~~~~~~~~~~~~~~~~~~~
+'connect'::
+	Can try to connect to 'git upload-pack' (for fetching),
+	'git receive-pack', etc for communication using the
+	packfile protocol.
++
+Supported commands: 'connect'.
+
+'fetch'::
+	Can discover remote refs and transfer objects reachable from
+	them to the local object store.
++
+Supported commands: 'list', 'fetch'.
+
+'import'::
+	Can discover remote refs and output objects reachable from
+	them as a stream in fast-import format.
++
+Supported commands: 'list', 'import'.
+
+If a helper advertises 'connect', git will use it if possible and
+fall back to another capability if the helper requests so when
+connecting (see the 'connect' command under COMMANDS).
+When choosing between 'fetch' and 'import', git prefers 'fetch'.
+Other frontends may have some other order of preference.
+
+'refspec' <refspec>::
+	This modifies the 'import' capability.
++
+A helper advertising
+`refspec refs/heads/{asterisk}:refs/svn/origin/branches/{asterisk}`
+in its capabilities is saying that, when it handles
+`import refs/heads/topic`, the stream it outputs will update the
+`refs/svn/origin/branches/topic` ref.
++
+This capability can be advertised multiple times.  The first
+applicable refspec takes precedence.  The left-hand of refspecs
+advertised with this capability must cover all refs reported by
+the list command.  If no 'refspec' capability is advertised,
+there is an implied `refspec {asterisk}:{asterisk}`.
+
 INVOCATION
 ----------
 
@@ -167,26 +286,6 @@ completing a valid response for the current command.
 Additional commands may be supported, as may be determined from
 capabilities reported by the helper.
 
-CAPABILITIES
-------------
-
-'fetch'::
-'option'::
-'push'::
-'import'::
-'connect'::
-	This helper supports the corresponding command with the same name.
-
-'refspec' 'spec'::
-	When using the import command, expect the source ref to have
-	been written to the destination ref. The earliest applicable
-	refspec takes precedence. For example
-	"refs/heads/{asterisk}:refs/svn/origin/branches/{asterisk}" means
-	that, after an "import refs/heads/name", the script has written to
-	refs/svn/origin/branches/name. If this capability is used at
-	all, it must cover all refs reported by the list command; if
-	it is not used, it is effectively "{asterisk}:{asterisk}"
-
 REF LIST ATTRIBUTES
 -------------------
 
-- 
1.7.6
