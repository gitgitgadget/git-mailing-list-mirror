From: Samuel Maftoul <samuel.maftoul@gmail.com>
Subject: Re: git clone submodules recursive and reference
Date: Fri, 20 Apr 2012 21:26:22 +0200
Message-ID: <CAFj+z04A5v7Cz=Wbqn_TBJQG88rPSfrs4T1=22x1N+v77ZXgYA@mail.gmail.com>
References: <CAFj+z055ZZc-Am+pEMgjRvHgoxKSRBjnHhABCseC45+8YswKWg@mail.gmail.com>
	<4F91B22A.9000507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 20 21:26:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLJTR-0002i4-CP
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 21:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab2DTT0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 15:26:24 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:43428 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab2DTT0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 15:26:23 -0400
Received: by qcro28 with SMTP id o28so6055374qcr.19
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GgUkp2uy7uCu1L7lYvd00mObIMC4nBYBLwWN2a7Khe0=;
        b=I78Eooi75C81eIBM5IjAeLjwZCO6+bOuSRx0MTGNhcPH2ff8/qkagrI2+AWo5ryIW1
         Te2WG24/92oyJb6sxdPu/gNHVd+PRykFLWT+WNdL4/fcqF1eIU4KTu3kxznc3zZSR6z+
         BRFIOA8lG+tykBUmrxhGxkGmSHoWfQWwnH3fBCJHLBJxVT91xXeuaNSWRaBhncmxQpFm
         uboBjnus90nklPhzqRoldInTsfs3Bsemxls6hiYh1ESEXedxFj0s9dANVBT/7c7Dkkf4
         FYl7hIZ9isLMfM9jMg8dW0wXdn0JiFLiMIYCi95x4/DHNq1V/Bdw8RHLqS0OsFBVCqUz
         VcBg==
Received: by 10.224.32.193 with SMTP id e1mr2999923qad.44.1334949982735; Fri,
 20 Apr 2012 12:26:22 -0700 (PDT)
Received: by 10.229.82.132 with HTTP; Fri, 20 Apr 2012 12:26:22 -0700 (PDT)
In-Reply-To: <4F91B22A.9000507@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196012>

> Hmm, to me it looks like passing the --reference option to the clone
> run in the submodules doesn't make much sense, as that would make
> all submodules and the superproject use the same alternates. And as
> far as I know sharing objects between different repositories is not
> supported.

I'm sharing objects between repositories by creating a bare
repository, adding the remotes for the repositories and fetch them in
this bare repo.
So for me, it makes sense to pass the "--reference" to the submodules
clone, if submodules remotes are added to this reference bare repo and
objects are already fetched (and I'm in this case, as I use a lot of
different projects that shares the same set of submodules).

>
>> How can I force the clones for submodules to be executed with the
>> --reference option ?
>
> You'd have to use "git clone" without the --recursive option and
> then do a "git submodule update --init --reference ...".

Yes, this should make it, but I would have been more happy with a
single command !

Thanks Jens !
