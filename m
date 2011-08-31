From: Ryan Wexler <ryan@iridiumsuite.com>
Subject: Re: need to create new repository initially seeded with several branches
Date: Wed, 31 Aug 2011 09:10:01 -0700
Message-ID: <CAKjsY4nsPNO_kvxeime8qcNrRFykgG2TOYxJ0HKbj2zR5Rwv+Q@mail.gmail.com>
References: <1314804325568-6746957.post@n2.nabble.com>
	<201108311540.p7VFen5S015756@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: in-git-vger@baka.org
X-From: git-owner@vger.kernel.org Wed Aug 31 18:10:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QynMt-0006op-Kn
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 18:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab1HaQKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Aug 2011 12:10:04 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54083 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755787Ab1HaQKD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2011 12:10:03 -0400
Received: by wwf5 with SMTP id 5so931969wwf.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 09:10:01 -0700 (PDT)
Received: by 10.216.154.75 with SMTP id g53mr572736wek.50.1314807001753; Wed,
 31 Aug 2011 09:10:01 -0700 (PDT)
Received: by 10.216.53.77 with HTTP; Wed, 31 Aug 2011 09:10:01 -0700 (PDT)
In-Reply-To: <201108311540.p7VFen5S015756@no.baka.org>
X-Google-Sender-Auth: bJVswYzcJeC53i20lNNASKKcw1c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180476>

On Wed, Aug 31, 2011 at 8:40 AM,  <in-git-vger@baka.org> wrote:
>
> In message <1314804325568-6746957.post@n2.nabble.com>, "ryan@iridiums=
uite.com" writes:
>
> =A0 =A0I would like to turn this into a git repository. =A0One branch=
 being master,
> =A0 =A0the second develop and finally a third branch that is extended=
 off the
> =A0 =A0develop branch.
>
> I will assume in my instructions that develop is "extended" off of ma=
ster.
>
> ---------------------------------------------------------------------=
-
> cd /path/to/new/master
> # Make this a git repo
> git init
> # Add all files to git
> git add .
> # Commit all files to git
> git commit -m "initial master version"
> # Make new develop branch
> git checkout -b develop
> # Cause git to delete all files in the internal index
> git read-tree --reset -i 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> # Cause git to delete all files in the working directory
> git clean -dfx
> # Copy all files from the develop directory
> cp -r /path/to/new/develop .
> # Add all files to git (and delete them too)
> git add -A .
> # Commit
> git commit -m "Initial develop branch"
> # Make new extended branch
> git checkout -b extended
> # Cause git to delete all files in the internal index
> git read-tree --reset -i 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> # Cause git to delete all files in the working directory
> git clean -dfx
> # Copy all files from the extended directory
> cp -r /path/to/new/extended .
> # Add all files to git (and delete them too)
> git add -A .
> # Commit
> git commit -m "Initial develop branch"
> ---------------------------------------------------------------------=
-
>
> The only "magic" is the read-tree/git-clean stuff. =A0The 4b82=85 val=
ue is
> the SHA of an empty tree. =A0It could be replaced by a:
>
> find . -maxdepth 1 ! -name '.git' -a ! -name '..' -a ! -name '.' -pri=
nt0 | xargs -0 rm -rf
>
> But that is 9 extra characters.
>
> Untested, but it should work.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0-Seth Robertson
>

Seth-
Thanks for the extensive reply.  I am excited that this is even possibl=
e.

I have to say that I am lost by the "magic" you describe.  I don't
understand what you mean by the 4b82... value should be replaced by
the find | xargs remove all command.   That command looks like it just
deletes all the "." file names?  But when you say replace I thought
you would mean I need to generate a new value to replace that magic
number??  Confused...
