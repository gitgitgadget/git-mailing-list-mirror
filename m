Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C001F453
	for <e@80x24.org>; Fri,  2 Nov 2018 19:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbeKCEJM (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 00:09:12 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:37267 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbeKCEJM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 00:09:12 -0400
Received: by mail-ed1-f48.google.com with SMTP id u12-v6so2633184eds.4
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YdXTT8KN4FXPjRNREeGOQ7EMAwd6EaS9IJxTMEFdRVU=;
        b=tYhv41jGyyG4/6nhwjvpXTaap3ieJYaL905E0GmWSjH5Dl6owhbNw02RCiWZOLdvK6
         /qGeihdKFku1qyCRopTyOTiijPj2Ytdfa7L1BmIrqJ987hMwpMEBmz2yURvNl6XTvmGK
         g9lsXSgsDIK/uuo6TQsclnGvZ4Qk6ID6xUrOV37gLm29fCY+Rv2gefOYo2Zil26n0gNd
         OMU/onyfkk8+4jmjnzd7X3BmBNLZAtnU3Yclw+xdf1NJL/TYALRrHdt6zoqPeDe7kwTK
         o6R7calKN6eP8RjlxRsd8n2Db66rAHb8XEF2DhwJ83roxUwfwaBi3NzzJvqAGc87udX2
         9tdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YdXTT8KN4FXPjRNREeGOQ7EMAwd6EaS9IJxTMEFdRVU=;
        b=HvOIsiNAt4kCnKBRIGYOmmYQw3m10yfsx79sv9N5ZsuLZpkbg6i0dkBP1fJxotcBU+
         MilTP8dLOSlfNu61nY4zHo63R4jQKi6L0xSWdXtKHN9XEKzIeoCR4ijLNrlJLMSyPMla
         nBFtACQWI1s3F3lR1pkuiB7X7K/Xcn74CPLhbpoqoEKQM1RlYKEa7MzeibH5+k/6zSaA
         JDS3qeHIcjIi2iPAbAvVFm/LYKdwHn8reXrVtR4RicvHn90MSBPUTWlfgnYAjY4vlRSk
         fK9ayXulhmRsBBFOrE3zTwDdbjpnJYE5Yn9Mgh06fPsTIzYKqoY4+PbFD6b5i+WSuNTV
         9FAw==
X-Gm-Message-State: AGRZ1gLNaDt6bydVTokQUqHt8/dBBYKUfJeMjNww5ujM96w+uGabw1Sl
        K63JWr/Q+JIAY9viPb2yYWCDoMtoRv7eJuV69eouHQ==
X-Google-Smtp-Source: AJdET5frxu+Vz1sCxCzvLk6cebhlp9HWPTG89TvSNUE7jO9+yQCWE3vqmmR6HRrMyn8zkAGtW5gYs6fKhuv/FYvgtR8=
X-Received: by 2002:a50:bc12:: with SMTP id j18-v6mr9709892edh.154.1541185253120;
 Fri, 02 Nov 2018 12:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8AVfkWsAP_-CNd5RSbQ=tyCzdw-ix1k5zwmAKaj+z1qXw@mail.gmail.com>
 <CAGZ79kbk0QdxTNWusieU=3DzTvxykmh-yTgNArTcM9USc5WWRw@mail.gmail.com> <CACsJy8AZ=re0wAabHbRV0R7s-CUMJR8G6aeMx9cb++RvGY59Vg@mail.gmail.com>
In-Reply-To: <CACsJy8AZ=re0wAabHbRV0R7s-CUMJR8G6aeMx9cb++RvGY59Vg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Nov 2018 12:00:41 -0700
Message-ID: <CAGZ79kbrmec=SDYShkRN0Bz_zuBJnbw7+obxMCezjEFW==OUJQ@mail.gmail.com>
Subject: Re: submodule support in git-bundle
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > This offloading-to-CDN (or "mostly resumable clone" in the
> > sense that the communication with the server is minimal, and
> > you get most of your data via resumable http range-requests)
> > sounds like complete offtopic, but is one of the requirements
> > for the repo to submodule migration, hence I came to speak of it.
>
> Hm.. so what you're saying is, we could have a pack file that lists
> other (real) pack files and for the bundle case they are all in the
> same file. And "download from $THERE" in this case is "download at
> this file offset"? That might actually work.

We're conflating 2 things here.
This idea of CDN offloading has nothing to do with submodules, it's
just a general thing to improve the fetch protocol.
And the pointed at file doesn't need to be a "real" packfile, as long
as the bytestream at the end looks like a real packfile. For example
the bytes to get from $THERE would not need to have a pack header
(or if it had, I would ask you to omit the first bytes containing the header)
as I can give the header myself.

The idea for submodules is more along the lines of having "just"
multiple pack files in the stream. For the bundle case we would
probably not have redirection to $THERE in there, as it should
be self contained completely (we don't know if the bundle recipient
can access $THERE in a timely manner).


> > Did you have other things in mind, on a higher level?
> > e.g. querying the bundle and creating submodule bundles
> > based off the superproject bundle? 'git bundle create' could
> > learn the --recurse-submodules option, which then produces
> > multiple bundle files without changing the file formats.
>
> This is probably the simplest way to support submodules.

Yep, that sounds simplest, but I think it makes for bad UX.
(Multiple files, need to be kept in some order and applied correctly)


> I just
> haven't really thought much about it (the problem just came up to me
> like 2 hours ago). Two problems with this are convenience (I don't
> want to handle multiple files) and submodule info (which pack should
> be unbundled on which submodule?). But I suppose if "git bundle"
> produces a tarball of these bundle files then you solve both.

The tarball makes it one file and would naturally provide some
order. It feels iffy, I'd rather have multiple packs in the bundle.

> But of course there may be other and better options like what you
> described above. If in long term we have "pack with hyperlinks" anyway
> for resumable clone and other fancy stuff then reusing the same
> mechanism for bundles makes sense, less maintenance burden.

I think of the hyperlinks in packs as an orthogonal feature, but closely
nearby in code and implementation, which is why I brought it up.
