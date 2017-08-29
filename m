Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB57E20285
	for <e@80x24.org>; Tue, 29 Aug 2017 09:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbdH2JhK (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 05:37:10 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33544 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbdH2JhH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 05:37:07 -0400
Received: by mail-io0-f179.google.com with SMTP id s101so15942572ioe.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 02:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FU0H5FwpgVfNuJzWgGvjPWvGDsq+VVgu8ioS1WEVjSU=;
        b=KJkBjtC3c46+WC0IW4rv2j5Y9wQdwhfsc+wjkJnPwAuEZKzQfoFfeITovKXEWKopvG
         kdCVSjxm2kYYUD0BlgIhVdIHgUu4bqny5oCYBSUSln188on7mwKbXEuZ9NHXy3P0NFYK
         aWzufvGZtJjDoJrWyMFdgWr+XPErRYK6Qe6eP1Mkmoi708NI1l0tfw1fLGXHzvkFWe7J
         c8xRJViFhAl6nHqZr2z1Tp+Al+Y9ixku7uWhuA4Mh/k9hAJD6qYgeikyUctvStrUEipt
         XqpfzM93vkRbwXxwK9aVHXXmL90XPnDPWJxIMYp7UsGBHSIJ6FB29XxZJmNelB6xc+z3
         IWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FU0H5FwpgVfNuJzWgGvjPWvGDsq+VVgu8ioS1WEVjSU=;
        b=lO4FpWBkHxs5FleOUI2mUsXwGEvw36vhFbUe+6V92c4YNbjq+lWjrXJheAnaSRtwg5
         8AEqjVISFKIQj+I8VfIAddUmauNL/esX2s/1pbwnbbNB773vsjaMCdhJKPel1GpHmMw3
         7CWMhr9+4rnXqmLHjlgbFHJvSO5CnHkdN6m3ITLjNQfZPUCVkcPE8MGhzSw3Jk/JcvG4
         jv2tDFoUMIRKQMJUWCYfdk/McqZLiRbxmH0KGcpTjK7JvCwI59slGi44Ksl/eLMECM5y
         1AGbTZNQJUdBn1FdzMwn9agf2rGtQdFYxuShVXi7ZPhltvCBVlu27jVG/TneITvglY/o
         JBhg==
X-Gm-Message-State: AHYfb5gf5HNqjCKBO+tivFpim+aruPYRn8s1RPJpEe1F3GiOUuuBH2Kr
        fDnAv/F45xPZ/5YQgyMgS9AFtIm62w==
X-Received: by 10.36.124.138 with SMTP id a132mr1360323itd.29.1503999426118;
 Tue, 29 Aug 2017 02:37:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.115.202 with HTTP; Tue, 29 Aug 2017 02:37:05 -0700 (PDT)
In-Reply-To: <20170825142300.01b15d6b@twelve2.svl.corp.google.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-36-chriscool@tuxfamily.org> <CAGZ79kYhUJ5mmTEO3b9G7M6onuCusBUTSsD7KeCmeMpfaOvroQ@mail.gmail.com>
 <CAP8UFD1oONnj93UKf=nBzgOQtY2E+ZVvoLGDNGLsZVobfiN90Q@mail.gmail.com> <20170825142300.01b15d6b@twelve2.svl.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 29 Aug 2017 11:37:05 +0200
Message-ID: <CAP8UFD1J_kDL928J2YV_Me3JtymXWfrs2N98hsR7eSYbyU=-Qw@mail.gmail.com>
Subject: Re: [PATCH v5 35/40] Add Documentation/technical/external-odb.txt
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 11:23 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Fri, 25 Aug 2017 08:14:08 +0200
> Christian Couder <christian.couder@gmail.com> wrote:
>
>> As Git is used by more and more by people having different needs, I
>> think it is not realistic to expect that we can optimize its object
>> storage for all these different needs. So a better strategy is to just
>> let them store objects in external stores.
> [snip]
>> About these many use cases, I gave the "really big binary files"
>> example which is why Git LFS exists (and which GitLab is interested in
>> better solving), and the "really big number of files that are fetched
>> only as needed" example which Microsoft is interested in solving. I
>> could also imagine that some people have both big text files and big
>> binary files in which case the "core.bigfilethreshold" might not work
>> well, or that some people already have blobs in some different stores
>> (like HTTP servers, Docker registries, artifact stores, ...) and want
>> to fetch them from there as much as possible.
>
> Thanks for explaining the use cases - this makes sense, especially the
> last one which motivates the different modes for the "get" command
> (return raw bytes vs populating the Git repository with loose/packed
> objects).

Thanks for this comment. Now the beginning of the "Purpose" section
looks like this:

--------
The purpose of this mechanism is to make possible to handle Git
objects, especially blobs, in much more flexible ways.

Currently Git can store its objects only in the form of loose objects
in separate files or packed objects in a pack file. These existing
object stores cannot be easily optimized for many different kind of
contents.

So the current stores are not flexible enough for some important use
cases like handling really big binary files or handling a really big
number of files that are fetched only as needed. And it is not
realistic to expect that Git could fully natively handle many of such
use cases. Git would need to natively implement different internal
stores which would be a huge burden and which could lead to
re-implement things like HTTP servers, Docker registries or artifact
stores that already exist outside Git.
--------

>> And then letting people
>> use different stores can make clones or fetches restartable which
>> would solve another problem people have long been complaining about...
>
> This is unrelated to the rest of my e-mail, but out of curiosity, how
> would a different store make clones or fetches restartable? Do you mean
> that Git would invoke a "fetch" command through the ODB protocol instead
> of using its own native protocol?

Yeah, the idea is that during a clone (or a fetch), Git could first
fetch some refs with "meta information", for example refs/odb/magic/*
(where "magic" is the odb name) which would tell if some (new) bundles
are available.
If there are (new) bundles available then during the 'init'
instruction, which takes place just after this first fetch, the
external odb helper will notice that and "fetch" the (new) bundles
using a restartable protocol, for example HTTP.

If something goes wrong when the helper "fetches" a bundle, the helper
could force the clone (or the fetch) to error out (after maybe
retrying), and when the user (or the helper itself) tries again to
clone (or fetch), the helper would restart its bundle "fetch" (using
the restartable protocol).

When this "fetch" eventually succeeds, then the helper will unbundle
what it received, and then give back control to the second regular
part of the clone (or fetch). This regular part of the clone (or
fetch) will then try to fetch the usual refs, but as the unbundling
has already updated the content of the usual refs (as well as the
object stores) this fetch will find that everything is up-to-date.

Ok, maybe everything is not quite up-to-date and there are still
things to fetch, but anyway the biggest part of the clone (or fetch)
has already been made using a restartable protocol, so we are doing
much better than if we are not restartable at all.

There are examples in t0430 at the end of the patch series of
restartable clones. They don't really test that one can indeed restart
a clone, but they show that things "just work" when `git clone` is
split into an initial fetch (that updates "meta information" refs),
then the 'init' instruction sent to an helper (that fetches and
unbundles a bundle based on the "meta information" refs) and then the
regular part of the clone.

>> >> +Furthermore many improvements that are dependent on specific setups
>> >> +could be implemented in the way Git objects are managed if it was
>> >> +possible to customize how the Git objects are handled. For example a
>> >> +restartable clone using the bundle mechanism has often been requested,
>> >> +but implementing that would go against the current strict rules under
>> >> +which the Git objects are currently handled.
>> >
>> > So in this example, you would use todays git-clone to obtain a small version
>> > of the repo and then obtain other objects later?
>>
>> The problem with explaining how it would work is that the
>> --initial-refspec option is added to git clone later in the patch
>> series. And there could be changes in the later part of the patch
>> series. So I don't want to promise or explain too much here.
>> But maybe I could add another patch to better explain that at the end
>> of the series.
>
> Such an explanation, in whatever form (patch or e-mail) would be great,
> because I'm not sure of the interaction between fetches and the
> connectivity check.

Ok, I will add parts of the above explanations to a documentation
patch at the end of the patch series.

> The approach I have taken in my own patches [1] is to (1) declare that
> if a lazy remote supplies an object, it promises to have everything
> referred to by that object, and (2) we thus only need to check the
> objects not from the lazy remote. Translated to the ODB world, (1) is
> possible in the Microsoft case and is trivial in all the cases where the
> ODB provides only blobs (since blobs don't refer to any other object),
> and for (2), a "list" command should suffice.

Ok, the "list" command is a command that any lazy remote should
implement so that other repos can ask it which are all the objects it
has, right?

> One constraint is that we do not want to obtain (from the remote) or
> store a separate list of what it has, to avoid the overhead.

So the answer to the "list" command should be part of the answer which
sends all the objects.

> (I saw the
> --initial-refspec approach - that would not work if we want to avoid the
> overhead.)

The --initial-refspec approach is interesting if you want to fetch a
big number of objects or many big objects, like when you do an initial
clone of a big repo. In this use case a relatively small amount of
time spent in the initial fetch is an acceptable trade-off if the
clone or the fetch is restartable.

Also as the --initial-refspec clone or fetch could alleviate resource
usage of the server, it could be even faster than a regular clone or
fetch in this case.

I don't think the --initial-refspec option should be used all the time
when an external odb is configured. But using an external odb in the
first place means that you have specific requirements which suggests
that the regular way to clone (or fetch or push) might not be very
good for your use cases and for the objects that are stored in the
external ODB.

When you don't use --intial-refspec and an external odb helper is
configured, what happens is that the objects managed by the external
odb are not put in the pack file that is sent, so the receiver should
also have configured an external odb helper that can get the missing
objects otherwise Git will error out complaining about missing
objects.

This has some drawbacks of course, but at least it makes sure that
users' repositories are properly configured before they can start
working with a server using an external ODB.

> For fetches, we remember the objects obtained from that specific remote
> by adding a special file, name to be determined (I used ".imported" in
> [1]). (The same method is used to note objects lazily downloaded.) The
> repack command understands the difference between these two types of
> objects (patches for this are in progress).
>
> I'm not sure if this can be translated to the ODB world. The ODB can
> declare a special capability that fetch sends to the server in order to
> inform the server that it can exclude certain objects, and fetch can
> inform the ODB of the packfiles that it has written, but I'm not sure
> how the ODB can "remember" what it has.

The current design of the "ODB world" doesn't require a new capability
and I think that is a good thing.
Maybe it will be (or it is already) possible to optimize it using a
new capability, but I think it is a good thing to separate the new
capability if possible.

I know I have not answered all the previous emails and I will try to
answer soon, but I try to improve the documentation (and the code) at
the same time, so that hopefully it makes thing clearer for people who
will have similar questions later.

> The ODB could mark such packs
> with ".managed" to note that it is managed by that ODB, so Git shoudn't
> touch it, but this means (for example) that Git can't GC them (and it
> seems also quite contradictory for an ODB to manage Git packfiles).

I don't like very much ODB managing packs. Yeah, the "get_direct"
instruction and cloning using bundles require the helpers to kind of
write loose files or pack files, but they should really use git
commands to do that and then stop taking care.
The more simple the helper can be, the better.
