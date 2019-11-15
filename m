Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311991F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKOBTw (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:19:52 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37751 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfKOBTw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:19:52 -0500
Received: by mail-il1-f196.google.com with SMTP id s5so7533873iln.4
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Frax1yXESC3KYwC8JinYCoGRGHWNVydVPZcatyWPD0=;
        b=sbRAb/Sci60rv1QS/NdGIQdZjYtg8cdwgjrqlr299akOa4ZGw9nAsYN7VeuPnjeQT4
         JuDD6ZnuCodS8SURFgS6VxxTtCYziLAGQfBXyxSWN5d2ETtD5E228VW3u2/PXGCYQPu2
         chlwGTsXYUctgxLjXJEnav4Wl+CMzWs4jzk33MfAxFBMT3j2WJNm1kMKpFYfruQVBx3e
         9J92OwIcVKFTNHdm3ZXx/bJ7zbP5aS5nJOhU6lSLpUE4857B3napg4YF+EFhIKWPKadC
         3V6Udfwex2vWrv4zibqVOA8kRY/qpaP6yh50vYGNRD2crvPCGHpruoQa3XG20Ag1lFkL
         MSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Frax1yXESC3KYwC8JinYCoGRGHWNVydVPZcatyWPD0=;
        b=JnSETE/XF9hHbNRRHlmzmTOfTgiMfCtVOjuaHN4wrip0k+7j2BBRbSPmGatUo4MNmj
         twQ2JmbpM0ATrd54IVo9nMn8tW21S/f46juyJqTmiWyx1IRWWaj5mlO2TvtEif/bqXkO
         Uh1+G9J3iqrcOTVyXSAIORtcHatUOGyWWE6kc8Ebtp0risP7OcOCr8qJi6mwc2J5O3qP
         NOyUvIcrpVY2ZDxCdT7Qk0/fkKktbtuIUIkSbAPNI6Fzs83ITfnogs2k5nmZZYDZ1Kqh
         8YRb2bsgQ1DYkrlnw/O3+gF+uq8Si/bb0RyfPNSETa/ds/jnRbtbuSUAxVhTXndlQl8U
         +h3g==
X-Gm-Message-State: APjAAAXUoKa2ctK9NVxyolzHD7eSQccz8MLdx/6EwGnRTRY/pqtkt8hk
        2hy92nir9oOVEtGjecbFZLviJAoPIQk4r/2YvncBUwSj
X-Google-Smtp-Source: APXvYqzlTXaoOe++G3ySqL2cG3EuMzC/WRJMBKcyilUAVwhMIlEis/+rt9X7qA+PH+H1fedmMd8jgRjD6BKXAvHlyxE=
X-Received: by 2002:a02:878b:: with SMTP id t11mr837637jai.20.1573780790662;
 Thu, 14 Nov 2019 17:19:50 -0800 (PST)
MIME-Version: 1.0
References: <CAGyf7-EXOUWYUZXmww2+NyD1OuWEG18n221MPojVSCCu=19JNA@mail.gmail.com>
 <20191114055906.GA10643@sigill.intra.peff.net>
In-Reply-To: <20191114055906.GA10643@sigill.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 14 Nov 2019 17:19:39 -0800
Message-ID: <CAGyf7-GTWsQEYH9mkM8TkY1PusMimtYcSaKhHubN_KsOtMRiBA@mail.gmail.com>
Subject: Re: rev-list and "ambiguous" IDs
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 13, 2019 at 9:59 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Nov 13, 2019 at 08:35:47PM -0800, Bryan Turner wrote:
>
> > When using a command like `git rev-list dc41e --`, it's possible to
> > get output like this: (from newer Git versions)
> > error: short SHA1 dc41e is ambiguous
> > hint: The candidates are:
> > hint:   dc41eeb01ba commit 2012-11-23 - Stuff from the commit message
> > hint:   dc41e0d508b tree
> > hint:   dc41e5bef41 tree
> > hint:   dc41e11ee18 blob
> > fatal: bad revision 'dc41e'
> >
> > Is there any way to ask rev-list to be a little...pickier about what
> > it considers a candidate? Almost without question the two trees and
> > the blob aren't what I'm asking for, which means there's actually only
> > one real candidate.
>
> Try "dc41e^{commit}", which will realize that trees and blobs cannot
> peel to a commit (there would still be an ambiguity with a tag).

Slick!

>
> I think one could argue that without "--objects" in play, rev-list
> should automatically disambiguate in favor of a committish. But that's
> not true for every command.
>
> You can also set core.disambiguate to "committish" (or even "commit").
> At the time we added that option (and started reporting the list of
> candidates), we pondered whether it might make sense to make that the
> default. That would probably help in a lot of cases, but the argument
> against it is that when it goes wrong, it may be quite confusing (so
> we're better off with the current message, which punts back to the
> user).

Having no disambiguation by default seems fine. Both of the approaches
here seem easy enough to activate explicitly in cases where the caller
(in this case Bitbucket Server; more on that later) knows they're
looking for a commit.

>
> I think it also comes up fairly rarely these days, as short sha1s we
> print have some headroom built in (as you can see above; the one you've
> input is really quite short compared to anything Git would have printed
> in that repo).

Just to provide a little context, this isn't coming up as something I
myself hit. Rather, it's a fairly common issue reported by Bitbucket
Server end users, and I would assume it happens with other hosting
providers as well: A user URL-hacks an ambiguous (or "ambiguous", in
cases like this) short hash and is disappointed when the system
doesn't manage to find the commit they were looking for. I'm just
investigating possible avenues for improving how Bitbucket Server
handles these cases. One option is to (essentially) parse the "hint",
if it's present, to get the candidates, and include them on the error
message we display. But in cases like the above it gets weird because
there's only one _commit_ candidate, and having our error message
include trees and blobs seems likely to be confusing/unexpected. I
suspect most Bitbucket Server users would say "The answer's obvious!
Why didn't you just use the commit?!", and I can sort of get behind
that view. The combination of using the disambiguation mechanism, so
single-commit ambiguities are resolved automatically, and parsing the
hint seems like it would produce the most logical behavior.

Where users get the short hashes they try is an interesting question.
As you say, Git wouldn't display a 5 character short hash, at least by
default, and Bitbucket Server doesn't either; it shows a flat 11
characters. I'm not sure, on that point.

Thanks for your insights! Learned a new Git trick today.

Best regards,
Bryan Turner



>
> > Also, while considering this, I noticed that `git rev-list
> > dc41e11ee18` (the blob from the output above) doesn't fail. It
> > silently exits, nothing written to stdout or stderr, with 0 status. A
> > little surprising; I would have expected rev-list to complain that
> > dc41e11ee18 isn't a valid commit-ish value.
>
> Yeah, this is a separate issue. If the revision machinery has pending
> trees or blobs but isn't asked to show them via "--objects", then it
> just ignores them.
>
> I've been running with the patch below for several years; it just adds a
> warning when we ignore such an object. I've been tempted to send it for
> inclusion, but it has some rough edges:
>
>   - there are some fast-export calls in the test scripts that trigger
>     this. I don't remember the details, and what the fix would look
>     like.
>
>   - it makes wildcards like "rev-list --all" complain, because they may
>     add a tag-of-blob, for example (in git.git, junio-gpg-pub triggers
>     this). Things like "--all" would probably need to get smarter, and
>     avoid adding non-commits in the first place (when --objects is not
>     in use, of course)
>
> ---
>  revision.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 0e39b2b8a5..7dc2d9a822 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -393,6 +393,16 @@ void add_pending_oid(struct rev_info *revs, const char *name,
>         add_pending_object(revs, object, name);
>  }
>
> +static void warn_ignored_object(struct object *object, const char *name)
> +{
> +       if (object->flags & UNINTERESTING)
> +               return;
> +
> +       warning(_("ignoring %s object in traversal: %s"),
> +               type_name(object->type),
> +               (name && *name) ? name : oid_to_hex(&object->oid));
> +}
> +
>  static struct commit *handle_commit(struct rev_info *revs,
>                                     struct object_array_entry *entry)
>  {
> @@ -458,8 +468,10 @@ static struct commit *handle_commit(struct rev_info *revs,
>          */
>         if (object->type == OBJ_TREE) {
>                 struct tree *tree = (struct tree *)object;
> -               if (!revs->tree_objects)
> +               if (!revs->tree_objects) {
> +                       warn_ignored_object(object, name);
>                         return NULL;
> +               }
>                 if (flags & UNINTERESTING) {
>                         mark_tree_contents_uninteresting(revs->repo, tree);
>                         return NULL;
> @@ -472,8 +484,10 @@ static struct commit *handle_commit(struct rev_info *revs,
>          * Blob object? You know the drill by now..
>          */
>         if (object->type == OBJ_BLOB) {
> -               if (!revs->blob_objects)
> +               if (!revs->blob_objects) {
> +                       warn_ignored_object(object, name);
>                         return NULL;
> +               }
>                 if (flags & UNINTERESTING)
>                         return NULL;
>                 add_pending_object_with_path(revs, object, name, mode, path);
> --
> 2.24.0.739.gb5632e4929
>
