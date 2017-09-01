Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6981F1F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 23:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbdIAXG6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 19:06:58 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36630 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbdIAXG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 19:06:57 -0400
Received: by mail-vk0-f50.google.com with SMTP id d124so4231746vkf.3
        for <git@vger.kernel.org>; Fri, 01 Sep 2017 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dmaoMUH9w7s3Z3C5gy/pW2xQeZ3lfHA8OOTru8itL9E=;
        b=o133CK4ypZBaEmOJqE2+a+VapetKGLpnKZEinijn7qz9BC+8C+G92+1BlOb3t+mSDe
         vU3kekFCHh/1VSHfIrEe0CjlPK9v/hJE4WPJmryRjhaDGlA7xyU41UdBWnMZhW19a3U+
         T+ZjSf2d+2OhLrqea0Law/Uk6Icx00GpdfHRn+yHR3dtTT+4TSyVhf2QTqQk7KdPCqUw
         oHtad735BK73W11EYm0naOsY9ay8SQIGmmandwa83/Nvva3aj+AX+eYJp7gOnUHHcA7a
         0PxZ7MVmBalomEBy4vNl9Kjg/B7OzPijhVxWFcRolA+tZ7QmqDkgs5d4f0IfXR7EUSgM
         Y/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dmaoMUH9w7s3Z3C5gy/pW2xQeZ3lfHA8OOTru8itL9E=;
        b=JdnmON3iEGsN7FK7GLuS74XHWAaX3fjXyD68/XDZiZPntbbBS+dbfwdiWvGTUHyQfd
         CMW1/vyOLReI0FCExH523rjC463zHdoknEHLv3u4iYWWrnDKeWM4WhMuXwCZtxXIvrVi
         6j11Ii80Flp0dkmQ1BnL51hfxavUXenJOMNzdabutcK/KlRkoxjdMyVNJSqF1A7NkEU6
         3XYKbr55If08AQ2QJsPjZpSjLXZOFvnoiaVFTOC6JB9a4XrvVMLAVjd/NA2PVRzWV9nd
         GdpCbk0BjcVnBDUEE/owexGJNcMJq5aMXK/ZCCrTB3cEaUpE+b76yUcxP1+wxd+BI3d4
         M0Eg==
X-Gm-Message-State: AHPjjUiSWxMVc8RiuIT3TSF3Fh2Q/L/Cy2qrKUpSafXa7ztflq2bBLF6
        MMXDJKW7ycZ/feG0HOTmUAKQdSOM6oGo
X-Google-Smtp-Source: ADKCNb54zUTLwaoWscO3KjkH4TEbdgqpSn/h9RSkqlGDJpzs89JwfTTgxcWR8Taewwn9vHFk5cTE5imz1OX29dOXCI0=
X-Received: by 10.31.120.206 with SMTP id t197mr2197218vkc.21.1504307216443;
 Fri, 01 Sep 2017 16:06:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.92.212 with HTTP; Fri, 1 Sep 2017 16:06:55 -0700 (PDT)
In-Reply-To: <20170830211245.GD50018@google.com>
References: <20170824225328.8174-1-bmwill@google.com> <20170825172901.kvquxafudhelxqq3@sigill.intra.peff.net>
 <CAGyf7-HTuM2kBRYDP8i9B8pUgqFw02pqBdYCVnp9s7v4bDAM0w@mail.gmail.com> <20170830211245.GD50018@google.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 1 Sep 2017 16:06:55 -0700
Message-ID: <CAGyf7-H9MdSzuU51opj+cA9ZAFSEnt-rvQcLuwY_j7qfn=kNsg@mail.gmail.com>
Subject: Re: [RFC 0/7] transitioning to protocol v2
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 2:12 PM, Brandon Williams <bmwill@google.com> wrote:
> On 08/30, Bryan Turner wrote:
>> On Fri, Aug 25, 2017 at 10:29 AM, Jeff King <peff@peff.net> wrote:
>> > On Thu, Aug 24, 2017 at 03:53:21PM -0700, Brandon Williams wrote:
>> >
>> >> The biggest question I'm trying to answer is if these are reasonable ways with
>> >> which to communicate a request to a server to use a newer protocol, without
>> >> breaking current servers/clients.  As far as I've tested, with patches 1-5
>> >> applied I can still communicate with current servers without causing any
>> >> problems.
>> >
>> > Current git.git servers, I assume?. How much do we want to care about
>> > alternate implementations? I would not be surprised if other git://
>> > implementations are more picky about cruft after the virtual-host field
>> > (though I double-checked GitHub's implementation at least, and it is
>> > fine).
>> >
>> > I don't think libgit2 implements the server side. That leaves probably
>> > JGit, Microsoft's VSTS (which I think is custom), and whatever Atlassian
>> > and GitLab use.
>>
>> Before I manually apply the patches to test how they work with
>> Bitbucket Server, are they applied on a branch somewhere where I can
>> just fetch them? If not, I'll apply them manually and verify.
>
> I just pushed this set of patches up to: https://github.com/bmwill/git/tree/protocol-v2
> so you should be able to fetch them from there (saves you from having to
> manually applying the patches).

Thanks for that! It made testing a lot simpler.

>
>> Just based on the description, though, I expect no issues. We don't
>> currently support the git:// protocol. Our HTTP handling passes
>> headers through to the receive-pack and upload-pack processes as
>> environment variables (with a little massaging), but doesn't consider
>> them itself; it only considers the URL and "service" query parameter
>> to decide what command to run and to detect "dumb" requests. Our SSH
>> handling ignores any environment variables provided and does not
>> forward them to the git process, similar to VSTS.
>>
>> I'll confirm explicitly, to be certain, but just based on reading the
>> overview and knowing our code I think the described approaches should
>> work fine.
>
> Perfect!  Thanks for taking the time to verify that this will work.

With 2 small tweaks on top of "protocol-v2", I was able to run our
full command and hosting (HTTP and SSH) test suites without issues.

diff --git a/transport.c b/transport.c
index c05e167..37b5d83 100644
--- a/transport.c
+++ b/transport.c
@@ -222,7 +222,8 @@ static struct ref *get_refs_via_connect(struct
transport *transport, int for_pus
        switch(determine_version(data->fd[0], &buf)) {
        case 2:
                /* The server understands Protocol v2 */
-               fprintf(stderr, "Server understands Protocol v2!\n");
+               if (transport->verbose >= 0)
+                       fprintf(stderr, "Server understands Protocol v2!\n");
                break;
        case 1:
                /* Server is speaking Protocol v1 and sent a ref so
process it */
diff --git a/upload-pack.c b/upload-pack.c
index 0f85315..7c59495 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1075,7 +1075,7 @@ int cmd_main(int argc, const char **argv)
        git_config(upload_pack_config, NULL);

        version = getenv("GIT_PROTOCOL");
-       if (!strcmp(version, "2"))
+       if (version && !strcmp(version, "2"))
                upload_pack_v2();

        upload_pack();

I'd imagine the "Server understands Protocol v2!" message won't
actually *ship* in Git, so it's likely making that honor "--quiet"
doesn't actually matter; I only adjusted it because we have a test
that verifies "git clone --quiet" is quiet. The "if (version" change I
commented on separately in the 7/7 patch that introduced the check.

Thanks again for publishing this, and for letting me test it!

>
> --
> Brandon Williams
