From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: Transaction patch series overview
Date: Thu, 31 Jul 2014 14:41:24 -0700
Message-ID: <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:41:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCy6N-00077c-IB
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 23:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbaGaVl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 17:41:28 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:49598 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbaGaVl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 17:41:26 -0400
Received: by mail-vc0-f180.google.com with SMTP id ij19so5313711vcb.39
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=HfSZWZDXvJlg7jQ18YS6xLKlhm48rVIGPnC2/kGROiI=;
        b=RzxmWwtwFxKwZrQWgUffW5qoC3FG29ReM2BvRpxXibN7cIPszwZ7Eb7B48O4AiBsWK
         ZezGDgMou8hIfLx5vSnxGpr/9yzl043IMW+UpFVIfxGCUOdrNvbJTD6kP34cV2IjrqUR
         Ln7jd1v9YITDe5ssoqQ9StHbEa9Ou0KzT3HtftxFYovqm9rnbhlxVYEWfpRmLdOPpa2p
         IVyMNVRBtUs8HGSjVHJG76lDyR2o4kODz7e9z8TTju4+sD3WB1m0OXHUZgO3tOaPuLqi
         tgZtyDdeH4bjarNVGInyTjqA5DKsOnMHdJUExZERPjQV+f2uK6y0PRNZHYKoYjh/gafi
         z6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=HfSZWZDXvJlg7jQ18YS6xLKlhm48rVIGPnC2/kGROiI=;
        b=CnkXr7/Kf/ip17914csDRaXh2ZOcjE3nyLlyzooSO85ohjBQ8LTfkZVnQpIGigem+L
         mNdp96CSP5xa6c+zWJp4ebKGzYT2sWUibMyyqMPTbMuOG3PMox/sV+rztPyW2gi86Oqs
         7pSQ1gCHz9DVWi9atM++IiZnB5WCsMwoK9gTQT7+TLXRfDJVJxN3ox8Nms21zZZuDy4S
         Hgy0t+hDETX0h9mIuwdT8QNEshEpNBuX4a/Cuj7rXBJ6Bc5UoZVJGsLEAw3iSWxH6NsB
         nIUiTqbV1K9AGcb5iwQWnmQ8RzRvwR7y6oa2j9i1YDlkjcKbQjGd0+DYhZtbQmK/RZsQ
         cJ1g==
X-Gm-Message-State: ALoCoQnw0EZqtDb8BeZYZgVXRlzxkeImWn43bGuiNpzQ+2ETXqzUIOjGS2mt5vYpgyvT9iXO8COB
X-Received: by 10.52.228.40 with SMTP id sf8mr1122854vdc.78.1406842884903;
 Thu, 31 Jul 2014 14:41:24 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Thu, 31 Jul 2014 14:41:24 -0700 (PDT)
In-Reply-To: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254614>

List, please see here an overview and ordering of the ref transaction
patch series.
These series build on each other and needs to be applied in the order
listed below.

This is an update.



rs/ref-transaction-0
---------------------------
    Early part of the "ref transaction" topic.

    * rs/ref-transaction-0:
      refs.c: change ref_transaction_update() to do error checking and
return status
      refs.c: remove the onerr argument to ref_transaction_commit
      update-ref: use err argument to get error from ref_transaction_commit
      refs.c: make update_ref_write update a strbuf on failure
      refs.c: make ref_update_reject_duplicates take a strbuf argument
for errors
      refs.c: log_ref_write should try to return meaningful errno
      refs.c: make resolve_ref_unsafe set errno to something meaningful on error
      refs.c: commit_packed_refs to return a meaningful errno on failure
      refs.c: make remove_empty_directories always set errno to something sane
      refs.c: verify_lock should set errno to something meaningful
      refs.c: make sure log_ref_setup returns a meaningful errno
      refs.c: add an err argument to repack_without_refs
      lockfile.c: make lock_file return a meaningful errno on failurei
      lockfile.c: add a new public function unable_to_lock_message
      refs.c: add a strbuf argument to ref_transaction_commit for error logging
      refs.c: allow passing NULL to ref_transaction_free
      refs.c: constify the sha arguments for
ref_transaction_create|delete|update
      refs.c: ref_transaction_commit should not free the transaction
      refs.c: remove ref_transaction_rollback

Has been merged into next.



ref-transaction-1 (2014-07-16) 20 commits
-------------------------------------------------------------
Second batch of ref transactions

 - refs.c: make delete_ref use a transaction
 - refs.c: make prune_ref use a transaction to delete the ref
 - refs.c: remove lock_ref_sha1
 - refs.c: remove the update_ref_write function
 - refs.c: remove the update_ref_lock function
 - refs.c: make lock_ref_sha1 static
 - walker.c: use ref transaction for ref updates
 - fast-import.c: use a ref transaction when dumping tags
 - receive-pack.c: use a reference transaction for updating the refs
 - refs.c: change update_ref to use a transaction
 - branch.c: use ref transaction for all ref updates
 - fast-import.c: change update_branch to use ref transactions
 - sequencer.c: use ref transactions for all ref updates
 - commit.c: use ref transactions for updates
 - replace.c: use the ref transaction functions for updates
 - tag.c: use ref transactions when doing updates
 - refs.c: add transaction.status and track OPEN/CLOSED/ERROR
 - refs.c: make ref_transaction_begin take an err argument
 - refs.c: update ref_transaction_delete to check for error and return status
 - refs.c: change ref_transaction_create to do error checking and return status
 (this branch is used by rs/ref-transaction, rs/ref-transaction-multi,
rs/ref-transaction-reflog and rs/ref-transaction-rename.)

 The second batch of the transactional ref update series.

Has been merged into pu



rs/ref-transaction (2014-07-17) 12 commits
-----------------------------------------------------------------
 - refs.c: fix handling of badly named refs
 - refs.c: make write_ref_sha1 static
 - fetch.c: change s_update_ref to use a ref transaction
 - refs.c: propagate any errno==ENOTDIR from _commit back to the callers
 - refs.c: pass a skip list to name_conflict_fn
 - refs.c: call lock_ref_sha1_basic directly from commit
 - refs.c: move the check for valid refname to lock_ref_sha1_basic
 - refs.c: pass NULL as *flags to read_ref_full
 - refs.c: pass the ref log message to _create/delete/update instead of _commit
 - refs.c: add an err argument to delete_ref_loose
 - wrapper.c: add a new function unlink_or_msg
 - wrapper.c: simplify warn_if_unremovable
 (this branch is used by rs/ref-transaction-multi,
rs/ref-transaction-reflog and rs/ref-transaction-rename; uses
rs/ref-transaction-1.)

The third and final part of the basic ref-transaction work.

Has been merged into pu.




rs/ref-transaction-reflog (2014-07-23) 15 commits
-----------------------------------------------------------------------
 - refs.c: allow deleting refs with a broken sha1
 - refs.c: remove lock_any_ref_for_update
 - refs.c: make unlock_ref/close_ref/commit_ref static
 - refs.c: rename log_ref_setup to create_reflog
 - reflog.c: use a reflog transaction when writing during expire
 - refs.c: allow multiple reflog updates during a single transaction
 - refs.c: only write reflog update if msg is non-NULL
 - refs.c: add a flag to allow reflog updates to truncate the log
 - refs.c: add a transaction function to append a reflog entry
 - lockfile.c: make hold_lock_file_for_append preserve meaningful errno
 - refs.c: add a function to append a reflog entry to a fd
 - refs.c: add a new update_type field to ref_update
 - refs.c: rename the transaction functions
 - refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 - refs.c: make ref_transaction_create a wrapper to ref_transaction_update
 (this branch is used by rs/ref-transaction-multi and
rs/ref-transaction-rename; uses rs/ref-transaction and
rs/ref-transaction-1.)

This patch series adds support for reflog updates to the transaction subsystem.
Once it has refactored the builtin/reflog.c to use a transaction
instead of accessing the refs and
reflogs directly it allows us to remove
unlock_ref/close_ref/commit_ref/lock_any_ref_for_update
from the public API.

As part of the reflog work I also refactor how reflog creation works
renaming log_ref_setup to create_reflog. These changes allow us then
to reduce the number of places where
we expose the global log_all_ref_updates to the callers.
This leads to a much cleaner api for reflog creation and avoids completely the
"manipulate the global log_all_ref_updates before calling
log_ref_setup" thing that was done
in checkout.c. Now checkout.c can just call create_reflog() and the
right thing will happen.

At the end of the patch series is an unrelated patch for repairing the
"allow deletion of a broken ref" functionality that was lost a while
back. This patch is independent of the reflog work but is placed here
just to avoid creating additional conflicts with this series and
series that follow.

Has been merged to pu.


ref-transactions-rename
-----------------------------------
refs.c: allow passing raw git_committer_info as email to _update_reflog
refs.c: return error instead of dying when locking fails during transaction
refs.c: use packed refs when deleting refs during a transaction
refs.c: update rename_ref to use a transaction
refs.c: rollback the lockfile before we die() in repack_without_refs

This series focuses on reworking how rename_ref works and to make it
use an atomic transaction for the rename.
The first three patches lead up to a point where we can now perform
the "delete the old ref and add the new ref" as a single atomic
operation to the packed refs file followed by the fourth patch where
we rework rename_ref() completely to perform the rename and the reflog
updates as a single atomic transaction.

As part of this the rename_ref logic is greatly simplified and we
reach several nice goals:
* no need to disallow rename_ref() if the reflog is a symlink
* no need to rename the reflog via a third filename
* make the rename become completely atomic both for the caller but
also for any external observers.

The fifth patch is independent to the rename work itself but was
discovered during the work for this patch. It could be applied
separately but I did not see any urgency to push it separetely and
left it as a patch in this series.

Has been merged into pu.



ref-transactions-req-packed-refs
----------------------------------------------
refs.c: move reflog updates into its own function
refs.c: write updates to packed refs when a transaction has more than one ref
remote.c: use a transaction for deleting refs
refs.c: make repack_without_refs static
refs.c: make the *_packed_refs functions static

These patches expands on the "perform ref operations as a packed refs
file commit" and changes the transaction subsystem to always perform
multi-ref updates as a packed ref commit instead of discreete
operations on loose refs.

The new logic is basically:
IF the transaction only touches a single ref, then just do the normal
loose ref operation as before.
   This is to make sure that the very common "git commit" command will
still always be fast.

IF the transaction touches multiple refs, then
 * first copy/move all affected refs to the packed refs file and
commit, then re-lock the packed
   refs file until the transaction has completed.
 * then delete any affected loose refs files (they are already in the
packed refs file)
 * perform the operation by adding/removing/updating packed refs entries
 * finally, commit the packed refs file

This leads to several new nice properties.
First, the transaction subsystem will now do the "right thing" and
automatically convert any
multi-ref updates to use the packed refs file. This then means that we
no longer need to have
special casing for clone.c to use a special packed_refs api. Clone.c
can now just use a transaction for its "add all refs" and the right
thing will happen.
Similar optimizations can be done for remote.c which now also can just
use a transaction
and know that the right thing will happen.
As we now no longer need to expose the special purpose packed-refs api
to external callers we can now make all the packed refs functions
private to refs.c and shrink the size of the public api.

Note: we still do have packed refs and they still work the same way as
before. It is just that the packed refs are now an internal
optimization for the refs code and no longer part of the public api.

Second, all transaction that affects multiple refs will now also
become atomic for any external observer regardless of whether they
used the packed refs api or not.


The following functions are now static to refs.c and no longer part of
the public api:
 add_packed_ref/lock_packed_refs/commit_packed_refs/rollback_packed_refs/repack_without_refs

Has been merged into pu.



Following are the patch series that has not yet made its way into pu.


ref-transactions-req-strbuf-err
-------------------------------------------
This series just contains various changes internally to refs.c to
expand on the use of a strbuf *err as argument for passing error
messages back to the caller.
Only thing by note here is tgat by doing this to update_ref() we can
finally get rid of the action_on_err enum:

-enum action_on_err {
-       UPDATE_REFS_MSG_ON_ERR,
-       UPDATE_REFS_DIE_ON_ERR,
-       UPDATE_REFS_QUIET_ON_ERR
-};

wooohooo

As part of this patch series I noticed that there were two places in
transport*.c where we were calling update_ref() and passing '0' as
argument instead of UPDATE_REFS_MSG_ON_ERR.
Not a bug and not a change in functionality but it would be nice if
the compiler could warn for this.



ref-transactions-send-pack
---------------------------------------
Various changes to allow a new argument  --atomic-push, and protocol
changes, to allow a client to request/negotiate that a multi-ref push
should be atomic. I.e. apply all changes or none.



ref-transactions-send-pack-post
----------------------------------------------
Various other changes to add a strbuf *err argument to error handling.

Not sent to the list yet.



And that concludes the basic ref-transaction stuff.


Once this is in I have a very large patch series that is mainly
rearranging code and to add support for pluggable ref backends.
But that is for when the ref transaction patches are in.



regards
