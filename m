Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEF3C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 14:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 010A060F23
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 14:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhJNOol (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:44:41 -0400
Received: from mout.gmx.net ([212.227.15.19]:34631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231685AbhJNOol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 10:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634222551;
        bh=/REs3nUK7yoi+MkQgMZ5D0ClGNZnBu3CYicJJJNonBE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WztnjvnaBM/uZOePlQSfhPvVmhh0SZTwThbcO4hRl/Dz9SnOQ3pvbxWvXgRxJb5vI
         4M7rYIO0z/Bo9V10lp2FtCdLiqA3WQ8up+O5Ll75UdlKIR2iTvmns0NP14ekdiy6BQ
         Y6LkJVpLnfjzgxPPb3Mm1iyZkIus73bnMzKedJpc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.7.163] ([213.196.212.140]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1mNFCz0CsQ-00PvxK; Thu, 14
 Oct 2021 16:42:31 +0200
Date:   Thu, 14 Oct 2021 16:42:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/retire-preserve-merges, was Re: What's cooking in git.git (Oct
 2021, #03; Mon, 11)
In-Reply-To: <xmqqwnmgeenz.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2110141641530.56@tvgsbejvaqbjf.bet>
References: <xmqqv9239k15.fsf@gitster.g> <xmqqwnmgeenz.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qDC6I49N6nyBGiOxAjBYzw8L00OWXDCY/jooKOHggLgn/vH+Csi
 4d1S79bG5qNP3hK4LUH8FjyZEoMEAAPvoVRmUoJW+fcMMOZEFXehybrdcvGhhXRMth//LkD
 ICVuJYesROT2y2lcapF8t7dgW9JCfk1cE4jRLtJv1sv2xI6MKAQCxojjEibqS5Zt9ML4YHW
 Q6q7C5e2XZpgH0mFyywPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yY0P/AmkAi4=:lQMbPy0Wqu3QdugmbmuUBZ
 YyvHmshA9Cs5jRtm4wsDiyRWtOdeT1lFUO47ydp8YQoPFGlsNlS6f1uO6HuGk3iaSPmoGY5m0
 gvDtU3TCT3j1jW6RDggBsabqaA0NflblpXf09q+nL1cl69kwxXYBbiMIbOXNbKEgFK0Xcfk6I
 b70mtQl0M7hbfAQIXnkFpzMtpVSwxrGmF7N0EwapWKGpEhaPDwnsYwt8XxcetqVlxqhGACzff
 +jqpNYG1PvpeBrERLK8IiPEd+s1XKRrov73w71XrzJbahzEG8dVHAz+k9cT2t1abLYQBy5IC/
 9EPGmt2mtzKEuDLT7hVVrpHYPFrQjC8/a/+zf+VFox81Gj4uPCYRVTwgqgsen3yOsGSRHjTR6
 1V6fjiouA+71jivxQcvDpLmToM8ulJwoPhUzjp4OxZRpItMWhYQPsVRzmSTEG7o+HnAqpkTc7
 LfTXKJBtyYLeIuYXCh0Cvf5VCVNyyBl8sNMmZo4jhgsXgaxN31nrOfgy6pbFmPIKwLAgggJvm
 gknD28Lmi3KF8amakTwSeAWmB8dmkiSU7py9aNbngsuusYYc4Dc1gy8m12bR0RVLs2BXuPmvN
 51/jImTf95rrJezhg0YW0j30YqSMQsCp+LDhr2vAELr2XmiTz+E8/CEN1KPg+D6IGzpbq1xUJ
 CmcDDnuY7qP8Wk1WiuYemxCnD6XtkBAzcEKFLvUnbZu9WLT29GkqH/I5SgmLX3fqAXfZvlSPd
 uKb4KSDU7HKkQ3wo86kaBvFARd+ZAtmEhitFhEeKdnAFBsNd4I7l1YiGv265oNf95BgnCFPBe
 pe9gsduln8tIU/b/xl4BS556YFS/g1Q+fe+WOYF96EqYhWSG3u3GMlrwCtggb5eCR2GqrqoAv
 pSI9E0G9w2IiYfegHbZcRLSTJG8+fvbcVmZKyE3LBo/lMmu/HI/EAbuXvqR3yaRh+pU6nmkyA
 B0XqFuXQcFKSbo7tlXPtix1Wglxueo/8XSNJJme6dx7m3sYZtvMXow55lIcQ7Xnt1dVTkMwvl
 Bm6/Yh1fCB0EJRcVGhOI626RO/13oGysY44ItfFe0Zk0AJSA0VtZLh89QjvDalCMsK60MaEQl
 n9crmmZ0SmoYQI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 13 Oct 2021, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > * js/retire-preserve-merges (2021-09-07) 11 commits
> >   (merged to 'next' on 2021-09-10 at f645ffd7a3)
> >  + sequencer: restrict scope of a formerly public function
> >  + rebase: remove a no-longer-used function
> >  + rebase: stop mentioning the -p option in comments
> >  + rebase: remove obsolete code comment
> >  + rebase: drop the internal `rebase--interactive` command
> >  + git-svn: drop support for `--preserve-merges`
> >  + rebase: drop support for `--preserve-merges`
> >  + pull: remove support for `--rebase=3Dpreserve`
> >  + tests: stop testing `git rebase --preserve-merges`
> >  + remote: warn about unhandled branch.<name>.rebase values
> >  + t5520: do not use `pull.rebase=3Dpreserve`
> >
> >  The "--preserve-merges" option of "git rebase" has been removed.
> >
> >  Will cook in 'next'.
>
> I am tempted to merge this down to 'master' soonish, in time for the
> next feature release that is planned to happen mid November.
>
> Opinions?

So far, I haven't heard any objections, so I'd be fin merging this
soon-ish.

Ciao,
Dscho
