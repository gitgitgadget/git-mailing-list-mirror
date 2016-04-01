From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: clarify that notes can be attached to any type of stored object
Date: Fri, 01 Apr 2016 09:47:38 -0700
Message-ID: <xmqq8u0xjmxh.fsf@gitster.mtv.corp.google.com>
References: <56FE48C6.9050306@gmail.com>
	<xmqqy48xjqg5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 18:47:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am2Ec-0002Za-0E
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 18:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbcDAQrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 12:47:41 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751175AbcDAQrl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 12:47:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0605B4F103;
	Fri,  1 Apr 2016 12:47:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iaf1mDuJ7cXddizhPCqeUVE1szA=; b=pYXX70
	VzLAKL85wm+ciJHahbYDOaiahEVxzdJ01lUNOvE2aOLif4/D5swVHCzs471v50R1
	eCPuLwLzdD+f6WdC7H6I1YXCoLzIUEElx53qxwbzn4nTmQWrTv2SDT6XcOUMxSGD
	RnQDuXDvJDFZSOm50cBlwZUdwUuoh8TpGDvtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pgGRfIGwKdQ5aKkJpDIiYX2MgzypPiZF
	qrp3wQKx/F+162caoYuMVcvlHaWYyrLIujNpMTCImAWYPwQtU0wASwKyRvwQqn6d
	GrBP+P5nreaN7LrMYhGvM37SYxT/lW6JejccT3vdFQEwjKmTxGHgmNP39FP1Mc8j
	b4pCZfxSRzE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F01654F102;
	Fri,  1 Apr 2016 12:47:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5D11F4F101;
	Fri,  1 Apr 2016 12:47:39 -0400 (EDT)
In-Reply-To: <xmqqy48xjqg5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 01 Apr 2016 08:31:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 71F5C402-F829-11E5-A504-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290558>

Junio C Hamano <gitster@pobox.com> writes:

> Sebastian Schuberth <sschuberth@gmail.com> writes:
>
>> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
>> ---
>>  Documentation/git-notes.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
> I do not think this is correct place to patch.

So,... where is the right place?

Let's disect what we have in the DESCRIPTION section.

    DESCRIPTION
    -----------
    Adds, removes, or reads notes attached to objects, without touching
    the objects themselves.

This says "notes attached to objects" and "the objects themselves".
They do not limit the target of attaching a note to "commits".
So this may be the place to add "  Note that notes can be attached
to any kind of objects, not limited to commits" or something, if
we really wanted to.

    By default, notes are saved to and read from `refs/notes/commits`, but
    this default can be overridden.  See the OPTIONS, CONFIGURATION, and
    ENVIRONMENT sections below.  If this ref does not exist, it will be
    quietly created when it is first needed to store a note.

    A typical use of notes is to supplement a commit message without
    changing the commit itself. Notes can be shown by 'git log' along with
    the original commit message. To distinguish these notes from the
    message stored in the commit object, the notes are indented like the
    message, after an unindented line saying "Notes (<refname>):" (or
    "Notes:" for `refs/notes/commits`).

    Notes can also be added to patches prepared with `git format-patch` by
    using the `--notes` option. Such notes are added as a patch commentary
    after a three dash separator line.

This paragraph _might_ be confusing to new readers.  The "added to"
sounds as if you are attaching a note to a non-object which is a
patch.  But this "add" is about "inserting the contents of the note
attached to the commit being formatted" and corresponds to "can be
shown by" in the previous paragraph.  We may want to avoid the verb
"add" when talking about the use of data stored in an existing note
to somewhere else like this.

    To change which notes are shown by 'git log', see the
    "notes.displayRef" configuration in linkgit:git-log[1].

    See the "notes.rewrite.<command>" configuration for a way to carry
    notes across commands that rewrite commits.



    SUBCOMMANDS
    -----------

    list::
            List the notes object for a given object. If no object is
            given, show a list of all note objects and the objects they
            annotate (in the format "<note object> <annotated object>").
            This is the default subcommand if no subcommand is given.

    add::
            Add notes for a given object (defaults to HEAD). Abort if the

And this "Add notes for " should probably be reworded to "Attach
notes to" to match the first sentence in the description.

            object already has notes (use `-f` to overwrite existing notes).
            However, if you're using `add` interactively (using an editor
            to supply the notes contents), then - instead of aborting -
            the existing notes will be opened in the editor (like the `edit`
            subcommand).
