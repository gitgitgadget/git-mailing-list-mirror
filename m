From: Marco Costalba <mcostalba@gmail.com>
Subject: Fwd: [RFC] Common library for Git GUIs
Date: Tue, 17 Feb 2009 08:40:05 +0100
Message-ID: <e5bfff550902162340i1970eeb6ofcf8ce4ee7a35874@mail.gmail.com>
References: <20090216212459.GA25046@efreet.light.src>
	 <e5bfff550902162337m43156398kb06320796838c953@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 08:41:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZKaL-0000F0-98
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 08:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbZBQHkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 02:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbZBQHkI
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 02:40:08 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:59202 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbZBQHkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 02:40:07 -0500
Received: by bwz5 with SMTP id 5so3718336bwz.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 23:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=hMz2I8VD6IzoBzR357HgMbeS5pkx2xA5glwogYmBX2U=;
        b=vidDIPxwBeSiYvn/MzSSefYFgysMSEh+moyE4ZktbFDsKmFrDCHunJNkWwJ4vbRYsG
         KTiYR56A/ZBR6wMPtBHCHJAG1CCqOHlMAh7gvphEixayJlcx3c7VGQXpxuuPidDtlEek
         QQg6u2xjObf44+z/6lLU84OaQe1lZYGiDccB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=df6ZSWIO2JDcMtE8cXpu2XiHqOjgixOB+yGZ25jXZsvlCM04f7nGN6apR082WYavrQ
         O3gfnp4P2Z91QVtntkipzGf1hAMEY29775y4VGAoKVYPRL+kn6YoV9KHNEnJ7S9wNhFe
         jauFm/g0cpEDZbuHb0vTSuGlHyJecA45tFYHM=
Received: by 10.181.206.7 with SMTP id i7mr1058236bkq.126.1234856405085; Mon, 
	16 Feb 2009 23:40:05 -0800 (PST)
In-Reply-To: <e5bfff550902162337m43156398kb06320796838c953@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110322>

On Mon, Feb 16, 2009 at 22:24, Jan Hudec <bulb@ucw.cz> wrote:
>
> Hello Folks,


Hi Jan,

   nice to hear you again.


>
> Looking at the current situation with Git GUIs, I thought it might be useful
> to create a generic library that would make it easier to develop git guis
> (especially plugins to various tools) and to add a new features to many of
> them with less effort. What do you people think about such idea?

 I fail to see the reason to do it given that git GUIs are already
quite mature and stable tools, feature addition at this stage is only
very limited and for only small things. Big features are already in
from a long time, as example (I speak about QGit but the same applies
to the others):

>
>    - Tree of all files in the work area with their status
>      Seeing status (unchanged/modified/staged/new/...) of individual files
>      in Visual Studio is the most wanted features of my colleagues at $work.
>      The feature is applicable for Windows shell extension (Tortoise Git),
>      similar KDE and Gnome extensions and all IDE bindings.


Already in. Modified files are bolded.

What qgit misses is new files (but this could be easily added if
needed because alre already known to qgit) and staged files (but I
dont understund the useful of this info).

>
>    - Tree of files in given revision
>      For browsing other revisions than the checked out one.

Already in.

>
>    - History *tree*
>      Starting gitk as separate process is suboptimal, because versions from
>      the tree can't be easily selected for operations (checkout, merge, ...).

Already in.

>
>    - Blob data
>      For looking at other revisions than the checked out one.

Already in.

>
>    - Commit properties
>      For showing details of revisions in the history view.

Already in.

>
>    - Diffs
>      Obviously...

Already in.  Obviously :-)

>
>    - Annotations
>      Again, should be integrated with the rest of gui, so selecting line in
>      annotation can open the revision in diff view, select it in history
>      etc.

Already in.

>
>    - Configuration
>      Many tools (eg. gui designers) feature a tree view of all properties of
>      some object (property grid) with editable values and short
>      descriptions. It's not as nice gui designed for individual options, but
>      can provide good-enough easy-to-write way to set all valid options from
>      the gui.


To what should this feature apply? Some examples please?


>
>  - Menu and action definitions for the common operations

Already in. Plus customizable actions/macros.


>
>
>  So what do you people think would be best? I see several options:
>
>  - QtCore
>
>   Qt seems to be the most popular library among Git GUI writers and since
>   version 4.5 will be LGPL, so it will be allowed to link with anything.
>   It is also probably the most portable one. On the downside, it's rather
>   large and it's language bindings are a bit worse (the garbage collector
>   integration was a bit bad last time I looked).


I never felt the need for a garbage collector at all. I strongly
prefer to spend time to manually fix the (very few) memory leaks that
slept in. Qt class model already does object housekeeping for you at
deterministic and well known times (when parent object is deleted so
are all corresponding children).


Thanks
Marco
