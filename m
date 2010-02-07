From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sun, 7 Feb 2010 02:20:35 +0100
Message-ID: <201002070220.36897.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <201002062314.00631.jnareb@gmail.com> <cb7bb73a1002061458s5b2c1e7ere83111429473d11c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 02:21:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndvpf-0004AY-41
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 02:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226Ab0BGBU5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 20:20:57 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:34524 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756204Ab0BGBU4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 20:20:56 -0500
Received: by fxm3 with SMTP id 3so5854975fxm.39
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 17:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rAxrUeP44d9kp/wgdvavYK0LfeLmYWHFrrF2liA5txM=;
        b=eWdrKQdd0vMEJDDTEgKROBG+2EwcqsNwvgQsAEEfg9sKQXwPjvpuSwAUIzdQe8/X8x
         7Cptu9FHJhcPk0S6qNZvPODxjGgIThXXVtAeEmIGo+lWgVl/9bxk06IylNzpJ2rbbBP8
         DKLW5P1UsFcl5GKleHoef181a2EZOdzkrKDVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cQtNvK2a6Ac+9WTOyEZjizl3PvtG6OH4dtnJHUw9yiif34O7/gYZOdacNLFbd2q4s0
         fP4t9LMTcxSmpTvZWpxHqOFjU0HoOFGThxW2mMlXPyoRoCHuUPaqUjTchx+g6s2OX5fW
         GO2w/RpGn7gZJFaSKiK7w8MqsePpSGetLy7yE=
Received: by 10.223.2.216 with SMTP id 24mr2242926fak.72.1265505654919;
        Sat, 06 Feb 2010 17:20:54 -0800 (PST)
Received: from ?192.168.1.13? (abws80.neoplus.adsl.tpnet.pl [83.8.242.80])
        by mx.google.com with ESMTPS id 19sm4504749fkr.48.2010.02.06.17.20.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 17:20:54 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a1002061458s5b2c1e7ere83111429473d11c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139206>

On Sat, 6 Feb 2010, Giuseppe Bilotta wrote:
> On Sat, Feb 6, 2010 at 11:14 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>> On Sat, 6 Feb 2010, Giuseppe Bilotta wrote:
>>> 2010/2/6 Jakub Narebski <jnareb@gmail.com>:
>>>> On Thu, 4 Feb 2010, Giuseppe Bilotta wrote:
>>
>>>>> + =A0 =A0 # Notes support. When this feature is enabled, the pres=
ence of notes
>>>>> + =A0 =A0 # for any commit is signaled, and the note content is m=
ade available
>>>>> + =A0 =A0 # in a way appropriate for the current view.
>>>>> + =A0 =A0 # Set this to '*' to enable all notes namespace, or to =
a shell-glob
>>>>> + =A0 =A0 # specification to enable specific namespaces only.
>>>>
>>>> It is not obvious from this description that you can provide _list=
_ of
>>>> notes namespaces (or list of shell-globs).
>>>
>>> I'm starting to think it might make sense to not have a list here, =
but
>>> rather a single value only. First of all, multiple refs can be
>>> indicated =E0 la shell with {ref1,ref2,ref3}. Or, we can also use t=
he
>>> intended command-line syntax ref1:ref2:ref3, which would help
>>> consistency. It also makes things easier for project overrides, as =
per
>>> your subsequent comment:
>>
>> So it is to be single shell-glob / fnmatch (I think) compatible patt=
ern,
>> isn't it?
>=20
> Sort of. fnmatch doesn't do brace expansion, which is a pity IMO, but
> that's just my personal preference.

Well, fnmatch is what I think git uses for <pattern> e.g. for=20
git-for-each-ref.

> Colon-separated, fnmatched components is probably the easiest thing t=
o
> implement to have multiple refs. I'll go with whatever is chosen for
> core.=20

I think that having actual list of patterns in $feature{'notes'}{'defau=
lt'}
might be more clear; you would still need colon separated (or space
separated) list of patterns in per-repo override in gitweb.notes config
variable.

So it would be

  $feature{'notes'}{'default'} =3D ['commits', '*svn*'];
  $feature{'notes'}{'override'} =3D 1;

but

  [gitweb]
  	notes =3D commits:*svn*
=20
Note that refs names cannot contain either colon ':' or space ' '
(see git-check-ref-format).

>>>> First, there are '--batch' and '--batch-check' options to git-cat-=
file.
>>>> With these I think you can get all notes with just single git comm=
and,
>>>> although using it is a bit complicated (requires open2 from IPC::O=
pen2
>>>> for bidi communication).
>>>
>>> Hm. The IPC::Open2 doc makes it sound horribly scary, but still doa=
ble.
>>
>> It would look something like the following (fragment of my WIP code)=
:
>>
>> =A0 =A0 =A0 =A0use IPC::Open2 qw(open2);
>> =A0 =A0 =A0 =A0use IO::Handle;
>>
>> =A0 =A0 =A0 =A0# ...
>>
>> =A0 =A0 =A0 =A0unless ($object_stdout) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# Open bidi pipe the first time get_o=
bject is called.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# open2 raises an exception on error,=
 no need to 'or die'.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$object_pid =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0open2($object_stdout,=
 $object_stdin,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git_cmd()=
, 'cat-file', '--batch');
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0$object_stdin->printflush("$object_id\n") # NB: \n re=
quired to avoid deadlocking
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0or die "get_object: cannot write to p=
ipe: $!";
>> =A0 =A0 =A0 =A0my ($sha1, $type, $size) =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0split ' ', $object_stdout->getline()
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0or die "get_object: cannot read from =
pipe: $!";
>> =A0 =A0 =A0 =A0die "'$object_id' not found in repository"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if $type eq 'missing';
>> =A0 =A0 =A0 =A0$object_stdout->read(my $content, $size);
>> =A0 =A0 =A0 =A0$object_stdout->getline(); =A0# eat trailing newline
>>
>> The above fragment of code is tested that it works. =A0You would pro=
bably
>> need to replace dies with something less fatal...
>=20
> On the other hand, as mentioned by Junio, this approach is not
> future-proof enough for any kind of fan-out schemes.

On the third hand ;-P you propose below a trick to deal with fan-out
schemes, assuming that they use 2-character component breaking.

Also, perhaps "git notes show" should acquire --batch / --batch-check
options, similar to git-cat-file's options of the same name?

>=20
>>>> Second, if not using 'git cat-file --batch', perhaps it would be e=
asier
>>>> to read each $note_ref tree using 'git ls-tree'/'git ls-tree -r', =
and
>>>> parse its output to check for which commits/objects there are note=
s
>>>> available, and only then call 'git show' (or reuse connection to
>>>> 'git cat-file --batch').
>>>>
>>>> The second solution, with a bit more work, could work even in pres=
ence
>>>> of fan-out schemes for notes, I think.
>>>
>>> An interesting approach. Without fan-out, git ls-tree -r
>>> refs/notes/whatever [hash ...] gives us the blobs we're interested =
in.
>>> In case of fan-out schemes, the efficiency of this approach probabl=
y
>>> depends on the kind of fan-out we have, and would require some
>>> heavy-duty grepping. A git ls-notes plumbing with a similar syntax =
and
>>> output would be a nice thing to have.
>>
>> No grepping, just pass '-r' option to 'git-ls-tree', and use
>> parse_ls_tree_line() to parse lines. =A0Then if we have fanout schem=
e
>> we would get, I guess, something like the following:
>>
>> =A0100644 blob 23da787d... =A0 =A0 =A0 de/adbeef...
>> =A0100644 blob bc10f25f... =A0 =A0 =A0 c5/31d986...
>> =A0100644 blob c9656ece... =A0 =A0 =A0 24/d93129...
>>
>> Now you only need to s!/!!g on filename to get SHA1 of annotated obj=
ect
>> (for which is the note).
>=20
> What worries me is that you're going to get fan-outs when there are
> LOTS of notes, and that's precisely the kind of situation where you
> _don't_ want to go through all the notes to pick the ones you're only
> interested in.

Right.  This method would be contrary to the goals of fan-out schemes..=
=2E
well, we could use 'git ls-tree' without '-r' option, or simply=20
'git cat-file --batch' to read trees (note that we would get raw,=20
unformatted tree, which is parseable with Perl, but it is not that easy=
),
and go down level-by-level.

>=20
> If we have a guarantee that the fan-outs follow a 2/[2/...] scheme,
> the open2 approach might still be the best way to go, by just trying
> not only namespace:xxxxx...xxx but also namespace:xx/xxxxx etc.
> Horrible, but could still be coalesced in a single call. It mgiht als=
o
> be optimized to stop at the first successfull hit in a namespace.

Nice trick!  It seems like quite a good idea... but it would absolutely
require using 'git cat-file --batch' rather than one git-show per try.

>> P.S. We still would want parse_commit_text to parse notes from defau=
lt
>> namespace. =A0parse_commit / parse_commits output contains notes fro=
m
>> default namespace, e.g.:
>>
>> =A0d6bbe7fd52058cdf0e48bec00701ae0f4861dcd3 94ac0c7b30a7dc43d926b0ff=
be90892c1e19e5f6
>> =A0tree b9ee8876df81b80b13c6b017be993fff8427cfaf
>> =A0parent 94ac0c7b30a7dc43d926b0ffbe90892c1e19e5f6
>> =A0author Jakub Narebski <jnareb@gmail.com> 1265309578 +0100
>> =A0committer Jakub Narebski <jnareb@gmail.com> 1265309578 +0100
>>
>> =A0 =A0 =A0This is a commit message
>>
>> =A0 =A0 =A0Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>>
>> =A0Notes:
>> =A0 =A0 =A0This is just a note for commit d6bbe7fd52058cdf0e48bec007=
01ae0f4861dcd3
>>
>> to get commit message lines in $co{'comment'} (as array reference),
>> and notes in $co{'note'} (or $co{'notes'}).
>=20
> I'm not getting these in the repo I'm testing this. And I think this
> is indeed the behavior of current git next

Errr, I not made myself clear. =20

I have added a note to a commit, using "git notes edit d6bbe7f".  Now i=
f
you take a look at gitweb output for this commit (e.g. 'commit' view fo=
r
this commit) using gitweb without your changes, you would see that it
flattened notes at the bottom of the commit message (which I think is
intended result by notes implementation).

If you run the command that parse_commit runs, namely

  $ git rev-list --parents --header -z --max-count=3D1 \
    d6bbe7fd52058cdf0e48bec00701ae0f4861dcd3

you would get (up to invisible NUL characters) the output shown above.
=46rom this output I would like to separate commit message from notes
in parse_commit_text subroutine.

I have set neither GIT_NOTES_REF nor core.notesRef.

--=20
Jakub Narebski
Poland
