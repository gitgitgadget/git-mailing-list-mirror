From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Document rev^! and rev^@ as revision specifiers
Date: Mon, 23 Jul 2012 12:27:54 -0700
Message-ID: <7vliial1l1.fsf@alter.siamese.dyndns.org>
References: <7vpq8aqdzb.fsf@alter.siamese.dyndns.org>
 <1341532890-13829-1-git-send-email-max@quendi.de>
 <1341532890-13829-2-git-send-email-max@quendi.de>
 <7vtxxlnyn1.fsf@alter.siamese.dyndns.org>
 <D8DF0AED-91D3-45C0-B49E-97E07D21350C@quendi.de>
 <7vliiwog0a.fsf@alter.siamese.dyndns.org>
 <05708C97-7925-4E45-BA16-374FB38F54D1@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 21:28:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StOIa-0006KE-Bj
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 21:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab2GWT2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 15:28:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698Ab2GWT15 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 15:27:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F98161E0;
	Mon, 23 Jul 2012 15:27:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g6rHafUe8Rfw8NbQzHZBVEdaCQM=; b=crCnm2
	X1Ch7TmSRxBsn5L0Z3JCQFdWdCY7RFj0EqkqA2ryEJAbYZKdx1LjbGmifFfpnQ79
	Ikp52SkXmhM4Nffv8Pa75odleVa4CPtkBj20ChBeDLED5guGcUGbFonmfVFIOLae
	59yhqNsRpxQy05fNEEO/TEKgmRwvaC2pBewK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xHUiV7hqKiL+2q5ip/UqL8ka14E6sVaF
	seLiacik50rr22R7Xudj7K8no6Rmoh/+040Iw0h9XTt/Xdg7jYJfrJBQtENirLuX
	0h5QhsTSEUiaor7VKO4f1bmoW9EldC0m3svIVR2mgVNzsS5pBEwm9Cvh0em6jtps
	u06Hq5ahfsQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DC5461DF;
	Mon, 23 Jul 2012 15:27:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B958061DD; Mon, 23 Jul 2012
 15:27:55 -0400 (EDT)
In-Reply-To: <05708C97-7925-4E45-BA16-374FB38F54D1@quendi.de> (Max Horn's
 message of "Mon, 9 Jul 2012 17:02:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80ECA24A-D4FC-11E1-AC31-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201965>

Max Horn <max@quendi.de> writes:

>> 
> On 06.07.2012, at 21:18, Junio C Hamano wrote:
>
>> Max Horn <max@quendi.de> writes:
>> 
>>>>> +'<rev>{caret}!', e.g. 'HEAD{caret}!'::
>>>>> +  A suffix '{caret}' followed by an exclamation mark
>>>>> +  means commit '<rev>' but forces all of its parents to be excluded. For
>>>>> +  commands that deal with a single revision, this is the same as '<rev>".
>>>> 
>>>> Is this sentence correct?  "git commit -C 'HEAD^!'" might be a
>>>> command that expects a single revision, but I do not think it is the
>>>> same as "git commit -C HEAD".
>>> 
>>> Ignoring the exact words I used for the moment, what I meant is
>>> that these two commands should be functionally
>>> equivalent. Aren't they?
>> 
>> No.  When a single commit is wanted HEAD^! shouldn't be used, and
>> they cannot be functionally equivalent.  I haven't tried but I think
>> "commit -C HEAD^!"  would give you a syntax error.
>
> Indeed, it says
>  fatal: could not lookup commit HEAD^!
>
> I'll iterate over this once more.

Let's do this instead.

-- >8 --
Subject: Enumerate revision range specifiers in the documentation

It was a bit hard to learn how <rev>^@, <rev>^! and various other
forms of range specification are used, because they were discussed
mostly in the prose part of the documentation, unlike various forms
of extended SHA-1 expressions that are listed in enumerated list.

Also add a few more examples showing use of <rev>, <rev>..<rev> and
<rev>^! forms, stolen from a patch by Max Horn.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/revisions.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index f4f6f28..6506ec6 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -218,13 +218,44 @@ and its parent commits exist.  The 'r1{caret}@' notation means all
 parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
 all of its parents.
 
+To summarize:
+
+'<rev>'::
+	Include commits that are reachable from (i.e. ancestors of)
+	<rev>.
+
+'{caret}<rev>'::
+	Exclude commits that are reachable from (i.e. ancestors of)
+	<rev>.
+
+'<rev1>..<rev2>'::
+	Include commits that are reachable from <rev2> but exclude
+	those that are reachable from <rev1>.
+
+'<rev1>...<rev2>'::
+	Include commits that are reachable from either <rev1> or
+	<rev2> but exclude those that are reachable from both.
+
+'<rev>{caret}@', e.g. 'HEAD{caret}@'::
+  A suffix '{caret}' followed by an at sign is the same as listing
+  all parents of '<rev>' (meaning, include anything reachable from
+  its parents, but not the commit itself).
+
+'<rev>{caret}!', e.g. 'HEAD{caret}!'::
+  A suffix '{caret}' followed by an exclamation mark is the same
+  as giving commit '<rev>' and then all its parents prefixed with
+  '{caret}' to exclude them (and their ancestors).
+
 Here are a handful of examples:
 
    D                G H D
    D F              G H I J D F
    ^G D             H D
    ^D B             E I J F B
+   B..C             C
    B...C            G H D E B C
    ^D B C           E I J F B C
+   C                I J F C
    C^@              I J F
+   C^!              C
    F^! D            G H D F
