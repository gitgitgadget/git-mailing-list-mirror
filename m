From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Sun, 23 Jan 2011 15:49:01 -0800
Message-ID: <7vipxfmb9u.fsf@alter.siamese.dyndns.org>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino> <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino> <20110119124230.GD23222@burratino>
 <AANLkTinE5gNZM_HDJq31qs5ARJn-DrO9HW66cszTayPa@mail.gmail.com>
 <20110119193116.GB30618@burratino> <7vpqrssl5d.fsf@alter.siamese.dyndns.org>
 <7v39omotxg.fsf@alter.siamese.dyndns.org>
 <AANLkTim_o9GGWbDFkeGb-va+4dP+StQE6GJyLpSMmV1H@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Maaartin <grajcar1@seznam.cz>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 24 00:50:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ph9hI-0005vk-99
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 00:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668Ab1AWXtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 18:49:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab1AWXtP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 18:49:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D6D6F437D;
	Sun, 23 Jan 2011 18:50:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dGNF0djCUfo3rGhWI6MUBSsfPJU=; b=by3Ws+
	dZzgj0je+0DB81ZeW0cwLAEpWRfqZtJnn1ISkM1i4BSuZn/nGfwgxPhKipg5eee3
	t7tLN8sEkhKMKocJKEgGjRmardam5SQp52CJDRT5IIJQt1THpNowd9+hfADfT/LJ
	x5KxxagfmyQjoCshmA7OM+F6K73Hd/JGpcrgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DfFLcLoASdNqzIG1I7f10Ra1VzYaVrX8
	9XGKe7d5bUCJQe203sZpoXYleIvSD2/YRAZ5rtahdXjP2nv36sFixd9f0ZrQYlCe
	YKmqgAdp1lUSHvc3N1HAhKnrg/KE3RsNQxca6oL9/2z1E6Su4cFmKYV1cIQ+X6Ne
	MIQSWK00zrc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F8C5437C;
	Sun, 23 Jan 2011 18:49:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 020A0437B; Sun, 23 Jan 2011
 18:49:50 -0500 (EST)
In-Reply-To: <AANLkTim_o9GGWbDFkeGb-va+4dP+StQE6GJyLpSMmV1H@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Sat\, 22 Jan 2011 17\:30\:51 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B489C64-274B-11E0-A81D-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165431>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Jan 22, 2011 at 3:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I was re-reading this thread, and changed my mind; I think we should have
>> this series to avoid unnecessary regression, with or without clarifying
>> (5), before 1.7.4 final.
>
> Sorry for late response. If we no longer consider this work-around,
> perhaps git.txt and config.txt should be updated to reflect it?

I am Ok with us considering this as a "work-around"; as long as we keep it
alive, the label does not matter much.

And the necessity of documentation updates you raised is really a good
point.  Something like this (on top of jn/setup-fixes branch queued in
next)?


 Documentation/config.txt |   23 ++++++++++++++++-------
 Documentation/git.txt    |   13 ++++---------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ff7c225..72b74c4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -317,17 +317,26 @@ false), while all other repositories are assumed to be bare (bare
 = true).
 
 core.worktree::
-	Set the path to the working tree.  The value will not be
-	used in combination with repositories found automatically in
-	a .git directory (i.e. $GIT_DIR is not set).
+	Set the path to the root of the work tree.
 	This can be overridden by the GIT_WORK_TREE environment
 	variable and the '--work-tree' command line option. It can be
-	an absolute path or relative path to the directory specified by
-	--git-dir or GIT_DIR.
-	Note: If --git-dir or GIT_DIR are specified but none of
+	an absolute path or a relative path to the .git directory,
+	either specified by --git-dir or GIT_DIR, or automatically
+	discovered.
+	If --git-dir or GIT_DIR are specified but none of
 	--work-tree, GIT_WORK_TREE and core.worktree is specified,
-	the current working directory is regarded as the top directory
+	the current working directory is regarded as the top level
 	of your working tree.
++
+Note that this variable is honored even when set in a configuration
+file in a ".git" subdirectory of a directory, and its value differs
+from the latter directory (e.g. "/path/to/.git/config" has
+core.worktree set to "/different/path"), which is most likely a
+misconfiguration.  Running git commands in "/path/to" directory will
+still use "/different/path" as the root of the work tree and can cause
+confusion, unless you know what you are doing (e.g. you are creating a
+read-only snapshot of the same index to a location different from the
+repository's usual working tree).
 
 core.logAllRefUpdates::
 	Enable the reflog. Updates to a ref <ref> is logged to the file
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4e5fe4d..245d84f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -291,17 +291,12 @@ help ...`.
 	path or relative path to current working directory.
 
 --work-tree=<path>::
-	Set the path to the working tree.  The value will not be
-	used in combination with repositories found automatically in
-	a .git directory (i.e. $GIT_DIR is not set).
+	Set the path to the working tree. It can be an absolute path
+	or relative path to the current working directory.
 	This can also be controlled by setting the GIT_WORK_TREE
 	environment variable and the core.worktree configuration
-	variable. It can be an absolute path or relative path to
-	current working directory.
-	Note: If --git-dir or GIT_DIR are specified but none of
-	--work-tree, GIT_WORK_TREE and core.worktree is specified,
-	the current working directory is regarded as the top directory
-	of your working tree.
+	variable (see core.worktree in linkgit:git-config[1] for a
+	more detailed discussion).
 
 --bare::
 	Treat the repository as a bare repository.  If GIT_DIR
