From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: How to Import a bitkeeper repo into git - Had a few questions on Qgit; I like the GUI.
Date: Wed, 17 Oct 2007 09:30:48 +0200
Message-ID: <e5bfff550710170030y7778e96ax146acea7a0e57a67@mail.gmail.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>
	 <20070709173720.GS29994@genesis.frugalware.org>
	 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>
	 <4713FA4A.5090501@bluelane.com>
	 <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
	 <471433F3.40606@bluelane.com>
	 <e5bfff550710152156t33ba10dam6171e3210c18d3ac@mail.gmail.com>
	 <47159779.6010502@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	"free cycle" <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, "Piet Delaney" <pdelaney@bluelane.com>
To: pete@bluelane.com, piet.delaney@gmail.piet.net
X-From: git-owner@vger.kernel.org Wed Oct 17 09:31:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii3Mv-0008DG-JA
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 09:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763540AbXJQHav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 03:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763053AbXJQHav
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 03:30:51 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:13068 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761875AbXJQHat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 03:30:49 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1667415rvb
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=DJo+H5xBDDsedcFvP+Tu8NSFr4HpfwWLsSAq+B1f+Vk=;
        b=BEjyh1Ycq3TH/s+ERMrTghp8qEy32rfzNffELeiHCa7rD2VtCjU9iWDKmQCaI38AS0b7t4ACcyA5vizQ0lUlYppMvZgDdM33B5prwgfP/NqmJGfzxaHYrOHRA1lyLjQu7o7DxsViCC1khk5vtpj/dERtfP3KWt08pntPTo7SihM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dsZwc0QTWgepXHxVu+01suNsiAz4uXe6QzAGFjqu0hPEHRrGsWmY71OyW9UvzV0f3TlJ5ugGa4Od3chhXS3Ghr+hND20QwUvPZljwXY1yccdSjcE4Io1aRBrYywUOoErHzk215yu6JpAbDuBRqr1sZhs574WSdaYW0pxpIrHuBQ=
Received: by 10.141.78.14 with SMTP id f14mr4000298rvl.1192606248300;
        Wed, 17 Oct 2007 00:30:48 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Wed, 17 Oct 2007 00:30:48 -0700 (PDT)
In-Reply-To: <47159779.6010502@bluelane.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61346>

On 10/17/07, Pete/Piet Delaney <pete@bluelane.com> wrote:
>
> While I'm looking at the diffs for a file if I pull down External Diff
> it launches 'kcompare' but for a file with a large change it seems
> to be running extremely slow.

qgit does not intergarte Kompare functionality, it just prepares the
files and spawns a Kompare process.

So there's seem nothing qgit can do about Kompare speed. You can try
with different diff viewers, meld,...etc..


> for small files. Know of what can me done so that 'kcompare' works
> fast on large files; something like pointing it's tmp files to a
> not NFS partition.
>

Well temporary file sfor Kompare are created in the repository working
directory. If this is a problem for you you can save manually the
files corresponding to the two revisions you want to diff (open tree
view, select the file, right click to open context menu, save as...)

You need to repeat the above 'save as...' the first time selecting the
first revision you want to compare, then selecting the other revision
in main view, so that tree view is updated and you end-up saving the
correct files.

You can save the files where you want then run Kompare manually, at
least you test your assumption about slowness of NFS partition.

>
> Another problem I've noticed is that sometime while running git
> it seems to spend a large amount of time  switching from one
> change-set to the next; seems to be due to all of the tagged
> files.
>

If you can post a repository where this occurs and the step to
reproduce I can investigate further.

> > Another feature you asked, i.e. CTRL + right click to select a
> > revision (different from the parent) to diff against the current one
> > is also already implemented.
>
> It seems that while I'm in "Rev List" mode I can select the the
> two versions to compare a selected file with View->External diff...
>
> Now, if I pull down "View File" or go to the file context were
> you see the change-set for a file then I can't get the CTRL + right
> click to allow me to diff two revisions of the file.
>


Yes. This is true, is not supported this feature. Maybe could be added ;-)


>
> MY guess is that I should install a newer version of qgit,
> I'm using 1.5.3.
>

Please install 1.5.7, it has several bugs fixed.

> How difficult is it to upgrade to the Qt4. Can I just
> install it to /usr/local and not interfere with Qt3?

It does not interfere wuth Qt3 also if you install with urpmi,
directories are kept separated. I have installed both with no
problems.

> Last I recall messing with installing ethereal from src
> I needed a graphics lib and as I recall installing it in
> /usr/local/ confused some build crap. It would be interesting
> to try out your new qgit-2.0.
>

Qt4 is big and complex, I would really suggest avoid experimenting
with that library, stay safe and use urpmi.

> >
> > And of course the two above features can be integrated: you select two
> > random revisions and then call the external diff viewer to check at
> > the differences in the way you prefer.
>
> Right, but how do I do this from the file context?
>

In this case (and also in the above case of external viewer) you need
the magic wand ;-)

Select a file from tree view, go with the magic wand and you can do
everithing from main view.

>
> it seems to be pretty big. The date on 1.5.7 was very
> close to 2.0 so I thought they might be very close in
> functionality and you maintaining the same code for
> both the common Qt3 and the new Qt4 to make it easy
> for users to install.
>

Yes it is. qgit-1.5.7 should be very similar to qgit-2.0 regarding the
features you listed above.


Marco
