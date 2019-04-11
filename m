Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803E620248
	for <e@80x24.org>; Thu, 11 Apr 2019 20:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDKUaV (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 16:30:21 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50928 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfDKUaU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 16:30:20 -0400
Received: by mail-pf1-f202.google.com with SMTP id a3so4929052pfi.17
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 13:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oQLKHN7xHpZWs4vcLGDS8pMcntQjKmsT13pRElICA4k=;
        b=SKSwlHx55K389NmA0j6PZh+IJyjRPV00mcXvGtT7h+2rpdXPfDRlMhp7IX/M3SUKRM
         0KK2fOULtXmnU/qB2bz3tQXHgEnVW3FU/5PhRhKS8owLbLVvBvyDU+uHpS1m/Q3RUI1N
         KqmP2vu5xIo+TGB/gpjSjzFRAhcriIMc5V5PjDVDPPCoYxf2AIyfamVm+ALhB0zy8oEm
         +t2XTbvS+u8x4e0/29Ir4I1xptra5N/MKG6+RwZs1XdvE1Nk0t8WulQ5bOG/4PL8i08K
         HUbeIM557DqitIAmYOl6koRU1rKwT1dSpD3tBbKRWnC73hdTuZQFHL89DftR1hk8dAx2
         HA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oQLKHN7xHpZWs4vcLGDS8pMcntQjKmsT13pRElICA4k=;
        b=gg48Msyurx+L5eRV3H6tTTZ0gDvr81H/5WsKkY9yxwgrYG2kcHRXHNzifSzBMU6LLP
         TGSj66filxe0BXS4/vwYC7WON7Ug0IGkMoiUno61LWvI2/zO4FRXXO2tTdcco4HUYq+9
         uiTPxk0r9MCbPgce+iRa8V+oOGwpqb17jXBCn2N4fdnFTc5/B9aCEI1LPIuQMll1vn/B
         zWFDcKeVHqvpwSwxpH7isLm/zm460SaHDKTAis0/nqIbiqpZVIQ1QzkORB0fx/PL1Gz1
         iMzx4cwxAfy1HJsGEkCF/UsTEBVeHY73/ZtAPSLUKd28+vkMUH7xGEBGNBbmO+iuB0A1
         TwFA==
X-Gm-Message-State: APjAAAUdRY8KUh8/66jWC5by791AYQ2iMpY8mnZbs+3E/fEfqnHK2PTm
        6Qget3V491+rlBw0STbkBsXhKHRJT/0nKRrcBPJ5+X4oH8zMapXeNAFfplmGKioZ6s3MbckUvqj
        +LE7Qu1XoDjI1nSXW4ee8L9JRJgOyQEwOMZ7rBWYiYfsIZTIdgeEAXpKyblMj4TqcDXmlkwhLdt
        8U
X-Google-Smtp-Source: APXvYqzpWTTyUMOgboQhC0THo4k7UHZtWu5d0pAJRuWEVhm6x7S7q7F8821ybzMpxITRzxJNq1E7tmSOJxzPh67SHQ50
X-Received: by 2002:a65:5c08:: with SMTP id u8mr1373149pgr.94.1555014619501;
 Thu, 11 Apr 2019 13:30:19 -0700 (PDT)
Date:   Thu, 11 Apr 2019 13:30:14 -0700
In-Reply-To: <20190405204413.93900-1-jonathantanmy@google.com>
Message-Id: <cover.1555014408.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190405204413.93900-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 0/2] Server options when cloning
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Jonathan Nieder, for your review.

> Thanks for writing this.  I'd be in favor of making this die().
> Compare what we already do in push:
> 
> 	if (args->push_options && !push_options_supported)
> 		die(_("the receiving end does not support push options"));

Thanks for pointing out what "push" does, and done.

> What happens in the case of push with protocol v0, where server options
> are supported?

They are just sent to the pre-receive and post-receive hooks, according
to the "git push" documentation. I added a mention of the push option
behavior in the 2nd commit's message.

> For example:
> 
> 	fatal: server options require protocol version 2 or later
> 	hint: see protocol.version in "git help config" for more details

Thanks - used your example (except I put the hint first, since the fatal
line is fatal).

> Should this use a static to also warn only once in the tag-catchup case
> you mentioned?

Since we're dying, this is no longer needed.

Jonathan Tan (2):
  transport: warn if server options are unsupported
  clone: send server options when using protocol v2

 Documentation/fetch-options.txt |  3 ++-
 Documentation/git-clone.txt     |  8 +++++++
 builtin/clone.c                 |  6 +++++
 t/t5702-protocol-v2.sh          | 41 +++++++++++++++++++++++++++++++++
 transport.c                     | 10 ++++++++
 5 files changed, 67 insertions(+), 1 deletion(-)

Range-diff against v2:
1:  af3cc05324 ! 1:  63049081c9 transport: warn if server options are unsupported
    @@ -4,13 +4,13 @@
     
         Server options were added in commit 5e3548ef16 ("fetch: send server
         options when using protocol v2", 2018-04-24), supported only for
    -    protocol version 2. Add a warning if server options are specified for
    -    the user if a legacy protocol is used instead.
    +    protocol version 2. But if the user specifies server options, and the
    +    protocol version being used doesn't support them, the server options are
    +    silently ignored.
     
    -    An effort is made to avoid printing the same warning more than once by
    -    clearing transport->server_options after the warning, but this does not
    -    fully avoid double-printing (for example, when backfulling tags using
    -    another fetch with a non-reusable transport).
    +    Teach any transport users to die instead in this situation, just like
    +    how "push" dies if push options are provided when the server doesn't
    +    support them.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
    @@ -22,10 +22,11 @@
      '
      
     +test_expect_success 'warn if using server-option with ls-remote with legacy protocol' '
    -+	GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
    ++	GIT_TEST_PROTOCOL_VERSION=0 test_must_fail git -c protocol.version=0 \
     +		ls-remote -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
     +
    -+	grep "Ignoring server options" err
    ++	grep "see protocol.version in" err &&
    ++	grep "server options require protocol version 2 or later" err
     +'
      
      test_expect_success 'clone with file:// using protocol v2' '
    @@ -39,10 +40,11 @@
     +
     +	git init temp_child &&
     +
    -+	GIT_TEST_PROTOCOL_VERSION=0 git -C temp_child -c protocol.version=0 \
    ++	GIT_TEST_PROTOCOL_VERSION=0 test_must_fail git -C temp_child -c protocol.version=0 \
     +		fetch -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
     +
    -+	grep "Ignoring server options" err
    ++	grep "see protocol.version in" err &&
    ++	grep "server options require protocol version 2 or later" err
     +'
     +
      test_expect_success 'upload-pack respects config using protocol v2' '
    @@ -56,10 +58,12 @@
      	return 0;
      }
      
    -+static void warn_server_options_unsupported(struct transport *transport)
    ++static void die_if_server_options(struct transport *transport)
     +{
    -+	warning(_("Ignoring server options because protocol version does not support it"));
    -+	transport->server_options = NULL;
    ++	if (!transport->server_options || !transport->server_options->nr)
    ++		return;
    ++	advise(_("see protocol.version in 'git help config' for more details"));
    ++	die(_("server options require protocol version 2 or later"));
     +}
     +
      /*
    @@ -69,7 +73,7 @@
      		break;
      	case protocol_v1:
      	case protocol_v0:
    -+		warn_server_options_unsupported(transport);
    ++		die_if_server_options(transport);
      		get_remote_heads(&reader, &refs,
      				 for_push ? REF_NORMAL : 0,
      				 &data->extra_have,
    @@ -77,7 +81,7 @@
      		break;
      	case protocol_v1:
      	case protocol_v0:
    -+		warn_server_options_unsupported(transport);
    ++		die_if_server_options(transport);
      		refs = fetch_pack(&args, data->fd, data->conn,
      				  refs_tmp ? refs_tmp : transport->remote_refs,
      				  dest, to_fetch, nr_heads, &data->shallow,
2:  142c25abd2 ! 2:  f59b8244eb clone: send server options when using protocol v2
    @@ -12,7 +12,9 @@
         "--server-option".
     
         Explain in the documentation, both for clone and for fetch, that server
    -    handling of server options are server-specific.
    +    handling of server options are server-specific. This is similar to
    +    receive-pack's handling of push options - currently, they are just sent
    +    to hooks to interpret as they see fit.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
    @@ -86,7 +88,7 @@
      --- a/t/t5702-protocol-v2.sh
      +++ b/t/t5702-protocol-v2.sh
     @@
    - 	grep "Ignoring server options" err
    + 	grep "server options require protocol version 2 or later" err
      '
      
     +test_expect_success 'server-options are sent when cloning' '
    @@ -103,11 +105,12 @@
     +test_expect_success 'warn if using server-option with clone with legacy protocol' '
     +	test_when_finished "rm -rf myclone" &&
     +
    -+	GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
    ++	GIT_TEST_PROTOCOL_VERSION=0 test_must_fail git -c protocol.version=0 \
     +		clone --server-option=hello --server-option=world \
     +		"file://$(pwd)/file_parent" myclone 2>err &&
     +
    -+	grep "Ignoring server options" err
    ++	grep "see protocol.version in" err &&
    ++	grep "server options require protocol version 2 or later" err
     +'
     +
      test_expect_success 'upload-pack respects config using protocol v2' '
-- 
2.21.0.392.gf8f6787159e-goog

