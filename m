From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Dealing with rewritten upstream
Date: Fri, 30 Sep 2011 23:04:09 +0000
Message-ID: <CAMOZ1Bu-1hq1UN+UQs9HreR4bhJAoxGFLA=jdW8jgoC9g3DJHQ@mail.gmail.com>
References: <CAG+J_DwR4vE6iYt475EM7-VDNi4hG3jhdmXWSbJ04Y9fyHeuLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 01:04:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9m8O-0000yq-JV
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 01:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758427Ab1I3XEl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 19:04:41 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51296 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab1I3XEj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 19:04:39 -0400
Received: by iaqq3 with SMTP id q3so2270225iaq.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 16:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zlBegwZZJbnZFU8IjZvHqA458X0xUrEJeARcMbs799U=;
        b=EI+13wrjpOYTWQe4KRX/XasCP9YxvLyQUPd41JGdDmr42I6z9W4Ow+TgFnE9FvQ0om
         micxrScOYpIuRXe2pMmrrh+lfMnqNne7e38I/D5cSg9N+Rqe//1DuumPD+woeNDHxcMy
         laJ5RPd736862qGDRxw4c4DO0KvRvk5gg5bj0=
Received: by 10.42.18.74 with SMTP id w10mr3487117ica.164.1317423879131; Fri,
 30 Sep 2011 16:04:39 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Fri, 30 Sep 2011 16:04:09 -0700 (PDT)
In-Reply-To: <CAG+J_DwR4vE6iYt475EM7-VDNi4hG3jhdmXWSbJ04Y9fyHeuLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182522>

On Fri, Sep 30, 2011 at 22:09, Jay Soffian <jaysoffian@gmail.com> wrote=
:
> I have a repo w/over two years of history whose upstream repo is a
> git-svn mirror.
>
> The upstream folks recently announced they need to retire the existin=
g
> repo and replace it with a new repo. The new repo is identical to the
> old repo tree wise (commit for commit), but some of the commits in th=
e
> old repo had incorrect authorship which is corrected in the new repo,
> so the new repo has different commit IDs than the old.
>
> (i.e., it's as if they've run filter-branch --env-filter on the old r=
epo.)
>
> My repo has many merge points with the old history.
>
> Pictorially:
>
> ---A---B---C---D---E... new-upstream/master
>
> ---a---b---c---d---e... old-upstream/master
> =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 1---2---3---4---5 =C2=A0master
>
> The obvious way do deal with this situation is:
>
> $ git merge -s ours -m "Splice in new-upstream/master" E
>
> Are there any other/better options I'm missing?
>
> (Eventually upstream plans to migrate entirely to git, so I can't jus=
t
> run git-svn myself.)

Surely, you'd rather have your master rewritten such that the relevant
commits of new-upstream/master are used IN PLACE of the corresponding
old-upstream/master. Have you considered ways to achieve that?
