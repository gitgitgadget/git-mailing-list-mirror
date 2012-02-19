From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2] Document format of basic Git objects
Date: Sun, 19 Feb 2012 00:39:41 -0800
Message-ID: <7vlinzp67m.fsf@alter.siamese.dyndns.org>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
 <1329624946-32173-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 19 09:40:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rz2Jm-0000ln-MD
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 09:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab2BSIjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Feb 2012 03:39:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51130 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab2BSIjp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2012 03:39:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B541A626C;
	Sun, 19 Feb 2012 03:39:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wJXJtJUJjrWM
	JncgL+g+T4HBusM=; b=XsXtCFN8IoOO/IR5rUdiujwy4FNy5jXNDfAcb8vKpi1A
	xEdTh4d5AtT9RbdnsDzupmRqmJpXhmeUwxFEXyHh4PmZWLOleeMbFYcj0Cc+PU3b
	0UFcg9HWtq/+F1OSWZ60cM0wCRDUzwOPJy43iIymKrrLXImgni6TJZNtfHFh+Y4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DzSgm1
	RAgm5J0FGKi8DPX4dfqd/5Uw8BLPo4xDaHfKsRysQyeRpu0b/awn+TAD60tDMB6X
	5nbzz70byUvnTLLQd6mGx0UI6G9zhWjDJom2G1njohcy4M3bbotSqg7d8t8wL96U
	1MKx9vzYOmKCO3l5fngoJKva1IPKhm52j4Fzo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC509626B;
	Sun, 19 Feb 2012 03:39:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3672626A; Sun, 19 Feb 2012
 03:39:42 -0500 (EST)
In-Reply-To: <1329624946-32173-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 19 Feb
 2012 11:15:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44CFA06A-5AD5-11E1-8BA5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191020>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Still draft for discussion. Of three people who participated on this
> thread, two favor a man page (me and Jonathan), one technical/
> (Junio), so let's put it as a man page for now.

Personally I do not have strong preference either way.

The original motivation of technical/ was that we wanted to have a plac=
e
to keep documentation that would help ourselves, the people who write t=
he
internals of git, even though we did not yet know and did not want to h=
ave
to decide if it is a good idea to expose the end users, who may not car=
e
about the gory details of the internal, with reams of such documents.

>  - Not sure if we fix the order of gpgsig and mergetag, or they can b=
e
>    mixed together. Also not sure if we can have multiple gpgsig.

You can merge a signed tag and then sign the resulting commit yourself,
and the order of the mixing would not matter. Technically a gpgsig is a
signature over the commit object payload without gpgsig lines, so you
could have two or more gpgsigs on the same commit object but from a lar=
ger
workflow point of view it would not be so useful, as it would involve
steps like this:

 * You prepare a commit object, you may perhaps sign it yourself;

 * You expose this commit object to chosen others from whom you want th=
eir
   signature on it;

 * They sign it with "commit -S --amend", but when they do so they make
   sure the resulting commit has the same committer/author header as th=
e
   original.  Note that the resulting commits will all have different
   object name, as the object name is over all payload including their
   gpgsigs.

 * You grab the gpgsig lines from these commits, paste them into the
   header part of the original, and then re-hash the result with
   "hash-object -w -t commit".  The result will have all valid gpgsigs
   over the payload in the commit without its gpgsig lines, because the
   gpgsig lines from all the signers were generated that way.

 * Then you give the general public the resulting commit.

>  - I skipped the experimental loose object format (it's what it's
>    called in sha1_file.c). I think we can call it deprecated and move
>    on.

Good.

>  - Do we assume tag/commit header in utf-8 or ascii?

Author-ident is typically utf-8 already, so you cannot assume "ASCII".


> +Object SHA-1
> +~~~~~~~~~~~~
> +An object SHA-1 is calculated on its header and payload. The content
> +to be consumed by SHA-1 calculation is:
> +
> +- Object type in ascii, either "commit", "tree", "tag" or "blob"
> +  (without quotes)
> +- One space (ASCII SP)
> +- The payload length in ascii canonical decimal format

"canonical" may make it sound as if the document is more formal, but th=
en
you would have to define what is canonical and what is not somewhere el=
se,
so I would suggest dropping it.

	The length of the payload in bytes, represented as a decimal integer.

Also if you spell ASCII, consistently spell it in all-caps.       =20

> +- ASCII NUL
> +- Object payload

----------------------------------------------------------------

> +BLOB OBJECTS
> +------------
> +Blob object payload is file data.

What's the significance of saying "file data" here?  In a document that
describes the structure, saying "is uninterpreted sequence of bytes" is
more accurate (the important point is that git does not care what it is=
)
and covers cases where blob was recorded with "hash-object -w --stdin"
where no such "file data" has ever existed in a 'file". Also a blob may
record contents of a symbolic link ;-).

> +TREE OBJECTS
> +------------
> +Tree object payload contains a list of entries, each with a mode,
> +object type, object name, and filename, sorted by filename. It
> +represents the contents of a single directory tree.

Drop "object type," from this list.  It is inferred from the mode.  I
personally would prefer to say "path" or "pathname" when the entity
referred to may not be a regular file.  I am not sure the last sentence=
 is
necessary, but if you must say something, say "It represents a
directory". It is by definition redundant to say that a tree represents=
 a
"tree".  Replace the above with something line this:

	... entries, each with a mode, object name and path. The type of
	the object is encoded in the "mode":

        - 100644 or 100755: the object is a "blob" that records the
          contents of a regular non-executable or executable file,
          respectively, that exists at the path.

	- 120000: the object is a "blob" that records the contents of a
          symbolic link that exists at the path.

	- 40000: the object is a "tree" that represents a subdirectory
          that exists at the path.

	- 160000: the object is a "commit" that records the state of a
          submodule that exists at the path.

> +The object type may be a blob, representing the contents of a file,
> +another tree, representing the contents of a subdirectory, or a comm=
it
> +(representing a subproject).

and drop the above line.

> +Since trees and blobs, like all other
> +objects, are named by a hash of their contents, two trees have the
> +same object name if and only if their contents (including,
> +recursively, the contents of all subdirectories) are identical. This
> +allows git to quickly determine the differences between two related
> +tree objects, since it can ignore any entries with identical object
> +names.

It does not make sense to say 'trees and blobs' when you explain that a
single top-level tree object defines the entire tree's state.  Just say
'trees'.  I know you would say "I wanted to say if tree A and tree B ar=
e
the same except for the content of a single blob recorded at path P, th=
e
result of hash for A and B would be different", but the same can be sai=
d
for a submodule, so singling out 'blob' is incomplete.  Also these tree=
s
may record the same set of blobs but tree B may record what tree A had =
at
path P at path Q, so it is not like the only thing that matter in the t=
ree
is the object names.

I personally do not think it is necessary to have the above paragraph a=
t
all in this object.

> +Note that the files all have mode 644 or 755: git actually only pays
> +attention to the executable bit.

Saying 644 or 755 here is misleading as it does not match any reality
(except for very early incarnation of git).  By rewriting the first
paragraph, these two lines can be safely eliminated.

> +Encoding
> +~~~~~~~~

"Encoding" is such a loaded word and does not help clarify what this
section is really about, which is "format of a tree entry", or simply
"Entries".

> +Entries are of variable length and self-delimiting. Each entry
> +consists of
> +
> +- a POSIX file mode in octal ascii representation, no 0 padding to t=
he
> +  left

This is not "a POSIX file mode" at all.  The mode in a tree entry was
modelled after that, but there is no need to mention it, especially
because POSIX does not define the exact bit assignment for types (the
permission are defined from S_IXOTH to S_IRWXU and S_ISUID/S_ISGID with
exact bit locations) and because of S_IFGITLINK which is clearly not
POSIX.  As we have enumerated them in the first paragraph,

	The "mode" (see above).

is sufficient here.

> +- exactly one space (ASCII SP)
> +- filename for the entry, as a NUL-terminated string

Again, "pathname" or just "path" for this entire document.

> +- 20-byte binary object name
> +
> +The mode should be 100755 (executable file), 100644 (regular file),
> +120000 (symlink), 40000 (subdirectory), or 160000 (subproject), with
> +no leading zeroes. Modes with one leading zero and the synonym 10066=
4
> +for 100644 are also accepted for historical reasons. Other modes are
> +not accepted.

This is made redundant by the first paragraph above.

> +The filename may be an arbitrary nonempty string of bytes, as long a=
s
> +it contains no '/' or NUL character.

s/, as long as it contains no/; it cannot contain any/

> +The associated object must be a valid blob if the mode indicates a
> +file or symlink, tree if it indicates a subdirectory, or commit if i=
t
> +indicates a subproject. The blob associated to a symlink entry
> +indicates the link target and its content not have any embedded NULs=
=2E

I doubt that we should even mention "and its content not have ...".  It=
 is
for readlink(2) and symlink(2) to decide.

> +Sorting
> +~~~~~~~
> +Entries are sorted by memcmp(3) on file name. No duplicate file name=
s
> +allowed.

A sentence without a verb seen at the end of this paragraph.


> +COMMIT OBJECT
> +-------------
> +The commit object links a physical state of a tree with a descriptio=
n
> +of how we got there and why.

What is the intended audience and the purpose of this document?  If thi=
s
were to strictly define and describe the "structure", then "and why" is
inappropriate.  It is merely the best-current-practice at the human lev=
el
to describe the "why" in their commit log messages---it does not break =
the
structure if nobody explains "why".

On the other hand, "how we got there" is a good phrase to explain that =
by
refering to its immediate parents, all the previous histories are also
described.

> +... Commit object payload contains the
> +associated tree SHA-1, parent commits's SHA-1, author and comitter
> +information.

s/.$/, among other things./; as the log message is also part of the
payload.

Start by labeling what the large block of example you are going to thro=
w
at the reader here.

> +------------------------------------------------
> +$ git cat-file commit 81d48f0aee54
> +tree 093f37084c133795e4ce71befa57185328737171
> +parent f5e4e20faa1eee3feaa0394897bbd1aca544e809
> +parent 661db794eb8179c7bea02f159bb691a2fff4a8e0
> +parent 14c173eb63432ba5d0783b6c4b23a8fe0c76fb0f
> +author Linus Torvalds <torvalds@linux-foundation.org> 1326576355 -08=
00
> +committer Linus Torvalds <torvalds@linux-foundation.org> 1326576355 =
-0800
> +mergetag object 661db794eb8179c7bea02f159bb691a2fff4a8e0
> + type commit
> + tag devicetree-for-linus
> + tagger Grant Likely <grant.likely@secretlab.ca> 1326520038 -0700
> +=20
> + 2nd set of device tree changes for v3.3
> + -----BEGIN PGP SIGNATURE-----
> + Version: GnuPG v1.4.11 (GNU/Linux)
> +=20
> + iQIcBAABAgAGBQJPERbzAAoJEEFnBt12D9kBmDIP/R9Vspc6yhjSAEvdp/VET2gi
> + TgAQfdp4VuYjjIt4cUPO5UQU9kw478GjTuP2blZEC9DlG1jSf/L8U+A7FHJIVVzU

Elide the above like so:

        -----BEGIN PGP SIGNATURE-----
        Version: GnuPG v1.4.11 (GNU/Linux)

        iQIcBAABAgAGBQJPERbzAAoJEEFnBt12D9kBmDIP/R9Vspc6yhjSAEvdp/VET2g=
i
        TgAQfdp4VuYjjIt4cUPO5UQU9kw478GjTuP2blZEC9DlG1jSf/L8U+A7FHJIVVz=
U
	...
        =3Dmup8
        -----END PGP SIGNATURE-----

> +Merge tags 'devicetree-for-linus' and 'spi-for-linus' of git://git.s=
ecretlab.ca/git/linux-2.6
> +
> +2nd set of device tree changes and SPI bug fixes for v3.3
> +
> +* tag 'devicetree-for-linus' of git://git.secretlab.ca/git/linux-2.6=
:
> +  of/irq: Add interrupts-names property to name an irq resource
> +  of/address: Add reg-names property to name an iomem resource
> +
> +* tag 'spi-for-linus' of git://git.secretlab.ca/git/linux-2.6:
> +  spi/tegra: depend instead of select TEGRA_SYSTEM_DMA
> +------------------------------------------------
> +
> +More precisely, a commit object begins with of one or more lines
> +delimited by ASCII LF. The end of the header is signalled by an empt=
y
> +line. Any remaining text after the empty line forms the commit

Drop "More precisely, ".  Also notice that you abruptly said "end of th=
e
header" without mentioning anything about "header" in the previous
sentence.

	A commit object begins with the "header" part, that consists of
	one or more lines delimited by LF, and the "body" part, that
	records the commit log message.  The first empty line delimits the
	header and the body.

> +The header must not contain NUL.

I vaguely recall that you made sure neither the header nor the body
contains NUL.

> +A "continuation line" in the header begins with an SP. The remainder
> +of the line, after removing that SP, is concatenated to the previous
> +line, while retaining the LF at the end of the previous line.
> +
> +When a line in the header begins with a letter other than SP, and ha=
s
> +at least one SP in it, it is called a "field". A field consists of t=
he
> +"field name", which is the string before the first SP on the line, a=
nd
> +its "value", which is everything after that SP. When the value
> +consists of multiple lines, continuation lines are used.
> +
> +More than one field with the same name can appear in the header of a=
n
> +object, and the order in which they appear is significant. A commit
> +object can contain these fields in the listed order:

s/can contain/contains/; as you are marking optional ones with "zero or=
".

> +1. one "tree" field with the 40-character textual object name of the
> +   associated tree object
> +2. zero or more "parent" fields, each with 40-character textual obje=
ct
> +   name of the parent commit object
> +3. one "author" field with an ident string
> +4. one "committer" field with an ident string
> +5. zero or one "encoding" field with an ascii string

s/zero or one/optionally, one/ (not a strong preference--I just felt th=
at
would be easier to read).

	After the above fields, other fields may follow, and new types of
	fields may be added in later versions of git.  Example of these
	optional fields are:

	- "mergetag" that copies the contents of a signed tag on one of
          the parent commit;
        - "gpgsig" that records a GPG signature for this commit object.

> +6. zero or more "mergetag" fields with associated tag object content
> +7. zero or one "gpgsig" field with gpg signature content

and exclude these two from the numbering above to make it clear they ar=
e
optional.

> +Ident strings
> +~~~~~~~~~~~~~
> +Ident strings record who's responsible of doing something at what
> +time. For a commit, the ident string in "author" line records who is
> +the author of the associated changes and when the changes are

s/are/were/, perhaps?  Again, what the purpose of this document?  If th=
is
were more than to strictly describe the "structure", it is OK and even
preferable to leave the meaning the "author" as vague, but if this were
also to suggest the best current practice interpretation, it may be wor=
th
to add something like

	There may be a case where it is difficult to attribute a commit to
        a single author; think of it as recording the primary contact, =
the
        person to ask any questions about the commit if needed later.

> +made. The ident string in "committer" line records who commits the

s/commits/committed/, perhaps?

> +changes to the repository and at what time.
> +
> +An ident string consists of an email address and a timestamp. More
> +precisely:

s/of an email/of a name, an email/;
s/. More precisely:/:/;

> +1. Optionally, a name
> +2. An email address wrapped around by `<` and `>`, followed by one
> +   space (ASCII SP)

The above makes it sound as if "A U Thor<author@example.xz>" is usual a=
nd
valid.  How about=20

	1. A name, followed by one ASCII SP

and after this enumeration, say something like:

	Name may be missing in commit objects produced by repository
	conversion from other SCMs that do not have it.  Name and email
	are typically encoded in UTF-8.

even though I am not sure the last sentence should be in this document.

> +3. The number of seconds since Epoch (00:00:00 UTC, January 1, 1970)
> +   followed by a space (ASCII SP)
> +4. Timezone: either plus or minus sign, followed by 4 decimal digits
> +
> +Name and email are encoded in UTF-8 and must must not contain ASCII
> +NUL characters.

Drop " and must must ...characters"; you already said that the header d=
oes
not have any NUL.  As I already said, I am not sure if you should menti=
on
"UTF-8" at all in this document.

> +Commit encoding
> +~~~~~~~~~~~~~~~
> +Encoding field describes that encoding that the commit message is
> +encoded in.

s/that encoding that/the character encoding in which/;
s/encoded in/recorded/;

> +... Encoding names must be recognized by iconv(3). By default,
> +commit message is in UTF-8. It's discouraged to use encodings that c=
an
> +generate ASCII NUL characters.

Here we would probably want to have a paragraph each for "mergetag" and
"gpgsig".

> +TAG OBJECTS
> +-----------
> +Tag object payload contains an object, object type, tag name, the na=
me
> +of the person ("tagger") who created the tag, and a message, which m=
ay
> +contain a signature.

s/a signature/a signature at the end/;

> +------------------------------------------------
> +$ git cat-file tag v1.5.0
> +object 437b1b20df4b356c9342dac8d38849f24ef44f27
> +type commit
> +tag v1.5.0
> +tagger Junio C Hamano <junkio@cox.net> 1171411200 +0000
> +
> +GIT 1.5.0
> +-----BEGIN PGP SIGNATURE-----
> +Version: GnuPG v1.4.6 (GNU/Linux)
> +
> +iD8DBQBF0lGqwMbZpPMRm5oRAuRiAJ9ohBLd7s2kqjkKlq1qqC57SbnmzQCdG4ui
> +nLE/L9aUXdWeTFPron96DLA=3D
> +=3D2E+0
> +-----END PGP SIGNATURE-----
> +------------------------------------------------
> +
> +Tag object format resembles commit format. A tag commit may have the
> +following fields in listed order:
> +
> +1. one "object" field with 40-character textual object name of the
> +   tagged object
> +2. one "type" field with type of the tagged object ("commit", "tag",
> +   "blob", or "tree")
> +3. one "tag" field with the name of the tag
> +4. one "tagger" with an ident string
> +
> +New kinds of fields may be added in later versions of git.
> +
> +Any remaining text after the header forms the tag message. Tag messa=
ge
> +has no specified encoding. Anything that does not contain ASCII NUL
> +characters are accepted.
> +
> +The object field must point to a valid object of type indicated by t=
he
> +type field. The tag name can be an arbitrary string without NUL byte=
s
> +or embedded newlines; in practice it usually follows the restriction=
s
> +described in linkgit:git-check-ref-format[1].

A description of how the signature part is formed needs to come here.

> +GIT
> +---
> +Part of the linkgit:git[1] suite
