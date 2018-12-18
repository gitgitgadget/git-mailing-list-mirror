Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2C191F405
	for <e@80x24.org>; Tue, 18 Dec 2018 23:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeLRXFW (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 18:05:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33739 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeLRXFW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 18:05:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so8515692pgu.0
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 15:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jwtt5fbYOEU33Dk0gpnw17zONKPi3O9k+3+8hEbLZF0=;
        b=qnOXY/mKfoehlDBFpCRasSl6z/4YkEdEZ7dIq5wOOFOtbdMrB+8KhFBD0VrENclkZd
         veJHdrM1GC/vIRFI2VvwMNHYPjAmF0FVxURBsOmaR6R9I9pYe83Jp0YfMAgzB8Mv6rCG
         /IVMEXX4AumadYszEu57Wue98BWIbdfqW0dXoSGlKCJlWvP9nx9jgJ2HRA52ME6QhFt4
         fxVCrjS5J3FK7yRwi82FTNYu+HyO5SkIS/TCAzcaRlXbckm4xk9NYigLW+ZYo2mZKHan
         vrNzPjFSu5GvwQJgQ+jxS7KW/K6Zu9tIDHJJpURLLzb/YHo8PfBblt/c2ijJWv7FCFkP
         f4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jwtt5fbYOEU33Dk0gpnw17zONKPi3O9k+3+8hEbLZF0=;
        b=LfbZ8UMj0xX81il7Ed5rUmm2Z/6OzgrOcQ6TNIB6fS2hTwJaiczJyKp5fx7P1h7ZzI
         XYnPKPRUwUkSOk08/M9gTouu1tubR8E0GopJDQo5md1tQ89lK0ssF4e33kPTi8MbTxTp
         ZvMxhNlBn7kPkIuCXSzCaBTGhF2h4rUxzkkuQq/hUqUyuIOxFDn3CwlawSC0WHYkXHrx
         QOCBV713J9RmJ7FJRwXL5Yp5S46FvT5B0bc8fu8fzllaXCZT2bk3lgrV8RSasYF+br5t
         fS4c+fSKp309pgxrXDDbFOtsV5QBsKlUISrR1dPTbs1maTV2DSqpaTEfrjL1TVhDuomq
         NNig==
X-Gm-Message-State: AA+aEWYP/SD1arw2P1hFaB7JJ/PEMWU8sUxER4jKMv6rF8Pl7geuPohI
        gEGw2g+mVj/jHmf0VxSG7gRKOA==
X-Google-Smtp-Source: AFSGD/WNp8U2cHp7beNVBk/Myl65cit84FPNZJfUgGI6NG2i2GvX4ffLdl5aMdiF7HYsEMjdp9pl8g==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr17090162pgi.8.1545174320638;
        Tue, 18 Dec 2018 15:05:20 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id 78sm24147215pft.184.2018.12.18.15.05.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 15:05:19 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:05:14 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        jonathantanmy@google.com, szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/1] protocol: advertise multiple supported versions
Message-ID: <20181218230514.GH37614@google.com>
Mail-Followup-To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        jonathantanmy@google.com, szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
References: <cover.1542162201.git.steadmon@google.com>
 <cover.1542407348.git.steadmon@google.com>
 <60f6f2fbd8ee03b2d461803b9313b7473300eecc.1542407348.git.steadmon@google.com>
 <87imzv273e.fsf@evledraar.gmail.com>
 <20181214215804.GF37614@google.com>
 <87h8ff20ol.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8ff20ol.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.12.14 23:39, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Dec 14 2018, Josh Steadmon wrote:
> 
> > On 2018.12.14 21:20, Ævar Arnfjörð Bjarmason wrote:
> >>
> >> On Fri, Nov 16 2018, Josh Steadmon wrote:
> >>
> >> I started looking at this to address
> >> https://public-inbox.org/git/nycvar.QRO.7.76.6.1812141318520.43@tvgsbejvaqbjf.bet/
> >> and was about to send a re-roll of my own series, but then...
> >>
> >> > Currently the client advertises that it supports the wire protocol
> >> > version set in the protocol.version config. However, not all services
> >> > support the same set of protocol versions. For example, git-receive-pack
> >> > supports v1 and v0, but not v2. If a client connects to git-receive-pack
> >> > and requests v2, it will instead be downgraded to v0. Other services,
> >> > such as git-upload-archive, do not do any version negotiation checks.
> >> >
> >> > This patch creates a protocol version registry. Individual client and
> >> > server programs register all the protocol versions they support prior to
> >> > communicating with a remote instance. Versions should be listed in
> >> > preference order; the version specified in protocol.version will
> >> > automatically be moved to the front of the registry.
> >> >
> >> > The protocol version registry is passed to remote helpers via the
> >> > GIT_PROTOCOL environment variable.
> >> >
> >> > Clients now advertise the full list of registered versions. Servers
> >> > select the first allowed version from this advertisement.
> >> >
> >> > Additionally, remove special cases around advertising version=0.
> >> > Previously we avoided adding version negotiation fields in server
> >> > responses if it looked like the client wanted v0. However, including
> >> > these fields does not change behavior, so it's better to have simpler
> >> > code.
> >>
> >> ...this paragraph is new in your v5, from the cover letter: "Changes
> >> from V4: remove special cases around advertising version=0". However as
> >> seen in the code & tests:
> >>
> >> > [...]
> >> >  static void push_ssh_options(struct argv_array *args, struct argv_array *env,
> >> >  			     enum ssh_variant variant, const char *port,
> >> > -			     enum protocol_version version, int flags)
> >> > +			     const struct strbuf *version_advert, int flags)
> >> >  {
> >> > -	if (variant == VARIANT_SSH &&
> >> > -	    version > 0) {
> >> > +	if (variant == VARIANT_SSH) {
> >> >  		argv_array_push(args, "-o");
> >> >  		argv_array_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
> >> > -		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
> >> > -				 version);
> >> > +		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
> >> > +				 version_advert->buf);
> >> >  	}
> >> > [...]
> >> > --- a/t/t5601-clone.sh
> >> > +++ b/t/t5601-clone.sh
> >> > @@ -346,7 +346,7 @@ expect_ssh () {
> >> >
> >> >  test_expect_success 'clone myhost:src uses ssh' '
> >> >  	git clone myhost:src ssh-clone &&
> >> > -	expect_ssh myhost src
> >> > +	expect_ssh "-o SendEnv=GIT_PROTOCOL" myhost src
> >> >  '
> >> >
> >> >  test_expect_success !MINGW,!CYGWIN 'clone local path foo:bar' '
> >> > @@ -357,12 +357,12 @@ test_expect_success !MINGW,!CYGWIN 'clone local path foo:bar' '
> >> >
> >> >  test_expect_success 'bracketed hostnames are still ssh' '
> >> >  	git clone "[myhost:123]:src" ssh-bracket-clone &&
> >> > -	expect_ssh "-p 123" myhost src
> >> > +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
> >> >  '
> >> >
> >> >  test_expect_success 'OpenSSH variant passes -4' '
> >> >  	git clone -4 "[myhost:123]:src" ssh-ipv4-clone &&
> >> > -	expect_ssh "-4 -p 123" myhost src
> >> > +	expect_ssh "-o SendEnv=GIT_PROTOCOL -4 -p 123" myhost src
> >> >  '
> >> >
> >> >  test_expect_success 'variant can be overridden' '
> >> > @@ -406,7 +406,7 @@ test_expect_success 'OpenSSH-like uplink is treated as ssh' '
> >> >  	GIT_SSH="$TRASH_DIRECTORY/uplink" &&
> >> >  	test_when_finished "GIT_SSH=\"\$TRASH_DIRECTORY/ssh\$X\"" &&
> >> >  	git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
> >> > -	expect_ssh "-p 123" myhost src
> >> > +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
> >> >  '
> >> >
> >> >  test_expect_success 'plink is treated specially (as putty)' '
> >> > @@ -446,14 +446,14 @@ test_expect_success 'GIT_SSH_VARIANT overrides plink detection' '
> >> >  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
> >> >  	GIT_SSH_VARIANT=ssh \
> >> >  	git clone "[myhost:123]:src" ssh-bracket-clone-variant-1 &&
> >> > -	expect_ssh "-p 123" myhost src
> >> > +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
> >> >  '
> >> >
> >> >  test_expect_success 'ssh.variant overrides plink detection' '
> >> >  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
> >> >  	git -c ssh.variant=ssh \
> >> >  		clone "[myhost:123]:src" ssh-bracket-clone-variant-2 &&
> >> > -	expect_ssh "-p 123" myhost src
> >> > +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
> >> >  '
> >> >
> >> >  test_expect_success 'GIT_SSH_VARIANT overrides plink detection to plink' '
> >> > @@ -488,7 +488,7 @@ test_clone_url () {
> >> >  }
> >> >
> >> >  test_expect_success !MINGW 'clone c:temp is ssl' '
> >> > -	test_clone_url c:temp c temp
> >> > +	test_clone_url c:temp "-o SendEnv=GIT_PROTOCOL" c temp
> >> >  '
> >> >
> >> >  test_expect_success MINGW 'clone c:temp is dos drive' '
> >> > @@ -499,7 +499,7 @@ test_expect_success MINGW 'clone c:temp is dos drive' '
> >> >  for repo in rep rep/home/project 123
> >> >  do
> >> >  	test_expect_success "clone host:$repo" '
> >> > -		test_clone_url host:$repo host $repo
> >> > +		test_clone_url host:$repo "-o SendEnv=GIT_PROTOCOL" host $repo
> >> >  	'
> >> >  done
> >> >
> >> > @@ -507,16 +507,16 @@ done
> >> >  for repo in rep rep/home/project 123
> >> >  do
> >> >  	test_expect_success "clone [::1]:$repo" '
> >> > -		test_clone_url [::1]:$repo ::1 "$repo"
> >> > +		test_clone_url [::1]:$repo "-o SendEnv=GIT_PROTOCOL" ::1 "$repo"
> >> >  	'
> >> >  done
> >> >  #home directory
> >> >  test_expect_success "clone host:/~repo" '
> >> > -	test_clone_url host:/~repo host "~repo"
> >> > +	test_clone_url host:/~repo "-o SendEnv=GIT_PROTOCOL" host "~repo"
> >> >  '
> >> >
> >> >  test_expect_success "clone [::1]:/~repo" '
> >> > -	test_clone_url [::1]:/~repo ::1 "~repo"
> >> > +	test_clone_url [::1]:/~repo "-o SendEnv=GIT_PROTOCOL" ::1 "~repo"
> >> >  '
> >> >
> >> >  # Corner cases
> >> > @@ -532,22 +532,22 @@ done
> >> >  for tcol in "" :
> >> >  do
> >> >  	test_expect_success "clone ssh://host.xz$tcol/home/user/repo" '
> >> > -		test_clone_url "ssh://host.xz$tcol/home/user/repo" host.xz /home/user/repo
> >> > +		test_clone_url "ssh://host.xz$tcol/home/user/repo" "-o SendEnv=GIT_PROTOCOL" host.xz /home/user/repo
> >> >  	'
> >> >  	# from home directory
> >> >  	test_expect_success "clone ssh://host.xz$tcol/~repo" '
> >> > -	test_clone_url "ssh://host.xz$tcol/~repo" host.xz "~repo"
> >> > +	test_clone_url "ssh://host.xz$tcol/~repo" "-o SendEnv=GIT_PROTOCOL" host.xz "~repo"
> >> >  '
> >> >  done
> >> >
> >> >  # with port number
> >> >  test_expect_success 'clone ssh://host.xz:22/home/user/repo' '
> >> > -	test_clone_url "ssh://host.xz:22/home/user/repo" "-p 22 host.xz" "/home/user/repo"
> >> > +	test_clone_url "ssh://host.xz:22/home/user/repo" "-o SendEnv=GIT_PROTOCOL -p 22 host.xz" "/home/user/repo"
> >> >  '
> >> >
> >> >  # from home directory with port number
> >> >  test_expect_success 'clone ssh://host.xz:22/~repo' '
> >> > -	test_clone_url "ssh://host.xz:22/~repo" "-p 22 host.xz" "~repo"
> >> > +	test_clone_url "ssh://host.xz:22/~repo" "-o SendEnv=GIT_PROTOCOL -p 22 host.xz" "~repo"
> >> >  '
> >> >
> >> >  #IPv6
> >> > @@ -555,7 +555,7 @@ for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1] [user@::
> >> >  do
> >> >  	ehost=$(echo $tuah | sed -e "s/1]:/1]/" | tr -d "[]")
> >> >  	test_expect_success "clone ssh://$tuah/home/user/repo" "
> >> > -	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
> >> > +	  test_clone_url ssh://$tuah/home/user/repo '-o SendEnv=GIT_PROTOCOL' $ehost /home/user/repo
> >> >  	"
> >> >  done
> >> >
> >> > @@ -564,7 +564,7 @@ for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
> >> >  do
> >> >  	euah=$(echo $tuah | tr -d "[]")
> >> >  	test_expect_success "clone ssh://$tuah/~repo" "
> >> > -	  test_clone_url ssh://$tuah/~repo $euah '~repo'
> >> > +	  test_clone_url ssh://$tuah/~repo '-o SendEnv=GIT_PROTOCOL' $euah '~repo'
> >> >  	"
> >> >  done
> >> >
> >> > @@ -573,7 +573,7 @@ for tuah in [::1] user@[::1] [user@::1]
> >> >  do
> >> >  	euah=$(echo $tuah | tr -d "[]")
> >> >  	test_expect_success "clone ssh://$tuah:22/home/user/repo" "
> >> > -	  test_clone_url ssh://$tuah:22/home/user/repo '-p 22' $euah /home/user/repo
> >> > +	  test_clone_url ssh://$tuah:22/home/user/repo '-o SendEnv=GIT_PROTOCOL -p 22' $euah /home/user/repo
> >> >  	"
> >> >  done
> >> >
> >> > @@ -582,7 +582,7 @@ for tuah in [::1] user@[::1] [user@::1]
> >> >  do
> >> >  	euah=$(echo $tuah | tr -d "[]")
> >> >  	test_expect_success "clone ssh://$tuah:22/~repo" "
> >> > -	  test_clone_url ssh://$tuah:22/~repo '-p 22' $euah '~repo'
> >> > +	  test_clone_url ssh://$tuah:22/~repo '-o SendEnv=GIT_PROTOCOL -p 22' $euah '~repo'
> >> >  	"
> >> >  done
> >>
> >> ...so now we're unconditionally going to SendEnv=GIT_PROTOCOL to "ssh"
> >> invocations. I don't have an issue with this, but given the change in
> >> the commit message this seems to have snuck under the radar. You're just
> >> talking about always including the version in server responses, nothing
> >> about the client always needing SendEnv=GIT_PROTOCOL now even with v0.
> >
> > Ack. I'll make sure that V6 calls this out in the commit message.
> >
> >
> >> If the server always sends the version now, why don't you need to amend
> >> the same t5400-send-pack.sh tests as in my "tests: mark & fix tests
> >> broken under GIT_TEST_PROTOCOL_VERSION=1"? There's one that spews out
> >> "version" there under my GIT_TEST_PROTOCOL_VERSION=1.
> >
> > Sorry if I'm being dense, but can you point out more specifically what
> > is wrong here? I don't see anything in t5400 that would be affected by
> > this; the final test case ("receive-pack de-dupes .have lines") is the
> > only one that does any tracing, and it strips out everything that's not
> > a ref advertisement before checking the output. Sorry if I'm missing
> > something obvious.
> 
> I think I'm just misunderstanding this bit:
> 
>     Additionally, remove special cases around advertising version=0.
>     Previously we avoided adding version negotiation fields in server
>     responses if it looked like the client wanted v0. However, including
>     these fields does not change behavior, so it's better to have
>     simpler code.

Ah yes, that is a bad description, which I will fix in V6. It should
replace "server responses" to instead be "client requests". Sorry for
the confusion, that was a really silly mistake for me to make.

Basically, in the current master, clients will not add a version
advertisement to their request if their only supported version is 0.
With this patch, they will always include a version advertisement.

> I meant that if you pick the series I have up to "tests: add a special
> setup that sets protocol.version", which is at c6f33984fc in a WIP
> branch in github.com/avar/git.git and run:
> 
>     $ GIT_TEST_PROTOCOL_VERSION=1 ./t5400-send-pack.sh -v -i -x
> 
> It'll fail with:
> 
>     + test_cmp expect refs
>     + diff -u expect refs
>     --- expect      2018-12-14 22:26:52.485411992 +0000
>     +++ refs        2018-12-14 22:26:52.713412148 +0000
>     @@ -1,3 +1,4 @@
>     +version 1
>      5285e1710002a06a379056b0d21357a999f3c642 refs/heads/master
>      5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/HEAD
>      5285e1710002a06a379056b0d21357a999f3c642 refs/remotes/origin/master
>     error: last command exited with $?=1
>     not ok 16 - receive-pack de-dupes .have lines

I believe the reason that my series doesn't fail on this test while
yours does with GIT_TEST_PROTOCOL_VERSION=1 is because the "fork" repo
in the test is a clone from the local filesystem. So in my case the
version negotiation differences are not visible in the trace output of
"git push" (since the advert should be in an environment variable in
this case).

> And I read your commit message to mean "v0 clients also support v1
> responses with the version in them, so let's just always send it". But I
> think this is my confusion (but I still don't know what it *really*
> means).

Yeah again, a dumb mistake in the description on my part. We are only
changing whether the client sends a version advertisement. If everything
else is equal, there should be no behavior changes apart from the
version advertisement.

> >> I was worried about this breaking GIT_SSH_COMMAND, but then I see due to
> >> an interaction with picking "what ssh implementation?" we don't pass "-G
> >> -o SendEnv=GIT_PROTOCOL" at all when I have a GIT_SSH_COMMAND, but *do*
> >> pass it to my normal /usr/bin/ssh. Is this intended? Now if I have a
> >> GIT_SSH_COMMAND that expects to wrap openssh I need to pass "-c
> >> ssh.variant=ssh", because "-c ssh.variant=auto" will now omit these new
> >> arguments.
> >
> > I am not an expert on this part of the code, but it seems to be
> > intended. Later on in the function, there are BUG()s that state that
> > VARIANT_AUTO should not be passed to the push_ssh_options() function.
> > And this only changes the behavior when version=0. For protocol versions
> > 1 & 2, VARIANT_AUTO never had SendEnv=GIT_PROTOCOL added to the command
> > line. Again, sorry if I'm missing some implication here.
> 
> I'm wondering if we need to worry about some new odd interactions
> between client/servers when using GIT_SSH* wrappers, maybe not, but
> e.g. as opposed to 0da0e49ba1 ("ssh: 'auto' variant to select between
> 'ssh' and 'simple'", 2017-11-20) which noted a similar change had been
> tested at Google internally (and I read it as Google using GIT_SSH* on
> workstations) your commit doesn't make any mention of this case being
> tested / considered.
> 
> So do we need to worry about some new interaction here? Maybe not. Just
> something for people more experienced with the ssh integration to chime
> in on.

After taking a look at 0da0e49ba1 (thanks for the find) and reading
fill_ssh_args(), it seems to me that this is the intended behavior.
ssh.variant=auto means that we will run an initial "$ssh_command -G" to
see if the wrapper seems to handle OpenSSH arguments; if so we will
switch the variant to VARIANT_SSH and run again with the proper options
(including SendEnv=GIT_PROTOCOL).
