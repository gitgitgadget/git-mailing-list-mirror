Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C4520A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 22:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbeLNWjN (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 17:39:13 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45333 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbeLNWjM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 17:39:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so6153836edb.12
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 14:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=H3OrDofXIJNg5gNDuajb4iwLISeM3eIYfAoQCgv9KBA=;
        b=dHZ0F/41wqCDxhpdYOTavsZpQWvHhcglDfKrB4nGASuiaDuNfChZZnagFh6+/zRgLP
         JpsWLJ0sof5j4kOfn6nnN6XGwp+jKnTYlHUuszoTIzDdAgrbDIOyYto/P1tsNWRpnkcL
         9TJ5pSmRNEyNX8Ew/5crMGimOrbUKQcCqoZmU+SQC6Wjkcbt3+BgYKV4UaOo9C3QoltD
         th4fF+cx/q8VUWodVmm0rnZ0YKqWdb961bXNsKSH2zD8v9yWSxalJ7zRGICxXA9Zlyfv
         ElED0PS7zR0YfPGLMyWhQV3U/eHdBxV1soe5i4Vub1XRt1Jt5HpaZxi2VGN5UBBcAIkf
         NR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=H3OrDofXIJNg5gNDuajb4iwLISeM3eIYfAoQCgv9KBA=;
        b=FiOp3I06mx9S8rha43A27nAD7jQdRtEFVpj0aEhmjqcVluJgb8GJRYCTnp11gjApZq
         keOzKmP/mNs9ic9rogIk562/KIWzB79HvkAfuAqmJX+176cYt4YCTSH6TED+YnQb2gWx
         c2mYs35S/qgJ9PS4SHn2lJuaHdGt7UVFVAxJN/cJXBzVlHwiOQjMqz6NmWOkUIFm8v+A
         3no79ktm2suYSKsB5LcWvjQta8pkiS4HhmfNcMNMe0mZeigd/GdSYdNVt450c5+LOMZf
         4iX7ypufmgCMLp2r6EVdrf5ZinqZnRRn2qJHUHZ+wmQ7cW/g1Spm+LxOrbZYt37T9S2A
         WP5g==
X-Gm-Message-State: AA+aEWbRWcnrDPToj9H+3K7LMASd/UZF6jE5/YNqner17C2SD8KHPLtU
        gP5Um3lTuR03ePIr5O8PBt5hnfHt
X-Google-Smtp-Source: AFSGD/VhO1IBLm8QYOHS3nozJ63AJddKUJfUMAdaePFD8zOycEEkg3Svl+FORxjzYtL6I5PowVg7Tg==
X-Received: by 2002:a17:906:1b12:: with SMTP id o18-v6mr3463695ejg.65.1544827148371;
        Fri, 14 Dec 2018 14:39:08 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id y16sm1756578edb.41.2018.12.14.14.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 14:39:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        jonathantanmy@google.com, szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/1] protocol: advertise multiple supported versions
References: <cover.1542162201.git.steadmon@google.com> <cover.1542407348.git.steadmon@google.com> <60f6f2fbd8ee03b2d461803b9313b7473300eecc.1542407348.git.steadmon@google.com> <87imzv273e.fsf@evledraar.gmail.com> <20181214215804.GF37614@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181214215804.GF37614@google.com>
Date:   Fri, 14 Dec 2018 23:39:06 +0100
Message-ID: <87h8ff20ol.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 14 2018, Josh Steadmon wrote:

> On 2018.12.14 21:20, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Fri, Nov 16 2018, Josh Steadmon wrote:
>>
>> I started looking at this to address
>> https://public-inbox.org/git/nycvar.QRO.7.76.6.1812141318520.43@tvgsbejvaqbjf.bet/
>> and was about to send a re-roll of my own series, but then...
>>
>> > Currently the client advertises that it supports the wire protocol
>> > version set in the protocol.version config. However, not all services
>> > support the same set of protocol versions. For example, git-receive-pack
>> > supports v1 and v0, but not v2. If a client connects to git-receive-pack
>> > and requests v2, it will instead be downgraded to v0. Other services,
>> > such as git-upload-archive, do not do any version negotiation checks.
>> >
>> > This patch creates a protocol version registry. Individual client and
>> > server programs register all the protocol versions they support prior to
>> > communicating with a remote instance. Versions should be listed in
>> > preference order; the version specified in protocol.version will
>> > automatically be moved to the front of the registry.
>> >
>> > The protocol version registry is passed to remote helpers via the
>> > GIT_PROTOCOL environment variable.
>> >
>> > Clients now advertise the full list of registered versions. Servers
>> > select the first allowed version from this advertisement.
>> >
>> > Additionally, remove special cases around advertising version=0.
>> > Previously we avoided adding version negotiation fields in server
>> > responses if it looked like the client wanted v0. However, including
>> > these fields does not change behavior, so it's better to have simpler
>> > code.
>>
>> ...this paragraph is new in your v5, from the cover letter: "Changes
>> from V4: remove special cases around advertising version=0". However as
>> seen in the code & tests:
>>
>> > [...]
>> >  static void push_ssh_options(struct argv_array *args, struct argv_array *env,
>> >  			     enum ssh_variant variant, const char *port,
>> > -			     enum protocol_version version, int flags)
>> > +			     const struct strbuf *version_advert, int flags)
>> >  {
>> > -	if (variant == VARIANT_SSH &&
>> > -	    version > 0) {
>> > +	if (variant == VARIANT_SSH) {
>> >  		argv_array_push(args, "-o");
>> >  		argv_array_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
>> > -		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
>> > -				 version);
>> > +		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
>> > +				 version_advert->buf);
>> >  	}
>> > [...]
>> > --- a/t/t5601-clone.sh
>> > +++ b/t/t5601-clone.sh
>> > @@ -346,7 +346,7 @@ expect_ssh () {
>> >
>> >  test_expect_success 'clone myhost:src uses ssh' '
>> >  	git clone myhost:src ssh-clone &&
>> > -	expect_ssh myhost src
>> > +	expect_ssh "-o SendEnv=GIT_PROTOCOL" myhost src
>> >  '
>> >
>> >  test_expect_success !MINGW,!CYGWIN 'clone local path foo:bar' '
>> > @@ -357,12 +357,12 @@ test_expect_success !MINGW,!CYGWIN 'clone local path foo:bar' '
>> >
>> >  test_expect_success 'bracketed hostnames are still ssh' '
>> >  	git clone "[myhost:123]:src" ssh-bracket-clone &&
>> > -	expect_ssh "-p 123" myhost src
>> > +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
>> >  '
>> >
>> >  test_expect_success 'OpenSSH variant passes -4' '
>> >  	git clone -4 "[myhost:123]:src" ssh-ipv4-clone &&
>> > -	expect_ssh "-4 -p 123" myhost src
>> > +	expect_ssh "-o SendEnv=GIT_PROTOCOL -4 -p 123" myhost src
>> >  '
>> >
>> >  test_expect_success 'variant can be overridden' '
>> > @@ -406,7 +406,7 @@ test_expect_success 'OpenSSH-like uplink is treated as ssh' '
>> >  	GIT_SSH="$TRASH_DIRECTORY/uplink" &&
>> >  	test_when_finished "GIT_SSH=\"\$TRASH_DIRECTORY/ssh\$X\"" &&
>> >  	git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
>> > -	expect_ssh "-p 123" myhost src
>> > +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
>> >  '
>> >
>> >  test_expect_success 'plink is treated specially (as putty)' '
>> > @@ -446,14 +446,14 @@ test_expect_success 'GIT_SSH_VARIANT overrides plink detection' '
>> >  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
>> >  	GIT_SSH_VARIANT=ssh \
>> >  	git clone "[myhost:123]:src" ssh-bracket-clone-variant-1 &&
>> > -	expect_ssh "-p 123" myhost src
>> > +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
>> >  '
>> >
>> >  test_expect_success 'ssh.variant overrides plink detection' '
>> >  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
>> >  	git -c ssh.variant=ssh \
>> >  		clone "[myhost:123]:src" ssh-bracket-clone-variant-2 &&
>> > -	expect_ssh "-p 123" myhost src
>> > +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
>> >  '
>> >
>> >  test_expect_success 'GIT_SSH_VARIANT overrides plink detection to plink' '
>> > @@ -488,7 +488,7 @@ test_clone_url () {
>> >  }
>> >
>> >  test_expect_success !MINGW 'clone c:temp is ssl' '
>> > -	test_clone_url c:temp c temp
>> > +	test_clone_url c:temp "-o SendEnv=GIT_PROTOCOL" c temp
>> >  '
>> >
>> >  test_expect_success MINGW 'clone c:temp is dos drive' '
>> > @@ -499,7 +499,7 @@ test_expect_success MINGW 'clone c:temp is dos drive' '
>> >  for repo in rep rep/home/project 123
>> >  do
>> >  	test_expect_success "clone host:$repo" '
>> > -		test_clone_url host:$repo host $repo
>> > +		test_clone_url host:$repo "-o SendEnv=GIT_PROTOCOL" host $repo
>> >  	'
>> >  done
>> >
>> > @@ -507,16 +507,16 @@ done
>> >  for repo in rep rep/home/project 123
>> >  do
>> >  	test_expect_success "clone [::1]:$repo" '
>> > -		test_clone_url [::1]:$repo ::1 "$repo"
>> > +		test_clone_url [::1]:$repo "-o SendEnv=GIT_PROTOCOL" ::1 "$repo"
>> >  	'
>> >  done
>> >  #home directory
>> >  test_expect_success "clone host:/~repo" '
>> > -	test_clone_url host:/~repo host "~repo"
>> > +	test_clone_url host:/~repo "-o SendEnv=GIT_PROTOCOL" host "~repo"
>> >  '
>> >
>> >  test_expect_success "clone [::1]:/~repo" '
>> > -	test_clone_url [::1]:/~repo ::1 "~repo"
>> > +	test_clone_url [::1]:/~repo "-o SendEnv=GIT_PROTOCOL" ::1 "~repo"
>> >  '
>> >
>> >  # Corner cases
>> > @@ -532,22 +532,22 @@ done
>> >  for tcol in "" :
>> >  do
>> >  	test_expect_success "clone ssh://host.xz$tcol/home/user/repo" '
>> > -		test_clone_url "ssh://host.xz$tcol/home/user/repo" host.xz /home/user/repo
>> > +		test_clone_url "ssh://host.xz$tcol/home/user/repo" "-o SendEnv=GIT_PROTOCOL" host.xz /home/user/repo
>> >  	'
>> >  	# from home directory
>> >  	test_expect_success "clone ssh://host.xz$tcol/~repo" '
>> > -	test_clone_url "ssh://host.xz$tcol/~repo" host.xz "~repo"
>> > +	test_clone_url "ssh://host.xz$tcol/~repo" "-o SendEnv=GIT_PROTOCOL" host.xz "~repo"
>> >  '
>> >  done
>> >
>> >  # with port number
>> >  test_expect_success 'clone ssh://host.xz:22/home/user/repo' '
>> > -	test_clone_url "ssh://host.xz:22/home/user/repo" "-p 22 host.xz" "/home/user/repo"
>> > +	test_clone_url "ssh://host.xz:22/home/user/repo" "-o SendEnv=GIT_PROTOCOL -p 22 host.xz" "/home/user/repo"
>> >  '
>> >
>> >  # from home directory with port number
>> >  test_expect_success 'clone ssh://host.xz:22/~repo' '
>> > -	test_clone_url "ssh://host.xz:22/~repo" "-p 22 host.xz" "~repo"
>> > +	test_clone_url "ssh://host.xz:22/~repo" "-o SendEnv=GIT_PROTOCOL -p 22 host.xz" "~repo"
>> >  '
>> >
>> >  #IPv6
>> > @@ -555,7 +555,7 @@ for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1] [user@::
>> >  do
>> >  	ehost=$(echo $tuah | sed -e "s/1]:/1]/" | tr -d "[]")
>> >  	test_expect_success "clone ssh://$tuah/home/user/repo" "
>> > -	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
>> > +	  test_clone_url ssh://$tuah/home/user/repo '-o SendEnv=GIT_PROTOCOL' $ehost /home/user/repo
>> >  	"
>> >  done
>> >
>> > @@ -564,7 +564,7 @@ for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
>> >  do
>> >  	euah=$(echo $tuah | tr -d "[]")
>> >  	test_expect_success "clone ssh://$tuah/~repo" "
>> > -	  test_clone_url ssh://$tuah/~repo $euah '~repo'
>> > +	  test_clone_url ssh://$tuah/~repo '-o SendEnv=GIT_PROTOCOL' $euah '~repo'
>> >  	"
>> >  done
>> >
>> > @@ -573,7 +573,7 @@ for tuah in [::1] user@[::1] [user@::1]
>> >  do
>> >  	euah=$(echo $tuah | tr -d "[]")
>> >  	test_expect_success "clone ssh://$tuah:22/home/user/repo" "
>> > -	  test_clone_url ssh://$tuah:22/home/user/repo '-p 22' $euah /home/user/repo
>> > +	  test_clone_url ssh://$tuah:22/home/user/repo '-o SendEnv=GIT_PROTOCOL -p 22' $euah /home/user/repo
>> >  	"
>> >  done
>> >
>> > @@ -582,7 +582,7 @@ for tuah in [::1] user@[::1] [user@::1]
>> >  do
>> >  	euah=$(echo $tuah | tr -d "[]")
>> >  	test_expect_success "clone ssh://$tuah:22/~repo" "
>> > -	  test_clone_url ssh://$tuah:22/~repo '-p 22' $euah '~repo'
>> > +	  test_clone_url ssh://$tuah:22/~repo '-o SendEnv=GIT_PROTOCOL -p 22' $euah '~repo'
>> >  	"
>> >  done
>>
>> ...so now we're unconditionally going to SendEnv=GIT_PROTOCOL to "ssh"
>> invocations. I don't have an issue with this, but given the change in
>> the commit message this seems to have snuck under the radar. You're just
>> talking about always including the version in server responses, nothing
>> about the client always needing SendEnv=GIT_PROTOCOL now even with v0.
>
> Ack. I'll make sure that V6 calls this out in the commit message.
>
>
>> If the server always sends the version now, why don't you need to amend
>> the same t5400-send-pack.sh tests as in my "tests: mark & fix tests
>> broken under GIT_TEST_PROTOCOL_VERSION=1"? There's one that spews out
>> "version" there under my GIT_TEST_PROTOCOL_VERSION=1.
>
> Sorry if I'm being dense, but can you point out more specifically what
> is wrong here? I don't see anything in t5400 that would be affected by
> this; the final test case ("receive-pack de-dupes .have lines") is the
> only one that does any tracing, and it strips out everything that's not
> a ref advertisement before checking the output. Sorry if I'm missing
> something obvious.

I think I'm just misunderstanding this bit:

    Additionally, remove special cases around advertising version=0.
    Previously we avoided adding version negotiation fields in server
    responses if it looked like the client wanted v0. However, including
    these fields does not change behavior, so it's better to have
    simpler code.

I meant that if you pick the series I have up to "tests: add a special
setup that sets protocol.version", which is at c6f33984fc in a WIP
branch in github.com/avar/git.git and run:

    $ GIT_TEST_PROTOCOL_VERSION=1 ./t5400-send-pack.sh -v -i -x

It'll fail with:

    + test_cmp expect refs
    + diff -u expect refs
    --- expect      2018-12-14 22:26:52.485411992 +0000
    +++ refs        2018-12-14 22:26:52.713412148 +0000
    @@ -1,3 +1,4 @@
    +version 1
     5285e1710002a06a379056b0d21357a999f3c642 refs/heads/master
     5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/HEAD
     5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/master
    error: last command exited with $?=1
    not ok 16 - receive-pack de-dupes .have lines

And I read your commit message to mean "v0 clients also support v1
responses with the version in them, so let's just always send it". But I
think this is my confusion (but I still don't know what it *really*
means).

>> I was worried about this breaking GIT_SSH_COMMAND, but then I see due to
>> an interaction with picking "what ssh implementation?" we don't pass "-G
>> -o SendEnv=GIT_PROTOCOL" at all when I have a GIT_SSH_COMMAND, but *do*
>> pass it to my normal /usr/bin/ssh. Is this intended? Now if I have a
>> GIT_SSH_COMMAND that expects to wrap openssh I need to pass "-c
>> ssh.variant=ssh", because "-c ssh.variant=auto" will now omit these new
>> arguments.
>
> I am not an expert on this part of the code, but it seems to be
> intended. Later on in the function, there are BUG()s that state that
> VARIANT_AUTO should not be passed to the push_ssh_options() function.
> And this only changes the behavior when version=0. For protocol versions
> 1 & 2, VARIANT_AUTO never had SendEnv=GIT_PROTOCOL added to the command
> line. Again, sorry if I'm missing some implication here.

I'm wondering if we need to worry about some new odd interactions
between client/servers when using GIT_SSH* wrappers, maybe not, but
e.g. as opposed to 0da0e49ba1 ("ssh: 'auto' variant to select between
'ssh' and 'simple'", 2017-11-20) which noted a similar change had been
tested at Google internally (and I read it as Google using GIT_SSH* on
workstations) your commit doesn't make any mention of this case being
tested / considered.

So do we need to worry about some new interaction here? Maybe not. Just
something for people more experienced with the ssh integration to chime
in on.
