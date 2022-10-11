Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F70C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 22:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJKWbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 18:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJKWbC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 18:31:02 -0400
X-Greylist: delayed 793 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Oct 2022 15:30:59 PDT
Received: from 1.mo576.mail-out.ovh.net (1.mo576.mail-out.ovh.net [178.33.251.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AB012779
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 15:30:59 -0700 (PDT)
Received: from player759.ha.ovh.net (unknown [10.111.172.91])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id E23D923716
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 21:54:32 +0000 (UTC)
Received: from ngraves.fr (met42-h01-213-44-161-47.dsl.sta.abo.bbox.fr [213.44.161.47])
        (Authenticated sender: ngraves@ngraves.fr)
        by player759.ha.ovh.net (Postfix) with ESMTPSA id 5B4652F9CA1B7;
        Tue, 11 Oct 2022 21:54:30 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G004009724b6-ca1d-4805-894c-a87b548ceb1b,
                    CAD2B4A3459146A86F0B95563822EA9C8829CA61) smtp.auth=ngraves@ngraves.fr
X-OVh-ClientIp: 213.44.161.47
From:   Nicolas Graves <ngraves@ngraves.fr>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Cuckoo Aidan <aidancuckoo@gmail.com>
Subject: Re: Error / feature-request: Signing git commits with SSH hardware key
In-Reply-To: <Y0XVCDu9o3xDnt81@tapette.crustytoothpaste.net>
References: <875ygqw7p8.fsf@ngraves.fr>
 <Y0XVCDu9o3xDnt81@tapette.crustytoothpaste.net>
Date:   Tue, 11 Oct 2022 23:54:27 +0200
Message-ID: <87v8oquiuk.fsf@ngraves.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Ovh-Tracer-Id: 16580002030863639162
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejjedgtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkgggtsehttdertddttddtnecuhfhrohhmpefpihgtohhlrghsucfirhgrvhgvshcuoehnghhrrghvvghssehnghhrrghvvghsrdhfrheqnecuggftrfgrthhtvghrnhepveekleeujedthefgffekleekhffhffetgfdvheekleeuhfehueeljedtjefhvdfgnecukfhppeduvdejrddtrddtrddupddvudefrdeggedrudeiuddrgeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeonhhgrhgrvhgvshesnhhgrhgrvhgvshdrfhhrqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeipdhmohguvgepshhmthhpohhuth
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2022-10-11 20:41, brian m. carlson wrote:

> Could you maybe mention what version of OpenSSH you're using and on what
> platform?  I used 9.0p1, and as I mentioned, it's Linux.  The output
> looks like so:

I currently use this version on Guix (so Linux):
OpenSSH_8.9p1, OpenSSL 1.1.1q  5 Jul 2022

The errors occurs when I try to "really" commit using magit or git
through the command line.

hint: Waiting for your editor to close the file...
Waiting for Emacs...
error: Couldn't load public key sk-ssh-ed25519@openssh.com AAAAG[..]zaDo=: No such file or directory?

fatal: failed to write commit object


Now if I try this command:
>   $ git verify-commit --raw HEAD

I get the following:
error: gpg.ssh.allowedSignersFile needs to be configured and exist for ssh signature verification


It's possible that my config is not complete, I remember not having
necessarily done the part with allowedsigners (which is not necessary
for an ed25519 "simple" key apparently). I'll take a look, and come back
to you. 


-- 
Best regards,
Nicolas Graves
