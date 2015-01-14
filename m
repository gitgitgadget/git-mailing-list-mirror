From: Michael Blume <blume.mike@gmail.com>
Subject: Re: Segmentation fault in git apply
Date: Wed, 14 Jan 2015 10:58:47 -0800
Message-ID: <CAO2U3Qje-YwcV1d5BK_zZqrTki4AU=emdkUZzEEieRjmoQdmGg@mail.gmail.com>
References: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com>
 <CAO2U3Qjn9o_eYayEMCC3S6DBr9kVH7mPL00QGrXAnV2iYRP-=A@mail.gmail.com>
 <CAO2U3Qj-Hg2tb72NgO6wb-aqAxFG7aga2ZDeZNDCPJzGtmHTAA@mail.gmail.com> <CAO2U3Qhd_DPP09BUyMr6NKUtOe4EQQ7G83BRg7MbtQXFPjKv8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 19:59:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBT9u-0003qM-Hn
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 19:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbbANS7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 13:59:10 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:51234 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbbANS7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 13:59:08 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp18so5317337obc.11
        for <git@vger.kernel.org>; Wed, 14 Jan 2015 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=rnJMdgA2DP4QdH0yb4PzAlo9J5uxhhXCbGecYPrdSQo=;
        b=FOSRit6WsFBvG12+GFL3CIZ8HTH5aPzkM63ZFMaiYhq6/bo2CxkD931YZcAhJgy3qY
         Qdn4CRcET3pMQvDne0JrgFKu5usMJzLhm5/WhyyBGAbd0EDGCFH8EQnflWmXgYo/4Yv0
         UsmNA7/NdI/qy1RwSodWnCcvuaD94jToffLQwVkofxfxOmuIe/0KibQ0c6ubInFTMtv2
         NpNYO8z48Km61VGAjhcyljTAp+ex4P2L5awt1j7CcRY/Kz6cnvK/jm4K/gmMAYzPhcYY
         hb271XLYpw8lepHwSVgdSc2RbFh4P2n4EXM5pY65UH230UPR3DT+jgpeQkFmEvDYiJ1R
         eqyA==
X-Received: by 10.60.102.200 with SMTP id fq8mr3584835oeb.2.1421261947752;
 Wed, 14 Jan 2015 10:59:07 -0800 (PST)
Received: by 10.202.48.207 with HTTP; Wed, 14 Jan 2015 10:58:47 -0800 (PST)
In-Reply-To: <CAO2U3Qhd_DPP09BUyMr6NKUtOe4EQQ7G83BRg7MbtQXFPjKv8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262412>

On Wed, Jan 14, 2015 at 10:48 AM, Michael Blume <blume.mike@gmail.com> wrote:
> On Wed, Jan 14, 2015 at 10:44 AM, Michael Blume <blume.mike@gmail.com> wrote:
>> On Wed, Jan 14, 2015 at 10:40 AM, Michael Blume <blume.mike@gmail.com> wrote:
>>> On Wed, Jan 14, 2015 at 10:20 AM, Michael Blume <blume.mike@gmail.com> wrote:
>>>> This is a mac with a fresh build of git from pu branch, commit 53b80d0.
>>>>
>>>> With my gitconfig looking like
>>>>
>>>> [user]
>>>>     email = blume.mike@gmail.com
>>>>     name = Michael Blume
>>>> [apply]
>>>>     whitespace = fix
>>>> [core]
>>>>     whitespace = fix,trailing-space,space-before-tab, tab-in-indent, tabwidth=4
>>>>
>>>> If I run
>>>> git clone git@github.com:MichaelBlume/clojure.git
>>>> cd clojure
>>>> git checkout origin/rebase-start
>>>> git rebase origin/rebase-base
>>>>
>>>> I get
>>>>
>>>> src/jvm/clojure/lang/Compiler.java                          |  26
>>>> +++++++++++++++++---------
>>>>  test/clojure/test_clojure/compilation.clj                   |  33
>>>> ++++++++++++++++++++++++++++++++-
>>>>  test/clojure/test_clojure/compilation/examples_clj_1561.clj | 121
>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 170 insertions(+), 10 deletions(-)
>>>>  create mode 100644 test/clojure/test_clojure/compilation/examples_clj_1561.clj
>>>> First, rewinding head to replay your work on top of it...
>>>> Applying: CLJ-1603 - add reducible cycle, iterate, repeat
>>>> Applying: CLJ-1515 Reify range
>>>> Applying: CLJ-1499 Direct iterators for PersistentHashMap,
>>>> APersistentSet, PersistentQueue, and PersistentStructMap, and records.
>>>> Added new IMapIterable interface for key and val iterators.
>>>> Applying: CLJ-1602 Make keys and vals return Iterable result
>>>> Applying: fix AOT bug preventing overriding of clojure.core functions
>>>> Applying: catch multiple rest forms
>>>> Applying: zipmap using iterators and transient maps
>>>> Applying: Define merge/merge-with after reduce has loaded
>>>> Applying: very simple test of the merge function
>>>> Applying: Support get on arbitrary java.util.List instances
>>>> Applying: CLJ-1451 add take-until
>>>> Applying: CLJ-1606 - complete eduction's xform without completing outer rfn
>>>> Applying: add unrolled vector implementation
>>>> Applying: add transient? predicate
>>>> Applying: fix emitted line numbers
>>>> Using index info to reconstruct a base tree...
>>>> M src/jvm/clojure/lang/Compiler.java
>>>> Falling back to patching base and 3-way merge...
>>>> Auto-merging src/jvm/clojure/lang/Compiler.java
>>>> Applying: just use a not
>>>> Applying: trailing whitespace
>>>> Applying: don't mix tabs/spaces in clojure.xml/emit-element
>>>> Applying: avoid mixing tabs with spaces in clojure core code
>>>> Applying: don't optimize for defrecord lookup if keyword is namespaced
>>>> Applying: CLJ-1572 - Extend CollReduce to IReduceInit for supported arity
>>>> Applying: unrolled impls for maps
>>>> Applying: CLJ-703: Remove flush and sync calls when writing class files.
>>>> Applying: CLJ-1078: Add queue and queue? to clojure.core
>>>> Applying: make RT.boundedLength lazier
>>>> Applying: first try for adding compare
>>>> Applying: Fix for #CLJ-1565
>>>> Applying: CLJ-1074: Read +/- Infinity and NaN
>>>> Applying: Fix CLJ-1074 for EdnReader too, see
>>>> eaeda2e7bf2697e565decdf14a8a99fbf8588c57
>>>> Applying: add get-and-set! to expose AtomicReference.getAndSet() for atoms
>>>> Applying: CLJ-1472 Locking macro without explicit monitor-enter, monitor-exit
>>>> Applying: CLJ-1449: Add starts-with? ends-with? contains? to clojure.string
>>>> Applying: if test expr of an if statement is a literal, don't emit the
>>>> runtime test
>>>> Applying: evaluate def symbol metadata only once
>>>> Applying: CLJ-1295: Speed up dissoc on array-maps
>>>> Applying: some throwing
>>>> Applying: don't pass offset to ArrayChunk
>>>> Applying: make EMPTY accessible
>>>> Applying: add handy create methods
>>>> Applying: regenerate
>>>> Applying: regenerate
>>>> /Users/michael.blume/libexec/git-core/git-am: line 854: 92059
>>>> Segmentation fault: 11  git apply --index "$dotest/patch" > /dev/null
>>>> 2>&1
>>>> /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:13: tab
>>>> in indent.
>>>>    IPersistentVector v = (IPersistentVector) asTransient().conj(val)
>>>> /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:14: tab
>>>> in indent.
>>>>    .persistent();
>>>> /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:15: tab
>>>> in indent.
>>>>    return (IPersistentVector) ((IObj) v).withMeta(meta);
>>>> /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:25: tab
>>>> in indent.
>>>> ITransientCollection coll = PersistentVector.EMPTY
>>>> /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:27: tab
>>>> in indent.
>>>> return (ITransientVector) coll.conj(e0).conj(e1).conj(e2)
>>>> warning: squelched 1 whitespace error
>>>> warning: 6 lines add whitespace errors.
>>>> Using index info to reconstruct a base tree...
>>>> M src/jvm/clojure/lang/PersistentUnrolledVector.java
>>>> <stdin>:13: tab in indent.
>>>>    IPersistentVector v = (IPersistentVector) asTransient().conj(val)
>>>> <stdin>:14: tab in indent.
>>>>    .persistent();
>>>> <stdin>:15: tab in indent.
>>>>    return (IPersistentVector) ((IObj) v).withMeta(meta);
>>>> <stdin>:25: tab in indent.
>>>> ITransientCollection coll = PersistentVector.EMPTY
>>>> <stdin>:27: tab in indent.
>>>> return (ITransientVector) coll.conj(e0).conj(e1).conj(e2)
>>>> warning: squelched 1 whitespace error
>>>> warning: 6 lines applied after fixing whitespace errors.
>>>> Falling back to patching base and 3-way merge...
>>>> fatal: Unable to create
>>>> '/Users/michael.blume/workspace/clojure/.git/index.lock': File exists.
>>>>
>>>> If no other git process is currently running, this probably means a
>>>> git process crashed in this repository earlier. Make sure no other git
>>>> process is running and remove the file manually to continue.
>>>> Failed to merge in the changes.
>>>> Patch failed at 0041 regenerate
>>>> The copy of the patch that failed is found in:
>>>>    /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch
>>>>
>>>> When you have resolved this problem, run "git rebase --continue".
>>>> If you prefer to skip this patch, run "git rebase --skip" instead.
>>>> To check out the original branch and stop rebasing, run "git rebase --abort".
>>>
>>> Same problem, exists on master, checking 2.2.2
>> Exists in 2.2.2, checking 2.0.0
> Ok, problem exists in 2.0.0 but not in 1.8.0, bisecting...
Hmm, sorry, no, this is strange, problem actually does exist in 1.8.0
but waits until a later commit and has somewhat different output but
still looks like a crash in git-apply...

First, rewinding head to replay your work on top of it...
Applying: CLJ-1603 - add reducible cycle, iterate, repeat
Applying: CLJ-1515 Reify range
Applying: CLJ-1499 Direct iterators for PersistentHashMap,
APersistentSet, PersistentQueue, and PersistentStructMap, and records.
Added new IMapIterable interface for key and val iterators.
Applying: CLJ-1602 Make keys and vals return Iterable result
Applying: fix AOT bug preventing overriding of clojure.core functions
Applying: catch multiple rest forms
Applying: zipmap using iterators and transient maps
Applying: Define merge/merge-with after reduce has loaded
Applying: very simple test of the merge function
Applying: Support get on arbitrary java.util.List instances
Applying: CLJ-1451 add take-until
Applying: CLJ-1606 - complete eduction's xform without completing outer rfn
Applying: add unrolled vector implementation
Applying: add transient? predicate
Applying: fix emitted line numbers
Using index info to reconstruct a base tree...
M src/jvm/clojure/lang/Compiler.java
Falling back to patching base and 3-way merge...
Auto-merging src/jvm/clojure/lang/Compiler.java
Applying: just use a not
Applying: trailing whitespace
Applying: don't mix tabs/spaces in clojure.xml/emit-element
Applying: avoid mixing tabs with spaces in clojure core code
Applying: don't optimize for defrecord lookup if keyword is namespaced
Applying: CLJ-1572 - Extend CollReduce to IReduceInit for supported arity
Applying: unrolled impls for maps
Applying: CLJ-703: Remove flush and sync calls when writing class files.
Applying: CLJ-1078: Add queue and queue? to clojure.core
Applying: make RT.boundedLength lazier
Applying: first try for adding compare
Applying: Fix for #CLJ-1565
Applying: CLJ-1074: Read +/- Infinity and NaN
Applying: Fix CLJ-1074 for EdnReader too, see
eaeda2e7bf2697e565decdf14a8a99fbf8588c57
Applying: add get-and-set! to expose AtomicReference.getAndSet() for atoms
Applying: CLJ-1472 Locking macro without explicit monitor-enter, monitor-exit
Applying: CLJ-1449: Add starts-with? ends-with? contains? to clojure.string
Applying: if test expr of an if statement is a literal, don't emit the
runtime test
Applying: evaluate def symbol metadata only once
Applying: CLJ-1295: Speed up dissoc on array-maps
Applying: some throwing
Applying: don't pass offset to ArrayChunk
Applying: make EMPTY accessible
Applying: add handy create methods
Applying: regenerate
Applying: regenerate
Applying: fix handling of key meta in assoc
Applying: don't check mapequivalence
Applying: add editablemap
Applying: use an arraymap in persistenthashset
Applying: no, use an unrolledmap
Applying: use the new stuff
Applying: CLJ-1613: evaluate :or defaults in enclosing scope in map
destructuring
Applying: CLJ-1615 ensure transient set "keys" and "values" have
consistent metadata
Applying: fix the unrolledmap transient entryat thing
/Users/michael.blume/libexec/git-core/git-am: line 811: 59793 Abort
trap: 6           git apply --index "$dotest/patch" > /dev/null 2>&1
/Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:10: tab
in indent.
IMapEntry doEntryAt(Object key) {
/Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:11: tab
in indent.
   int h = Util.hasheq(key);
/Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:12: tab
in indent.
   int idx = indexOf(h, key);
/Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:13: tab
in indent.
   switch (idx) {
/Users/michael.blume/workspace/clojure/.git/rebase-apply/patch:14: tab
in indent.
   case 0:
warning: squelched 15 whitespace errors
warning: 20 lines add whitespace errors.
Using index info to reconstruct a base tree...
M src/jvm/clojure/lang/PersistentUnrolledMap.java
<stdin>:10: tab in indent.
IMapEntry doEntryAt(Object key) {
<stdin>:11: tab in indent.
   int h = Util.hasheq(key);
<stdin>:12: tab in indent.
   int idx = indexOf(h, key);
<stdin>:13: tab in indent.
   switch (idx) {
<stdin>:14: tab in indent.
   case 0:
warning: squelched 15 whitespace errors
warning: 20 lines applied after fixing whitespace errors.
Falling back to patching base and 3-way merge...
fatal: Unable to create
'/Users/michael.blume/workspace/clojure/.git/index.lock': File exists.

If no other git process is currently running, this probably means a
git process crashed in this repository earlier. Make sure no other git
process is running and remove the file manually to continue.
Failed to merge in the changes.
Patch failed at 0050 fix the unrolledmap transient entryat thing
The copy of the patch that failed is found in:
   /Users/michael.blume/workspace/clojure/.git/rebase-apply/patch

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".
