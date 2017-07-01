Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C8320209
	for <e@80x24.org>; Sat,  1 Jul 2017 19:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbdGATlG (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 15:41:06 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35562 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbdGATlF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 15:41:05 -0400
Received: by mail-io0-f177.google.com with SMTP id h134so38828039iof.2
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 12:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sacwzy4N314JjslddYWd0+alfOwujWdNBm2ZEaG86Q8=;
        b=YcE17/b+9XCh0TaLv5idhYln9/rvk0KrNrbVBbXIlNaTHGIvAwbndHQuRvrW1wRDRc
         fP+Axzg3ezkAIscH7hqfynm1i7vuolHLZNBuwyxjryewRxWmlWYv7GKiucmeA5J08mTG
         OTheMh+8MaopxD4FnZtTfi22jhsPpb7OimygXULBT/FXftAudPClmIn+bcSoqNkV5bou
         ZBNQtBQQ33s+vc1aBi2G4XmusGF3DVqqdjvh2jwhIXZhtWKh5aZFxrrBcI9r336jRkSu
         Xr2Shi2QfcwcGAlJ81qaOST+bqVFRBBMDLP2oCLSn3O+ukXtznZaDtgKIpYx9+rQNj6o
         NLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sacwzy4N314JjslddYWd0+alfOwujWdNBm2ZEaG86Q8=;
        b=M48uHFmN2qF1FfmnPNU1S8XDlg7CHloQ8S5kg0goUdh1985SYtKS5Gj0Wzza0C49+1
         cNTBuynVHneBC49Tw70PTpDas0efERlBTyO7hzjmUwJsgqGhz/8tquNd/QybGStsNWnA
         sq/VxX95H9LUP/1ukJphA+dd80h98VJKkoh9FZpA2cGHuUiymncIQP5wMZRg69XoR9Ax
         yQo3MoDXiRVinsSQjsZOoUeoRuMdgkrPX1Y9sNcmSoJVuw52EceY7jCBeHJ31ybMLRMS
         DXNo97KNlOf425xTlJIh2Dvu+vZxSzCOwDmjLGqs+L+8miKvcTkwJFNnL6uqJNgZgE64
         gIbw==
X-Gm-Message-State: AKS2vOxk0rJaSi7jhVcWKfyqzOyJ53ak8F/WzQOYswmVQC9fBD14O6s9
        w/8FL9FOZBb4FiLOuDcE17c9pAbBmAyf
X-Received: by 10.107.41.4 with SMTP id p4mr26805243iop.126.1498938063605;
 Sat, 01 Jul 2017 12:41:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Sat, 1 Jul 2017 12:41:02 -0700 (PDT)
In-Reply-To: <4be750af-b093-6644-7f0e-82983327766a@gmail.com>
References: <20170620075523.26961-1-chriscool@tuxfamily.org> <4be750af-b093-6644-7f0e-82983327766a@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 1 Jul 2017 21:41:02 +0200
Message-ID: <CAP8UFD2hghBePr-WVLiA6P0rS5=JPLmsxqJ_6rEWrqG3VEd7Dg@mail.gmail.com>
Subject: Re: [RFC/PATCH v4 00/49] Add initial experimental external ODB support
To:     Ben Peart <peartben@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
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

On Fri, Jun 23, 2017 at 8:24 PM, Ben Peart <peartben@gmail.com> wrote:
>
>
> On 6/20/2017 3:54 AM, Christian Couder wrote:

>> To be able to better handle some kind of objects, for example big
>> blobs, it would be nice if Git could store its objects in other object
>> databases (ODB).
>>
>> To do that, this patch series makes it possible to register commands,
>> also called "helpers", using "odb.<odbname>.command" config variables,
>> to access external ODBs where objects can be stored and retrieved.
>>
>> External ODBs should be able to tranfer information about the blobs
>> they store. This patch series shows how this is possible using kind of
>> replace refs.
>
> Great to see this making progress!
>
> My thoughts and questions are mostly about the overall design tradeoffs.
>
> Is your intention to enable the ODB to completely replace the regular object
> store or just to supplement it?

It is to supplement it, as I think the regular object store works very
well most of the time.

> I think it would be good to ensure the
> interface is robust and performant enough to actually replace the current
> object store interface (even if we don't actually do that just yet).

I agree that it should be robust and performant, but I don't think it
needs to be as performant in all cases as the current object store
right now.

> Another way of asking this is: do the 3 verbs (have, get, put) and the 3
> types of "get" enable you to wrap the current loose object and pack file
> code as ODBs and run completely via the external ODB interface?  If not,
> what is missing and can it be added?

Right now the "put" verb only send plain blobs, so the most logical
way to run completely via the external ODB interface would be to use
it to send and receive plain blobs. There are tests scripts (t0420,
t0470 and t0480) that use an http server as the external ODB and all
the blobs are stored in it.

And yeah for now it works only for blobs. There is a temporary patch
in the series that limits it to blobs. For the non RFC patch series, I
think it should either use the attribute system to tell which objects
should be run via the external ODB interface, or perhaps there should
be a way to ask each external ODB helper which kind of objects and
blobs it can handle. I should add that in the future work part.

> _Eventually_ it would be great to see the current object store(s) moved
> behind the new ODB interface.

This is not one of my goals and I think it could be a problem if we
want to keep the "fault in" mode.
In this mode the helper writes or reads directly to or from the
current object store, so it needs the current object store to be
available.

Also I think compatibility with other git implementations is important
and it is a good thing that they can all work on a common repository
format.

> When there are multiple ODB providers, what is the order they are called?

The external_odb_config() function creates the helpers for the
external ODBs in the order they are found in the config file, and then
these helpers are called in turn in the same order.

> If one fails a request (get, have, put) are the others called to see if they
> can fulfill the request?

Yes, but there are no tests to check that it works well. I will need
to add some.

> Can the order they are called for various verb be configured explicitly?

Right now, you can configure the order by changing the config file,
but the order will be the same for all the verbs.

> For
> example, it would be nice to have a "large object ODB handler" configured to
> get first try at all "put" verbs.  Then if it meets it's size requirements,
> it will handle the verb, otherwise it fail and git will try the other ODBs.

This can work if the "large object ODB handler" is configured first.

Also this is linked with how you define which objects are handled by
which helper. For example if the attribute system is used to describe
which external ODB is used for which files, there could be a way to
tell for example that blobs larger than 1MB are handled by the "large
object ODB handler" while those that are smaller are handled by
another helper.

>> Design
>> ~~~~~~
>>
>> * The "helpers" (registered commands)
>>
>> Each helper manages access to one external ODB.
>>
>> There are now 2 different modes for helper:
>>
>>    - When "odb.<odbname>.scriptMode" is set to "true", the helper is
>>      launched each time Git wants to communicate with the <odbname>
>>      external ODB.
>>
>>    - When "odb.<odbname>.scriptMode" is not set or set to "false", then
>>      the helper is launched once as a sub-process (using
>>      sub-process.h), and Git communicates with it using packet lines.
>
> Is it worth supporting two different modes long term?  It seems that this
> could be simplified (less code to write, debug, document, support) by only
> supporting the 2nd that uses the sub-process.  As far as I can tell, the
> capabilities are the same, it's just the second one is more performant when
> multiple calls are made.

Yeah, capabilities are the same, but I think the script mode has
value, because helper are simpler to  write and debug.
If for example one wants to use the external ODB system to implement
clone bundles, like what is done in t0430 at the end of the patch
series, then it's much simpler if the helper uses the script mode, and
there is no performance downside as the helper will be called once.

I think people might want to implement these kinds of helpers to just
setup a repo quickly and properly for their specific needs.
For example for companies using big monorepos, there could be
different helpers for different kind of people working on different
parts of the code. For example one for front end developers and one
for back end developers.

Also my goal is to share as much of the implementation as possible
between the script and the sub process mode. I think this can help us
be confident that the overall design is good.

>> A helper can be given different instructions by Git. The instructions
>> that are supported are negociated at the beginning of the
>> communication using a capability mechanism.
>>
>> For now the following instructions are supported:
>>
>>    - "have": the helper should respond with the sha1, size and type of
>>      all the objects the external ODB contains, one object per line.
>>
>>    - "get <sha1>": the helper should then read from the external ODB
>>      the content of the object corresponding to <sha1> and pass it to Git.
>>
>>    - "put <sha1> <size> <type>": the helper should then read from from
>>      Git an object and store it in the external ODB.
>>
>> Currently "have" and "put" are optional.
>
> It's good the various verbs can be optional.  That way any particular ODB
> only has to handle those it needs to provide a different behavior for.

Yeah, my goal is to have only the "init" verb be required.

>> There are 3 different kinds of "get" instructions depending on how the
>> helper passes objects to Git:
>>
>>    - "fault_in": the helper will write the requested objects directly
>>      into the regular Git object database, and then Git will retry
>>      reading it from there.
>>
>
> I think the "fault_in" behavior can be implemented efficiently without the
> overhead of a 3rd special "get" instruction if we enable some of the other
> capabilities discussed.

The "fault_in" behavior will be just a special kind of "get"
capability. Git needs to know that the helper has this capability, but
there should be no overhead. So I am not sure if I understand you
properly.

> For example, assume an ODB is setup to handle missing objects (by
> registering itself as "last" in the prioritized list of ODB handlers). If it
> is ever asked to retrieve a missing object, it can retrieve the object and
> return it as a "git_object" or "plain_object" and also cache it locally as a
> loose object, pack file, or any other ODB handler supported mechanism.
> Future requests will then provide that object via the locally cached copy
> and its associated ODB handler.

Yeah, but if the ODB handler has written it the first time as a loose
file into the regular Git object database, then it won't be requested
again from the handler. Maybe you are saying that using the regular
Git object database is an overhead?

>>    - "git_object": the helper will send the object as a Git object.
>>
>>    - "plain_object": the helper will send the object (a blob) as a raw
>>      object. (The blob content will be sent as is.)
>>
>> For now the kind of "get" that is supported is read from the
>> "odb.<odbname>.fetchKind" configuration variable, but in the future it
>> should be decided as part of the capability negociation.
>
> I agree it makes sense to move this into the capability negotiation but I
> also wonder if we really need to support both.  Is there a reason we can't
> just choose one and force all ODBs to support it?

I think the different kind of get can all be useful and can all be
natural in different situations.

For example if there are different Git repos that share a lot of
common quite big blobs that may not be often needed by the developers
using these repos. They might want to store them in only one repo and
configure the other repos to get these blobs from the first one only
if they are needed. In this case it is better if the repos can share
the blobs as Git objects.

If on the other hand one want to store a few very big blobs on an HTTP
server, where they could also be retrieved using a browser, it is
simpler if they are stored as plain objects and passed to Git as such.

The "fault in" mode is interesting in case of a clone bundle, or
fetching bundles, for example.

Forcing only one mode means making it harder for some use cases and
probably having external ODB helpers duplicate a lot of code in
different programming languages.

>> * Transfering information
>
> This whole section on "odb ref" feels out of place to me.  Below you state
> it is optional in which case I think it should be discussed in the patches
> that implement the tests that use it rather than here.  It seems to be a
> test ODB specific implementation detail.

I think it is good to provide somewhere in the cover letter an idea
about how this part can already easily work, so that people can
understand the whole picture. But I agree it should probably move to
the "Implementation" section.

>> To tranfer information about the blobs stored in external ODB, some
>> special refs, called "odb ref", similar as replace refs, are used in
>> the tests of this series, but in general nothing forces the helper to
>> use that mechanism.
>>
>> The external odb helper is responsible for using and creating the refs
>> in refs/odbs/<odbname>/, if it wants to do that. It is free for example
>> to just create one ref, as it is also free to create many refs. Git
>> would just transmit the refs that have been created by this helper, if
>> Git is asked to do so.
>>
>> For now in the tests there is one odb ref per blob, as it is simple
>> and as it is similar to what git-lfs does. Each ref name is
>> refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob stored
>> in the external odb named <odbname>.
>>
>> These odb refs point to a blob that is stored in the Git
>> repository and contain information about the blob stored in the
>> external odb. This information can be specific to the external odb.
>> The repos can then share this information using commands like:
>>
>> `git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`
>>
>> At the end of the current patch series, "git clone" is teached a
>> "--initial-refspec" option, that asks it to first fetch some specified
>> refs. This is used in the tests to fetch the odb refs first.
>>  > This way only one "git clone" command can setup a repo using the
>> external ODB mechanism as long as the right helper is installed on the
>> machine and as long as the following options are used:
>>
>>    - "--initial-refspec <odbrefspec>" to fetch the odb refspec
>>    - "-c odb.<odbname>.command=<helper>" to configure the helper
>>
>> There is also a test script that shows that the "--initial-refspec"
>> option along with the external ODB mechanism can be used to implement
>> cloning using bundles.
>
> The fact that "git clone is taught a --initial-refspec" option" indicates
> this isn't just an ODB implementation detail.  Is there a general capability
> that is missing from the ODB interface that needs to be addressed here?

Technically you don't need to teach `git clone` the --initial-refspec
option to make it work.
It can work like this:

$ git init
$ git remote add origin <originurl>
$ git fetch origin <odbrefspec>
$ git config odb.<odbname>.command <helper>
$ git fetch origin

But it is much simpler for the user to instead just do:

$ git clone -c odb.<odbname>.command=<helper> --initial-refspec
<odbrefspec> <originurl>

I also think that the --initial-refspec option could perhaps be useful
for other kinds of refs for example tags, notes or replace refs, to
make sure that those refs are fetched first and that hooks can use
them when fetching other refs like branches in the later part of the
clone.

I have put the --initial-refspec at the end of the patch series
because there could be other ways to do it. For example the helper
could perhaps be passed <originurl> in the "init" instruction and then
use this URL to get all the information it needs (for example by
fetching special refs from this URL or any other way it wants).

The problem with that is if the setup is done in separate steps (`git
init`, then `git remote add` ...) like I show above, then it is not
sure that the "init" would trigger when fetching the right remote/URL.
It could trigger when the user does a `git log` in between the above
steps, and this means that helpers receiving "init" should not rely on
being always passed a remote/URL.

So the "init" handling in the helpers would have to be more complex
than if they only need to rely on the <odbrefspec> having been fetched
before.

> I don't believe there is.  Instead, I think we should allow the various
> "partial clone" patch series already in progress solve the problem of how
> you do a partial clone of a repo.

I think this is not really related to partial clone, but maybe I
should take a closer look at these patch series.

> [1]
> https://public-inbox.org/git/1488994685-37403-1-git-send-email-jeffhost@microsoft.com/
> [2]
> https://public-inbox.org/git/20170309073117.g3br5btsfwntcdpe@sigill.intra.peff.net/
> [3]
> https://public-inbox.org/git/cover.1496361873.git.jonathantanmy@google.com/
> [4]
> https://public-inbox.org/git/20170602232508.GA21733@aiede.mtv.corp.google.com/

>> Highlevel view of the patches in the series
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>>      - Patch 1/49 is a small code cleanup that I already sent to the
>>        mailing list but will probably be removed in the end bdue to
>>        ongoing work on "git clone"
>>
>>      - Patches 02/49 to 08/49 create a Git/Packet.pm module by
>>        refactoring "t0021/rot13-filter.pl". Functions from this new
>>        module will be used later in test scripts.
>
> Nice!
>
>>      - Patches 09/49 to 16/49 create the external ODB insfrastructure
>>        in external-odb.{c,h} and odb-helper.{c,h} for the script mode.
>>
>>      - Patches 17/49 to 23/49 improve lib-http to make it possible to
>>        use it as an external ODB to test storing blobs in an HTTP
>>        server.
>>
>>      - Patches 24/49 to 44/49 improve the external ODB insfrastructure
>>        to support sub-processes and make everything work using them.
>
> I understand why it is this way historically but it seems these should just
> be combined with patches 9-16. Instead of writing the new odb specific
> routines and then patching them to support sub-process, just write them that
> way the "first" time.

Yeah, I could do that but I fear it would result in a some bigger
patches that would be harder to review and understand than a longer
patch series where feature are implemented and tested in small steps.

>>      - Patches 45/49 to 49/49 add the --initial-refspec to git clone
>>        along with tests.
>
> I'm hopeful the changes to git clone to add the --initial-refspec can
> eventually be dropped. It seems we should be able to test the ODB
> capabilities without having to add options to git clone.

I described above (and there are examples in the tests of) how
--initial-refspec can be avoided, but in the end I think we should
really have a robust and easy way for the user to setup everything.
And for now I think --initial-refspec is at least a good solution.

Thanks for your interest and your help in this!
