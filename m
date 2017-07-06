Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343BA202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 17:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbdGFRgP (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 13:36:15 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35137 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdGFRgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 13:36:14 -0400
Received: by mail-qk0-f196.google.com with SMTP id 16so1225761qkg.2
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 10:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1dYwwhblGTrHy3xI1dGcndHHOr4psLSV+/N23zbedtI=;
        b=g+ddu031YBLBoqCqN+Qq6NSQ7VZYz89qiWOw2FjUzH9hGx61vvLXdZMFNY9Xdk/+cN
         g9I1cUw58I4xyD8cL3sILwTn1Qh+k6BVr8uNUWEtu3KCSpL8SREK14wr1uAAb1OFwemI
         /Rtdcc6jcnN1yYjumZfFHzIwsoMat5+FfapeiTYejSFuAyr3Yhf685TVH6yUE+W8n8bB
         irHrfp+dPPENmnX77HM8gYNPUDJDxBC3myqFnWqCiOUSr+WTnZfn0gMt1MzQwM65QLXf
         nV/LGTWBcSGOxD3A9U3ICqlRqXi8bqVvaJJhVH4WdplKQpl+WBtrSN5Jd7xdv/uN9iP+
         bk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1dYwwhblGTrHy3xI1dGcndHHOr4psLSV+/N23zbedtI=;
        b=cwydQ+xYWXRX4YDUtE/OyVD60uqDD1cWZtgyAeaO7lhdBuwx2UrGr7hToLnHZl+BWQ
         rlVPP1Hh6EZk5YBQIjwveQ0b+BTec76Tpz6GOib3eIg57U4Njxfa0TJUkW+UHDbsb8H1
         AELgU7FxNub5G4Wyma3JgpxrHFuub28SQNdx7z51MHCUtZIclUbgcqJzudLDTJ9BNvkR
         FezmTWz+Xh/9zg+uY1LYZblMX8kwA6oQ9gtkTgI5eStB3rAXdoYo3AgyUbXCNae+1QNo
         +IKAmRB1LLH3vIdnmxSaoAD2dK1YlMvLiU9Tb6WkEQFyAYcgW5Yf+WJk9SNUsLf1q1wj
         fhpg==
X-Gm-Message-State: AIVw1109vEkQ27JjVbJj8l8C5E7SHbTlY2uI4ADeXBwK6QI8CuEgiq2C
        ZDfDh6w4dBcNAw==
X-Received: by 10.55.71.134 with SMTP id u128mr38248465qka.25.1499362572659;
        Thu, 06 Jul 2017 10:36:12 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id q201sm548912qke.61.2017.07.06.10.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jul 2017 10:36:11 -0700 (PDT)
Subject: Re: [RFC/PATCH v4 00/49] Add initial experimental external ODB
 support
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
 <4be750af-b093-6644-7f0e-82983327766a@gmail.com>
 <CAP8UFD2hghBePr-WVLiA6P0rS5=JPLmsxqJ_6rEWrqG3VEd7Dg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <b218004c-200c-b45a-0d0a-e273707d5aa0@gmail.com>
Date:   Thu, 6 Jul 2017 13:36:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2hghBePr-WVLiA6P0rS5=JPLmsxqJ_6rEWrqG3VEd7Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/2017 3:41 PM, Christian Couder wrote:
> On Fri, Jun 23, 2017 at 8:24 PM, Ben Peart <peartben@gmail.com> wrote:
>>
>>
>> On 6/20/2017 3:54 AM, Christian Couder wrote:
> 
>>> To be able to better handle some kind of objects, for example big
>>> blobs, it would be nice if Git could store its objects in other object
>>> databases (ODB).
>>>
>>> To do that, this patch series makes it possible to register commands,
>>> also called "helpers", using "odb.<odbname>.command" config variables,
>>> to access external ODBs where objects can be stored and retrieved.
>>>
>>> External ODBs should be able to tranfer information about the blobs
>>> they store. This patch series shows how this is possible using kind of
>>> replace refs.
>>
>> Great to see this making progress!
>>
>> My thoughts and questions are mostly about the overall design tradeoffs.
>>
>> Is your intention to enable the ODB to completely replace the regular object
>> store or just to supplement it?
> 
> It is to supplement it, as I think the regular object store works very
> well most of the time.
> 

I certainly understand the desire to restrict the scope of the patch 
series.  I know full replacement is a much larger problem as it would 
touch much more of the codebase.

I'd still like to see an object store that was thread safe, more robust 
(ie transactional) and hopefully faster so I am hoping we can design the 
ODB interface to eventually enable that.

For example: it seems the ODB helpers need to be able to be called 
before the regular object store in the "put" case (so they can intercept 
large objects for example) and after in in the "get" case to enable 
"fault-in."  Something like this:

have/get
========
git object store
large object ODB helper

put
===
large object ODB helper
git object store

It would be nice if that order wasn't hard coded but that the order or 
level of the "git object store" could be specified using the same 
mechanism as used for the ODB helpers so that some day you could do 
something like this:

have/get
========
"LMDB" ODB helper
git object store

put
===
"LMDB" ODB helper
git object store

(and even further out, drop the current git object store completely :)).

>> I think it would be good to ensure the
>> interface is robust and performant enough to actually replace the current
>> object store interface (even if we don't actually do that just yet).
> 
> I agree that it should be robust and performant, but I don't think it
> needs to be as performant in all cases as the current object store
> right now.
> 
>> Another way of asking this is: do the 3 verbs (have, get, put) and the 3
>> types of "get" enable you to wrap the current loose object and pack file
>> code as ODBs and run completely via the external ODB interface?  If not,
>> what is missing and can it be added?
> 

One example of what I think is missing is a way to stream objects (ie 
get_stream, put_stream).  This isn't used often in git but it did exist 
last I checked.  I'm not saying this needs to be supported in the first 
version - more if we want to support total replacement.

I also wonder if we'd need an "optimize" verb (for "git gc") or a 
"validate" verb (for "git fsck").  Again, only if/when we are looking at 
total replacement.

> Right now the "put" verb only send plain blobs, so the most logical
> way to run completely via the external ODB interface would be to use
> it to send and receive plain blobs. There are tests scripts (t0420,
> t0470 and t0480) that use an http server as the external ODB and all
> the blobs are stored in it.
> 
> And yeah for now it works only for blobs. There is a temporary patch
> in the series that limits it to blobs. For the non RFC patch series, I
> think it should either use the attribute system to tell which objects
> should be run via the external ODB interface, or perhaps there should
> be a way to ask each external ODB helper which kind of objects and
> blobs it can handle. I should add that in the future work part.
> 

Sounds good.  For GVFS we handle all object types (including commits and 
trees) so would need this to be enabled so that we can switch to using it.

>> _Eventually_ it would be great to see the current object store(s) moved
>> behind the new ODB interface.
> 
> This is not one of my goals and I think it could be a problem if we
> want to keep the "fault in" mode.
 > In this mode the helper writes or reads directly to or from the
 > current object store, so it needs the current object store to be
 > available.
 >

I think implementing "fault in" should be an option that the ODB handler 
can implement but should not be required by the design/interface.  As 
you state above, this could be as simple as having the ODB handler write 
the object to the git object store on "get."

> Also I think compatibility with other git implementations is important
> and it is a good thing that they can all work on a common repository
> format.

I agree this should be an option but I don't want to say we'll _never_ 
move to a better object store.

> 
>> When there are multiple ODB providers, what is the order they are called?
> 
> The external_odb_config() function creates the helpers for the
> external ODBs in the order they are found in the config file, and then
> these helpers are called in turn in the same order.
> 
>> If one fails a request (get, have, put) are the others called to see if they
>> can fulfill the request?
> 
> Yes, but there are no tests to check that it works well. I will need
> to add some.
> 
>> Can the order they are called for various verb be configured explicitly?
> 
> Right now, you can configure the order by changing the config file,
> but the order will be the same for all the verbs.

Do you mean it will work like this?

have/get
========
git object store
first ODB helper
second ODB helper
third ODB helper

put
===
first ODB helper
second ODB helper
third ODB helper
git object store

If so, I'd prefer having more flexibility and be able to specify where 
the "git object store" fits in the stack along with the ODB helpers so 
that you could eventually support the "LMDB" ODB helper example above.

> 
>> For
>> example, it would be nice to have a "large object ODB handler" configured to
>> get first try at all "put" verbs.  Then if it meets it's size requirements,
>> it will handle the verb, otherwise it fail and git will try the other ODBs.
> 
> This can work if the "large object ODB handler" is configured first.
> 
> Also this is linked with how you define which objects are handled by
> which helper. For example if the attribute system is used to describe
> which external ODB is used for which files, there could be a way to
> tell for example that blobs larger than 1MB are handled by the "large
> object ODB handler" while those that are smaller are handled by
> another helper.
> 

I can see that using at attribute system could get complex to implement 
generically in git.  It seems defining the set of attributes and the 
rules for matching against them could get complex.

I wonder if it is sufficient to just have a hierarchy and then let each 
ODB handler determine which objects it wants to handle based on whatever 
criteria (size, object type, etc) it wants.

The downside of doing it this way is that calling the various handlers 
needs to be fast as there may be a lot of calls passed through to the 
next handler.  I think this can be accomplished by using persistent 
background processes instead of spawning a new one on each call.

>>> Design
>>> ~~~~~~
>>>
>>> * The "helpers" (registered commands)
>>>
>>> Each helper manages access to one external ODB.
>>>
>>> There are now 2 different modes for helper:
>>>
>>>     - When "odb.<odbname>.scriptMode" is set to "true", the helper is
>>>       launched each time Git wants to communicate with the <odbname>
>>>       external ODB.
>>>
>>>     - When "odb.<odbname>.scriptMode" is not set or set to "false", then
>>>       the helper is launched once as a sub-process (using
>>>       sub-process.h), and Git communicates with it using packet lines.
>>
>> Is it worth supporting two different modes long term?  It seems that this
>> could be simplified (less code to write, debug, document, support) by only
>> supporting the 2nd that uses the sub-process.  As far as I can tell, the
>> capabilities are the same, it's just the second one is more performant when
>> multiple calls are made.
> 
> Yeah, capabilities are the same, but I think the script mode has
> value, because helper are simpler to  write and debug.
> If for example one wants to use the external ODB system to implement
> clone bundles, like what is done in t0430 at the end of the patch
> series, then it's much simpler if the helper uses the script mode, and
> there is no performance downside as the helper will be called once.
> 
> I think people might want to implement these kinds of helpers to just
> setup a repo quickly and properly for their specific needs.
> For example for companies using big monorepos, there could be
> different helpers for different kind of people working on different
> parts of the code. For example one for front end developers and one
> for back end developers.
> 

I think the ease of writing a script mode helper vs sub-process can be 
alleviated with a library of helper routines to help with the 
sub-process interface.  You have a start on that already and given it is 
also already used by the filter interface there should be a good body of 
code to copy/paste for future implementations.  I've written them in 
perl and in C/C++ and once you have some helper functions, it's really 
quite simple.

> Also my goal is to share as much of the implementation as possible
> between the script and the sub process mode. I think this can help us
> be confident that the overall design is good.
> 

Ahh, but a single implementation is easier to code, test and maintain 
than two implementations - even with shared code. :)

>>> A helper can be given different instructions by Git. The instructions
>>> that are supported are negociated at the beginning of the
>>> communication using a capability mechanism.
>>>
>>> For now the following instructions are supported:
>>>
>>>     - "have": the helper should respond with the sha1, size and type of
>>>       all the objects the external ODB contains, one object per line.
>>>
>>>     - "get <sha1>": the helper should then read from the external ODB
>>>       the content of the object corresponding to <sha1> and pass it to Git.
>>>
>>>     - "put <sha1> <size> <type>": the helper should then read from from
>>>       Git an object and store it in the external ODB.
>>>
>>> Currently "have" and "put" are optional.
>>
>> It's good the various verbs can be optional.  That way any particular ODB
>> only has to handle those it needs to provide a different behavior for.
> 
> Yeah, my goal is to have only the "init" verb be required.
> 
>>> There are 3 different kinds of "get" instructions depending on how the
>>> helper passes objects to Git:
>>>
>>>     - "fault_in": the helper will write the requested objects directly
>>>       into the regular Git object database, and then Git will retry
>>>       reading it from there.
>>>
>>
>> I think the "fault_in" behavior can be implemented efficiently without the
>> overhead of a 3rd special "get" instruction if we enable some of the other
>> capabilities discussed.
> 
> The "fault_in" behavior will be just a special kind of "get"
> capability. Git needs to know that the helper has this capability, but
> there should be no overhead. So I am not sure if I understand you
> properly.
> 

Hopefully my sample diagrams above better illustrated what I was 
thinking and why I don't think git needs to be aware of "fault_in" 
behaviors.

>> For example, assume an ODB is setup to handle missing objects (by
>> registering itself as "last" in the prioritized list of ODB handlers). If it
>> is ever asked to retrieve a missing object, it can retrieve the object and
>> return it as a "git_object" or "plain_object" and also cache it locally as a
>> loose object, pack file, or any other ODB handler supported mechanism.
>> Future requests will then provide that object via the locally cached copy
>> and its associated ODB handler.
> 
> Yeah, but if the ODB handler has written it the first time as a loose
> file into the regular Git object database, then it won't be requested
> again from the handler. Maybe you are saying that using the regular
> Git object database is an overhead?
> 
>>>     - "git_object": the helper will send the object as a Git object.
>>>
>>>     - "plain_object": the helper will send the object (a blob) as a raw
>>>       object. (The blob content will be sent as is.)
>>>
>>> For now the kind of "get" that is supported is read from the
>>> "odb.<odbname>.fetchKind" configuration variable, but in the future it
>>> should be decided as part of the capability negociation.
>>
>> I agree it makes sense to move this into the capability negotiation but I
>> also wonder if we really need to support both.  Is there a reason we can't
>> just choose one and force all ODBs to support it?
> 
> I think the different kind of get can all be useful and can all be
> natural in different situations.
> 
> For example if there are different Git repos that share a lot of
> common quite big blobs that may not be often needed by the developers
> using these repos. They might want to store them in only one repo and
> configure the other repos to get these blobs from the first one only
> if they are needed. In this case it is better if the repos can share
> the blobs as Git objects.
> 
> If on the other hand one want to store a few very big blobs on an HTTP
> server, where they could also be retrieved using a browser, it is
> simpler if they are stored as plain objects and passed to Git as such.
> 

I can see how this could be handy, I was just trying to simplify things 
as much as possible.

> The "fault in" mode is interesting in case of a clone bundle, or
> fetching bundles, for example.
> 
> Forcing only one mode means making it harder for some use cases and
> probably having external ODB helpers duplicate a lot of code in
> different programming languages.
> 
>>> * Transfering information
>>
>> This whole section on "odb ref" feels out of place to me.  Below you state
>> it is optional in which case I think it should be discussed in the patches
>> that implement the tests that use it rather than here.  It seems to be a
>> test ODB specific implementation detail.
> 
> I think it is good to provide somewhere in the cover letter an idea
> about how this part can already easily work, so that people can
> understand the whole picture. But I agree it should probably move to
> the "Implementation" section.
> 
>>> To tranfer information about the blobs stored in external ODB, some
>>> special refs, called "odb ref", similar as replace refs, are used in
>>> the tests of this series, but in general nothing forces the helper to
>>> use that mechanism.
>>>
>>> The external odb helper is responsible for using and creating the refs
>>> in refs/odbs/<odbname>/, if it wants to do that. It is free for example
>>> to just create one ref, as it is also free to create many refs. Git
>>> would just transmit the refs that have been created by this helper, if
>>> Git is asked to do so.
>>>
>>> For now in the tests there is one odb ref per blob, as it is simple
>>> and as it is similar to what git-lfs does. Each ref name is
>>> refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob stored
>>> in the external odb named <odbname>.
>>>
>>> These odb refs point to a blob that is stored in the Git
>>> repository and contain information about the blob stored in the
>>> external odb. This information can be specific to the external odb.
>>> The repos can then share this information using commands like:
>>>
>>> `git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`
>>>
>>> At the end of the current patch series, "git clone" is teached a
>>> "--initial-refspec" option, that asks it to first fetch some specified
>>> refs. This is used in the tests to fetch the odb refs first.
>>>   > This way only one "git clone" command can setup a repo using the
>>> external ODB mechanism as long as the right helper is installed on the
>>> machine and as long as the following options are used:
>>>
>>>     - "--initial-refspec <odbrefspec>" to fetch the odb refspec
>>>     - "-c odb.<odbname>.command=<helper>" to configure the helper
>>>
>>> There is also a test script that shows that the "--initial-refspec"
>>> option along with the external ODB mechanism can be used to implement
>>> cloning using bundles.
>>
>> The fact that "git clone is taught a --initial-refspec" option" indicates
>> this isn't just an ODB implementation detail.  Is there a general capability
>> that is missing from the ODB interface that needs to be addressed here?
> 
> Technically you don't need to teach `git clone` the --initial-refspec
> option to make it work.
> It can work like this:
> 
> $ git init
> $ git remote add origin <originurl>
> $ git fetch origin <odbrefspec>
> $ git config odb.<odbname>.command <helper>
> $ git fetch origin
> 
> But it is much simpler for the user to instead just do:
> 
> $ git clone -c odb.<odbname>.command=<helper> --initial-refspec
> <odbrefspec> <originurl>
> 
> I also think that the --initial-refspec option could perhaps be useful
> for other kinds of refs for example tags, notes or replace refs, to
> make sure that those refs are fetched first and that hooks can use
> them when fetching other refs like branches in the later part of the
> clone.
> 
> I have put the --initial-refspec at the end of the patch series
> because there could be other ways to do it. For example the helper
> could perhaps be passed <originurl> in the "init" instruction and then
> use this URL to get all the information it needs (for example by
> fetching special refs from this URL or any other way it wants).
> 
> The problem with that is if the setup is done in separate steps (`git
> init`, then `git remote add` ...) like I show above, then it is not
> sure that the "init" would trigger when fetching the right remote/URL.
> It could trigger when the user does a `git log` in between the above
> steps, and this means that helpers receiving "init" should not rely on
> being always passed a remote/URL.
> 
> So the "init" handling in the helpers would have to be more complex
> than if they only need to rely on the <odbrefspec> having been fetched
> before.
> 
>> I don't believe there is.  Instead, I think we should allow the various
>> "partial clone" patch series already in progress solve the problem of how
>> you do a partial clone of a repo.
> 
> I think this is not really related to partial clone, but maybe I
> should take a closer look at these patch series.

My thought was that since a standard clone copies all objects into the 
local object store, there is no need for a way to retrieve "missing" 
objects as, by definition, none are missing.

The various partial clone patch series are discussing how to clone a 
repo and _not_ copy down all objects which creates the need for a way to 
retrieve "missing" objects.  They are also dealing with how to enable 
git to know the object is intentionally missing (ie "have" can succeed 
but "get" will have to go retrieve the missing object before it can 
return it).

This enables having missing objects without some local placeholder (ref) 
so that repos with large numbers of objects can still do a fast clone as 
they don't have to download millions of refs for the "missing" objects.

> 
>> [1]
>> https://public-inbox.org/git/1488994685-37403-1-git-send-email-jeffhost@microsoft.com/
>> [2]
>> https://public-inbox.org/git/20170309073117.g3br5btsfwntcdpe@sigill.intra.peff.net/
>> [3]
>> https://public-inbox.org/git/cover.1496361873.git.jonathantanmy@google.com/
>> [4]
>> https://public-inbox.org/git/20170602232508.GA21733@aiede.mtv.corp.google.com/
> 
>>> Highlevel view of the patches in the series
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>>       - Patch 1/49 is a small code cleanup that I already sent to the
>>>         mailing list but will probably be removed in the end bdue to
>>>         ongoing work on "git clone"
>>>
>>>       - Patches 02/49 to 08/49 create a Git/Packet.pm module by
>>>         refactoring "t0021/rot13-filter.pl". Functions from this new
>>>         module will be used later in test scripts.
>>
>> Nice!
>>
>>>       - Patches 09/49 to 16/49 create the external ODB insfrastructure
>>>         in external-odb.{c,h} and odb-helper.{c,h} for the script mode.
>>>
>>>       - Patches 17/49 to 23/49 improve lib-http to make it possible to
>>>         use it as an external ODB to test storing blobs in an HTTP
>>>         server.
>>>
>>>       - Patches 24/49 to 44/49 improve the external ODB insfrastructure
>>>         to support sub-processes and make everything work using them.
>>
>> I understand why it is this way historically but it seems these should just
>> be combined with patches 9-16. Instead of writing the new odb specific
>> routines and then patching them to support sub-process, just write them that
>> way the "first" time.
> 
> Yeah, I could do that but I fear it would result in a some bigger
> patches that would be harder to review and understand than a longer
> patch series where feature are implemented and tested in small steps.
> 
>>>       - Patches 45/49 to 49/49 add the --initial-refspec to git clone
>>>         along with tests.
>>
>> I'm hopeful the changes to git clone to add the --initial-refspec can
>> eventually be dropped. It seems we should be able to test the ODB
>> capabilities without having to add options to git clone.
> 
> I described above (and there are examples in the tests of) how
> --initial-refspec can be avoided, but in the end I think we should
> really have a robust and easy way for the user to setup everything.
> And for now I think --initial-refspec is at least a good solution.
> 
> Thanks for your interest and your help in this!
> 
