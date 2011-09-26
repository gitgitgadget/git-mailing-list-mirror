From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Thoughts on gitk's memory footprint over linux-2.6.git
Date: Mon, 26 Sep 2011 18:07:44 -0400
Message-ID: <CACPiFCJvg4X7yL0FUYEtB4U4cabyczrHGDapTgLncFCoDF1EEQ@mail.gmail.com>
References: <CACPiFC+T1EZ1CSakQxsYZhsnHc-ZsN1-=tpoi-NaQSdpU5Yxkg@mail.gmail.com>
 <CABPp-BHo5qKQVFRzFpoyt6dZZ3=UqVAtSjVy0uRDWnA+ASsBPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 00:08:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8JLP-00045l-Au
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 00:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab1IZWIG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 18:08:06 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42318 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab1IZWIF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 18:08:05 -0400
Received: by iaqq3 with SMTP id q3so4966099iaq.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 15:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AxDrzvneGJjPKeMSMal+nqh1g4EQ7/oTg2rRPY3sTUw=;
        b=vXfiEaE1tJJv1TfkAJNa/SOcyMhPoyNYif5STcS25AdQbDC+AC+uTXczJNbwhSjkwr
         0f4gbriRTc+nf7k3gb151oVH3P+41hU/YeKYZys6cJf1gZhK/Nhxm25InWnMOqZifbp3
         i2EMyVDUb0gfV2X4CdCqGbNRw5ArGq2vGFqkg=
Received: by 10.43.134.7 with SMTP id ia7mr8001385icc.201.1317074884060; Mon,
 26 Sep 2011 15:08:04 -0700 (PDT)
Received: by 10.42.172.130 with HTTP; Mon, 26 Sep 2011 15:07:44 -0700 (PDT)
In-Reply-To: <CABPp-BHo5qKQVFRzFpoyt6dZZ3=UqVAtSjVy0uRDWnA+ASsBPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182175>

On Mon, Sep 26, 2011 at 6:02 PM, Elijah Newren <newren@gmail.com> wrote=
:
> If you only want to look at a couple commits, you could tell gitk tha=
t:
> =A0gitk -N

I know I can -- I've done my bit of git hacking but it was long ago so
if you use your -N parameter you won't see it ;-)

I argue that -n 10000 should be the default -- most of the time you
open git to see recent commits, not that 2.6.12-rc3 commit. Of course,
it cannot actually be the default, because currently there's no way to
scroll past that limiter.

It's a hard limit, and that's not useful.

Now, git internally is very smart about using sliding windows over
large datasets. The porcelain tools don't try to be so smart, but
we're at a point where, as a user, I really wish gitk had some of that
magic.

cheers,



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
