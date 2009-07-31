From: skillzero@gmail.com
Subject: Re: [RFC PATCH 0/5] Sparse checkout resurrection
Date: Fri, 31 Jul 2009 14:18:26 -0700
Message-ID: <2729632a0907311418m6e60b1b6g9475f7668dec0192@mail.gmail.com>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 23:25:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWzbF-0001eS-Eb
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 23:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbZGaVZB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 17:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbZGaVZA
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 17:25:00 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:50939 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbZGaVZA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 17:25:00 -0400
Received: by an-out-0708.google.com with SMTP id d40so2871333and.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 14:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VWpkHxGeuBP3JGyBPYLYWB82BHJHoida8goE1dhGNNE=;
        b=g93L88q2/XDd2y+sJ2DeKFLsbGthKFDo9g6gDF2+xFWUs7BkmJz5MeN5ZHYEnkxjqc
         L5vP8mjS317dIFdVQTTlDHclGrwsuJlIIGv9lCiJYM/FshXqCzWLcO/nwHnwsxpxxkXX
         t7Zn6UVG8YZO5qRo418o2tGbKuNf/Bvcd0Qgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aR/6df+BIeJKP/sOoFUll31W9Ok1I7ZQYrwp3SoTR+vSWC+tnLdUNbaykrQXZcK4O9
         4Ab+mqLD9sc2cH8A3uLm2byzOU7vIP+Wm9xrsmBS9i36Cu708AQQ39ISj8A1mht+QaXM
         trzReNLvXW9tvtEj5bxaxWClGB7CG/geeC+fc=
Received: by 10.100.225.7 with SMTP id x7mr2902278ang.172.1249075106974; Fri, 
	31 Jul 2009 14:18:26 -0700 (PDT)
In-Reply-To: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124600>

2009/7/28 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> Hi,
>
> I rip most of the code from my sparse checkout series,
> leaving only basic stuff. Now there is no CE_NO_CHECKOUT bit (CE_VALI=
D
> will be used), no sparse pattterns. You will need to provide a script=
,
> namely "git-shape-workdir", to specify how you want to shape your
> workdir. That's all. No porcelain, only plumbing. Need to add some
> options to read-tree and checkout in order to enable/disable this, bu=
t
> I haven't got that far.
>
> The first four patches is more or less CE_VALID fixups. Real stuff is
> in the last patch. Sparse patterns may return as a separate
> script. Currently no idea how the porcelain UI should be. The only
> thing that is probably impossible this way is "git clone
> --sparse". You may need to "clone -n" first, then apply sparse
> checkout later.
>
> Comments?

I don't know the git code enough to really comment on the details yet,
but I just wanted to say that I'd love to see sparse checkout support
in git. I tried your other patch series using a config variable
instead of the "git-shape-workdir" script and I liked it (although I
didn't thoroughly test it). It shouldn't be hard to write a
git-shape-workdir script to parse a modules file to decide which files
to include/exclude (I'm hoping to do that soon).

Judging by the surprisingly large number of people commenting in the
recent git survey that they want some form of sparse/partial checkout
support (myself included), I hope something like this patch series
gets some traction.

BTW...Is there a repository I can clone from that has these changes
and possibly future enhancements? I checked
<http://repo.or.cz/w/git/pclouds.git>, but I didn't see them.
