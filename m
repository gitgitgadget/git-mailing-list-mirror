From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: First stab at glossary
Date: Wed, 17 Aug 2005 16:56:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508171655250.13502@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463794688-618415668-1124290608=:13502"
X-From: git-owner@vger.kernel.org Wed Aug 17 16:57:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5PLt-00079f-5I
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 16:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVHQO4u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 10:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVHQO4u
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 10:56:50 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:28565 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751147AbVHQO4u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 10:56:50 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 921F9E26AE
	for <git@vger.kernel.org>; Wed, 17 Aug 2005 16:56:48 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 72CB8AD803
	for <git@vger.kernel.org>; Wed, 17 Aug 2005 16:56:48 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 3FB2DAD5B4
	for <git@vger.kernel.org>; Wed, 17 Aug 2005 16:56:48 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 3063AE26AE
	for <git@vger.kernel.org>; Wed, 17 Aug 2005 16:56:48 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794688-618415668-1124290608=:13502
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

long, long time. Here=B4s my first stab at the glossary, attached the=20
alphabetically sorted, asciidoc marked up txt file (Comments?=20
Suggestions? Pizzas?):

object::
	The unit of storage in GIT. It is uniquely identified by
	the SHA1 of its contents. Consequently, an object can not
	be changed.

SHA1::
	A 20-byte sequence (or 41-byte file containing the hex
	representation and a newline). It is calculated from the
	contents of an object by the Secure Hash Algorithm 1.

object database::
	Stores a set of "objects", and an individial object is identified
	by its SHA1 (its ref). The objects are either stored as single
	files, or live inside of packs.

object name::
	Synonym for SHA1.

blob object::
	Untyped object, i.e. the contents of a file.

tree object::
	An object containing a list of blob and/or tree objects.
	(A tree usually corresponds to a directory without
	subdirectories).

tree::
	Either a working tree, or a tree object together with the
	dependent blob and tree objects (i.e. a stored representation
	of a working tree).

cache::
	A collection of files whose contents are stored as objects.
	The cache is a stored version of your working tree. Well, can
	also contain a second, and even a third version of a working
	tree, which are used when merging.

cache entry::
	The information regarding a particular file, stored in the index.
	A cache entry can be unmerged, if a merge was started, but not
	yet finished (i.e. if the cache contains multiple versions of
	that file).

index::
	Contains information about the cache contents, in particular
	timestamps and mode flags ("stat information") for the files
	stored in the cache. An unmerged index is an index which contains
	unmerged cache entries.

working tree::
	The set of files and directories currently being worked on.
	Think "ls -laR"

directory::
	The list you get with "ls" :-)

checkout::
	The action of updating the working tree to a revision which was
	stored in the object database.

revision::
	A particular state of files and directories which was stored in
	the object database. It is referenced by a commit object.

commit::
	The action of storing the current state of the cache in the
	object database. The result is a revision.

commit object::
	An object which contains the information about a particular
	revision, such as parents, committer, author, date and the
	tree object which corresponds to the top directory of the
	stored revision.

changeset::
	BitKeeper/cvsps speak for "commit". Since git does not store
	changes, but states, it really does not make sense to use
	the term "changesets" with git.

ent::
	Favorite synonym to "tree-ish" by some total geeks.

clean::
	A working tree is clean, if it corresponds to the revision
	referenced by the current head.

dirty::
	A working tree is said to be dirty if it contains modifications
	which have not been committed to the current branch.

head::
	The top of a branch. It contains a ref to the corresponding
	commit object.

branch::
	A non-cyclical graph of revisions, i.e. the complete history of
	a particular revision, which does not (yet) have children, which
	is called the branch head. The branch heads are stored in
	$GIT_DIR/refs/heads/.

ref::
	A 40-byte hex representation of a SHA1 pointing to a particular
	object. These are stored in $GIT_DIR/refs/.

head ref::
	A ref pointing to a head. Often, this is abbreviated to "head".
	Head refs are stored in $GIT_DIR/refs/heads/.

tree-ish::
	A ref pointing to either a commit object, a tree object, or a
	tag object pointing to a commit or tree object.

tag object::
	An object containing a ref pointing to another object. It can
	contain a (PGP) signature, in which case it is called "signed
	tag object".

tag::
	A ref pointing to a tag or commit object. In contrast to a head,
	a tag is not changed by a commit. Tags (not tag objects) are
	stored in $GIT_DIR/refs/tags/. A git tag has nothing to do with
	a Lisp tag (which is called object type in git's context).

merge::
	To merge branches means to try to accumulate the changes since a
	common ancestor and apply them to the first branch. An automatic
	merge uses heuristics to accomplish that. Evidently, an automatic
	merge can fail.

resolve::
	The action of fixing up manually what a failed automatic merge
	left behind.

repository::
	A collection of refs together with an object database containing
	all objects, which are reachable from the refs. A repository can
	share an object database with other repositories.

alternate object database::
	Via the alternates mechanism, a repository can inherit part of its
	object database from another object database, which is called
	"alternate".

reachable::
	An object is reachable from a ref/commit/tree/tag, if there is a
	chain leading from the latter to the former.

chain::
	A list of objects, where each object in the list contains a
	reference to its successor (for example, the successor of a commit
	could be one of its parents).

parent::
	A commit object contains a (possibly empty) list of the logical
	predecessor(s) in the line of development, i.e. its parents.

fetch::
	Fetching a branch means to get the branch's head ref from a
	remote repository, to find out which objects are missing from
	the local object database, and to get them, too.

pull::
	Pulling a branch means to fetch it and merge it.

push::
	Pushing a branch means to get the branch's head ref from a remote
	repository, find out if it is an ancestor to the branch's local
	head ref is a direct, and in that case, putting all objects, which
	are reachable from the local head ref, and which are missing from
	the remote repository, into the remote object database, and updating
	the remote head ref. If the remote head is not an ancestor to the
	local head, the push fails.

pack::
	A set of objects which have been compressed into one file (to save
	space or to transmit them efficiently).

pack index::
	Contains offsets into a pack, so the pack can be used instead of
	the unpacked objects.

plumbing::
	Cute name for core git.

porcelain::
	Cute name for programs and program suites depending on core git,
	presenting a high level access to core git. Porcelains expose
	more of a SCM interface than the plumbing.

object type:
	One of the identifiers "commit","tree","tag" and "blob" describing
	the type of an object.

SCM::
	Source code management (tool).

dircache::
	You are *waaaaay* behind.

---1463794688-618415668-1124290608=:13502
Content-Type: TEXT/plain; charset=US-ASCII; name=glossary.txt
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.63.0508171656480.13502@wgmdd8.biozentrum.uni-wuerzburg.de>
Content-Description: 
Content-Disposition: attachment; filename=glossary.txt

R0lUIEdsb3NzYXJ5DQo9PT09PT09PT09PT0NCkF1ZyAyMDA1DQoNCltbcmVm
X1NDTV1dU0NNOjoNCglTb3VyY2UgY29kZSBtYW5hZ2VtZW50ICh0b29sKS4g
DQoNCltbcmVmX1NIQTFdXVNIQTE6Og0KCUEgMjAtYnl0ZSBzZXF1ZW5jZSAo
b3IgNDEtYnl0ZSBmaWxlIGNvbnRhaW5pbmcgdGhlIGhleCByZXByZXNlbnRh
dGlvbg0KCWFuZCBhIG5ld2xpbmUpLiBJdCBpcyBjYWxjdWxhdGVkIGZyb20g
dGhlIGNvbnRlbnRzIG9mIGFuDQoJPDxyZWZfb2JqZWN0LG9iamVjdD4+IGJ5
IHRoZSBTZWN1cmUgSGFzaCBBbGdvcml0aG0gMS4gDQoNCltbcmVmX2FsdGVy
bmF0ZV9vYmplY3RfZGF0YWJhc2VdXWFsdGVybmF0ZSBvYmplY3QgZGF0YWJh
c2U6Og0KCVZpYSB0aGUgYWx0ZXJuYXRlcyBtZWNoYW5pc20sIGEgPDxyZWZf
cmVwb3NpdG9yeSxyZXBvc2l0b3J5Pj4gY2FuDQoJaW5oZXJpdCBwYXJ0IG9m
IGl0cyA8PHJlZl9vYmplY3RfZGF0YWJhc2Usb2JqZWN0IGRhdGFiYXNlPj4g
ZnJvbSBhbm90aGVyDQoJPDxyZWZfb2JqZWN0X2RhdGFiYXNlLG9iamVjdCBk
YXRhYmFzZT4+LCB3aGljaCBpcyBjYWxsZWQgImFsdGVybmF0ZSIuIA0KDQpb
W3JlZl9ibG9iX29iamVjdF1dYmxvYiBvYmplY3Q6Og0KCVVudHlwZWQgPDxy
ZWZfb2JqZWN0LG9iamVjdD4+LCBpLmUuIHRoZSBjb250ZW50cyBvZiBhIGZp
bGUuIA0KDQpbW3JlZl9icmFuY2hdXWJyYW5jaDo6DQoJQSBub24tY3ljbGlj
YWwgZ3JhcGggb2YgcmV2aXNpb25zLCBpLmUuIHRoZSBjb21wbGV0ZSBoaXN0
b3J5IG9mIGENCglwYXJ0aWN1bGFyIDw8cmVmX3JldmlzaW9uLHJldmlzaW9u
Pj4sIHdoaWNoIGRvZXMgbm90ICh5ZXQpIGhhdmUNCgljaGlsZHJlbiwgd2hp
Y2ggaXMgY2FsbGVkIHRoZSA8PHJlZl9icmFuY2gsYnJhbmNoPj4gPDxyZWZf
aGVhZCxoZWFkPj4uDQoJVGhlIDw8cmVmX2JyYW5jaCxicmFuY2g+PiBoZWFk
cyBhcmUgc3RvcmVkIGluICRHSVRfRElSL3JlZnMvaGVhZHMvLiANCg0KW1ty
ZWZfY2FjaGVdXWNhY2hlOjoNCglBIGNvbGxlY3Rpb24gb2YgZmlsZXMgd2hv
c2UgY29udGVudHMgYXJlIHN0b3JlZCBhcyBvYmplY3RzLiBUaGUNCgk8PHJl
Zl9jYWNoZSxjYWNoZT4+IGlzIGEgc3RvcmVkIHZlcnNpb24gb2YgeW91cg0K
CTw8cmVmX3dvcmtpbmdfdHJlZSx3b3JraW5nIHRyZWU+Pi4gV2VsbCwgY2Fu
IGFsc28gY29udGFpbiBhIHNlY29uZCwgYW5kDQoJZXZlbiBhIHRoaXJkIHZl
cnNpb24gb2YgYSB3b3JraW5nIDw8cmVmX3RyZWUsdHJlZT4+LCB3aGljaCBh
cmUgdXNlZCB3aGVuDQoJbWVyZ2luZy4gDQoNCltbcmVmX2NhY2hlX2VudHJ5
XV1jYWNoZSBlbnRyeTo6DQoJVGhlIGluZm9ybWF0aW9uIHJlZ2FyZGluZyBh
IHBhcnRpY3VsYXIgZmlsZSwgc3RvcmVkIGluIHRoZQ0KCTw8cmVmX2luZGV4
LGluZGV4Pj4uIEEgPDxyZWZfY2FjaGVfZW50cnksY2FjaGUgZW50cnk+PiBj
YW4gYmUgdW5tZXJnZWQsDQoJaWYgYSA8PHJlZl9tZXJnZSxtZXJnZT4+IHdh
cyBzdGFydGVkLCBidXQgbm90IHlldCBmaW5pc2hlZCAoaS5lLiBpZiB0aGUN
Cgk8PHJlZl9jYWNoZSxjYWNoZT4+IGNvbnRhaW5zIG11bHRpcGxlIHZlcnNp
b25zIG9mIHRoYXQgZmlsZSkuIA0KDQpbW3JlZl9jaGFpbl1dY2hhaW46Og0K
CUEgbGlzdCBvZiBvYmplY3RzLCB3aGVyZSBlYWNoIDw8cmVmX29iamVjdCxv
YmplY3Q+PiBpbiB0aGUgbGlzdCBjb250YWlucw0KCWEgcmVmZXJlbmNlIHRv
IGl0cyBzdWNjZXNzb3IgKGZvciBleGFtcGxlLCB0aGUgc3VjY2Vzc29yIG9m
IGENCgk8PHJlZl9jb21taXQsY29tbWl0Pj4gY291bGQgYmUgb25lIG9mIGl0
cyBwYXJlbnRzKS4gDQoNCltbcmVmX2NoYW5nZXNldF1dY2hhbmdlc2V0OjoN
CglCaXRLZWVwZXIvY3ZzcHMgc3BlYWsgZm9yICI8PHJlZl9jb21taXQsY29t
bWl0Pj4iLiBTaW5jZSBnaXQgZG9lcyBub3QNCglzdG9yZSBjaGFuZ2VzLCBi
dXQgc3RhdGVzLCBpdCByZWFsbHkgZG9lcyBub3QgbWFrZSBzZW5zZSB0byB1
c2UgdGhlIHRlcm0NCgkiY2hhbmdlc2V0cyIgd2l0aCBnaXQuIA0KDQpbW3Jl
Zl9jaGVja291dF1dY2hlY2tvdXQ6Og0KCVRoZSBhY3Rpb24gb2YgdXBkYXRp
bmcgdGhlIDw8cmVmX3dvcmtpbmdfdHJlZSx3b3JraW5nIHRyZWU+PiB0byBh
DQoJPDxyZWZfcmV2aXNpb24scmV2aXNpb24+PiB3aGljaCB3YXMgc3RvcmVk
IGluIHRoZQ0KCTw8cmVmX29iamVjdF9kYXRhYmFzZSxvYmplY3QgZGF0YWJh
c2U+Pi4gDQoNCltbcmVmX2NsZWFuXV1jbGVhbjo6DQoJQSA8PHJlZl93b3Jr
aW5nX3RyZWUsd29ya2luZyB0cmVlPj4gaXMgPDxyZWZfY2xlYW4sY2xlYW4+
PiwgaWYgaXQNCgljb3JyZXNwb25kcyB0byB0aGUgPDxyZWZfcmV2aXNpb24s
cmV2aXNpb24+PiByZWZlcmVuY2VkIGJ5IHRoZSBjdXJyZW50DQoJPDxyZWZf
aGVhZCxoZWFkPj4uIA0KDQpbW3JlZl9jb21taXRdXWNvbW1pdDo6DQoJVGhl
IGFjdGlvbiBvZiBzdG9yaW5nIHRoZSBjdXJyZW50IHN0YXRlIG9mIHRoZSA8
PHJlZl9jYWNoZSxjYWNoZT4+IGluDQoJdGhlIDw8cmVmX29iamVjdF9kYXRh
YmFzZSxvYmplY3QgZGF0YWJhc2U+Pi4gVGhlIHJlc3VsdCBpcyBhDQoJPDxy
ZWZfcmV2aXNpb24scmV2aXNpb24+Pi4gDQoNCltbcmVmX2NvbW1pdF9vYmpl
Y3RdXWNvbW1pdCBvYmplY3Q6Og0KCUFuIDw8cmVmX29iamVjdCxvYmplY3Q+
PiB3aGljaCBjb250YWlucyB0aGUgaW5mb3JtYXRpb24gYWJvdXQgYQ0KCXBh
cnRpY3VsYXIgPDxyZWZfcmV2aXNpb24scmV2aXNpb24+Piwgc3VjaCBhcyBw
YXJlbnRzLCBjb21taXR0ZXIsDQoJYXV0aG9yLCBkYXRlIGFuZCB0aGUgPDxy
ZWZfdHJlZV9vYmplY3QsdHJlZSBvYmplY3Q+PiB3aGljaCBjb3JyZXNwb25k
cw0KCXRvIHRoZSB0b3AgPDxyZWZfZGlyZWN0b3J5LGRpcmVjdG9yeT4+IG9m
IHRoZSBzdG9yZWQNCgk8PHJlZl9yZXZpc2lvbixyZXZpc2lvbj4+LiANCg0K
W1tyZWZfZGlyY2FjaGVdXWRpcmNhY2hlOjoNCglZb3UgYXJlICp3YWFhYWF5
KiBiZWhpbmQuIA0KDQpbW3JlZl9kaXJlY3RvcnldXWRpcmVjdG9yeTo6DQoJ
VGhlIGxpc3QgeW91IGdldCB3aXRoICJscyIgOi0pIA0KDQpbW3JlZl9kaXJ0
eV1dZGlydHk6Og0KCUEgPDxyZWZfd29ya2luZ190cmVlLHdvcmtpbmcgdHJl
ZT4+IGlzIHNhaWQgdG8gYmUgPDxyZWZfZGlydHksZGlydHk+PiBpZg0KCWl0
IGNvbnRhaW5zIG1vZGlmaWNhdGlvbnMgd2hpY2ggaGF2ZSBub3QgYmVlbiBj
b21taXR0ZWQgdG8gdGhlIGN1cnJlbnQNCgk8PHJlZl9icmFuY2gsYnJhbmNo
Pj4uIA0KDQpbW3JlZl9lbnRdXWVudDo6DQoJRmF2b3JpdGUgc3lub255bSB0
byAiPDxyZWZfdHJlZS1pc2gsdHJlZS1pc2g+PiIgYnkgc29tZSB0b3RhbCBn
ZWVrcy4gDQoNCltbcmVmX2ZldGNoXV1mZXRjaDo6DQoJRmV0Y2hpbmcgYSA8
PHJlZl9icmFuY2gsYnJhbmNoPj4gbWVhbnMgdG8gZ2V0IHRoZQ0KCTw8cmVm
X2JyYW5jaCxicmFuY2g+PidzIDw8cmVmX2hlYWRfcmVmLGhlYWQgcmVmPj4g
ZnJvbSBhIHJlbW90ZQ0KCTw8cmVmX3JlcG9zaXRvcnkscmVwb3NpdG9yeT4+
LCB0byBmaW5kIG91dCB3aGljaCBvYmplY3RzIGFyZSBtaXNzaW5nDQoJZnJv
bSB0aGUgbG9jYWwgPDxyZWZfb2JqZWN0X2RhdGFiYXNlLG9iamVjdCBkYXRh
YmFzZT4+LCBhbmQgdG8gZ2V0IHRoZW0sDQoJdG9vLiANCg0KW1tyZWZfaGVh
ZF1daGVhZDo6DQoJVGhlIHRvcCBvZiBhIDw8cmVmX2JyYW5jaCxicmFuY2g+
Pi4gSXQgY29udGFpbnMgYSA8PHJlZl9yZWYscmVmPj4gdG8gdGhlDQoJY29y
cmVzcG9uZGluZyA8PHJlZl9jb21taXRfb2JqZWN0LGNvbW1pdCBvYmplY3Q+
Pi4gDQoNCltbcmVmX2hlYWRfcmVmXV1oZWFkIHJlZjo6DQoJQSA8PHJlZl9y
ZWYscmVmPj4gcG9pbnRpbmcgdG8gYSA8PHJlZl9oZWFkLGhlYWQ+Pi4gT2Z0
ZW4sIHRoaXMgaXMNCglhYmJyZXZpYXRlZCB0byAiPDxyZWZfaGVhZCxoZWFk
Pj4iLiBIZWFkIHJlZnMgYXJlIHN0b3JlZCBpbg0KCSRHSVRfRElSL3JlZnMv
aGVhZHMvLiANCg0KW1tyZWZfaW5kZXhdXWluZGV4OjoNCglDb250YWlucyBp
bmZvcm1hdGlvbiBhYm91dCB0aGUgPDxyZWZfY2FjaGUsY2FjaGU+PiBjb250
ZW50cywgaW4NCglwYXJ0aWN1bGFyIHRpbWVzdGFtcHMgYW5kIG1vZGUgZmxh
Z3MgKCJzdGF0IGluZm9ybWF0aW9uIikgZm9yIHRoZSBmaWxlcw0KCXN0b3Jl
ZCBpbiB0aGUgPDxyZWZfY2FjaGUsY2FjaGU+Pi4gQW4gdW5tZXJnZWQgPDxy
ZWZfaW5kZXgsaW5kZXg+PiBpcyBhbg0KCTw8cmVmX2luZGV4LGluZGV4Pj4g
d2hpY2ggY29udGFpbnMgdW5tZXJnZWQgPDxyZWZfY2FjaGUsY2FjaGU+PiBl
bnRyaWVzLg0KDQpbW3JlZl9tZXJnZV1dbWVyZ2U6Og0KCVRvIDw8cmVmX21l
cmdlLG1lcmdlPj4gYnJhbmNoZXMgbWVhbnMgdG8gdHJ5IHRvIGFjY3VtdWxh
dGUgdGhlIGNoYW5nZXMNCglzaW5jZSBhIGNvbW1vbiBhbmNlc3RvciBhbmQg
YXBwbHkgdGhlbSB0byB0aGUgZmlyc3QNCgk8PHJlZl9icmFuY2gsYnJhbmNo
Pj4uIEFuIGF1dG9tYXRpYyA8PHJlZl9tZXJnZSxtZXJnZT4+IHVzZXMgaGV1
cmlzdGljcw0KCXRvIGFjY29tcGxpc2ggdGhhdC4gRXZpZGVudGx5LCBhbiBh
dXRvbWF0aWMgPDxyZWZfbWVyZ2UsbWVyZ2U+PiBjYW4NCglmYWlsLiANCg0K
W1tyZWZfb2JqZWN0XV1vYmplY3Q6Og0KCVRoZSB1bml0IG9mIHN0b3JhZ2Ug
aW4gR0lULiBJdCBpcyB1bmlxdWVseSBpZGVudGlmaWVkIGJ5IHRoZQ0KCTw8
cmVmX1NIQTEsU0hBMT4+IG9mIGl0cyBjb250ZW50cy4gQ29uc2VxdWVudGx5
LCBhbg0KCTw8cmVmX29iamVjdCxvYmplY3Q+PiBjYW4gbm90IGJlIGNoYW5n
ZWQuIA0KDQpbW3JlZl9vYmplY3RfZGF0YWJhc2VdXW9iamVjdCBkYXRhYmFz
ZTo6DQoJU3RvcmVzIGEgc2V0IG9mICJvYmplY3RzIiwgYW5kIGFuIGluZGl2
aWRpYWwgPDxyZWZfb2JqZWN0LG9iamVjdD4+IGlzDQoJaWRlbnRpZmllZCBi
eSBpdHMgPDxyZWZfU0hBMSxTSEExPj4gKGl0cyA8PHJlZl9yZWYscmVmPj4p
LiBUaGUgb2JqZWN0cw0KCWFyZSBlaXRoZXIgc3RvcmVkIGFzIHNpbmdsZSBm
aWxlcywgb3IgbGl2ZSBpbnNpZGUgb2YgcGFja3MuIA0KDQpbW3JlZl9vYmpl
Y3RfbmFtZV1db2JqZWN0IG5hbWU6Og0KCVN5bm9ueW0gZm9yIDw8cmVmX1NI
QTEsU0hBMT4+LiANCg0KW1tyZWZfcGFja11dcGFjazo6DQoJQSBzZXQgb2Yg
b2JqZWN0cyB3aGljaCBoYXZlIGJlZW4gY29tcHJlc3NlZCBpbnRvIG9uZSBm
aWxlICh0byBzYXZlIHNwYWNlDQoJb3IgdG8gdHJhbnNtaXQgdGhlbSBlZmZp
Y2llbnRseSkuIA0KDQpbW3JlZl9wYWNrX2luZGV4XV1wYWNrIGluZGV4OjoN
CglDb250YWlucyBvZmZzZXRzIGludG8gYSA8PHJlZl9wYWNrLHBhY2s+Piwg
c28gdGhlIDw8cmVmX3BhY2sscGFjaz4+IGNhbg0KCWJlIHVzZWQgaW5zdGVh
ZCBvZiB0aGUgdW5wYWNrZWQgb2JqZWN0cy4gDQoNCltbcmVmX3BhcmVudF1d
cGFyZW50OjoNCglBIDw8cmVmX2NvbW1pdF9vYmplY3QsY29tbWl0IG9iamVj
dD4+IGNvbnRhaW5zIGEgKHBvc3NpYmx5IGVtcHR5KSBsaXN0DQoJb2YgdGhl
IGxvZ2ljYWwgcHJlZGVjZXNzb3IocykgaW4gdGhlIGxpbmUgb2YgZGV2ZWxv
cG1lbnQsIGkuZS4gaXRzDQoJcGFyZW50cy4gDQoNCltbcmVmX3BsdW1iaW5n
XV1wbHVtYmluZzo6DQoJQ3V0ZSBuYW1lIGZvciBjb3JlIGdpdC4gDQoNCltb
cmVmX3BvcmNlbGFpbl1dcG9yY2VsYWluOjoNCglDdXRlIG5hbWUgZm9yIHBy
b2dyYW1zIGFuZCBwcm9ncmFtIHN1aXRlcyBkZXBlbmRpbmcgb24gY29yZSBn
aXQsDQoJcHJlc2VudGluZyBhIGhpZ2ggbGV2ZWwgYWNjZXNzIHRvIGNvcmUg
Z2l0LiBQb3JjZWxhaW5zIGV4cG9zZSBtb3JlIG9mIGENCgk8PHJlZl9TQ00s
U0NNPj4gaW50ZXJmYWNlIHRoYW4gdGhlIDw8cmVmX3BsdW1iaW5nLHBsdW1i
aW5nPj4uIA0KDQpbW3JlZl9wdWxsXV1wdWxsOjoNCglQdWxsaW5nIGEgPDxy
ZWZfYnJhbmNoLGJyYW5jaD4+IG1lYW5zIHRvIDw8cmVmX2ZldGNoLGZldGNo
Pj4gaXQgYW5kDQoJPDxyZWZfbWVyZ2UsbWVyZ2U+PiBpdC4gDQoNCltbcmVm
X3B1c2hdXXB1c2g6Og0KCVB1c2hpbmcgYSA8PHJlZl9icmFuY2gsYnJhbmNo
Pj4gbWVhbnMgdG8gZ2V0IHRoZSA8PHJlZl9icmFuY2gsYnJhbmNoPj4ncw0K
CTw8cmVmX2hlYWRfcmVmLGhlYWQgcmVmPj4gZnJvbSBhIHJlbW90ZSA8PHJl
Zl9yZXBvc2l0b3J5LHJlcG9zaXRvcnk+PiwNCglmaW5kIG91dCBpZiBpdCBp
cyBhbiBhbmNlc3RvciB0byB0aGUgPDxyZWZfYnJhbmNoLGJyYW5jaD4+J3Mg
bG9jYWwNCgk8PHJlZl9oZWFkX3JlZixoZWFkIHJlZj4+IGlzIGEgZGlyZWN0
LCBhbmQgaW4gdGhhdCBjYXNlLCBwdXR0aW5nIGFsbA0KCW9iamVjdHMsIHdo
aWNoIGFyZSA8PHJlZl9yZWFjaGFibGUscmVhY2hhYmxlPj4gZnJvbSB0aGUg
bG9jYWwNCgk8PHJlZl9oZWFkX3JlZixoZWFkIHJlZj4+LCBhbmQgd2hpY2gg
YXJlIG1pc3NpbmcgZnJvbSB0aGUgcmVtb3RlDQoJPDxyZWZfcmVwb3NpdG9y
eSxyZXBvc2l0b3J5Pj4sIGludG8gdGhlIHJlbW90ZQ0KCTw8cmVmX29iamVj
dF9kYXRhYmFzZSxvYmplY3QgZGF0YWJhc2U+PiwgYW5kIHVwZGF0aW5nIHRo
ZSByZW1vdGUNCgk8PHJlZl9oZWFkX3JlZixoZWFkIHJlZj4+LiBJZiB0aGUg
cmVtb3RlIDw8cmVmX2hlYWQsaGVhZD4+IGlzIG5vdCBhbg0KCWFuY2VzdG9y
IHRvIHRoZSBsb2NhbCA8PHJlZl9oZWFkLGhlYWQ+PiwgdGhlIDw8cmVmX3B1
c2gscHVzaD4+IGZhaWxzLiANCg0KW1tyZWZfcmVhY2hhYmxlXV1yZWFjaGFi
bGU6Og0KCUFuIDw8cmVmX29iamVjdCxvYmplY3Q+PiBpcyA8PHJlZl9yZWFj
aGFibGUscmVhY2hhYmxlPj4gZnJvbSBhDQoJPDxyZWZfcmVmLHJlZj4+Lzw8
cmVmX2NvbW1pdCxjb21taXQ+Pi88PHJlZl90cmVlLHRyZWU+Pi88PHJlZl90
YWcsdGFnPj4sDQoJaWYgdGhlcmUgaXMgYSA8PHJlZl9jaGFpbixjaGFpbj4+
IGxlYWRpbmcgZnJvbSB0aGUgbGF0dGVyIHRvIHRoZSBmb3JtZXIuDQoNCltb
cmVmX3JlZl1dcmVmOjoNCglBIDQwLWJ5dGUgaGV4IHJlcHJlc2VudGF0aW9u
IG9mIGEgPDxyZWZfU0hBMSxTSEExPj4gcG9pbnRpbmcgdG8gYQ0KCXBhcnRp
Y3VsYXIgPDxyZWZfb2JqZWN0LG9iamVjdD4+LiBUaGVzZSBhcmUgc3RvcmVk
IGluICRHSVRfRElSL3JlZnMvLiANCg0KW1tyZWZfcmVwb3NpdG9yeV1dcmVw
b3NpdG9yeTo6DQoJQSBjb2xsZWN0aW9uIG9mIHJlZnMgdG9nZXRoZXIgd2l0
aCBhbiA8PHJlZl9vYmplY3RfZGF0YWJhc2Usb2JqZWN0DQoJZGF0YWJhc2U+
PiBjb250YWluaW5nIGFsbCBvYmplY3RzLCB3aGljaCBhcmUgPDxyZWZfcmVh
Y2hhYmxlLHJlYWNoYWJsZT4+DQoJZnJvbSB0aGUgcmVmcy4gQSA8PHJlZl9y
ZXBvc2l0b3J5LHJlcG9zaXRvcnk+PiBjYW4gc2hhcmUgYW4NCgk8PHJlZl9v
YmplY3RfZGF0YWJhc2Usb2JqZWN0IGRhdGFiYXNlPj4gd2l0aCBvdGhlciBy
ZXBvc2l0b3JpZXMuIA0KDQpbW3JlZl9yZXNvbHZlXV1yZXNvbHZlOjoNCglU
aGUgYWN0aW9uIG9mIGZpeGluZyB1cCBtYW51YWxseSB3aGF0IGEgZmFpbGVk
IGF1dG9tYXRpYw0KCTw8cmVmX21lcmdlLG1lcmdlPj4gbGVmdCBiZWhpbmQu
IA0KDQpbW3JlZl9yZXZpc2lvbl1dcmV2aXNpb246Og0KCUEgcGFydGljdWxh
ciBzdGF0ZSBvZiBmaWxlcyBhbmQgZGlyZWN0b3JpZXMgd2hpY2ggd2FzIHN0
b3JlZCBpbiB0aGUNCgk8PHJlZl9vYmplY3RfZGF0YWJhc2Usb2JqZWN0IGRh
dGFiYXNlPj4uIEl0IGlzIHJlZmVyZW5jZWQgYnkgYQ0KCTw8cmVmX2NvbW1p
dF9vYmplY3QsY29tbWl0IG9iamVjdD4+LiANCg0KW1tyZWZfdGFnXV10YWc6
Og0KCUEgPDxyZWZfcmVmLHJlZj4+IHBvaW50aW5nIHRvIGEgPDxyZWZfdGFn
LHRhZz4+IG9yDQoJPDxyZWZfY29tbWl0X29iamVjdCxjb21taXQgb2JqZWN0
Pj4uIEluIGNvbnRyYXN0IHRvIGEgPDxyZWZfaGVhZCxoZWFkPj4sDQoJYSA8
PHJlZl90YWcsdGFnPj4gaXMgbm90IGNoYW5nZWQgYnkgYSA8PHJlZl9jb21t
aXQsY29tbWl0Pj4uIFRhZ3MgKG5vdA0KCTw8cmVmX3RhZyx0YWc+PiBvYmpl
Y3RzKSBhcmUgc3RvcmVkIGluICRHSVRfRElSL3JlZnMvdGFncy8uIEEgZ2l0
DQoJPDxyZWZfdGFnLHRhZz4+IGhhcyBub3RoaW5nIHRvIGRvIHdpdGggYSBM
aXNwIDw8cmVmX3RhZyx0YWc+PiAod2hpY2ggaXMNCgljYWxsZWQgPDxyZWZf
b2JqZWN0LG9iamVjdD4+IHR5cGUgaW4gZ2l0J3MgY29udGV4dCkuIA0KDQpb
W3JlZl90YWdfb2JqZWN0XV10YWcgb2JqZWN0OjoNCglBbiA8PHJlZl9vYmpl
Y3Qsb2JqZWN0Pj4gY29udGFpbmluZyBhIDw8cmVmX3JlZixyZWY+PiBwb2lu
dGluZyB0bw0KCWFub3RoZXIgPDxyZWZfb2JqZWN0LG9iamVjdD4+LiBJdCBj
YW4gY29udGFpbiBhIChQR1ApIHNpZ25hdHVyZSwgaW4NCgl3aGljaCBjYXNl
IGl0IGlzIGNhbGxlZCAic2lnbmVkIDw8cmVmX3RhZ19vYmplY3QsdGFnIG9i
amVjdD4+Ii4gDQoNCltbcmVmX3RyZWVdXXRyZWU6Og0KCUVpdGhlciBhIDw8
cmVmX3dvcmtpbmdfdHJlZSx3b3JraW5nIHRyZWU+Piwgb3IgYSA8PHJlZl90
cmVlX29iamVjdCx0cmVlDQoJb2JqZWN0Pj4gdG9nZXRoZXIgd2l0aCB0aGUg
ZGVwZW5kZW50IGJsb2IgYW5kIDw8cmVmX3RyZWUsdHJlZT4+IG9iamVjdHMN
CgkoaS5lLiBhIHN0b3JlZCByZXByZXNlbnRhdGlvbiBvZiBhIDw8cmVmX3dv
cmtpbmdfdHJlZSx3b3JraW5nIHRyZWU+PikuIA0KDQpbW3JlZl90cmVlX29i
amVjdF1ddHJlZSBvYmplY3Q6Og0KCUFuIDw8cmVmX29iamVjdCxvYmplY3Q+
PiBjb250YWluaW5nIGEgbGlzdCBvZiBibG9iIGFuZC9vcg0KCTw8cmVmX3Ry
ZWUsdHJlZT4+IG9iamVjdHMuIChBIDw8cmVmX3RyZWUsdHJlZT4+IHVzdWFs
bHkgY29ycmVzcG9uZHMgdG8gYQ0KCTw8cmVmX2RpcmVjdG9yeSxkaXJlY3Rv
cnk+PiB3aXRob3V0IHN1YmRpcmVjdG9yaWVzKS4gDQoNCltbcmVmX3RyZWUt
aXNoXV10cmVlLWlzaDo6DQoJQSA8PHJlZl9yZWYscmVmPj4gcG9pbnRpbmcg
dG8gZWl0aGVyIGEgPDxyZWZfY29tbWl0X29iamVjdCxjb21taXQNCglvYmpl
Y3Q+PiwgYSA8PHJlZl90cmVlX29iamVjdCx0cmVlIG9iamVjdD4+LCBvciBh
IDw8cmVmX3RhZ19vYmplY3QsdGFnDQoJb2JqZWN0Pj4gcG9pbnRpbmcgdG8g
YSA8PHJlZl9jb21taXQsY29tbWl0Pj4gb3IgPDxyZWZfdHJlZV9vYmplY3Qs
dHJlZQ0KCW9iamVjdD4+LiANCg0KW1tyZWZfd29ya2luZ190cmVlXV13b3Jr
aW5nIHRyZWU6Og0KCVRoZSBzZXQgb2YgZmlsZXMgYW5kIGRpcmVjdG9yaWVz
IGN1cnJlbnRseSBiZWluZyB3b3JrZWQgb24uIFRoaW5rICJscw0KCS1sYVIi
IA0KDQo=

---1463794688-618415668-1124290608=:13502--
