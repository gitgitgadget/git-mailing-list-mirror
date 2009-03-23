From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] Clean up interpret_nth_last_branch feature
Date: Mon, 23 Mar 2009 01:10:55 -0700
Message-ID: <7v63i08xrk.fsf@gitster.siamese.dyndns.org>
References: <cover.1237791716.git.gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 09:13:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlfGz-0006kY-JI
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 09:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755034AbZCWILL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 04:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754586AbZCWILJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 04:11:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718AbZCWILI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 04:11:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 031118713;
	Mon, 23 Mar 2009 04:11:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 624828711; Mon,
 23 Mar 2009 04:10:59 -0400 (EDT)
In-Reply-To: <cover.1237791716.git.gitster@pobox.com> (Junio C. Hamano's
 message of "Mon, 23 Mar 2009 00:58:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 29138948-1782-11DE-89E2-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114262>

Junio C Hamano <gitster@pobox.com> writes:

> The changes since the previous round are:
>
>  - Tightening of the refname rule comes very late in the series, so that
>    we can optionally drop it;
>
>  - In addition to allowing "git branch -d bad@{name}ref.", we also allow
>    "git branch -d bad@{name}ref. good-one" as another escape hatch;

Sorry, the "also allow" one is about renaming, i.e. "branch -m bad. good".

>  - Update documentation to git-check-ref-format to describe the tightened
>    rules.
>
> Junio C Hamano (7):
>   Rename interpret/substitute nth_last_branch functions
>   strbuf_branchname(): a wrapper for branch name shorthands
>   check-ref-format --branch: give Porcelain a way to grok branch
>     shorthand
>   Fix branch -m @{-1} newname
>   strbuf_check_branch_ref(): a helper to check a refname for a branch
>   check_ref_format(): tighten refname rules
>   checkout -: make "-" to mean "previous branch" everywhere
>
>  Documentation/git-check-ref-format.txt |   18 ++++++++++++++++-
>  branch.c                               |   10 +--------
>  builtin-branch.c                       |   32 +++++++++++++++++-------------
>  builtin-check-ref-format.c             |    9 ++++++++
>  builtin-checkout.c                     |   26 ++++++++++--------------
>  builtin-merge.c                        |    5 +--
>  cache.h                                |    2 +-
>  refs.c                                 |   16 +++++++++++---
>  sha1_name.c                            |   33 ++++++++++++++++++-------------
>  strbuf.c                               |   17 ++++++++++++++++
>  strbuf.h                               |    3 ++
>  11 files changed, 110 insertions(+), 61 deletions(-)
