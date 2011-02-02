From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [1.8.0] Tracking empty directories
Date: Wed, 2 Feb 2011 18:23:07 -0500
Message-ID: <AANLkTi=bK7mFS3eWVMWXqZSnv73tafL9AGazk4jPLddp@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <m3zkqe8xc8.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 00:24:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkm3O-0005nC-PI
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 00:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508Ab1BBXXj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 18:23:39 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34245 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180Ab1BBXXi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Feb 2011 18:23:38 -0500
Received: by iwn9 with SMTP id 9so512107iwn.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 15:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Fz6BjWPWifkDZTf5Nw+TA2LzKDpYDQ9PyIfzwUkvhoA=;
        b=oOc3ZgO6yOCJEMcYUBdsn85fgRfeMvsFi8to2NPydXE+vk8iaF524dntmoCxJZ65xt
         IlAphhioRh97bz6WNk/fOH+NQyLFLtXxfOnf0zdVgwglvKzEkIg0v6VEv8LFGQk5E47q
         sGozQ50GNsKKnvkBMBbzqWI8Tj2SuDsTLVQZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=H2kpIlypANH1DywzGV9LWb7uocHQS1i4rlQUVBvjmU0jEVpOCMrPC1wEUK1fWEwgmj
         jfgkd6rKad/I/1NnW/oMl9VJh9qNwQ6CQtzOL2x+8IY2HRaiSFQJbidYe4hC8OZD0es9
         7XgcUiBpHpNqkTRtIOWtKKTH48dPq2AEuLOJg=
Received: by 10.231.147.149 with SMTP id l21mr10661430ibv.152.1296689017576;
 Wed, 02 Feb 2011 15:23:37 -0800 (PST)
Received: by 10.231.30.65 with HTTP; Wed, 2 Feb 2011 15:23:07 -0800 (PST)
In-Reply-To: <m3zkqe8xc8.fsf_-_@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165939>

On Wed, Feb 2, 2011 at 6:56 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> The problem with backward compatibility is twofold. =C2=A0First and m=
ore
> important is while git supports empty tree object (it has it hardcode=
d
> for some time, as it is necessary e.g. for initial diff, or merging
> unrelated branches without common ancestor), and there is no problem
> with entry for empty tree in a tree object
>
> =C2=A0040000 tree 22d5826c087c4b9dcc72e2131c2cfb061403f7eb =C2=A0empt=
y
>
> there is (supposedly) problem when checking out such tree (see email
> referenced above) with an old git.
>
> Second is that tracking empty directories would require extension to =
the
> git index (storing trees in index, like we store submodules)... but t=
hat
> is purely local matter.

Instead of using an empty tree, construct a tree containing a single
sentinel file whose contents are a suitable warning not to delete/edit
said file using pre-1.8.0 git. Meanwhile git-1.8.0 never writes the
file to the filesystem. Too ugly?

j.
