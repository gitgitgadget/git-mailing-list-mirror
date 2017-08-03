Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D32D208B4
	for <e@80x24.org>; Thu,  3 Aug 2017 18:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbdHCSiK (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:38:10 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33135 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbdHCSiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:38:09 -0400
Received: by mail-lf0-f49.google.com with SMTP id d17so9706570lfe.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WI6wf/LFO9UUnoC3UFJUhc9w4d1Fkl8HNk0zDq+MMPE=;
        b=lda3kl7NrgixspPBBOVNSEmSaKffMYmsZRBFlmvPfWVlBmKmv3K4t5Kl6VIJAo/J8i
         s3vkBfY/zMfoCdZL7HofCZFwJ69ZO3omdgzh0MpD3Px1VcKztE64Q+tQdTwh8VDAnkfC
         F3uqbZNk4wlFTVvHWAAaom1Qrh7UZbOCFG3BIlT3qkmdUOOv1aHDcJSAbYiRassz+tiY
         UzyKKmdE30gmiQE2vnQJoYpqjbPb/iw8NyNqf+mabATZ5sr2iXRSxGC9Fo3kBd+cREM4
         n9WpZ9yxceYZgscbLgX44WGrdd2Wbq9vZhKA4/9pUlFPbQnsIMupahLoIjvGIkm8OsJt
         uOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WI6wf/LFO9UUnoC3UFJUhc9w4d1Fkl8HNk0zDq+MMPE=;
        b=e8DXNfuZaMLRJbBW5gh1880ZRQnpyxeMKmtHu+M7ujoLznE4pLpH39xiT/FB8jO9rI
         lUzlRlJvNcgpqkPfqr7Gzmfk0V4Byr7KU+qMzqZ8rCA6LMdNp1QQ/JdLI+HnvbsLzwqh
         h9SzcxoMfd+AVVx8URSu17v9DyjXdgi7yyRZ/jEo2hY4aCABIy5ZWwstU1vcRGFb7KO/
         L8MD3qN4NC+V+Wc7rInTs3Omm54dCCBww8mXqpAhBOwVJLTPvPuayhZz0dU34+5dLiQB
         AWp/eH96PgRUVcAz2S8PeL6d/o+HxDztzo15QhXqfhjxCN7kdjFYwzGXUAlRfn2I74qe
         rNFg==
X-Gm-Message-State: AIVw110/gNNpdijcXZ1OJIK594La2KGabV/mdFfrBSDiBxz4aALspvbQ
        D5/AHC9rH9G0LNvpVLKzme05/+aBwyJF
X-Received: by 10.46.69.193 with SMTP id s184mr1060821lja.116.1501785487103;
 Thu, 03 Aug 2017 11:38:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 3 Aug 2017 11:38:05 -0700 (PDT)
In-Reply-To: <20170803091926.1755-36-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org> <20170803091926.1755-36-chriscool@tuxfamily.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 Aug 2017 11:38:05 -0700
Message-ID: <CAGZ79kYhUJ5mmTEO3b9G7M6onuCusBUTSsD7KeCmeMpfaOvroQ@mail.gmail.com>
Subject: Re: [PATCH v5 35/40] Add Documentation/technical/external-odb.txt
To:     Christian Couder <christian.couder@gmail.com>
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

On Thu, Aug 3, 2017 at 2:19 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> This describes the external odb mechanism's purpose and
> how it works.

Thanks for providing this documentation patch!

I read through it sequentially, see questions that came to mind
in between.

If the very last paragraph came earlier (or an example), it
would have helped me to understand the big picture better.

>
> Helped-by: Ben Peart <benpeart@microsoft.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/technical/external-odb.txt | 295 +++++++++++++++++++++++++++++++
>  1 file changed, 295 insertions(+)
>  create mode 100644 Documentation/technical/external-odb.txt
>
> diff --git a/Documentation/technical/external-odb.txt b/Documentation/technical/external-odb.txt
> new file mode 100644
> index 0000000000..5991221fd5
> --- /dev/null
> +++ b/Documentation/technical/external-odb.txt
> @@ -0,0 +1,295 @@
> +External ODBs
> +^^^^^^^^^^^^^
> +
> +The External ODB mechanism makes it possible for Git objects, mostly
> +blobs for now though, to be stored in an "external object database"
> +(External ODB).
> +
> +An External ODB can be any object store as long as there is an helper
> +program called an "odb helper" that can communicate with Git to
> +transfer objects to/from the external odb and to retrieve information
> +about available objects in the external odb.
> +
> +Purpose
> +=======
> +
> +The purpose of this mechanism is to make possible to handle Git
> +objects, especially blobs, in much more flexible ways.
> +
> +Currently Git can store its objects only in the form of loose objects
> +in separate files or packed objects in a pack file.
> +
> +This is not flexible enough for some important use cases like handling
> +really big binary files or handling a really big number of files that
> +are fetched only as needed. And it is not realistic to expect that Git
> +could fully natively handle many of such use cases.

This is a strong statement. Why is it not realistic? What are these
"many of such use cases"?

> +Furthermore many improvements that are dependent on specific setups
> +could be implemented in the way Git objects are managed if it was
> +possible to customize how the Git objects are handled. For example a
> +restartable clone using the bundle mechanism has often been requested,
> +but implementing that would go against the current strict rules under
> +which the Git objects are currently handled.

So in this example, you would use todays git-clone to obtain a small version
of the repo and then obtain other objects later?

> +What Git needs a mechanism to make it possible to customize in a lot
> +of different ways how the Git objects are handled.

I do not understand why we need this. Is this aimed to support git LFS,
which by its model has additional objects not natively tracked by Git, that
are fetched later when needed?

> Though this
> +mechanism should try as much as possible to avoid interfering with the
> +usual way in which Git handle its objects.
> +
> +Helpers
> +=======
> +
> +ODB helpers are commands that have to be registered using either the
> +"odb.<odbname>.subprocessCommand" or the "odb.<odbname>.scriptCommand"
> +config variables.
> +
> +Registering such a command tells Git that an external odb called
> +<odbname> exists and that the registered command should be used to
> +communicate with it.
> +
> +There are 2 kinds of commands. Commands registered using the
> +"odb.<odbname>.subprocessCommand" config variable are called "process
> +commands" and the associated mode is called "process mode". Commands
> +registered using the "odb.<odbname>.scriptCommand" config variables
> +are called "script commands" and the associated mode is called "script
> +mode".

So there is the possibility for multiple ODBs by the nature of the config
as we can have multiple <odbname> sections. How does Git know which
odb to talk to? (does it talk to all of them when asking for a random object?)

When writing an object how does Git decide where to store an object
(internally or in one of its ODB? Maybe in multiple ODBs? Does the user
give rules how to tackle the problem or will Git have some magic to do
the right thing? If so where can I read about that?)

One could think that one ODB is able to learn about objects out of band
i.e. to replace the fetch/clone/push mechanism, whereas another ODB is
capable of efficient fast local storage and yet another one that is optimized
for storing large binary files.

> +Process Mode
> +============
> +
> +In process mode the command is started as a single process invocation
> +that should last for the entire life of the single Git command that
> +started it.
> +
> +A packet format (pkt-line, see technical/protocol-common.txt) based
> +protocol over standard input and standard output is used for
> +communication between Git and the helper command.
> +
> +After the process command is started, Git sends a welcome message
> +("git-read-object-client"), a list of supported protocol version
> +numbers, and a flush packet. Git expects to read a welcome response
> +message ("git-read-object-server"), exactly one protocol version
> +number from the previously sent list, and a flush packet. All further
> +communication will be based on the selected version.
> +
> +The remaining protocol description below documents "version=1". Please
> +note that "version=42" in the example below does not exist and is only
> +there to illustrate how the protocol would look with more than one
> +version.
> +
> +After the version negotiation Git sends a list of all capabilities
> +that it supports and a flush packet. Git expects to read a list of
> +desired capabilities, which must be a subset of the supported
> +capabilities list, and a flush packet as response:
> +
> +------------------------
> +packet: git> git-read-object-client
> +packet: git> version=1
> +packet: git> version=42
> +packet: git> 0000
> +packet: git< git-read-object-server
> +packet: git< version=1
> +packet: git< 0000
> +packet: git> capability=get_raw_obj
> +packet: git> capability=have
> +packet: git> capability=put_raw_obj
> +packet: git> capability=not-yet-invented
> +packet: git> 0000
> +packet: git< capability=get_raw_obj
> +packet: git< 0000
> +------------------------
> +
> +Afterwards Git sends a list of "key=value" pairs terminated with a
> +flush packet. The list will contain at least the instruction (based on
> +the supported capabilities) and the arguments for the
> +instruction. Please note, that the process must not send any response
> +before it received the final flush packet.
> +
> +In general any response from the helper should end with a status
> +packet. See the documentation of the 'get_*' instructions below for
> +examples of status packets.
> +
> +After the helper has processed an instruction, it is expected to wait
> +for the next "key=value" list containing another instruction.
> +
> +On exit Git will close the pipe to the helper. The helper is then
> +expected to detect EOF and exit gracefully on its own. Git will wait
> +until the process has stopped.
> +
> +Script Mode
> +===========
> +
> +In this mode Git launches the script command each time it wants to
> +communicates with the helper. There is no welcome message and no
> +protocol version in this mode.
> +
> +The instruction and associated arguments are passed as arguments when
> +launching the script command and if needed further information is
> +passed between Git and the command through stdin and stdout.
> +
> +Capabilities/Instructions
> +=========================
> +
> +The following instructions are currently supported by Git:
> +
> +- init
> +- get_git_obj
> +- get_raw_obj
> +- get_direct
> +- put_raw_obj
> +- have
> +
> +The plan is to also support 'put_git_obj' and 'put_direct' soon, for
> +consistency with the 'get_*' instructions.
> +
> + - 'init'
> +
> +All the process and script commands must accept the 'init'
> +instruction. It should be the first instruction sent to a command. It
> +should not be advertised in the capability exchange. Any argument
> +should be ignored.
> +
> +In process mode, after receiving the 'init' instruction and a flush
> +packet, the helper should just send a status packet and then a flush
> +packet. See the 'get_*' instructions below for examples of status
> +packets.
> +
> +In script mode the command should print on stdout the capabilities
> +that it supports if any. This is the only time in script mode when a
> +capability exchange happens.
> +
> +For example a script command could use the following shell code
> +snippet to handle the 'init' instruction:
> +
> +------------------------
> +case "$1" in
> +init)
> +       echo "capability=get_git_obj"
> +       echo "capability=put_raw_obj"
> +       echo "capability=have"
> +       ;;
> +------------------------

I can see the rationale for script mode, but not quite for process mode
as in process mode we could do the same init work that is needed after
the welcome message?

Is it kept in process mode to keep consistent with script mode?

I assume this is to setup the ODB, which then can also state  things like
"I am not in a state to work, as the network connection is missing"
or ask the user for a password for the encrypted database?

> + - 'get_git_obj <sha1>' and 'get_raw_obj <sha1>'
> +
> +These instructions should have a hexadecimal <sha1> argument to tell
> +which object the helper should send to git.
> +
> +In process mode the sha1 argument should be followed by a flush packet
> +like this:
> +
> +------------------------
> +packet: git> command=get_git_obj
> +packet: git> sha1=0a214a649e1b3d5011e14a3dc227753f2bd2be05
> +packet: git> 0000
> +------------------------
> +
> +After reading that the helper should send the requested object to Git in a
> +packet series followed by a flush packet. If the helper does not experience
> +problems then the helper must send a "success" status like the following:
> +
> +------------------------
> +packet: git< status=success
> +packet: git< 0000
> +------------------------
> +
> +In case the helper cannot or does not want to send the requested
> +object as well as any other object for the lifetime of the Git
> +process, then it is expected to respond with an "abort" status at any
> +point in the protocol:
> +
> +------------------------
> +packet: git< status=abort
> +packet: git< 0000
> +------------------------
> +
> +Git neither stops nor restarts the helper in case the "error"/"abort"
> +status is set.
> +
> +If the helper dies during the communication or does not adhere to the
> +protocol then Git will stop and restart it with the next instruction.
> +
> +In script mode the helper should just send the requested object to Git
> +by writing it to stdout and should then exit. The exit code should
> +signal to Git if a problem occured or not.
> +
> +The only difference between 'get_git_obj' and 'get_raw_obj' is that in
> +case of 'get_git_obj' the requested object should be sent as a Git
> +object (that is in the same format as loose object files). In case of
> +'get_raw_obj' the object should be sent in its raw format (that is the
> +same output as `git cat-file <type> <sha1>`).

In case of abort, what are the implications for Git? How do we deliver the
message to the user (should the helper print to stderr, or is there a way
to relay it through Git such that we do not have racy output?)

> + - 'get_direct <sha1>'
> +
> +This instruction is similar as the other 'get_*' instructions except
> +that no object should be sent from the helper to Git. Instead the
> +helper should directly write the requested object into a loose object
> +file in the ".git/objects" directory.
> +
> +After the helper has sent the "status=success" packet and the
> +following flush packet in process mode, or after it has exited in the
> +script mode, Git should lookup again for a loose object file with the
> +requested sha1.

Does it have to be a loose object or is the helper also allowed
to put a packfile into $GIT_OBJECT_DIRECTORY/pack ?
If so, is it expected to also produce an idx file?

> +
> + - 'put_raw_obj <sha1> <size> <type>'
> +
> +This instruction should be following by three arguments to tell which
> +object the helper will receive from git: <sha1>, <size> and
> +<type>. The hexadecimal <sha1> argument describes the object that will
> +be sent from Git to the helper. The <type> is the object type (blob,
> +tree, commit or tag) of this object. The <size> is the size of the
> +(decompressed) object content.

So the type is encoded as strings "blob", "tree" ... Maybe quote them?

The size is "in bytes" (maybe add that unit?). I expect there is no fanciness
allowed such as "3.3MB" as that is not precise enough.

> +In process mode the last argument (the type) should be followed by a
> +flush packet.
> +
> +After reading that the helper should read the announced object from
> +Git in a packet series followed by a flush packet.
> +
> +If the helper does not experience problems when receiving and storing
> +or processing the object, then the helper must send a "success" status
> +as described for the 'get_*' instructions.

Otherwise an abort is expected?

> +
> +In script mode the helper should just receive the announced object
> +from its standard input. After receiving and processing the object,
> +the helper should exit and its exit code should signal to Git if a
> +problem occured or not.
> +
> +- 'have'
> +
> +In process mode this instruction should be followed by a flush
> +packet. After receiving this packet the helper should send the sha1,
> +size and type, in this order, of all the objects it can provide to Git
> +(through a 'get_*' instruction). There should be a space character
> +between the sha1 and the size and between the size and the type, and
> +then a new line character after the type.

As this is also inside a packet, do we need to care about splitting
up the payload? i.e. when we have a lot of objects such that we need
multiple packets to present all 'have's, are we allowed to split
up anywhere or just after a '\n' ?

> +If the helper does not experience problems, then it must then send a
> +"success" status as described for the 'get_*' instructions.
> +
> +In script mode the helper should send to its standard output the sha1,
> +size and type, in this order of all the objects it can provide to
> +Git. There should also be a space character between the sha1 and the
> +size and between the size and the type, and then a new line character
> +after the type.
> +
> +After sending this, the script helper should exit and its exit code
> +should signal to Git if a problem occured or not.
> +
> +Selecting objects
> +=================
> +
> +To select objects that should be handled by an external odb, one can
> +use the git attributes system. For now this will only work will blobs
> +and this will only work along with the 'put_raw_obj' instruction.
> +
> +For example if one has an external odb called "magic" and has
> +registered an associated a process command helper that supports the
> +'put_raw_obj' instruction, then one can tell Git that all the .jpg
> +files should be handled by the "magic" odb using a .gitattributes file
> +can that contains:
> +
> +------------------------
> +*.jpg           odb=magic
> +------------------------

Hah that answers some questions that are asked earlier!

What happens if I say

  *.jpg odb=my-magic-store,my-jpeg-store

?

Maybe relevant:
https://public-inbox.org/git/20170725211300.vwlpioy5jes55273@sigill.intra.peff.net/
"Extend the .gitattributes file to also specify file sizes"

> +
> --
> 2.14.0.rc1.52.gf02fb0ddac.dirty
>

Thanks,
Stefan
