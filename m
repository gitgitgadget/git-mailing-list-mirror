Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8125FC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 13:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiBVNIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 08:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiBVNIg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 08:08:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DFB151D01
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 05:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645535285;
        bh=GtDKdxOgQO/4HPTJ5e1xe8r+wk/lDRkpfpZLRF1DJx8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TRzevMRNvO87Wsht+26X1xOMzsuaYADs9hlYDXZkdCdarQ2Nocp0nOL0qyLycRslZ
         wIpk9kS+vS1A8v5x+RI7waYotkJdZx05Ah7bze367lEsP7m4jxfl30kUoKLrZFtGUG
         7Hf/d8rBHWnxZDhRgil40uQHrhzuW47CKRa66ak0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DJv-1nNt0a0ug1-003awz; Tue, 22
 Feb 2022 14:08:05 +0100
Date:   Tue, 22 Feb 2022 14:08:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
In-Reply-To: <CABPp-BEQ5BBEgB21hUNBuioOfMry_x2nKOLgY8=v2w8eGXrsyw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221407150.11118@tvgsbejvaqbjf.bet>
References: <20220105163324.73369-1-chriscool@tuxfamily.org> <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com> <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com> <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet> <CABPp-BHJvFx0fxobYZ2vauK=KfCLF_7So8xABLjqr9rx4SVy-w@mail.gmail.com> <CABPp-BEQ5BBEgB21hUNBuioOfMry_x2nKOLgY8=v2w8eGXrsyw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HGW9k46/OTGMPTl3rGMnV9Mk+z+4e/uuuLxcXxhPcxX1hUbiJ7J
 FvcAFke08mYGBoRRvgSgrrjDFJ0SbsCfoH7HC9VmUhqpgb3+XSBWozaUQoZ6r7MlEJOTJqI
 Mzrvdo+LvgACyGdjq119KPqd0yU2Yb2S0bHyQNuaDtjmC5sUVCoSMFH1Mf1lJwV8SDbTbry
 b+tJx9WyFBGnJMmoFrmbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HORwhv1huIw=:FWOg0oQNkbayHQmmcUSs4F
 ThAVJSmLgodKa2ZciRg9FWXDFG928+xB7vkOlV+5UjneOSLkrUcIbtgttpCey9l/eam3dBxLI
 DRZoSMhPtB7a18hsfvxP5x5X/LBdnqtbsCWW9oL+bWZGnb+sz+2tnrgxI9ujatTw9mkKLTff6
 tUH6Pp21+olPWEVmH5vgLaD02Z2U3+tqFpuEW32F1W/n3HmLJv2pPoGKlihsICwBvm7e7AWsv
 VF3gvVe29Ya7T3PFV86XyoGkaIVfs7X4Dtv0XQDQZoLV3qrFGxHLat3DOFZgi5Su9sBh7J1W9
 B9A9Gb8523KVto6mXeO6MGeieuWzZl/H/cx0rBllRLhLmcP/UIPAHHtq2PNaBHE7Zvw3clniX
 7//WCxTL3ImZ1Ev1yqr9gb7dnMAvhqW0AK/wtcKkzAowtrsIgct/C/EVIXt6K1IeNBpngGNg1
 bdwaTq5hhWQvZgYYbcaUwUtOx5hM45jUMUKpzx1oTmDHZhdFpLm6UzTslD9Xd+ZjvRtE9YxOn
 zlNR4M+iTaWyrxuQLsk2CxaJ/tKP38Bjw9GhFuONq4+07DYIqWytPfzOrpbRzOiy3QA/O6uVp
 ArKysm+y9IMD5eMYuif614cwj86NCgL8Me4+uRFf6zFt6xMw6xY460w3SEgJvnWu2+rroXWcp
 wwKm90bVYhEHwbL1UkphMSuSWDoXj81363eAmAs81gO5YmtIjIEOLteVbj+4qvfi2zTSZU+Ad
 7f9wohpVLxw2YPEwG3mEdXR0rNLkiIKMpkIu8ect3GGyzhL3JQ4tqcyLC7i0175itACZrh+B5
 13j4GpNfYLYJ7agp1pCCoOes2nDUzu2NBEJpqugCpqbcJN2P6fqRp5mFeolDrOzbe6GZqC0ST
 V5w7g4vR0qf7q19vVLUdY55V7pKgsnr4PABVv/JsEk/Pe0DLqRiJGiWHgeSWMeR1JtoEN8TTK
 +i5I+I3vc3koZ8SJeXGpmyONStlFcaeDxTkHEBL/e4epOUVcE6jg0AFIg7kkPIS5KoxJgUKYd
 XmQFqnATEDWtwdJ8H3UZth2MPu4yjgbkPMOLcKLwd8L3ROYMeNv3inRTcruduD0MbI/EEXWM6
 ennYLKnSd+vetk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 11 Jan 2022, Elijah Newren wrote:

> On Mon, Jan 10, 2022 at 9:59 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Mon, Jan 10, 2022 at 5:49 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> ...
> > >, therefore it expects the resolved conflicts to
> > > be in _files_. I don't think that there is a way to reasonably handl=
e
> > > symlink target conflicts or directory/file/symlink conflicts, but th=
ere
> > > might be.
> >
> > You really need (mode,oid) pairs to be provided by the user.  That
> > fixes the executable issue I mentioned above, and makes it clear how
> > to handle symlinks and file/symlink conflicts.
> >
> > directory/file are still handled by providing individual files, but
> > ordering traversal becomes really tricky.  The directory/file case
> > might even require the pre_resolved_conflicts to be pulled out of that
> > loop somehow.  It'd take some investigative work, or some deep
> > thought, or both.
>
> I think I came up with a solution to this during my run yesterday,
> though I haven't tried or tested it.  Instead of modifying the loop
> over plist.items, you instead add a preliminary loop over
> pre_resolved_conflicts that modifies opt->priv->paths (and add this
> preliminary loop just before the items from opt->priv->paths are added
> to plist.items).  In that preliminary loop, you need to make sure that
> (a) any files in pre_resolved_conflicts corresponding to existing
> _files_ in opt->priv->path result in updating that item's clean &
> is_null & mode & oid state, (b) any files in pre_resolved_conflicts
> that correspond to existing _directories_ in opt->priv->path need the
> value to be expanded to be a conflict_info instead of just a
> merged_info, you need to set the df_conflict bit, and don't update the
> merge_info fields but do update the extended conflict_info ones, (c)
> any new files in pre_resolved_conflicts result in new entries
> opt->priv->paths, (d) any leading directories of new files in
> pre_resolved_conflicts are appropriately handled, meaning: (d1) new
> opt->priv->paths are created if the directory path wasn't in
> opt->priv->paths before, (d2) a tweak to df_conflict for the directory
> item if it previously existed in opt->priv->paths but only as a file
> (possibly also necessitating expanding from a merged_info to a
> conflict_info), (d3) no-op if the directory already existed in
> opt->priv->paths and was just a directory (and in this case, you can
> stop walking the parent directories to the toplevel).
>
> Then, after this preliminary loop that modifies opt->priv->paths, the
> rest can just proceed as-is.
>
> That should handle new files, new directories, and all directory/file
> conflicts.  Yeah, it's a bunch to look at, but directory/file
> conflicts are always a bear.

Indeed.

What's even worse is the question how to represent that in a web UI, and I
think I'll wait for that to happen (if ever) to give that part of the
design more thought.

Ciao,
Dscho
