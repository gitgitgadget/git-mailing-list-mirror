Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A88D31F516
	for <e@80x24.org>; Tue, 26 Jun 2018 17:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbeFZRKD (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 13:10:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52995 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753199AbeFZRKA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 13:10:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so2825874wmb.2
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8bO+5HmJnE5qqczsep8VJUsZoISqy8UOT6bOaxt5frQ=;
        b=nS3z2NPA1Pg4EIQvA8gb9Rkkfn1JKvjMKugVUqZlK6QSEoGvS2ziqny+bhm9OSV8I1
         tItqmD73wSN5+0qyk0pzm/3lHkK692Ov40CgU6WvwBB16IwGGYJSNcBP96rIB0/eEjdt
         Tv+NvrAhrfv7nuolY8AjDlP+N7LoPsm57BzeC+Dr9Am7WwOHqUvY5pMWBntYgStT0SFn
         IFRPVpLPuw+LdihTCeECWUihbHWikYG06zNpZ2pjpfiBzrmGKFYvSm/tWCLwLsJHWl2M
         MVJFVlubH5fi0cniDEv2ToXlR+s27zoM5cRKnBY0nYXQYXDK1eWzHvvnYLhaTc1dKqTw
         cB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8bO+5HmJnE5qqczsep8VJUsZoISqy8UOT6bOaxt5frQ=;
        b=Cy3qB1z7gP/KsMj4EkgYq5u17ZMV04z+hzpJ0VG66hLHN6842mJcwxCswQ5udtlkjx
         ia2WmVdeF7uN4nOTV8b7ERRt7bRaAFZ7MrqocefSKbvsByz6XlUOMsY045B9EhbcEBvy
         xxpw1lyoo7yb0JSEvw+sCF0IZKzkuaz/O/QvECEIhU/esxnWCftHMHYXENruROH8xn3y
         XUNeYPRbISVVDkrvwPr4rV9f88a2XzxmR8RjhT0CSKvCxaFDDb26ndd+r4Jgdq+Bw0oQ
         1c46hgZB8k0bRz+8A7/xQgBST+417zXMqr8eVOMMaY294moShAPG6o6yxrNFdlB5VS4b
         vD0g==
X-Gm-Message-State: APt69E1ZhShTWZ2HXdsSiWvcOskL154LTqOlYB67uY9nNX9goyKgp4I4
        DX88ReoA4+Av53Q+4U6E+A8=
X-Google-Smtp-Source: AAOMgpeQQLMHBn2s6TOkT4m1+NqgxHdILITYSaWjKjQlkgCcrEESc2uMqkS7QKT+sZ0QnodxCMPqUg==
X-Received: by 2002:a1c:29c5:: with SMTP id p188-v6mr2235382wmp.45.1530032999295;
        Tue, 26 Jun 2018 10:09:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o12-v6sm2244035wrn.4.2018.06.26.10.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:09:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] url schemes should be case-insensitive
References: <20180624085622.GA28575@sigill.intra.peff.net>
        <xmqqvaa6ohiw.fsf@gitster-ct.c.googlers.com>
        <20180626122143.GA14052@sigill.intra.peff.net>
Date:   Tue, 26 Jun 2018 10:09:58 -0700
In-Reply-To: <20180626122143.GA14052@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 26 Jun 2018 08:21:43 -0400")
Message-ID: <xmqq1sctmq3d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > We seem to match url schemes case-sensitively:
>> >
>> >   $ git clone SSH://example.com/repo.git
>> >   Cloning into 'repo'...
>> >   fatal: Unable to find remote helper for 'SSH'
>> >
>> > whereas rfc3986 is clear that the scheme portion is case-insensitive.
>> > We probably ought to match at least our internal ones with strcasecmp.
>> 
>> That may break if somebody at DevToolGroup@$BIGCOMPANY got cute and
>> named their custom remote helper SSH:// that builds on top of the
>> normal ssh:// protocol with something extra and gave it to their
>> developers (and they named the http counterpart that has the same
>> extra HTTP://, of course).
>
> True, though I am on the fence whether that is a property worth
> maintaining. AFAIK it was not planned and is just a "this is how it
> happened to work" case that is (IMHO) doing the wrong thing.

FWIW, I fully agree with the assessment; sorry for not saying that
together with the devil's advocate comment to save a round-tip.

> It may also interact in a funny way with our allowed-protocol code, if
> "SSH" gets a pass as "ssh" under the default config, but actually runs
> the otherwise-disallowed git-remote-SSH (though one would _hope_ if you
> have such a git-remote-SSH that it behaves just like an ssh remote).

True.  I did not offhand recall how protocol whitelist matches the
protocol name with config, but transport.c::get_protocol_config()
seems to say that the <name> part of "protocol.<name>.allow" is case
sensitive, and we match known-safe (and known-unsafe "ext::")
protocols with strcmp() not strcasecmp().  We need to figure out the
implications of allowing SSH:// not to error out but pretending as
if it were ssh:// on those who have protocol.ssh.allow defined.

>> > We could probably also give an advise() message in the above output,
>> > suggesting that the problem is likely one of:
>> >
>> >   1. They misspelled the scheme.
>> >
>> >   2. They need to install the appropriate helper.
>> >
>> > This may be a good topic for somebody looking for low-hanging fruit to
>> > get involved in development (I'd maybe call it a #leftoverbits, but
>> > since I didn't start on it, I'm not sure if it counts as "left over" ;)).
>> [..]
>> It may probably be a good idea to do an advice, but I'd think
>> "Untable to find remote helper for 'SSH'" may be clear enough.  If
>> anything, perhaps saying "remote helper for 'SSH' protocol" would
>> make it even clear?  I dunno.
>
> I think it doesn't help much if the user does not know what a remote
> helper is, or why Git is looking for one.

True.  

	$ git clone SSH://example.com/repo.git
	fatal: unable to handle URL that begins with SSH://

would be clear enough, perhaps?  At least this line of change is a
small first step that would improve the situation without potential
to break anybody who has been abusing the case sensitivity loophole.

