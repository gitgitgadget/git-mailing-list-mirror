Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6416B1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 21:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfICV35 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 17:29:57 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:34777 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbfICV35 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Sep 2019 17:29:57 -0400
Received: from [IPv6:2001:980:2408:1:a91f:52f8:a5ea:865] ([IPv6:2001:980:2408:1:a91f:52f8:a5ea:865])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id 5GN7iLjhtxNy05GN9igkvy; Tue, 03 Sep 2019 23:29:55 +0200
Subject: Re: Retrieve version-string on shallow clone
References: <20190902140854.GA3806@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
Cc:     git@vger.kernel.org
From:   Reino Wijnsma <rwijnsma@xs4all.nl>
Message-ID: <078d6283-726a-c7a9-5c24-97dbc7ff180f@xs4all.nl>
Date:   Tue, 3 Sep 2019 23:30:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20190902140854.GA3806@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfE5xqwqEkFFJEBRRA76zDbYi7MkjRRNkZR8MoLKbVEDQ6JYRhKg/dlW38QlUxEDohJe026+97cVZ0jwl4ZUH04BES23RNFYOisDcXYi/sC8xSlpFb8cu
 WelYtn3h9lwwc+NNnIe9jtg3hRnttkBQh7V6MuZ3Hww7pcQ+mtFGvkOAmd8adGRBUx3u1h1J8aotCwbMX3MDIm1+zfqNDwGh48CUsgEW6RokD4ku/4gDH4Ql
 qecpmuU6k/pXVHDrPzFk/pm2RtjWZDd+ngYFildVPwU=
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Giuseppe, Philip and Jeff,

On 2019-09-02T16:08:54+0200, Giuseppe Crinò <giuscri@gmail.com> wrote:
> To my understanding both questions are solved by
> * https://stackoverflow.com/a/47720414/2219670
> * https://stackoverflow.com/a/12704727/2219670
On 2019-09-02T17:52:19+0200, Philip Oakley <philipoakley@iee.email> wrote:
> Start by getting a bit more history depth, then see if you need to fetch some of the tags (or at least any specific tags of interest).
On 2019-09-02T17:54:40+0200, Jeff King <peff@peff.net> wrote:
> But what you want is perfectly reasonable; there's just not a good way to do it yet.
> [...] There's no way to trigger this within Git's protocols.

I never thought this would be impossible, or at least very hard, to accomplish.

git ls-remote --tags --refs https://github.com/mstorsjo/fdk-aac.git
94f9d5ca2077262e838fbc8ed111da03be5389d5        refs/tags/v0.1.0
1551d17717e42e7c295da0a682ae299791ee87c7        refs/tags/v0.1.1
fa3b711888883ccb19337c0ca76aea7dd85af9c8        refs/tags/v0.1.2
db7189736b49d27225eea917fcf1581b5228c830        refs/tags/v0.1.3
d17a2ebc6d8f593ffbefacaea1bfa6d6a81356a1        refs/tags/v0.1.4
a3f40d8d974f1aacde95e0996739941bde8f5e98        refs/tags/v0.1.5
c98ba983b0cd6905a52ab34222418ca7a5ff2260        refs/tags/v0.1.6
e35d91ddd8d41515594b7fd51b6bae1b17fee530        refs/tags/v2.0.0

git ls-remote --tags --refs https://github.com/mstorsjo/fdk-aac.git | tail -n1 | cut -d/ -f3-
v2.0.0

Regrettably the remote repo doesn't include the entire version-string with revision and commit-hash (v2.0.0-185-gcc5c85d).

Having to download fdk-aac's complete commit-history (9.38MB) isn't yet all too bad. FFmpeg (https://github.com/FFmpeg/FFmpeg.git) its commit-history on the other hand is a whopping 239MB (as opposed to 15.7MB for --depth 1) and perhaps a better example here!
I'm compiling and distributing FFmpeg executables. When I compile FFmpeg I'm not interested in its entire commit-history at that moment. I'm only interested in the checked out source files and the version-string (4.3-dev-327-g83e0b71 for instance).

Since this doesn't appear to be possible at the moment, I'll let this rest.
Thank you all for your replies.

-- Reino
