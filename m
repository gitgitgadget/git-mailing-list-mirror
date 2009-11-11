From: Baz <brian.ewins@gmail.com>
Subject: Re: [PATCH] Clarify documentation on the "ours" merge strategy.
Date: Wed, 11 Nov 2009 15:13:52 +0000
Message-ID: <2faad3050911110713y4e33c7d2h21ad42efe4fd70b3@mail.gmail.com>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de>
	 <200911111411.nABEBfox031023@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Nov 11 16:14:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8EtU-0006YH-Fq
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 16:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757297AbZKKPNt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Nov 2009 10:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756940AbZKKPNt
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 10:13:49 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:50932 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756839AbZKKPNs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 10:13:48 -0500
Received: by bwz27 with SMTP id 27so1109756bwz.21
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 07:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L0AnFjsSUe2el+AoOy5XgRt9OsHOqsQtmFcf3e1EEkI=;
        b=fhbN+OZMx2VThj2xkJV8yRH5xe1DmNUXw0A6EWD5pLqEOuQ6MsOMaeY9ilhjP01dwD
         XzVAlOFNrEnKAban9cZ8OG5L7QcVIoXa4wAdilpvLEJ6/0W7Xy7CDRy9iPk1tmFRuoH4
         ohG/dhZZ67UPVjpyqHMxe1/B9HNN7YPABttsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eijTmErvyEtrekSb5O/PL10GCxmwSqXMJr033X7uxM9VOrEVylkV7BvPz0tJQsKXMq
         2uKV0z767zeHbnTOS8K74XG2xVzufEjedqb++YbUkkHp4rdNfjpWIeFCnQYFbw8mFbSq
         YYZWHNGq2rPXXlzgEE1OZORmP8Om8tuGB2O/c=
Received: by 10.216.86.206 with SMTP id w56mr536602wee.1.1257952432685; Wed, 
	11 Nov 2009 07:13:52 -0800 (PST)
In-Reply-To: <200911111411.nABEBfox031023@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132662>

2009/11/11 Peter Krefting <peter@softwolves.pp.se>:
> Make it clear that the merge strategy will discard all changes made t=
o
> the branch being merged, and not just avoid creating merge conflicts.
> ---
> =C2=A0Documentation/merge-strategies.txt | =C2=A0 =C2=A03 ++-
> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>
>> If you want to use any merge strategy, you must understand what it d=
oes
>> first.
>
> Indeed. Perhaps this clarification will help the next poor soul that =
tries
> doing what I tried?
>
> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge=
-strategies.txt
> index 4365b7e..a340dc9 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -30,7 +30,8 @@ octopus::
>
> =C2=A0ours::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0This resolves any number of heads, but the=
 result of the
> - =C2=A0 =C2=A0 =C2=A0 merge is always the current branch head. =C2=A0=
It is meant to
> + =C2=A0 =C2=A0 =C2=A0 merge is always the current branch head, disca=
rding any
> + =C2=A0 =C2=A0 =C2=A0 changes on the merged branch. =C2=A0It is mean=
t to

I think part of the problem is that it is unclear what the "current
branch head" means when used in a rebase, and hence when this text is
included in the help for git-rebase and git-pull. This flipped
behaviour is surprising given the natural meaning of 'ours', or
'current branch', particularly for git pull:

git pull -s ours  - discards changes in remote branch, keeps changes
in current branch
git pull --rebase -s ours - discards changes in current branch, keeps
changes in remote branch

Perhaps something more in the way of an explicit warning?

ours::
         This resolves any number of heads, but the result of the
         merge is always the current branch head, discarding any
         changes on the merged branch.  It is meant to
         be used to supersede old development history of side
         branches. Note that when rebasing, the branch you are
         rebasing onto is the "current branch head", and using this
         strategy will lose all of your changes - unlikely to be what
         you wanted to do.

-Baz

> =C2=A0 =C2=A0 =C2=A0 =C2=A0be used to supersede old development histo=
ry of side
> =C2=A0 =C2=A0 =C2=A0 =C2=A0branches.
>
> --
> 1.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
