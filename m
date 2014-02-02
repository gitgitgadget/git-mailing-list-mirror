From: David Kastrup <dak@gnu.org>
Subject: Re: Creating own hierarchies under $GITDIR/refs ?
Date: Sun, 02 Feb 2014 12:19:43 +0100
Message-ID: <8761ox2240.fsf@fencepost.gnu.org>
References: <87a9e92424.fsf@fencepost.gnu.org>
	<CACsJy8CdKRQ_au3QqVoUdedvPpkPh_2vodKJwLZ7VrrwRJSDXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 02 12:19:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9v5b-0004Wx-Hr
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 12:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbaBBLTq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 06:19:46 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:56852 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbaBBLTo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Feb 2014 06:19:44 -0500
Received: from localhost ([127.0.0.1]:55894 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W9v5T-00029M-Tn; Sun, 02 Feb 2014 06:19:44 -0500
Received: by lola (Postfix, from userid 1000)
	id 790CBDF68C; Sun,  2 Feb 2014 12:19:43 +0100 (CET)
In-Reply-To: <CACsJy8CdKRQ_au3QqVoUdedvPpkPh_2vodKJwLZ7VrrwRJSDXQ@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 2 Feb 2014 18:00:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241360>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Feb 2, 2014 at 5:37 PM, David Kastrup <dak@gnu.org> wrote:
>> in the context of an ongoing discussion on the Emacs developer list =
of
>> converting the Bzr repository of Emacs, one question (with different
>> approaches) is where to put the information regarding preexisting Ba=
zaar
>> revision numbers and bug tracker ids: those are not present in the
>> current Git mirror.
>>
>> Putting them in the commit messages would require a full history
>> rewrite, and if some are missed in the process, this cannot be fixed
>> afterwards.
>
> What do you need them for?

Resolving references typically found in commit messages.  Also
establishing correlation to bug issue numbers.

> Perhaps putting everything in a file, maybe sorted by SHA-1, would
> suffice? It should not be too hard to write a script to map bug
> tracker id to a commit id.

We are not talking about "it should not be too hard".  We are talking
about "obvious and reliable enough to render a complete history rewrite
pointless".

> The file is for past commits only.

> New commits can contain these info in their messages.

If it's not forgotten.  Experience shows that things like issue numbers
have a tendency to be omitted, and then they stay missing.

At any rate, this is exactly the kind of stuff that tags are useful for=
,
except that using them for all that would render the "tag space"
overcrowded.

Rest assured that the "standard" answers have been beat to death in the
Emacs developer list thread several times over.

So I'm more interested in getting actual answers dealing with the
question I=A0have asked rather than suggestions for questions that woul=
d
be easier to answer.

Since Git has a working facility for references that is catered to do
exactly this kind of mapping and already _does_, it seems like a
convenient path to explore.

It apparently even already works with --decorate:

commit c92b1fb3ad8514f08fc4cec531211717955a5c29 (tag: release/2.19.1-1,=
 origin/release/unstable, tag: refs/bzr/r15000)
Author: Phil Holmes <mail@philholmes.net>
Date:   Sun Jan 19 15:01:48 2014 +0000

    Release: update news.

--=20
David Kastrup
