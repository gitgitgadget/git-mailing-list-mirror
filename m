Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB013211B5
	for <e@80x24.org>; Wed,  9 Jan 2019 22:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfAIW1i (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 17:27:38 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39340 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAIW1i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 17:27:38 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so8622458edt.6
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 14:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FndS91tq90stP9O1UEOaOvoWUNCLLXIOJRwldVKS8/g=;
        b=OX1bMFIRi4Y96N4q0QZ2qpnKApYJod7IWWQsDMueFFUU8AUJIU905+IJrLP9p+RTfI
         JV5h4bRGcrlvQdHkfdYRoi00kwPEJBFrNf6SBdn+RCIKYozbt3kJe+8XhGcqPWSIcWK1
         c2/V58/UV9MnBkaC826SpRzrExZToxRiOYIjT8hm/2/pZLoGUcI3BkC/z4ISWeKxv0Ew
         5bwWOHQkvbsvzeXeMkBU0pC3rJa1MyBp8BRRVTSwbSS3yBe6GPVZWQhMfUueJhBRNJf9
         Ei7SNggeHrQtfPVQVm9cg0ieWscn80yvkQ2SB3XvoLZksdJC9Fz2i+KjA80mCQoFWMWG
         eOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FndS91tq90stP9O1UEOaOvoWUNCLLXIOJRwldVKS8/g=;
        b=JvKIj8YGcH7LvP1ePbPeS88MGIpV7keyqZWGCan3gAN2AvkuvyPoFW4YqrX8KGhhp+
         q7Cxd51v2yAphQhf/6Gvo2IKYH/A/AjkHTx6um62a/or35AiZfOJFfThhtjIU7Lb8fOQ
         EPunRdyBeHPFnW+QCMagdtaGl2z5kE7AdPx31mF6sw+XS9TKtI8vrcDN7lgTIpmmqpUF
         l/EjHwNj7NnTLXtDp2moQq1soEVrWcO/I2O6A8yK2NOoF/OvDV6eEzJMaps+5LM9AX3Y
         avuX6gmNHk0tWtGr5YANR+0tZLkaDZIhsYDMLZKjK6KK8k7WvXbMymrFR4t8SULKvc1T
         84sQ==
X-Gm-Message-State: AJcUukfP+U+d+SA8PxLS1MAke59AozZa/oX2B+ScIrnw7Txeed2dulXv
        W26tS97+B1qapcIu4A4jJ/3x+sZH/gUqYC3VphOd/PVSYb780A==
X-Google-Smtp-Source: ALg8bN4trEC2ZlAB+5zzEKadcECPLv0+n52n48mR6imbIHXBJLpEn7/2Ysoo3hoIvhV6SCCUsV95rtuAQpsuT++uDhg=
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr7397094edy.231.1547072856355;
 Wed, 09 Jan 2019 14:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20181229034342.11543-1-e@80x24.org> <20181229035621.cwjpknctq3rjnlhs@dcvr>
 <20181229043858.GA28509@pure.paranoia.local>
In-Reply-To: <20181229043858.GA28509@pure.paranoia.local>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Jan 2019 14:27:25 -0800
Message-ID: <CAGZ79kb9Tbnxe1mSnxpqT_FO6Gdi6wxd-r2YarHXRF1sVRyxLA@mail.gmail.com>
Subject: Re: "IMAP IDLE"-like long-polling "git fetch"
To:     Eric Wong <e@80x24.org>, git <git@vger.kernel.org>,
        meta@public-inbox.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 28, 2018 at 8:39 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Sat, Dec 29, 2018 at 03:56:21AM +0000, Eric Wong wrote:
> > Hey all, I just added this to the TODO file for public-inbox[1] but
> > obviously it's intended for git.git (meta@public-inbox cc-ed):
> >
> > > +* Contribute something like IMAP IDLE for "git fetch".
> > > +  Inboxes (and any git repos) can be kept up-to-date without
> > > +  relying on polling.
> >
> > I would've thought somebody had done this by now, but I guess
> > it's dependent on a bunch of things (TLS layer nowadays, maybe
> > HTTP/2), so git-daemon support alone wouldn't cut it...
>
> Polling is not all bad, especially for large repository collections.

I disagree with that statement.

IIRC, More than half the bandwidth of Googles git servers are used
for ls-remote calls (i.e. polling a lot of repos, most of them did *not*
change, by build bots which are really eager to try again after a minute).

That is why we use a superproject, with all other repositories as
a submodule for polling, as that would slash the ls-remote traffic
approximately by the number of repositories.

There was an attempt in JGit to support this type of communication
of long polling at
https://git.eclipse.org/r/plugins/gitiles/jgit/jgit/+/2adc572628f9382ace5fbd791325dc64f7c968d3
but not a whole lot is left over in JGit as it was refactored at least
once again.

IIRC the issues where in the lack of protocol definition that made it
usable for a wider audience.
