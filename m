From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT: stgitformatversion vs. stgit.formatversion
Date: Mon, 4 Jun 2007 23:12:25 +0100
Message-ID: <b0943d9e0706041512g2b063676x6c6c954c9fd84aeb@mail.gmail.com>
References: <20070602191641.GB6992@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070603121718.GA6507@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Yann Dirson" <ydirson@altern.org>,
	"GIT list" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 00:12:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvKmx-0007oW-7T
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 00:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbXFDWM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 4 Jun 2007 18:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbXFDWM2
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 18:12:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:29191 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbXFDWM2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2007 18:12:28 -0400
Received: by ug-out-1314.google.com with SMTP id j3so892937ugf
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 15:12:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UHu7Q1n+/l4B/L2V1KnU8z45ij9+yP3sHvxhMP7lhRgOeaWGdmMgdrugsLrH2vNBZKhn4sw1KclR6Q1wb6QaB216GR28a1nDfknScPwB5Tey4YFp9FihqvpfkadaIHlhlxtQzxQfI6bdkbgIhLjZiPvXlGEhfr12upC+f3Pldds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uNxmbPLpSqfT6BQX+o9VsZ/pVej168Tp/Qd5jfcpKljIM6YwdqBgpd5hcMneGJlGEKbo1buTkvQt+dwODJhyIQ+Y2Zjyyw/KWWpwKsnxCMx6d/4vG3k6XzXNhsNnFBgJkgPzDcrG/wktshVLwG4ZuhjbrjnDzBVYt+oWDraOhPI=
Received: by 10.67.93.2 with SMTP id v2mr3379984ugl.1180995145940;
        Mon, 04 Jun 2007 15:12:25 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Mon, 4 Jun 2007 15:12:25 -0700 (PDT)
In-Reply-To: <20070603121718.GA6507@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49133>

On 03/06/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-06-02 21:16:41 +0200, Yann Dirson wrote:
>
> > What about using branch.*.stgit.formatversion to store the version,
> > to be consistent with other stgit-specific per-branch settings ?

I agree as well.

> Good idea. But we should probably fall back to stgitformatversion (or
> better, upgrade from it) to be nice to those running Catalin's master=
=2E

It could, indeed, fall back to stgitformatversion and upgrade from it.
Anyway, I'm not sure there are that many running the master branch but
this would be needed for us as well.

> It happens a bit too often that we find problems with patches only
> after Catalin has published them on "master". (At least that seems to
> be the case with patches coming from me!) Maybe a "pu" branch
> (maintained either by Catalin or someone else) would be a good way to
> smoke them out before they're written in stone and distributed to lot=
s
> of people.

Well, I consider "master" to be a development branch anyway. It would
be useful to get an idea of how many are using this branch (people not
following the GIT list are probably using the stable releases anyway).
A "pu" branch would make sense for more experimental stuff, like the
DAG patches.

> If the stgitformatversion patch had been on such a branch, we could
> just have edited it and not have to worry about upgrading old configs
> (aside from posting a mail on how to upgrade manually).

But now I have plenty of branches in my Linux tree already, so I
wouldn't do it manually. We already have checks for the repository
version, adding this would probably only be 2-3 lines.

--=20
Catalin
