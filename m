From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sat, 6 Feb 2010 10:02:21 +0100
Message-ID: <cb7bb73a1002060102n5544f825x3d01860b1228cee@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1265300338-25021-2-git-send-email-giuseppe.bilotta@gmail.com> 
	<201002060044.11225.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 10:02:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdgZ3-0007YW-OM
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 10:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059Ab0BFJCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 04:02:44 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:2551 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab0BFJCm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 04:02:42 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1006925eyd.19
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 01:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=MdNMP9iU7LtJ6driH+FHiPL7gP97pFNULV+h8o9EFf4=;
        b=rridiGNXDg567xXkipmp4QPB9kd6sRAygLS5BqQDDR1Xzk3aj9npKXPUpIL4v1SRvs
         xHBtCB34+qVzoW29Uqe++nlbqEqPwY/dx0YAL6fLiGRAOxY9ujBv+2doXyyB5Ag8FfwB
         WxvIJ62JOi8CH4sCpDmUuP8PYkntxCMkdXhWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wodxjR3JH6dD3s6Lu1YsHIT6e8VrFsd03VzJnwHo0z3Q9dupUSanajVs+5ColtlP6w
         kPOAp/kQ1e/1Okl1hhIHwBVl8Sk0XC7i8OtGOaMT+5jSkQa2fHn2AoAcRgu60tXUbuSq
         qgDUB8djQN+IC0cQ1GnWbEt+LWpBOc9Qn6mlw=
Received: by 10.213.48.2 with SMTP id p2mr1580223ebf.60.1265446961116; Sat, 06 
	Feb 2010 01:02:41 -0800 (PST)
In-Reply-To: <201002060044.11225.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139151>

2010/2/6 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 4 Feb 2010, Giuseppe Bilotta wrote:
>
> BTW. shouldn't this series be marked as RFC?
>

[snip]

>
> Signoff?

Y'know, one would figure that, this not being my first contribution
and what, I'd have learned to do this properly 8-/.

>> + =A0 =A0 # Notes support. When this feature is enabled, the presenc=
e of notes
>> + =A0 =A0 # for any commit is signaled, and the note content is made=
 available
>> + =A0 =A0 # in a way appropriate for the current view.
>> + =A0 =A0 # Set this to '*' to enable all notes namespace, or to a s=
hell-glob
>> + =A0 =A0 # specification to enable specific namespaces only.
>
> It is not obvious from this description that you can provide _list_ o=
f
> notes namespaces (or list of shell-globs).

I'm starting to think it might make sense to not have a list here, but
rather a single value only. First of all, multiple refs can be
indicated =E0 la shell with {ref1,ref2,ref3}. Or, we can also use the
intended command-line syntax ref1:ref2:ref3, which would help
consistency. It also makes things easier for project overrides, as per
your subsequent comment:

>> +
>> + =A0 =A0 # To enable system wide have in $GITWEB_CONFIG
>> + =A0 =A0 # $feature{'notes'}{'default'} =3D ['*'];
>> + =A0 =A0 # To have project specific config enable override in $GITW=
EB_CONFIG
>> + =A0 =A0 # $feature{'notes'}{'override'} =3D 1;
>> + =A0 =A0 # and in project config gitweb.notes =3D namespace;
>
> How you can provide list of notes here? =A0Is overriding limited to s=
ingle
> name or shell-glob?
>
> See feature_snapshot for example implementation.

As mentioned above, I'd rather use the same syntax deployed on the
command line, either shell-like or PATH-like multiple paths.

> Second, perhaps it is time to refactor all those similar feature_xxx
> subroutines (just a possible suggestion)?

feature_notes looks remarkably like feature_avatar, indeed.

>> +# return all refs matching refs/notes/<globspecs> where the globspe=
cs
>> +# are taken from the notes feature content.
>> +sub get_note_refs {
>> + =A0 =A0 my @globs =3D gitweb_get_feature('notes');
>> + =A0 =A0 my @note_refs =3D ();
>> + =A0 =A0 foreach my $glob (@globs) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (open my $fd, '-|', git_cmd(), 'for-eac=
h-ref',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 '--format=3D%(refname)', "refs/not=
es/$glob") {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0open my $fd, '-|', git_cmd(), 'for-eac=
h-ref',
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'--format=3D%(refname)=
', "refs/notes/$glob"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0or return;
>
> would reduce indent level a bit.

Good idea, thanks.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (<$fd>) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chomp;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 push @note=
_refs, $_ if $_;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Why not simply
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chomp(@note_refs =3D <$fd>);

Because I didn't know chomp worked on lists. Thanks for the idea.

>> + =A0 =A0 =A0 =A0 =A0 =A0 my %notes =3D () ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 foreach my $note_ref (@note_refs) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $obj =3D "$note_ref:$co=
{'id'}";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (open my $fd, '-|', git=
_cmd(), 'rev-parse',
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 '--verify'=
, '-q', $obj) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $exists=
 =3D <$fd>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 close $fd;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (define=
d $exists) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 if (open $fd, '-|', git_cmd(), 'show', $obj) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 $notes{$note_ref} =3D scalar <$fd>;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 close $fd;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> First, there are '--batch' and '--batch-check' options to git-cat-fil=
e.
> With these I think you can get all notes with just single git command=
,
> although using it is a bit complicated (requires open2 from IPC::Open=
2
> for bidi communication).

Hm. The IPC::Open2 doc makes it sound horribly scary, but still doable.

> Second, if not using 'git cat-file --batch', perhaps it would be easi=
er
> to read each $note_ref tree using 'git ls-tree'/'git ls-tree -r', and
> parse its output to check for which commits/objects there are notes
> available, and only then call 'git show' (or reuse connection to
> 'git cat-file --batch').
>
> The second solution, with a bit more work, could work even in presenc=
e
> of fan-out schemes for notes, I think.

An interesting approach. Without fan-out, git ls-tree -r
refs/notes/whatever [hash ...] gives us the blobs we're interested in.
In case of fan-out schemes, the efficiency of this approach probably
depends on the kind of fan-out we have, and would require some
heavy-duty grepping. A git ls-notes plumbing with a similar syntax and
output would be a nice thing to have.

--=20
Giuseppe "Oblomov" Bilotta
