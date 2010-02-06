From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sat, 6 Feb 2010 23:58:54 +0100
Message-ID: <cb7bb73a1002061458s5b2c1e7ere83111429473d11c@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<201002060044.11225.jnareb@gmail.com> <cb7bb73a1002060102n5544f825x3d01860b1228cee@mail.gmail.com> 
	<201002062314.00631.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 23:59:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdtcZ-0008Gt-Tc
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 23:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933066Ab0BFW7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 17:59:19 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:40593 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933061Ab0BFW7R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 17:59:17 -0500
Received: by ewy28 with SMTP id 28so1295468ewy.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jZw707E6C+fE40PPFdN8z6aZgAElEHq0dR+1dhPUUxU=;
        b=J4rHoc+iDz9lCIU53I/WuWh3LBCE9YFKBYfX1lUt2Zmvw65w5SK9H5XW/ShH3VwFwZ
         z8Qtu94BQCVUxeTlyn5GyenMJr1Z9TZYfdoLDQrZPmRd2TnRSvdiHPAWr/oI6qdx+ItF
         rg3OX7WvlzUWPIr5AExR07+gmJOOlIJH61+6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FV61QOkcqd5Ke6SS1gnhF5NqTQI87myML3S4Y6EHmNCFN6h1c76jfGdNXw8hbZEvQi
         Yu6OfCUsPVpPv8vPE5R3SKOWK31S7IjOPgl3X4bjOImdwEUKsnqOJma5RgFOYFof8/+e
         y4QIF1o+kfWDA4asOk1W5M/WLHOczggBNiih8=
Received: by 10.213.71.143 with SMTP id h15mr2322195ebj.31.1265497154070; Sat, 
	06 Feb 2010 14:59:14 -0800 (PST)
In-Reply-To: <201002062314.00631.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139199>

On Sat, Feb 6, 2010 at 11:14 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Sat, 6 Feb 2010, Giuseppe Bilotta wrote:
>> 2010/2/6 Jakub Narebski <jnareb@gmail.com>:
>>> On Thu, 4 Feb 2010, Giuseppe Bilotta wrote:
>
>>>> + =A0 =A0 # Notes support. When this feature is enabled, the prese=
nce of notes
>>>> + =A0 =A0 # for any commit is signaled, and the note content is ma=
de available
>>>> + =A0 =A0 # in a way appropriate for the current view.
>>>> + =A0 =A0 # Set this to '*' to enable all notes namespace, or to a=
 shell-glob
>>>> + =A0 =A0 # specification to enable specific namespaces only.
>>>
>>> It is not obvious from this description that you can provide _list_=
 of
>>> notes namespaces (or list of shell-globs).
>>
>> I'm starting to think it might make sense to not have a list here, b=
ut
>> rather a single value only. First of all, multiple refs can be
>> indicated =E0 la shell with {ref1,ref2,ref3}. Or, we can also use th=
e
>> intended command-line syntax ref1:ref2:ref3, which would help
>> consistency. It also makes things easier for project overrides, as p=
er
>> your subsequent comment:
>
> So it is to be single shell-glob / fnmatch (I think) compatible patte=
rn,
> isn't it?

Sort of. fnmatch doesn't do brace expansion, which is a pity IMO, but
that's just my personal preference. Colon-separated, fnmatched
components is probably the easiest thing to implement to have multiple
refs. I'll go with whatever is chosen for core.

>>> First, there are '--batch' and '--batch-check' options to git-cat-f=
ile.
>>> With these I think you can get all notes with just single git comma=
nd,
>>> although using it is a bit complicated (requires open2 from IPC::Op=
en2
>>> for bidi communication).
>>
>> Hm. The IPC::Open2 doc makes it sound horribly scary, but still doab=
le.
>
> It would look something like the following (fragment of my WIP code):
>
> =A0 =A0 =A0 =A0use IPC::Open2 qw(open2);
> =A0 =A0 =A0 =A0use IO::Handle;
>
> =A0 =A0 =A0 =A0# ...
>
> =A0 =A0 =A0 =A0unless ($object_stdout) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# Open bidi pipe the first time get_ob=
ject is called.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# open2 raises an exception on error, =
no need to 'or die'.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$object_pid =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0open2($object_stdout, =
$object_stdin,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git_cmd(),=
 'cat-file', '--batch');
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0$object_stdin->printflush("$object_id\n") # NB: \n req=
uired to avoid deadlocking
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0or die "get_object: cannot write to pi=
pe: $!";
> =A0 =A0 =A0 =A0my ($sha1, $type, $size) =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0split ' ', $object_stdout->getline()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0or die "get_object: cannot read from p=
ipe: $!";
> =A0 =A0 =A0 =A0die "'$object_id' not found in repository"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if $type eq 'missing';
> =A0 =A0 =A0 =A0$object_stdout->read(my $content, $size);
> =A0 =A0 =A0 =A0$object_stdout->getline(); =A0# eat trailing newline
>
> The above fragment of code is tested that it works. =A0You would prob=
ably
> need to replace dies with something less fatal...

On the other hand, as mentioned by Junio, this approach is not
future-proof enough for any kind of fan-out schemes.

>>> Second, if not using 'git cat-file --batch', perhaps it would be ea=
sier
>>> to read each $note_ref tree using 'git ls-tree'/'git ls-tree -r', a=
nd
>>> parse its output to check for which commits/objects there are notes
>>> available, and only then call 'git show' (or reuse connection to
>>> 'git cat-file --batch').
>>>
>>> The second solution, with a bit more work, could work even in prese=
nce
>>> of fan-out schemes for notes, I think.
>>
>> An interesting approach. Without fan-out, git ls-tree -r
>> refs/notes/whatever [hash ...] gives us the blobs we're interested i=
n.
>> In case of fan-out schemes, the efficiency of this approach probably
>> depends on the kind of fan-out we have, and would require some
>> heavy-duty grepping. A git ls-notes plumbing with a similar syntax a=
nd
>> output would be a nice thing to have.
>
> No grepping, just pass '-r' option to 'git-ls-tree', and use
> parse_ls_tree_line() to parse lines. =A0Then if we have fanout scheme
> we would get, I guess, something like the following:
>
> =A0100644 blob 23da787d... =A0 =A0 =A0 de/adbeef...
> =A0100644 blob bc10f25f... =A0 =A0 =A0 c5/31d986...
> =A0100644 blob c9656ece... =A0 =A0 =A0 24/d93129...
>
> Now you only need to s!/!!g on filename to get SHA1 of annotated obje=
ct
> (for which is the note).

What worries me is that you're going to get fan-outs when there are
LOTS of notes, and that's precisely the kind of situation where you
_don't_ want to go through all the notes to pick the ones you're only
interested in.

If we have a guarantee that the fan-outs follow a 2/[2/...] scheme,
the open2 approach might still be the best way to go, by just trying
not only namespace:xxxxx...xxx but also namespace:xx/xxxxx etc.
Horrible, but could still be coalesced in a single call. It mgiht also
be optimized to stop at the first successfull hit in a namespace.

> P.S. We still would want parse_commit_text to parse notes from defaul=
t
> namespace. =A0parse_commit / parse_commits output contains notes from
> default namespace, e.g.:
>
> =A0d6bbe7fd52058cdf0e48bec00701ae0f4861dcd3 94ac0c7b30a7dc43d926b0ffb=
e90892c1e19e5f6
> =A0tree b9ee8876df81b80b13c6b017be993fff8427cfaf
> =A0parent 94ac0c7b30a7dc43d926b0ffbe90892c1e19e5f6
> =A0author Jakub Narebski <jnareb@gmail.com> 1265309578 +0100
> =A0committer Jakub Narebski <jnareb@gmail.com> 1265309578 +0100
>
> =A0 =A0 =A0This is a commit message
>
> =A0 =A0 =A0Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>
> =A0Notes:
> =A0 =A0 =A0This is just a note for commit d6bbe7fd52058cdf0e48bec0070=
1ae0f4861dcd3
>
> to get commit message lines in $co{'comment'} (as array reference),
> and notes in $co{'note'} (or $co{'notes'}).

I'm not getting these in the repo I'm testing this. And I think this
is indeed the behavior of current git next

--=20
Giuseppe "Oblomov" Bilotta
