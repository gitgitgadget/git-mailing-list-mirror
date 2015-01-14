From: Michael Blume <blume.mike@gmail.com>
Subject: Re: Segmentation fault in git apply
Date: Wed, 14 Jan 2015 10:40:06 -0800
Message-ID: <CAO2U3Qjn9o_eYayEMCC3S6DBr9kVH7mPL00QGrXAnV2iYRP-=A@mail.gmail.com>
References: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 19:40:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBSro-0003eo-2m
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 19:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbbANSk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 13:40:27 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:44577 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbbANSk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 13:40:27 -0500
Received: by mail-ob0-f171.google.com with SMTP id uz6so9525013obc.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 10:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=XBcyhmU5zjCpaoDOHLFAMbTVMRsz9W28Z3LsUxQY8Bw=;
        b=KY5Fw+/WARkXBp+YRMcgJT+mJ/oA8CV+Czfo78tXVsbROo37gA+amn2cvs9X1EkHo4
         Ur2H6p1XTD5yPcSakkGpMZpfnCx7KOH9+GdOr22W569LuulmYI1yXq+WNxCRlS6ZM3tH
         0biZ+oDXcVBEs/N4QA+w5FsC4fe0mXNiZb+LBxSZU6WEUbPNYFnMoYz3s8WhUKFDejEp
         4I6zSCZzbKeDtSSOWUk9wKckZHBxY9pjKTkI2frpiJ9OW4gdfpn++8xAPoa95DzT9+hP
         trLyUPzjFEDZYFt+5tqgF+X2Kc6zUmFb97EocuwDRRI0sEjmQYBXZEjFo5SAi6MeDxb3
         /QZA==
X-Received: by 10.202.67.136 with SMTP id q130mr3192817oia.120.1421260826554;
 Wed, 14 Jan 2015 10:40:26 -0800 (PST)
Received: by 10.202.48.207 with HTTP; Wed, 14 Jan 2015 10:40:06 -0800 (PST)
In-Reply-To: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262407>

On Wed, Jan 14, 2015 at 10:20 AM, Michael Blume <blume.mike@gmail.com> wrote:
> This is a mac with a fresh build of git from pu branch, commit 53b80d0.
>
> With my gitconfig looking like
>
> [user]
>     email = blume.mike@gmail.com
>     name = Michael Blume
> [apply]
>     whitespace = fix
> [core]
>     whitespace = fix,trailing-space,space-before-tab, tab-in-indent, tabwidth=4
>
> If I run
> git clone git@github.com:MichaelBlume/clojure.git
> cd clojure
> git checkout origin/rebase-start
> git rebase origin/rebase-base
>
> I get
>
> src/jvm/clojure/lang/Compiler.java                          |  26
> +++++++++++++++++---------
>  test/clojure/test_clojure/compilation.clj                   |  33
> ++++++++++++++++++++++++++++++++-
>  test/clojure/test_clojure/compilation/examples_clj_1561.clj | 121
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 170 insertions(+), 10 deletions(-)
>  create mode 100644 test/clojure/test_clojure/compilation/examples_clj_1561.clj
> First, rewinding head to replay your work on top of it...
> Applying: CLJ-1603 - add reducible cycle, iterate, repeat
> Applying: CLJ-1515 Reify range
> Applying: CLJ-1499 Direct iterators for PersistentHashMap,
> APersistentSet, PersistentQueue, and PersistentStructMap, and records.
> Added new IMapIterable interface for key and val iterators.
> Applying: CLJ-1602 Make keys and vals return Iterable result
> Applying: fix AOT bug preventing overriding of clojure.core functions
> Applying: catch multiple rest forms
> Applying: zipmap using iterators and transient maps
> Applying: Define merge/merge-with after reduce has loaded
> Applying: very simple test of the merge function
> Applying: Support get on arbitrary java.util.List instances
> Applying: CLJ-1451 add take-until
> Applying: CLJ-1606 - complete eduction's xform without completing outer rfn
> Applying: add unrolled vector implementation
> Applying: add transient? predicate
> Applying: fix emitted line numbers
> Using index info to reconstruct a base tree...
> M src/jvm/clojure/lang/Compiler.java
> Falling back to patching base and 3-way merge...
> Auto-merging src/jvm/clojure/lang/Compiler.java
> Applying: just use a not
> Applying: trailing whitespace
> Applying: don't mix tabs/spaces in clojure.xml/emit-element
> Applying: avoid mixing tabs with spaces in clojure core code
> Applying: don't optimize for defrecord lookup if keyword is namespaced
> Applying: CLJ-1572 - Extend CollReduce to IReduceInit for supported arity
> Applying: unrolled impls for maps
> Applying: CLJ-703: Remove flush and sync calls when writing class files.
> Applying: CLJ-1078: Add queue and queue? to clojure.core
> Applying: make RT.boundedLength lazier
> Applying: first try for adding compare
> Applying: Fix for #CLJ-1565
> Applying: CLJ-1074: Read +/- Infinity and NaN
> Applying: Fix CLJ-1074 for EdnReader too, see
> eaeda2e7bf2697e565decdf14a8a99fbf8588c57
> Applying: add get-and-set! to expose AtomicReference.getAndSet() for atoms
> Applying: CLJ-1472 Locking macro without explicit monitor-enter, monitor-exit
> Applying: CLJ-1449: Add starts-with? ends-with? contains? to clojure.string
> Applying: if test expr of an if statement is a literal, don't emit the
> runtime test
> Applying: evaluate def symbol metadata only once
> Applying: CLJ-1295: Speed up dissoc on array-maps
> Applying: some throwing
> Applying: don't pass offset to ArrayChunk
> Applying: make EMPTY accessible
> Applying: add handy create methods
> Applying: regenerate
> Applying: regenerate
> /Users/michael.blume/libexec/git-core/git-am: line 854: 92059
> Segmentation fault: 11  git apply --index "$dotest/patch" > /dev/null
> 2>&1
> /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:13: tab
> in indent.
>    IPersistentVector v = (IPersistentVector) asTransient().conj(val)
> /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:14: tab
> in indent.
>    .persistent();
> /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:15: tab
> in indent.
>    return (IPersistentVector) ((IObj) v).withMeta(meta);
> /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:25: tab
> in indent.
> ITransientCollection coll = PersistentVector.EMPTY
> /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:27: tab
> in indent.
> return (ITransientVector) coll.conj(e0).conj(e1).conj(e2)
> warning: squelched 1 whitespace error
> warning: 6 lines add whitespace errors.
> Using index info to reconstruct a base tree...
> M src/jvm/clojure/lang/PersistentUnrolledVector.java
> <stdin>:13: tab in indent.
>    IPersistentVector v = (IPersistentVector) asTransient().conj(val)
> <stdin>:14: tab in indent.
>    .persistent();
> <stdin>:15: tab in indent.
>    return (IPersistentVector) ((IObj) v).withMeta(meta);
> <stdin>:25: tab in indent.
> ITransientCollection coll = PersistentVector.EMPTY
> <stdin>:27: tab in indent.
> return (ITransientVector) coll.conj(e0).conj(e1).conj(e2)
> warning: squelched 1 whitespace error
> warning: 6 lines applied after fixing whitespace errors.
> Falling back to patching base and 3-way merge...
> fatal: Unable to create
> '/Users/michael.blume/workspace/clojure/.git/index.lock': File exists.
>
> If no other git process is currently running, this probably means a
> git process crashed in this repository earlier. Make sure no other git
> process is running and remove the file manually to continue.
> Failed to merge in the changes.
> Patch failed at 0041 regenerate
> The copy of the patch that failed is found in:
>    /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch
>
> When you have resolved this problem, run "git rebase --continue".
> If you prefer to skip this patch, run "git rebase --skip" instead.
> To check out the original branch and stop rebasing, run "git rebase --abort".

Same problem, exists on master, checking 2.2.2
