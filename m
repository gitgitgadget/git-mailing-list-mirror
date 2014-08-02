From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: cherry picking and merge
Date: Sat, 2 Aug 2014 11:39:08 +0100
Organization: OPDS
Message-ID: <FAC83E31AC1645EB83068122320F35AE@PhilipOakley>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com> <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net> <4EA0D79811C348C6893039D315E6E190@PhilipOakley> <FC00A4BB-6CB9-421D-83D6-4E1AFBB4CB3C@comcast.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	<git@vger.kernel.org>
To: "Mike Stump" <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Sat Aug 02 12:39:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDWic-0007d9-0I
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 12:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbaHBKjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Aug 2014 06:39:10 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:28503 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751863AbaHBKjI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Aug 2014 06:39:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao0fAGm+3FMCYJjrPGdsb2JhbABagw1jAUWHL4EEyysBAgEBDHgXBQEBAQE4NoN+BQEBBQgBAR0LAQUeAQEhCwIDBQIBAxUBAgklFAEEGgYHAxQGEwgCAQIDAYgdAxW2H4kvCIcrjmkaSTWDAYEcBZFcolY8L4EFAR4G
X-IPAS-Result: Ao0fAGm+3FMCYJjrPGdsb2JhbABagw1jAUWHL4EEyysBAgEBDHgXBQEBAQE4NoN+BQEBBQgBAR0LAQUeAQEhCwIDBQIBAxUBAgklFAEEGgYHAxQGEwgCAQIDAYgdAxW2H4kvCIcrjmkaSTWDAYEcBZFcolY8L4EFAR4G
X-IronPort-AV: E=Sophos;i="5.01,786,1400022000"; 
   d="scan'208";a="563179218"
Received: from host-2-96-152-235.as13285.net (HELO PhilipOakley) ([2.96.152.235])
  by out1.ip05ir2.opaltelecom.net with SMTP; 02 Aug 2014 11:39:06 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254694>

=46rom: "Mike Stump" <mikestump@comcast.net>
Sent: Friday, August 01, 2014 11:10 PM
> On Aug 1, 2014, at 11:57 AM, Philip Oakley <philipoakley@iee.org>=20
> wrote:
>> But that goes both ways, and is a philosophical issue about what is=20
>> to be expected in various cases.
>
> The problem is, users expect merge to merge.  There isn=92t a user th=
at=20
> expects it to scramble the source code, because the command is called=
=20
> merge, not scramble.

Unfortunately we are back at the problem af what 'merge' means. Git use=
s=20
a snapshot model, while most other version control systems uses a=20
changeset model (which has been used since before the Titanic was built=
=20
for various reasons [1]) for their storage. Thus most VCS users see=20
merge as the addition of a delta "A + delta -> B", while Git sees merge=
=20
as the union of snapshots "A + G -> Q".

The cherry-pick and rebase methods determine the change deltas between=20
adjacent snaphots (i.e. patches) and then apply that to a different=20
snapshot. In those cases we are not merging snapshots, rather applying=20
patches (note my changed use of 'merge').

>That word has semantics that were not invented by your project.  You=20
>cannot change the semantic of the word.  Merge has a nice mathematical=
=20
>definition.  Merge branch into master means, place into into master th=
e=20
>work from that branch.  git already does this 99% correct, it is=20
>missing one corner case.
>
> This is not a philosophical issue.  It is a definitional one.
>
>> For some central control use styles, the ideas behind _distributed_=20
>> version control are anathema and (Git) just grinds away at the=20
>> policies that are expected.
>
> This is irrelevant to the issue at hand.
>
>> That said, Git doesn't claim to be perfect
>
> Again, irrelevant.
>
>> (and can't because
>
> Do you mean, and can=92t be?  If so, you are wrong in the case at han=
d.=20
> svn is an existence proof that you are wrong.
>
>> of the 'relativity' that comes with being distributed - truth has to=
=20
>> give way to a web of trust). Also the artefacts that Git validates=20
>> are at a different level of abstraction i.e. the whole project as a=20
>> commit, rather than just a few/one file at a time.
>
<snipped remainder because of time limitations>

--
Philip

[1] Way back when blueprints really were blue, and real drawing were on=
=20
kaolin & linen drawing sheets with indian ink, the 'master' drawings=20
were the most prized items, that if damaged would stop production, so=20
there were many layers of drawing office controls to avoid touching it=20
(e.g. tracers to copy drawings) and keep the master drawings pristine.

=46rom that, the ideas of Change requests, Change orders, Approved chan=
ges=20
etc. became the norm. It was the changes that were recorded. These=20
processes are still in place today in most engineering companies and th=
e=20
military, in fact anyone with real artefacts. These techniques were=20
copied into the computing world when it was young.

The big change has been that Computing has reduced the cost of=20
production (duplication, replication) to zero, so now the problem is in=
=20
trying to validate and verify which alledged copy is actually the=20
'master' - especially in a fully distributed environment, such as the=20
many different Linux distributions and applications. It was into this=20
gap that Git steps, with the use of the sha1 to both validate the=20
history chain and verify any specific snapshot. It doesn't get hung up=20
on what the change was, that can be determined easily after the fact by=
=20
a simple diff between adjacent snapshots, though having lots of small=20
changes and crisp commit messages does help.

That's the way I view it anyway. (When I first started work, they still=
=20
had blue prints, but had moved to microfiche and melinex (polyester)=20
drawing sheets, and the 8088 / IBM PC was new and powerful! I still wor=
k=20
in engineering where the old VC model is ubiquitous)
