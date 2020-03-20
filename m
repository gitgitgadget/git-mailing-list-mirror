Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45446C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E292070A
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IoIIOWeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgCTPgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:36:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:36891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgCTPgG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 11:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584718559;
        bh=gMcDqKmCBq57Acwktv89Z+IA+oE+jRqt8c8acSwdFzM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IoIIOWeoAsO5RANcNEPLPhezJdzKzHT605nWdZWQkGn/aRw28LZjBbPeudLTn0tvj
         DT/i1P6VmxFrw6feomEMahIM+mqau4KCWpGxCPEcQcXxFQmnnwdgULkCsqibnyah5L
         ipjB+G8ZvT1B4B03sdx+7eKgPAtUm5VR+Dcqy2Q8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.214.160]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MxUnz-1jUoIY2D73-00xvi0; Fri, 20 Mar 2020 16:35:59 +0100
Date:   Fri, 20 Mar 2020 16:35:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
In-Reply-To: <xmqqd097dg4k.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003201633560.46@tvgsbejvaqbjf.bet>
References: <20200302230400.107428-1-emilyshaffer@google.com> <20200302230400.107428-3-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet> <20200319213902.GB45325@google.com> <xmqqd097dg4k.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:O5nUMJpX13n8DGGcyF8YGm1ziav0knFcxhFsrQ4YS1o+UVmEFjn
 P+9u2DhUch7VhkrJNu3JEdWFKI8bWQVcsR2oRYgo180uGhmCEZKXTy021iXycAOs6zE/l3Q
 5gObUAofvJHUdZbucsNF178OZ93r195fYeHtnJhTaBCrHPTttQANylcw3tAUQFhfKuGetU5
 2lZch9kvup4uSrQUM2g0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/nhB9QUB2u0=:V9b6BV3g/5sEWofjzel8dG
 GTYCMYNBSa5IDJK6EfoKFNWVO0YWAFJGLki41ffmWlxzSe2CQ4Is8PX0rUXPiqxKTAqEDjO+z
 BRY1wRrduvvkF0bZzXkI67rpERvYePAWSI2sax6yXa0TJhgSc43gc0o+9dibaisyPT4YTXqa0
 5S3B3XoKeH9c8n5qzeG1kNtegmcGAU51SruRj3RqeWWMT34HM2R41/g0J1giwaeU6EZLJeLT+
 vVarZq6H69vPTpInmLiBLujIFnc3hMi9JhtDLISnCyRfxDu+QEvP4PaJ9jFwynp+ZrS74ImSB
 u+Ju/tvScwV+j9GwckWwgk1gQipkxSrr0zVcjvIqrssO2T9pePRSDAhr3A/Rftjy4P/Env6WF
 iu1TmuIA2XroeLagZb8374tj5hkWHAW+PO0ErQNh9jZQMG9JpE9EUpnPZBbocOWV8mDQVz4vD
 0bHalTsnMi/uWA3EumWuSbgxK6nd/2u4sDCuIGnna863SfvgzU3XAyoj92UtF2TKxRoFQ4RTY
 V4S6wIar4Ob084CPprR27WcMJ2UCXYR2965I+2YCwZVcFIHfFeXSoNcRjelQiIofA2PIBn/cH
 vQx+nXanlWAuYlZgbz5jd9I6yyyHWpHlRInUUZvlExu8/v/RATgIUgB3G4OMJ69p17ptWQe/H
 9i2Cy0HM46xAsf40NZmt4fBHIKvLu39ijB1bFikzBhicIqiUnoSNK0WTTfMu9eMNDIQskhXup
 zy8p5GqRReeQ4OKzYk4HkUP+scDMsE8TowZ+L/fK2f/N1XmZb8iUJjedILvhN6bQQcvynB71S
 ZWx4ZF1vA25yRfEhkT3cyNFXG7tD8VNHKmoOQoZHmSRa9lunOrGJhrxlTtqD3lmfl+wxDFN90
 BuENiF0DI+36OXZt63H9PexbqFymFuP9OAWwWWxlmrE2g97nJyVROdO/YOafdTICyHzCOgGr9
 afLT8jP1WQcreaIeFqdy3fB6d79Ufm2A9Y1tIuiGvkI506l4z/nrfaiuqpDeMrOrcdZcPEEmO
 N3+VP1lfe5jzAv3Rms/efQYNXsMrmq4RFxQNFBxNwIMjqBBKE21V25os0/pHL6gz2ons8Z0CJ
 EAI6r0z8s7Wild9mT6+0Uq+0Wr6MzMRxBEL+yINki4TAv2Saupu3X7d8EKsayLIZL7htZectx
 DQbBRL3c2dqx+aup7fEwXVCPghu1Tghb6FCHkrgdMI4tWciK6ScjfwuyH6lqXdO2RDwVhKwlg
 QLnQ56uNqfTkAmySw
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 19 Mar 2020, Junio C Hamano wrote:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > Builtin:
> > + Don't have to call out-of-process to identify 'git version --build-o=
ptions'
> > + Better assurance that we aren't shipping a broken bugreport alongsid=
e a new
> >   version
> > - Binary bloat, possible startup time hit
> > ? Libraries will behave identically to where the user is seeing issues
> >   (This point is a possible pro but also a possible con; see similar p=
oint in
> >   standalone list)
>
>  - Makes it hard to pull in libraries that "bugreport" alone will
>    want to use in the future without negatively impacting the rest
>    of Git.

And of course we should never do that, lest `git bugreport` won't even
load because of it while `git` would.

So even in the purely speculative scenario that we _wanted_ to add more
libraries (which we don't, why should we?), we wouldn't actually do it.

> >  - Time to editor for 'git bugreport' with the same setup as previous
>
> This is something we absolutely should totally ignore.  Even if the
> bulitin version takes 1 sec to spawn an editor while a standalone
> one took only 0.1 sec, if other criteria you listed that are more
> important favours the builtin solution, we should pick it.
>
> In any case, I think we've wasted enough time on this.  Let's see a
> minimum working version that won't break/affect the rest of Git and
> ship it standalone.

I still disagree with that, but it seems that no amount of arguments will
convince Junio, and he's dead set on the standalone version.
