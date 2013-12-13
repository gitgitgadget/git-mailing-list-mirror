From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 21:35:54 -0500
Message-ID: <CACPiFCLJfefNaPYtCXd21fO-ztmaaX6xdz1TtcMdYc0y19t56g@mail.gmail.com>
References: <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <20131212171756.GA6954@inner.h.apk.li> <20131212182932.GB16960@thyrsus.com>
 <CACPiFCJ22xiedXAoQktMLd=gASgD0NS24Pya9TvCo9aQP5JaBQ@mail.gmail.com>
 <20131212193918.GA17529@thyrsus.com> <CACPiFCLXeK9DH=f80ReSmYHJ7zjOn-D2zvs3WmdiV-k=wBGgjA@mail.gmail.com>
 <20131212205819.GA18166@thyrsus.com> <CACPiFCJDP6OVju2xzm2NWR5gc=bZDeNmXsD_MFH2mgHQru_u6Q@mail.gmail.com>
 <20131212230454.GA20054@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 03:36:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrIc0-0003uk-D1
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 03:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab3LMCgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 21:36:16 -0500
Received: from mail-ve0-f173.google.com ([209.85.128.173]:48459 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742Ab3LMCgP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 21:36:15 -0500
Received: by mail-ve0-f173.google.com with SMTP id oz11so973952veb.32
        for <git@vger.kernel.org>; Thu, 12 Dec 2013 18:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IdX7t5Hr2RHw8PdcTH5ICjwslkgZFQPlCdqsw+H6Bcs=;
        b=IPeAehk4fUw3uGsMdtnebTgN0g6jIRRPKBiwkOlM68n/FmS9mhy0vuaskhzTy8kJMR
         OIwG0MDZagLxm5XPXDjSWKVXZYGEghCuihf5C6gqf2MDjABpVakG9E6EVgK/nqxuJ11g
         PcMbLQZ6CP7xLzluy7QAaEqGV1iKuOMdMseQDQoRM1jR/fnIDsKu5pKaokxdlht8cIoW
         R6VnSMAug4/nOjaL7rhQGYgPKLuHazkR0KyAQEhqWl2F1Du8UNMeS3D6ksKU7C4SQhuA
         Cn56JiFbGHnNj2duUbNP5IY1AgAaovpLUUU9VHweeJT2iHteqi1y2M0u97VtoZJ16jGA
         2nqQ==
X-Received: by 10.52.36.80 with SMTP id o16mr45209vdj.48.1386902174810; Thu,
 12 Dec 2013 18:36:14 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Thu, 12 Dec 2013 18:35:54 -0800 (PST)
In-Reply-To: <20131212230454.GA20054@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239255>

On Thu, Dec 12, 2013 at 6:04 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> I'm not sure what counts as a nonsensical branching point. I do know that
> Keith left this rather cryptic note in a REAME:

Keith names exactly what we are talking about. At that time, Keith was
struggling with the old xorg cvs repo which these and quite a few
other nasties. I was also struggling with the mozilla cvs repo with
its own gremlins.

Between my earlier explanation and Keith's notes it should be clear to
you. It is absolutely trivial in CVS to have an "inconsistent"
checkout (for example, if you switch branch with the -l parameter
disabling recursion, or if you accidentally switch branch in a
subdirectory).

On that inconsistent checkout, nothing prevents you from tagging it,
nor from creating a new branch.

An importer with a 'consistent tree mentality' will look at the
files/revs involved in that tag (or branching point) and find no tree
to match.

CVS repos with that crap exist. x11/xorg did (Jim Gettys challenged me
to try importing it at an LCA, after the Bazaar NG folks passed on
it). Mozilla did as well.


IMHO it is a valid path to skip importing the tag/branch. As long as
main dev work was in HEAD, things end up ok (which goes back to my
flying fish notes).

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
