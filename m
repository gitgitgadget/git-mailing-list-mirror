Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C737DC433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 21:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbiBFVTM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 16:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiBFVTL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 16:19:11 -0500
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 13:19:10 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0371FC061348
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 13:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644182348;
        bh=i5P/5aBTUre83GqB6eck+m/u8Sd6ZOev/P18acIXsxk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ff0HFi/c2NYUTmAupCKok0MVQCE9Hdk8E7BTgHQKVY7RHIcKt0F8XtxiGxlAQBndP
         o761BbnsHlkqA2dbeil4r7oDn9k4Y7njoKYFqvVnsab0Xd2SnUdZOtLttl6vts9Bly
         AZXkou+wfY5xBNyZeKIAAdo6xgHACt5OKefXqAlM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.212.206]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1nfsup1hZz-00P7JN; Sun, 06
 Feb 2022 22:14:00 +0100
Date:   Sun, 6 Feb 2022 22:13:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 0/5] scalar: implement the subcommand "diagnose"
In-Reply-To: <dda1b3c8-afc6-d9d5-1bfb-4a48ac87ca54@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202062213030.347@tvgsbejvaqbjf.bet>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com> <dda1b3c8-afc6-d9d5-1bfb-4a48ac87ca54@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SLhZRfceeNjHiVmCWmy732b4O/H85Gqi9FMoxSsrugHR/e+RPM5
 9xpRrtS+l9fD6yRNbg8SlEf6QUVPVCE2EwhocKpavowaDMJl2g4krcDfy821r72LQDNQT6a
 w1uP/Arljr/EbJUYkeVCI2R2Li4NO2WSAIrHlqawXyYWsrGdeI4S1i2YAtUNDvplETRorC+
 8Y5I0dJ1eCIM1x37TRbzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pspt29tJIH0=:f1LANXDplItMMUjrvHoYc8
 uOUSuj68IDU5o7iwlzIJY+aRM2GZnyLFGPTmYHvX6yW6KWb/C33f8/4i2qzYrYWK0tbNkagyt
 2r1AyEHi50MHcRjgiX7zTcikoSVk+m5wkVC1AkvbfSlNJLLktSLZCIPhEOd8Dn8okLgjJGRPK
 c5W2q4pDhsr1nyDLw1FpG/uJf9RnH1vQV8SHpoRPyqU0jbaDye5m19RRPTuJToBRWlkvKRctg
 /nTfKhAzc7yhQRi/Dv/2xsROt5jrc+yS0GD9nAOXdvPD/b/Fj+xfws8pgW6YcwGwWxiWp22Z7
 8iDv22ZLKZ1MpDuWRURZHzaYbsGxL9pnKuDv8lfcmraMPtzi3eYVfT9EsUaRsbi566VB6eoik
 4z70Dv/0A44Ck2Maekj37FF392e71LTo1mUkBP4r7am1e28VqxoDHuyUEr8SUJW+Q/MeCY6M7
 yO8veOpwcGSRQKQ13ncNANZQODtbbmlwZHZA/J5m8c3nHQBLQTl1VLa2n38HA7xJhsB6QyMmg
 QwSOoSOOqKudQXYTzVy1yZ9iZZu9U7jJwCLDS/+DbBu+/2m5BYlo71hzbSARWKwfkqRxZjxy+
 /6sQIJJRjckdgA+TWn5Kpa367eYss8WtY1eSsmjceyRjLl5gFt0jB06sEDDn+178YfmmEizzi
 IJ9goDMhvWIb440FKP7arUo5j/y2T1ARu2JeZ6PWBKK3b0NefZuoQ0+7QEY7XiC3fqjph2+AK
 OcPcyRMzEgiaMHvHGPUMXjlQ3gyaiktisI70J/nQ7MIU0379sz+od4+NVF8mS4O8Yiu4oHuai
 CAA0wO/LqUIUhr09QGkKwWppWt+KUszCL8zC6ietLO0n6FJOKbMTRQhgIxjovM0vlTcJZ312C
 mFZxKbgzDRK9d4J+JuTB+MdRbqWOl3ZdCqWpKOgzudQAXQcwoIgVIplauf44bFhx5u+CxAXmW
 kjq7+1YI3bCavKWl9gKTgEMInLkFUVpqu6Pug4oFsbXcbMOABFyjS9LmeQDS4BMB4zjriSrQN
 mCg1dyB5/WulfHtGMljaPg0uK79pKmkTkmObi55C82DcchViYjf1mPRGfaBA+a+nv/fQa8H12
 fQ5RHuWvMfyEow=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee & Emily,

On Thu, 27 Jan 2022, Derrick Stolee wrote:

> On 1/26/2022 3:41 AM, Johannes Schindelin via GitGitGadget wrote:
> > Over the course of the years, we developed a sub-command that gathers
> > diagnostic data into a .zip file that can then be attached to bug repo=
rts.
> > This sub-command turned out to be very useful in helping Scalar develo=
pers
> > identify and fix issues.
>
> For historical context: The 'diagnose' command was implemented in VFS fo=
r
> Git and ported to the C# version of Scalar before 'git bugreport' existe=
d,
> but they serve very similar purposes.
>
> I wonder if 'scalar diagnose' could include some of the information
> captured by 'git bugreport' or whether this implementation of 'diagnose'
> could help inform 'git bugreport' in any way.

Indeed, I think that the `bugreport` command could easily benefit from at
least the number of pack files and loose objects.

Ciao,
Dscho

>
> CC'ing Emily for thoughts.
>
> Thanks,
> -Stolee
>
