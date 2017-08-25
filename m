Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4783520285
	for <e@80x24.org>; Fri, 25 Aug 2017 06:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754316AbdHYGOO (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 02:14:14 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:33814 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754279AbdHYGOL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 02:14:11 -0400
Received: by mail-it0-f51.google.com with SMTP id s132so1728608ita.1
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 23:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P2eEBdyoGwl0v/mAgxPsM5ofWT5ktKzEPuZKo3u+7cE=;
        b=AU3lQSMkHU7oiLmzd3kMrIufaDmuDQu5ZEFm8HEvNSyMXThqcO9SnL5E1rR6zHagdm
         msM1RAAajkqOzCksDoH0N1hHovehjgqiliRrIkF5Q8zdlKdpKsFgwL6xnw5Y4k26iJxn
         fGDBHjY/8sbfeMQYQUi4AKm4L/xDI3p3Yvjm7TiRtZKIvQmKQaRMAQZmmFvngRM6NU8x
         n9mj2NeDEns34wQbDyV7199+hsxOrYLjDwFFWqWC6WHQ0sBX9u5fKX/YTsl+/0WyU3XH
         dV/vTGauQZvSGGmmY2F4AruQj7LyxjzYjNNDnvmuhdzI17p8T4BdXSRQPlDyhpgLJiEF
         Z42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P2eEBdyoGwl0v/mAgxPsM5ofWT5ktKzEPuZKo3u+7cE=;
        b=SrBX+XI0h0mzZBKD5eFzq4I3DLQCSZV/IZSiTB8Ph+2uIr82gMswNO87MYhmLvcWQX
         BuWjRi/U/T5/PIyEwBIKgaa6rRF2VMVTi33MJOnYyEPFq0q80NcMLndQRn/tWK/7xi4J
         qy19/Vf2rTv6Cm7oDlRSKzeWI6gOEiUOuX0VAl070cASsJlw7ARC3H2Hwp8alOJ51AYw
         jHpNpwdOW6aF43flGLXEcC3l2PXJl5iZCfTqnFboFYpV8Oz37XHSksp2F+5wvcw1Lr9E
         ccpprybmfFGbaE9WHmQew3M2LxO+1AhK+FedylWPxUAh7ZPP3ccYmrNPj8XyIbv9d9Np
         4hig==
X-Gm-Message-State: AHYfb5gySKs2ecU3HmZ5PdbmW9yPM2jHGxz9RnBmRI9XCzBdVweTPqVe
        q+RoWBcN1mO/XGAuKagWGJjts9A75Q==
X-Received: by 10.36.172.91 with SMTP id m27mr315046iti.184.1503641649738;
 Thu, 24 Aug 2017 23:14:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.115.202 with HTTP; Thu, 24 Aug 2017 23:14:08 -0700 (PDT)
In-Reply-To: <CAGZ79kYhUJ5mmTEO3b9G7M6onuCusBUTSsD7KeCmeMpfaOvroQ@mail.gmail.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-36-chriscool@tuxfamily.org> <CAGZ79kYhUJ5mmTEO3b9G7M6onuCusBUTSsD7KeCmeMpfaOvroQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 25 Aug 2017 08:14:08 +0200
Message-ID: <CAP8UFD1oONnj93UKf=nBzgOQtY2E+ZVvoLGDNGLsZVobfiN90Q@mail.gmail.com>
Subject: Re: [PATCH v5 35/40] Add Documentation/technical/external-odb.txt
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
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

On Thu, Aug 3, 2017 at 8:38 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Aug 3, 2017 at 2:19 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> This describes the external odb mechanism's purpose and
>> how it works.
>
> Thanks for providing this documentation patch!
>
> I read through it sequentially, see questions that came to mind
> in between.

Thanks for your feedback!

> If the very last paragraph came earlier (or an example), it
> would have helped me to understand the big picture better.

Ok, I added the following at the end of the "helpers" section:

"Early on git commands send an 'init' instruction to the registered
commands. A capability negociation will take place during this
request/response exchange which will let Git and the helpers know how
they can further collaborate. The attribute system can also be used to
tell Git which objects should be handled by which helper."

>> +Purpose
>> +=======
>> +
>> +The purpose of this mechanism is to make possible to handle Git
>> +objects, especially blobs, in much more flexible ways.
>> +
>> +Currently Git can store its objects only in the form of loose objects
>> +in separate files or packed objects in a pack file.
>> +
>> +This is not flexible enough for some important use cases like handling
>> +really big binary files or handling a really big number of files that
>> +are fetched only as needed. And it is not realistic to expect that Git
>> +could fully natively handle many of such use cases.
>
> This is a strong statement. Why is it not realistic? What are these
> "many of such use cases"?

What I mean is that the Git default storage (loose objects and packed
objects) cannot easily be optimized for many different kind of
contents. Currently it is optimized for a not huge number of not very
big text files, and it works quite well too when there are not too
many quite small binary files. And then there are tweaks that can be
used to improve things in specific cases (for example if you have very
big text files, you can set "core.bigfilethreshold" to a size bigger
than your text files so that they will still be delta-compress as Peff
explained in a recent thread).

As Git is used by more and more by people having different needs, I
think it is not realistic to expect that we can optimize its object
storage for all these different needs. So a better strategy is to just
let them store objects in external stores.

If we wanted to optimize for different use cases without letting
people use external stores, we would anyway need to implement
different internal stores which would be a huge burden and which could
lead us to re-implement things like HTTP servers that already exists
outside Git.

About these many use cases, I gave the "really big binary files"
example which is why Git LFS exists (and which GitLab is interested in
better solving), and the "really big number of files that are fetched
only as needed" example which Microsoft is interested in solving. I
could also imagine that some people have both big text files and big
binary files in which case the "core.bigfilethreshold" might not work
well, or that some people already have blobs in some different stores
(like HTTP servers, Docker registries, artifact stores, ...) and want
to fetch them from there as much as possible. And then letting people
use different stores can make clones or fetches restartable which
would solve another problem people have long been complaining about...

I will try to use the above explanations to better improve the
statement in the documentation though I don't want it to be as long as
the above. Do you have an idea about what the right balance should be?

>> +Furthermore many improvements that are dependent on specific setups
>> +could be implemented in the way Git objects are managed if it was
>> +possible to customize how the Git objects are handled. For example a
>> +restartable clone using the bundle mechanism has often been requested,
>> +but implementing that would go against the current strict rules under
>> +which the Git objects are currently handled.
>
> So in this example, you would use todays git-clone to obtain a small version
> of the repo and then obtain other objects later?

The problem with explaining how it would work is that the
--initial-refspec option is added to git clone later in the patch
series. And there could be changes in the later part of the patch
series. So I don't want to promise or explain too much here.
But maybe I could add another patch to better explain that at the end
of the series.

>> +What Git needs a mechanism to make it possible to customize in a lot
>> +of different ways how the Git objects are handled.
>
> I do not understand why we need this. Is this aimed to support git LFS,
> which by its model has additional objects not natively tracked by Git, that
> are fetched later when needed?

It is aimed to support not just something like git LFS, but also many
different use cases (see my above explanations).

>> Though this
>> +mechanism should try as much as possible to avoid interfering with the
>> +usual way in which Git handle its objects.
>> +
>> +Helpers
>> +=======
>> +
>> +ODB helpers are commands that have to be registered using either the
>> +"odb.<odbname>.subprocessCommand" or the "odb.<odbname>.scriptCommand"
>> +config variables.
>> +
>> +Registering such a command tells Git that an external odb called
>> +<odbname> exists and that the registered command should be used to
>> +communicate with it.
>> +
>> +There are 2 kinds of commands. Commands registered using the
>> +"odb.<odbname>.subprocessCommand" config variable are called "process
>> +commands" and the associated mode is called "process mode". Commands
>> +registered using the "odb.<odbname>.scriptCommand" config variables
>> +are called "script commands" and the associated mode is called "script
>> +mode".
>
> So there is the possibility for multiple ODBs by the nature of the config
> as we can have multiple <odbname> sections. How does Git know which
> odb to talk to? (does it talk to all of them when asking for a random object?)
>
> When writing an object how does Git decide where to store an object
> (internally or in one of its ODB? Maybe in multiple ODBs? Does the user
> give rules how to tackle the problem or will Git have some magic to do
> the right thing? If so where can I read about that?)

Yeah, it's possible to configure many ODBs. In this case after the
'init' instruction, Git will know what are the instructions supported
by each ODB. If more than one ODB support a 'get_*' instruction, yeah,
Git will ask the ODBs supporting a 'get_*' instruction in turn for
each object it did not already find. If more than one ODB support a
'put_*' instruction and if the attributes for a blob correspond to
more than one of these ODBs, yeah Git will try to "put" the blob into
these ODBs in turn until it succeeds.

> One could think that one ODB is able to learn about objects out of band
> i.e. to replace the fetch/clone/push mechanism, whereas another ODB is
> capable of efficient fast local storage and yet another one that is optimized
> for storing large binary files.

Yeah, all these things are possible.

Hopefully the following will clarify that:

"The communication happens through instructions that are sent by Git
and that the commands should answer. If it makes sense, Git will send
the same instruction to many commands in the order in which they are
configured."

>> +Process Mode
>> +============
>> +
>> +In process mode the command is started as a single process invocation
>> +that should last for the entire life of the single Git command that
>> +started it.
>> +
>> +A packet format (pkt-line, see technical/protocol-common.txt) based
>> +protocol over standard input and standard output is used for
>> +communication between Git and the helper command.
>> +
>> +After the process command is started, Git sends a welcome message
>> +("git-read-object-client"), a list of supported protocol version
>> +numbers, and a flush packet. Git expects to read a welcome response
>> +message ("git-read-object-server"), exactly one protocol version
>> +number from the previously sent list, and a flush packet. All further
>> +communication will be based on the selected version.
>> +
>> +The remaining protocol description below documents "version=1". Please
>> +note that "version=42" in the example below does not exist and is only
>> +there to illustrate how the protocol would look with more than one
>> +version.
>> +
>> +After the version negotiation Git sends a list of all capabilities
>> +that it supports and a flush packet. Git expects to read a list of
>> +desired capabilities, which must be a subset of the supported
>> +capabilities list, and a flush packet as response:
>> +
>> +------------------------
>> +packet: git> git-read-object-client
>> +packet: git> version=1
>> +packet: git> version=42
>> +packet: git> 0000
>> +packet: git< git-read-object-server
>> +packet: git< version=1
>> +packet: git< 0000
>> +packet: git> capability=get_raw_obj
>> +packet: git> capability=have
>> +packet: git> capability=put_raw_obj
>> +packet: git> capability=not-yet-invented
>> +packet: git> 0000
>> +packet: git< capability=get_raw_obj
>> +packet: git< 0000
>> +------------------------
>> +
>> +Afterwards Git sends a list of "key=value" pairs terminated with a
>> +flush packet. The list will contain at least the instruction (based on
>> +the supported capabilities) and the arguments for the
>> +instruction. Please note, that the process must not send any response
>> +before it received the final flush packet.
>> +
>> +In general any response from the helper should end with a status
>> +packet. See the documentation of the 'get_*' instructions below for
>> +examples of status packets.
>> +
>> +After the helper has processed an instruction, it is expected to wait
>> +for the next "key=value" list containing another instruction.
>> +
>> +On exit Git will close the pipe to the helper. The helper is then
>> +expected to detect EOF and exit gracefully on its own. Git will wait
>> +until the process has stopped.
>> +
>> +Script Mode
>> +===========
>> +
>> +In this mode Git launches the script command each time it wants to
>> +communicates with the helper. There is no welcome message and no
>> +protocol version in this mode.
>> +
>> +The instruction and associated arguments are passed as arguments when
>> +launching the script command and if needed further information is
>> +passed between Git and the command through stdin and stdout.
>> +
>> +Capabilities/Instructions
>> +=========================
>> +
>> +The following instructions are currently supported by Git:
>> +
>> +- init
>> +- get_git_obj
>> +- get_raw_obj
>> +- get_direct
>> +- put_raw_obj
>> +- have
>> +
>> +The plan is to also support 'put_git_obj' and 'put_direct' soon, for
>> +consistency with the 'get_*' instructions.
>> +
>> + - 'init'
>> +
>> +All the process and script commands must accept the 'init'
>> +instruction. It should be the first instruction sent to a command. It
>> +should not be advertised in the capability exchange. Any argument
>> +should be ignored.
>> +
>> +In process mode, after receiving the 'init' instruction and a flush
>> +packet, the helper should just send a status packet and then a flush
>> +packet. See the 'get_*' instructions below for examples of status
>> +packets.
>> +
>> +In script mode the command should print on stdout the capabilities
>> +that it supports if any. This is the only time in script mode when a
>> +capability exchange happens.
>> +
>> +For example a script command could use the following shell code
>> +snippet to handle the 'init' instruction:
>> +
>> +------------------------
>> +case "$1" in
>> +init)
>> +       echo "capability=get_git_obj"
>> +       echo "capability=put_raw_obj"
>> +       echo "capability=have"
>> +       ;;
>> +------------------------
>
> I can see the rationale for script mode, but not quite for process mode
> as in process mode we could do the same init work that is needed after
> the welcome message?
>
> Is it kept in process mode to keep consistent with script mode?

Yes and because I want only the 'init' instruction to be required.
In process mode, if there were no 'init' instruction how could Git
know if it is ok to send a 'get' instruction for example if it does
not yet know the helpers' capabilities, and how could a helper that
only setup things be called only once?

> I assume this is to setup the ODB, which then can also state  things like
> "I am not in a state to work, as the network connection is missing"
> or ask the user for a password for the encrypted database?

Yeah, the helper can also take advantage of 'init' to setup and check
everything.

Do you think I should clarify something?

>> + - 'get_git_obj <sha1>' and 'get_raw_obj <sha1>'
>> +
>> +These instructions should have a hexadecimal <sha1> argument to tell
>> +which object the helper should send to git.
>> +
>> +In process mode the sha1 argument should be followed by a flush packet
>> +like this:
>> +
>> +------------------------
>> +packet: git> command=get_git_obj
>> +packet: git> sha1=0a214a649e1b3d5011e14a3dc227753f2bd2be05
>> +packet: git> 0000
>> +------------------------
>> +
>> +After reading that the helper should send the requested object to Git in a
>> +packet series followed by a flush packet. If the helper does not experience
>> +problems then the helper must send a "success" status like the following:
>> +
>> +------------------------
>> +packet: git< status=success
>> +packet: git< 0000
>> +------------------------
>> +
>> +In case the helper cannot or does not want to send the requested
>> +object as well as any other object for the lifetime of the Git
>> +process, then it is expected to respond with an "abort" status at any
>> +point in the protocol:
>> +
>> +------------------------
>> +packet: git< status=abort
>> +packet: git< 0000
>> +------------------------
>> +
>> +Git neither stops nor restarts the helper in case the "error"/"abort"
>> +status is set.
>> +
>> +If the helper dies during the communication or does not adhere to the
>> +protocol then Git will stop and restart it with the next instruction.
>> +
>> +In script mode the helper should just send the requested object to Git
>> +by writing it to stdout and should then exit. The exit code should
>> +signal to Git if a problem occured or not.
>> +
>> +The only difference between 'get_git_obj' and 'get_raw_obj' is that in
>> +case of 'get_git_obj' the requested object should be sent as a Git
>> +object (that is in the same format as loose object files). In case of
>> +'get_raw_obj' the object should be sent in its raw format (that is the
>> +same output as `git cat-file <type> <sha1>`).
>
> In case of abort, what are the implications for Git? How do we deliver the
> message to the user (should the helper print to stderr, or is there a way
> to relay it through Git such that we do not have racy output?)

The helper can print something to stderr. Hopefully it will be printed
using one printf() call or something like that which will make it not
so racy. (Or what kind of race are you talking about?) And Git will
remove the current instruction from the helpers capabilities, so it
will not ask the same instruction again (for the duration of the
current git process).

>> + - 'get_direct <sha1>'
>> +
>> +This instruction is similar as the other 'get_*' instructions except
>> +that no object should be sent from the helper to Git. Instead the
>> +helper should directly write the requested object into a loose object
>> +file in the ".git/objects" directory.
>> +
>> +After the helper has sent the "status=success" packet and the
>> +following flush packet in process mode, or after it has exited in the
>> +script mode, Git should lookup again for a loose object file with the
>> +requested sha1.
>
> Does it have to be a loose object or is the helper also allowed
> to put a packfile into $GIT_OBJECT_DIRECTORY/pack ?
> If so, is it expected to also produce an idx file?

It could also be a packfile and an idx file, but I expect most of
these kind of helpers will just create loose object files.
I will clarify with:

"...Git will lookup again for the requested sha1 in its loose
object files and pack files."

>> + - 'put_raw_obj <sha1> <size> <type>'
>> +
>> +This instruction should be following by three arguments to tell which
>> +object the helper will receive from git: <sha1>, <size> and
>> +<type>. The hexadecimal <sha1> argument describes the object that will
>> +be sent from Git to the helper. The <type> is the object type (blob,
>> +tree, commit or tag) of this object. The <size> is the size of the
>> +(decompressed) object content.
>
> So the type is encoded as strings "blob", "tree" ... Maybe quote them?

Ok, they will be quoted in the next version.

> The size is "in bytes" (maybe add that unit?). I expect there is no fanciness
> allowed such as "3.3MB" as that is not precise enough.

Yeah, I added "in bytes".

>> +In process mode the last argument (the type) should be followed by a
>> +flush packet.
>> +
>> +After reading that the helper should read the announced object from
>> +Git in a packet series followed by a flush packet.
>> +
>> +If the helper does not experience problems when receiving and storing
>> +or processing the object, then the helper must send a "success" status
>> +as described for the 'get_*' instructions.
>
> Otherwise an abort is expected?

There are also "notfound" and "error" failures. I will clarify this
with the following:

"Git neither stops nor restarts the helper in case a
"notfound"/"error"/"abort" status is set. An "error" status means a
possibly more transient error than an abort. The helper should also
send a "notfound" error in case of a "get_*" instruction, which means
that the requested object cannot be found."

>> +In script mode the helper should just receive the announced object
>> +from its standard input. After receiving and processing the object,
>> +the helper should exit and its exit code should signal to Git if a
>> +problem occured or not.
>> +
>> +- 'have'
>> +
>> +In process mode this instruction should be followed by a flush
>> +packet. After receiving this packet the helper should send the sha1,
>> +size and type, in this order, of all the objects it can provide to Git
>> +(through a 'get_*' instruction). There should be a space character
>> +between the sha1 and the size and between the size and the type, and
>> +then a new line character after the type.
>
> As this is also inside a packet, do we need to care about splitting
> up the payload? i.e. when we have a lot of objects such that we need
> multiple packets to present all 'have's, are we allowed to split
> up anywhere or just after a '\n' ?

The code only supports splitting just after a '\n'. I will clarify with:

"If many packets are needed to send back all this information, the
split between packets should be made after the new line characters."

>> +If the helper does not experience problems, then it must then send a
>> +"success" status as described for the 'get_*' instructions.
>> +
>> +In script mode the helper should send to its standard output the sha1,
>> +size and type, in this order of all the objects it can provide to
>> +Git. There should also be a space character between the sha1 and the
>> +size and between the size and the type, and then a new line character
>> +after the type.
>> +
>> +After sending this, the script helper should exit and its exit code
>> +should signal to Git if a problem occured or not.
>> +
>> +Selecting objects
>> +=================
>> +
>> +To select objects that should be handled by an external odb, one can
>> +use the git attributes system. For now this will only work will blobs
>> +and this will only work along with the 'put_raw_obj' instruction.
>> +
>> +For example if one has an external odb called "magic" and has
>> +registered an associated a process command helper that supports the
>> +'put_raw_obj' instruction, then one can tell Git that all the .jpg
>> +files should be handled by the "magic" odb using a .gitattributes file
>> +can that contains:
>> +
>> +------------------------
>> +*.jpg           odb=magic
>> +------------------------
>
> Hah that answers some questions that are asked earlier!
>
> What happens if I say
>
>   *.jpg odb=my-magic-store,my-jpeg-store
>
> ?

I am not sure how the attributes system works but I think it should handle this.
So the above would mean that Git will try to send the .jpg files to
both the "my-magic-store" and the "my-jpeg-store" helpers. The order
depends on which of those appears first in the config files.

> Maybe relevant:
> https://public-inbox.org/git/20170725211300.vwlpioy5jes55273@sigill.intra.peff.net/
> "Extend the .gitattributes file to also specify file sizes"

Yeah, it looks like this could help if some attributes could be set
depending on file sizes.

Thanks,
Christian.
