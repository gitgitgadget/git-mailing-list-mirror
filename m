From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Help with sparse checkouts
Date: Tue, 13 Aug 2013 13:07:39 +0700
Message-ID: <CACsJy8B8T=DvR4DcXgjvqTX2HvUGDY140JtiQdrv=JwRt_DCrQ@mail.gmail.com>
References: <7159505.507781376331946615.JavaMail.root@zimbra> <6658365.507831376332071042.JavaMail.root@zimbra>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Ari Entlich <atrigent@ccs.neu.edu>
X-From: git-owner@vger.kernel.org Tue Aug 13 08:08:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V97mA-0007pi-Ow
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 08:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914Ab3HMGIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 02:08:11 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:42281 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab3HMGIK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Aug 2013 02:08:10 -0400
Received: by mail-ob0-f169.google.com with SMTP id wc20so10145643obb.0
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 23:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oDgNz2YQv9+mwQsWMNfIBUotExlXdAYsLC/0Gf/gF44=;
        b=GAMog89L+n7TONXeEPImb+gs2CIduoyjt/rJ9dZYdxX8k9cLlKOgef8zXHNoHQo8X3
         kYOTBs9ZTpbOvSEnYuI//1IPJvJ4EFG5zu/8ACyyU+c/TXMNY+bieu7QVcTcuMgQ+Eiu
         vZeqfXtq8ZIrjSUb3RTU219emtvhnXMM3V1Fd49OJlynoflTN9bIUVrizlzHZWZ+80BE
         zmudghwXRgKkSm9UrW/NgXOJtDm1j5z87WCncs1ntuH1FBP9Q/hhhat6ave21lP2/32R
         JI57hIDQKyCwarsrJ8vOlje9hsaD0DS4llIMDAmQ8AZskrAoO4UQiYUsP1XRm76isMRY
         iE4Q==
X-Received: by 10.60.62.101 with SMTP id x5mr2645377oer.24.1376374089469; Mon,
 12 Aug 2013 23:08:09 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Mon, 12 Aug 2013 23:07:39 -0700 (PDT)
In-Reply-To: <6658365.507831376332071042.JavaMail.root@zimbra>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232213>

On Tue, Aug 13, 2013 at 1:27 AM, Ari Entlich <atrigent@ccs.neu.edu> wrote:
> Hello all!
>
> At my current workplace, I have a git-svn repository which has an extremely large working directory. I did not use the --stdlayout option in this clone, so I have a number of branches in my working directory which duplicate large amounts of trunk. There is a particularly large subdirectory which has now been copied to branches four times (and hence shows up in my working directory 5 times). This directory and its copies are making up the vast majority of the files and storage space in my working directory. Furthermore, I do not need or want to have access to the data in these particular directories. Hence, I would like to use the sparse checkouts feature to exclude them from my working directory.
>
> Let's say that these directories are all called "thedir". What I would like to do with the sparse checkouts feature is to simply ignore directories with this name anywhere in the working tree. Intuitively, it seems like I should be able to put:
>
> !thedir
>
> or possibly
>
> !thedir/
>

I think this should work (but I haven't tested it)

/
!thedir

The first rule is to include all, the we exclude what we don't want
using the second one (trailing slash or not is ok).

> in the sparse-checkout file, but these don't seem to work. I've tried a number of other things, but I always seem to either get the "sparse checkout leaves no entry on working directory" error or no effect at all. In the end, I basically just don't really understand how this file is supposed to work, so I'd rather get some expert help here rather than thrashing about randomly. I realize that sparse checkouts is usually used to select a specific directory rather than what I'm trying to do, so I accept that what I want may simply not be possible with the current implementation. I've asked on IRC, but I wanted to ask here also since it seemed that most of the people I talked to weren't that familiar with the sparse checkouts feature.
>
> Note that, while using --stdlayout would mitigate the massive working directory somewhat, I would still probably want to exclude this directory from my worktree. I will probably do a reclone at some point and use --stdlayout, but I will still want to exclude this particular directory even at that point. I had a lot of people on IRC telling me to just use --stdlayout, which was a good suggestion, but didn't fully fulfill my needs.
>
> Thanks!
>
> Ari
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
