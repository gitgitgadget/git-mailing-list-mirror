From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 18:22:07 -0800
Message-ID: <3ab397d0812301822p34a021b1w6799a9de9a4ffeb4@mail.gmail.com>
References: <BB5F02FD3789B54E8964D38D6775E718242D31@ALTMORE-SVR.altmore.local>
	 <alpine.LNX.1.00.0812301859100.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Conor Rafferty" <conor.rafferty@altmore.co.uk>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Dec 31 03:23:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHqk5-0003gC-FK
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 03:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbYLaCWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 21:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753869AbYLaCWK
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 21:22:10 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:59718 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbYLaCWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 21:22:09 -0500
Received: by qw-out-2122.google.com with SMTP id 3so4430344qwe.37
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 18:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6HMlyZjbLVa5uTVhidvz8xNhPfxYLtxM/mLxnn4vWG0=;
        b=pqi4f/8GJGn9zzSU6vTVIIvXL2my3oT/FsmAYs3wZ1vuZ9FCfySNTaweNhtB2xpKaz
         jyOrol49ULvIfavHdsGsQJGwPtQ0YouT3Rnmf1EX3XG4AVQLtkQwyXADAkpHQCno1/Qd
         7hj20HS3n5jIvnFFgXHyFV5k9jlRhHsItM1Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=E/WoRwCu5XsS/7bp6PC1ed5fq81T4Yi+3THOeMoghdKvWzqKsAhNZG6SIdBHUTXTD6
         QmZRXqin6xVC2U/NscUFy6MVarQFpt9NNnPhBNeeYvOl+4jxn0Z3kx3BrHdmAw4JNjCf
         /4Gr80sbV24jVfN41sN34/mCjCWtTVFQb0sZg=
Received: by 10.214.60.14 with SMTP id i14mr13297945qaa.217.1230690127303;
        Tue, 30 Dec 2008 18:22:07 -0800 (PST)
Received: by 10.215.41.3 with HTTP; Tue, 30 Dec 2008 18:22:07 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0812301859100.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104237>

wtf is wrong with

git checkout <something>

??

if you must have

git checkout <something> <paths>

then instead use

git checkout <something> <paths>
git clean

but you will lose other files that aren't part of the repo but are
still in the project's dir (i.e. untracked files).

On Tue, Dec 30, 2008 at 4:15 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 30 Dec 2008, Conor Rafferty wrote:
>
>> I don't understand, sorry. I thought I'd already removed all files from
>> the local tree, in the $ rm *.* move just above the checkout
>
> That removes them from the filesystem, but they're still in the index. And
> "git checkout <something> ." first gets everything that *is* in "." in
> <something> into the index, and then gets everything from "." in the index
> into the filesystem.
>
> I suppose it is questionable as to whether it ought to copy paths that
> aren't in versionA from the index into the filesystem.
>
> To see this in a bit more detail, do:
>
> $ rm *.*
> $ git status
> (notice that the deletes are in the "won't be committed" section)
>
> Now, "git checkout <path>" will discard any changes in the "won't be
> committed" section for that path. Maybe "git checkout versionA <path>"
> should only discard changes that are in the "won't be committed" section
> for filenames that match that path and are in versionA (or are
> *different* in versionA and not removed?), but I think it's an area where,
> if you're expecting any particular behavior out of that command, you're
> likely to be surprised in some way in some situation.
>
>        -Daniel
> *This .sig left intentionally blank*
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
