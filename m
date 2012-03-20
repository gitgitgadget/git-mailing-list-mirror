From: Junio C Hamano <gitster@pobox.com>
Subject: Incremental updates to What's cooking
Date: Tue, 20 Mar 2012 16:35:56 -0700
Message-ID: <7v62dy4zhf.fsf@alter.siamese.dyndns.org>
References: <7vmx7c86j8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 00:36:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA8b0-0000Mm-DO
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 00:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127Ab2CTXgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 19:36:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab2CTXf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 19:35:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35AF87D63;
	Tue, 20 Mar 2012 19:35:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x83Z3El3JUzjccVycM4GcmmfUxk=; b=xy6rlk
	PdIp3fcyCcqyFoNJF1zMcsdQqUwaBG6dnNkz7KH6j/YBcEYfk+jiiTtKy0fRdTZT
	3dQVoR3PhCQpezORjkVXvBtcNUkVc0NlC82gvzHcU27jLS1hoMK9o3lgiMF0S6hL
	pO/QOASP6iqRi0Rh/r0KJGHK9KGFpdXKLGDgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rJHcHw2jfFNqUHAVTJgOuqpzO6hOhb55
	Mzw44cmqFsKEuosTeKPYumKDRyrHSo+C0rWutdi6sMKYoW9lt0cAKba9rWVWoASz
	JOcokGI8YzBXZ5XlIzDbhL83UhwpCyyQlVgR0KbFzg1aP+BNvSkcx+ZM++WvEngs
	J6iZHzRZ2C4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BECA7D62;
	Tue, 20 Mar 2012 19:35:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CB4E7D60; Tue, 20 Mar 2012
 19:35:58 -0400 (EDT)
In-Reply-To: <7vmx7c86j8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 19 Mar 2012 17:23:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71FC30B2-72E5-11E1-AE49-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193551>

Again, just the highlights of the notable topics.

Not much has happened on the 'master' front.

[New Topics]

* am/completion-zsh-fix (2012-03-20) 1 commit
 - contrib/completion: "local var=()" is misinterpreted as function decl by zsh

Needs a bit better explanation.

* lp/maint-diff-three-dash-with-graph (2012-03-20) 3 commits
 - t4202: add test for "log --graph --stat -p" separator lines
 - log --graph: fix break in graph lines
 - log --graph --stat: three-dash separator should come after graph lines

The combination of two options "log --graph --stat" was an obscure corner
case nobody cared about, and did not correctly show the ancestry graph
lines.

I've split the original patch into three pieces, one for fixes to two
different issues and a test.  Also the test is adjusted so that the series
can be back-merged to older codebase that did not have 7f81463 (Use
correct grammar in diffstat summary line, 2012-02-01) that first appeared
in v1.7.9.2

* wk/gitweb-snapshot-use-if-modified-since (2012-03-20) 1 commit
 - Pull gitweb If-Modified-Since handling out into its own function and use for snapshots.

Unreviewed; the title looks way too long and does not sit well in the
shortlog output.

* jc/maint-merge-autoedit (2012-03-20) 1 commit
 - merge: backport GIT_MERGE_AUTOEDIT support

In 1.7.10, we added GIT_MERGE_AUTOEDIT=no environment variable to help
older scripts to let them refuse giving users a chance to explain the
merge, but forgot that 1.7.9 automatically opens an editor when merging an
annotated tag, and there is no equivalent escape hatch.  A merge of this
topic to 1.7.10 track becomes a no-op, but we may want to apply this to
the 1.7.9.x series.

[Cooking]

* ct/advise-push-default (2012-03-19) 1 commit
 - push: Provide situational hints for non-fast-forward error

Breaks down the cases in which "git push" fails due to non-ff into three
categories, and gives separate advise messages.  This should be a good
change regardless of mm/push-default-switch-warning topic.

* tr/maint-word-diff-regex-sticky (2012-03-14) 3 commits
  (merged to 'next' on 2012-03-20 at b3f67cd)
 + diff: tweak a _copy_ of diff_options with word-diff
 + diff: refactor the word-diff setup from builtin_diff_cmd
 + t4034: diff.*.wordregex should not be "sticky" in --word-diff

It would be nice to have this fix in 1.7.10 but perhaps we can wait until
1.7.10.1.

* nl/http-proxy-more (2012-03-15) 5 commits
  (merged to 'next' on 2012-03-20 at c004001)
 + http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
 + http: Avoid limit of retrying request only twice
 + http: handle proxy authentication failure (error 407)
 + http: handle proxy proactive authentication
 + http: try http_proxy env var when http.proxy config option is not set

The code to talk to http proxies learn to use the same credential
API used to talk to the final http destinations.

[Stalled]

* th/difftool-diffall (2012-03-19) 9 commits
 . difftool: print list of valid tools with '--tool-help'
 . difftool: teach dir-diff to copy modified files back to working tree
 . difftool: teach difftool to handle directory diffs
 . difftool: replace system call with Git::command_noisy
 . difftool: eliminate setup_environment function
 . difftool: stop appending '.exe' to git
 . difftool: remove explicit change of PATH
 . difftool: exit(0) when usage is printed
 . difftool: parse options using Getopt::Long

Reworks the "diffall" contrib script into "difftool" framework.
Breaks tests when merged to 'pu'.

* jh/apply-free-patch (2012-03-20) 2 commits
 - apply: free patch->result
 - apply: do not leak patches and fragments

Valgrind reports quite a lot of discarded memory inside apply. I have a
slight suspicion that we should first clarify the ownership rules of
pieces of memory in this standalone program that was designed to be "run
once and let exit take care of the memory" before proceeding further.

* dg/test-from-elsewhere (2012-03-04) 2 commits
 - Support out-of-tree Valgrind tests
 - Allow overriding GIT_BUILD_DIR

Better support for out-of-tree test scripts, but it appears that the
approach needs to be rethought.  By repointing TEST_DIRECTORY to a
directory other than $(pwd)/.., an out of place test script can reach
test helpers and freshly built Git relative to it (GIT_BUILD_DIR is
a mere short-hand for $TEST_DIRECTORY/..).

Discussion stalled.
