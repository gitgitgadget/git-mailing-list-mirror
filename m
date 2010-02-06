From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sat, 6 Feb 2010 23:14:00 +0100
Message-ID: <201002062314.00631.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <201002060044.11225.jnareb@gmail.com> <cb7bb73a1002060102n5544f825x3d01860b1228cee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 23:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndsuw-0004hV-0g
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 23:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996Ab0BFWOK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 17:14:10 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:58975 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349Ab0BFWOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 17:14:08 -0500
Received: by fxm3 with SMTP id 3so5728270fxm.39
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 14:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=k4MMjfQWEMqPX2/BybvJmfgIfOVav2ombdqwYgoYUXI=;
        b=aQWOS9Px8jPOwrzDvM3PynkEsMIoQ3cfdw/elts9EwrP79FBs/c6ikiJfPWG/PjQk1
         yfCbUfNwPzirZhPzn3eMCbBGolwrf3a/09uRbSbF5lu4wEEMpKfnXOowBGhupyU/n5Vc
         9/eH59t4wllIEof7hGMCpZcAPbt4BalPPgQZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BPoQTU/9HjmN5vlIh5RV3XNqkr9BccEAo6hKkK3zQPYCDGqmCDVbS1KNLfHu2do2pY
         kTbK1ITqkpW11chSM//Qf7KsYgMGDMziIelYXjBLFpBOksSEC1fSaKqnnQcFwxJ8Vqjd
         ljwTwEbb0UyVvNPTc/twKpN0Xft8h2cjZYZoA=
Received: by 10.87.68.19 with SMTP id v19mr3869963fgk.2.1265494446686;
        Sat, 06 Feb 2010 14:14:06 -0800 (PST)
Received: from ?192.168.1.13? (abws80.neoplus.adsl.tpnet.pl [83.8.242.80])
        by mx.google.com with ESMTPS id l19sm1832102fgb.15.2010.02.06.14.14.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 14:14:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a1002060102n5544f825x3d01860b1228cee@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139196>

On Sat, 6 Feb 2010, Giuseppe Bilotta wrote:
> 2010/2/6 Jakub Narebski <jnareb@gmail.com>:
>> On Thu, 4 Feb 2010, Giuseppe Bilotta wrote:

>>> + =A0 =A0 # Notes support. When this feature is enabled, the presen=
ce of notes
>>> + =A0 =A0 # for any commit is signaled, and the note content is mad=
e available
>>> + =A0 =A0 # in a way appropriate for the current view.
>>> + =A0 =A0 # Set this to '*' to enable all notes namespace, or to a =
shell-glob
>>> + =A0 =A0 # specification to enable specific namespaces only.
>>
>> It is not obvious from this description that you can provide _list_ =
of
>> notes namespaces (or list of shell-globs).
>=20
> I'm starting to think it might make sense to not have a list here, bu=
t
> rather a single value only. First of all, multiple refs can be
> indicated =E0 la shell with {ref1,ref2,ref3}. Or, we can also use the
> intended command-line syntax ref1:ref2:ref3, which would help
> consistency. It also makes things easier for project overrides, as pe=
r
> your subsequent comment:

So it is to be single shell-glob / fnmatch (I think) compatible pattern=
,
isn't it?
=20
[...]
>>> + =A0 =A0 =A0 =A0 =A0 =A0 my %notes =3D () ;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 foreach my $note_ref (@note_refs) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $obj =3D "$note_ref:$c=
o{'id'}";
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (open my $fd, '-|', gi=
t_cmd(), 'rev-parse',
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 '--verify=
', '-q', $obj) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $exist=
s =3D <$fd>;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 close $fd=
;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defin=
ed $exists) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 if (open $fd, '-|', git_cmd(), 'show', $obj) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 $notes{$note_ref} =3D scalar <$fd>;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 close $fd;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> First, there are '--batch' and '--batch-check' options to git-cat-fi=
le.
>> With these I think you can get all notes with just single git comman=
d,
>> although using it is a bit complicated (requires open2 from IPC::Ope=
n2
>> for bidi communication).
>=20
> Hm. The IPC::Open2 doc makes it sound horribly scary, but still doabl=
e.

It would look something like the following (fragment of my WIP code):

	use IPC::Open2 qw(open2);
	use IO::Handle;

	# ...

	unless ($object_stdout) {
		# Open bidi pipe the first time get_object is called.
		# open2 raises an exception on error, no need to 'or die'.
		$object_pid =3D
			open2($object_stdout, $object_stdin,
			      git_cmd(), 'cat-file', '--batch');
	}
	$object_stdin->printflush("$object_id\n") # NB: \n required to avoid d=
eadlocking
		or die "get_object: cannot write to pipe: $!";
	my ($sha1, $type, $size) =3D
		split ' ', $object_stdout->getline()
		or die "get_object: cannot read from pipe: $!";
	die "'$object_id' not found in repository"
		if $type eq 'missing';
	$object_stdout->read(my $content, $size);
	$object_stdout->getline();  # eat trailing newline
=20
The above fragment of code is tested that it works.  You would probably
need to replace dies with something less fatal...

>> Second, if not using 'git cat-file --batch', perhaps it would be eas=
ier
>> to read each $note_ref tree using 'git ls-tree'/'git ls-tree -r', an=
d
>> parse its output to check for which commits/objects there are notes
>> available, and only then call 'git show' (or reuse connection to
>> 'git cat-file --batch').
>>
>> The second solution, with a bit more work, could work even in presen=
ce
>> of fan-out schemes for notes, I think.
>=20
> An interesting approach. Without fan-out, git ls-tree -r
> refs/notes/whatever [hash ...] gives us the blobs we're interested in=
=2E
> In case of fan-out schemes, the efficiency of this approach probably
> depends on the kind of fan-out we have, and would require some
> heavy-duty grepping. A git ls-notes plumbing with a similar syntax an=
d
> output would be a nice thing to have.

No grepping, just pass '-r' option to 'git-ls-tree', and use
parse_ls_tree_line() to parse lines.  Then if we have fanout scheme
we would get, I guess, something like the following:

  100644 blob 23da787d...	de/adbeef...
  100644 blob bc10f25f...	c5/31d986...
  100644 blob c9656ece...	24/d93129...

Now you only need to s!/!!g on filename to get SHA1 of annotated object
(for which is the note).

The identifier of note itself would be either id from tree (e.g. 23da78=
7d...
for note from first line), or note namespace composed with note "pathna=
me",
(e.g. refs/notes/commits:de/adbeef... for note from first line).

Even if you use one git-show per note, it would need only git commands
to discover object to note mapping.


P.S. We still would want parse_commit_text to parse notes from default
namespace.  parse_commit / parse_commits output contains notes from
default namespace, e.g.:

  d6bbe7fd52058cdf0e48bec00701ae0f4861dcd3 94ac0c7b30a7dc43d926b0ffbe90=
892c1e19e5f6
  tree b9ee8876df81b80b13c6b017be993fff8427cfaf
  parent 94ac0c7b30a7dc43d926b0ffbe90892c1e19e5f6
  author Jakub Narebski <jnareb@gmail.com> 1265309578 +0100
  committer Jakub Narebski <jnareb@gmail.com> 1265309578 +0100

      This is a commit message
     =20
      Signed-off-by: Jakub Narebski <jnareb@gmail.com>
 =20
  Notes:
      This is just a note for commit d6bbe7fd52058cdf0e48bec00701ae0f48=
61dcd3

to get commit message lines in $co{'comment'} (as array reference),
and notes in $co{'note'} (or $co{'notes'}).

--=20
Jakub Narebski
Poland
