Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20DC0211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 23:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeLFXQ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 18:16:29 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:39262 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeLFXQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 18:16:29 -0500
Received: by mail-io1-f74.google.com with SMTP id q23so1876298ior.6
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 15:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qm28vHGBwdAK90VLrmmzQlFzVmia2ajLHW9bBhYKy6E=;
        b=Q1hEyUEZo3nuqruQBtfHygz4tlv4Gqt4AH7KOU1+yM5sz3R5u5kHZ8AS9MPBrJyoOu
         HFBkkNmSlspCaP+FtUN5cmSDbCASIy1xy3snrJHWvNyavn86S3soKtiBmw2rAoSxxvQF
         Vc6lfKRzbleZ1GFh37MY+fGicXvy7opBkaFmC/ZrpujCAqzHqsaek59BMNqfN8d62pFB
         7bxO1jdhrtLV9t1eEw73wEUu6PxC7FiepjOG0DryTOA8odFBW5cExDkL6/TVx88Kocst
         u0NCFf/vtF6scI9lJO+gmByt+ieKajnhoOTVfAq8JrZuXUV7B8oJxZuGmqf1YZdc4nko
         B5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qm28vHGBwdAK90VLrmmzQlFzVmia2ajLHW9bBhYKy6E=;
        b=lDo2npyQ/JQ5L232+Cp4xCO5IyqDu++zzuf2udGAkxBvo8RAEQ1p6QV+DUPXxlihH0
         2uKtvJ004BcVfDhEO6vc9FwrR0UuTNULycb8si8SeQwO1Fp6g6QwcVr05/7M4ZKuOs6V
         7k82dhFYiL2xFMppZw5z2Fmjw3H0v86dWE+tIj1X2dDQ7Mykwx1vu1MAV4ox51Yj6DKW
         mDC5+cSMHGLXwaHjU4r8AmnjC5gb4ILXZep/rYLQOeU+ecJSm7/hKv7LHt7MO+Wy4BEy
         YUBZW2cakoJ0XFKv6p0FICYIhgV0x7E+eGB5NZBj3i/g9m3AyY0T2o1lA9IUrl3IH25D
         hoWA==
X-Gm-Message-State: AA+aEWZFqtD362YZ2h24gnatPo/etgC28rYqpqSjAnB/Iw5MeJmE0ab9
        QImpVrchNd1LXt0Y386vsi9ixu72h8pLyU0yBmTA
X-Google-Smtp-Source: AFSGD/VeIYWu5t4tb4jajVkbQkBh3Y6jc7dm9/3a1H3XVSuKyAQjCnN217VqLuwMgjGWMlsTh97JLx8YZFmCzVi3HGb4
X-Received: by 2002:a24:fe42:: with SMTP id w63mr212414ith.13.1544138188687;
 Thu, 06 Dec 2018 15:16:28 -0800 (PST)
Date:   Thu,  6 Dec 2018 15:16:24 -0800
In-Reply-To: <xmqqbm60d0s1.fsf@gitster-ct.c.googlers.com>
Message-Id: <20181206231624.139000-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqbm60d0s1.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +This feature allows servers to serve part of their packfile response as URIs.
> > +This allows server designs that improve scalability in bandwidth and CPU usage
> > +(for example, by serving some data through a CDN), and (in the future) provides
> > +some measure of resumability to clients.
> 
> Without reading the remainder, this makes readers anticipate a few
> good things ;-)
> 
>  - "part of", so pre-generated constant material can be given from
>    CDN and then followed-up by "filling the gaps" small packfile,
>    perhaps?

Yes :-)

>  - The "part of" transmission may not bring the repository up to
>    date wrt to the "want" objects; would this feature involve "you
>    asked history up to these commits, but with this pack-uri, you'll
>    be getting history up to these (somewhat stale) commits"?

It could be, but not necessarily. In my current WIP implementation, for
example, pack URIs don't give you any commits at all (and thus, no
history) - only blobs. Quite a few people first think of the "stale
clone then top-up" case, though - I wonder if it would be a good idea to
give the blob example in this paragraph in order to put people in the
right frame of mind.

> > +If the client replies with the following arguments:
> > +
> > + * packfile-uris
> > + * thin-pack
> > + * ofs-delta
> 
> "with the following" meaning "with all of the following", or "with
> any of the following"?  Is there a reason why the server side must
> require that the client understands and is willing to accept a
> thin-pack when wanting to use packfile-uris?  The same question for
> the ofs-delta.

"All of the following", but from your later comments, we probably don't
need this section anyway.

> My recommendation is to drop the mention of "thin" and "ofs" from
> the above list, and also from the following paragraph.  The "it MAY
> send" will serve as a practical escape clause to allow a server/CDN
> implementation that *ALWAYS* prepares pregenerated material that can
> only be digested by clients that supports thin and ofs.  Such a server
> can send packfile-URIs only when all of the three are given by the
> client and be compliant.  And such an update to the proposed document
> would allow a more diskful server to prepare both thin and non-thin
> pregenerated packs and choose which one to give to the client depending
> on the capability.

That is true - we can just let the server decide. I'll update the patch
accordingly, and state that the URIs should point to packs with features
like thin-pack and ofs-delta only if the client has declared that it
supports them.

> > +Clients then should understand that the returned packfile could be incomplete,
> > +and that it needs to download all the given URIs before the fetch or clone is
> > +complete. Each URI should point to a Git packfile (which may be a thin pack and
> > +which may contain offset deltas).
> 
> weaken or remove the (parenthetical comment) in the last sentence,
> and replace the beginning of the section with something like
> 
> 	If the client replies with 'packfile-uris', when the server
> 	sends the packfile, it MAY send a `packfile-uris` section...
> 
> You may steal what I wrote in the above response to help the
> server-side folks to decide how to actually implement the "it MAY
> send a packfile-uris" part in the document.

OK, will do.

> OK, this comes back to what I alluded to at the beginning.  We could
> respond to a full-clone request by feeding a series of packfile-uris
> and some ref information, perhaps like this:
> 
> 	* Grab this packfile and update your remote-tracking refs
>           and tags to these values; you'd be as if you cloned the
>           project when it was at v1.0.
> 
> 	* When you are done with the above, grab this packfile and
>           update your remote-tracking refs and tags to these values;
>           you'd be as if you cloned the project when it was at v2.0.
> 
> 	* When you are done with the above, grab this packfile and
>           update your remote-tracking refs and tags to these values;
>           you'd be as if you cloned the project when it was at v3.0.
> 
> 	...
> 
> 	* When you are done with the above, here is the remaining
>           packdata to bring you fully up to date with your original
>           "want"s.
> 
> and before fully reading the proposal, I anticipated that it was
> what you were going to describe.  The major difference is "up to the
> packdata given to you so far, you'd be as if you fetched these" ref
> information, which would allow you to be interrupted and then simply
> resume, without having to remember the set of packfile-uris yet to
> be processed across a fetch/clone failure.  If you sucessfully fetch
> packfile for ..v1.0, you can update the remote-tracking refs to
> match as if you fetched back when that was the most recent state of
> the project, and then if you failed while transferring packfile for
> v1.0..v2.0, the resuming would just reissue "git fetch" internally.

The "up to" would work if we had the stale clone + periodic "upgrades"
arrangement you describe, but not when, for example, we just want to
separate large blobs out. If we were to insist on attaching ref
information to each packfile URI (or turn the packfiles into bundles),
it is true that we can have resumable fetch, although I haven't fully
thought out the implications of letting the user modify the repository
while a fetch is in progress. (What happens if the user wipes out their
object store in between fetching one packfile and the next, for
example?) That is why I only talked about resumable clone, not resumable
fetch.
