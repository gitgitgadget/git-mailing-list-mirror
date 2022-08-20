Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27109C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 08:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245060AbiHTItA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 04:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbiHTIs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 04:48:59 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57455A81A
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 01:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660985328;
        bh=yq88YKBqj33CmdwR+iUiQlo2L+paVqD7Uw2djUio8kQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IqOGtZnDbLdv+XVBV16B0dxicqRsaBIYEy48viLYAmnPEo1/O9kQGj7ZSEE6pfFJO
         jjbwTWuf8mnv7hVVeX0Rt3qQQdC5AUhsfC9+B35HVGLHdMIIC2EKaToIXuGo1pbUTU
         O//41NUGAqtQecJchjvoBdtBOYUqWKHXp/CQzrCw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.48]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MrOdf-1pDW8l0CZD-00o4Qe; Sat, 20
 Aug 2022 10:48:48 +0200
Message-ID: <9829e1cf-21aa-0c10-0b64-c8a2ffdbc943@web.de>
Date:   Sat, 20 Aug 2022 10:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH 4/6] verify_one_sparse(): drop unused repository parameter
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
 <Yv9O+HDMLKglLcqY@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Yv9O+HDMLKglLcqY@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:okOzyzxjr7airJrSq1EWNtYZXnO4AR0q/ZIgztnBGfn2WVFER06
 K9Oyc3GNzxl7ZK3bVrPZfhdrSoWLQfgbvKMOg6ji/S9VAVnIs9LFXg1CT9jW7b9fiWyCByA
 sp+RmbpiMBsHElWHZUj7JDgGS8Ae4XKhRPGZSuTRGFIdNLQpx9F5twKfvxYIYk8uLWX8V7a
 EEyFmTz3g+kBj3ZBPCt+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:spa+PqOF9uo=:QD+REx3fgYKUvqtzDt15nJ
 reoLRolu+MvYHydJMr5tb4taEwgouYyASDnB01S61XyJFZoOIzrNfi4tK4xyrJtNX7WgiA4Iz
 1T2zFPn6CLppD4qMkVJWXR/o+NwBGmaX2D31lARHn5s3vLde0X3QfkTW/xuvhC6zudTohJ10/
 l/Sq8fL4Y5ssse2VoF6kLZG9BHqNZnHuWjEQQTsDXc6Omz0U9c5pZ6b9c8tHCukXznO+5Nuyx
 a0qboo10okhD4WF0AFabUHs5nTzeSAeKXfGDAR1JtU07190OxJGvfLJBSbTNSocsXDsmzJ6/J
 BZome5FcuO1MEbnrBs22fHUro9QqD2vlOyLCi6/Jn9tyEHvU+o8gZ6/gTdE2OXCLNEGT0hOOA
 p44QRgB/4L52Lm24QGtC7/eBAF+GYBsBexLoq2wuv6cesdfYctghUgudCC+uTPrYVW9CSulzE
 tiiWUcZvYq/XFtlRIsStnlVNeSPuihSxwPan7K3MiXc5aEdQWhebJRvNfD62kTwcUWzQIzyDM
 8rr6N6AWSQZkHwrEhNcC9JyfsfWMLiMEEe6UawyZhMwMI1WbVmMr0rWwc4Cjk5tYV0G7fG9Rp
 Pl+SLJQogsM4AKsZqLFiXE1iRx+wwvt0PsyKLKRoSbny6jTzOZTrc32S2NIz7ov9G/vVX24Jv
 0NvFzCyRf8/OQGNolk/jIy49zOAk7/N/yLBTihrHOyFf+ERmQevjotHI8cvftzNX44QfXUzvU
 GRncn+UANLJFAknZloncoLnelWmbrXceHH9bZ8BYsPbk23dyE7dYRssAzVfZpEz/AhUQjg/pu
 HDn0XRUP8RnMPidpKegeWxjD+q97M4frEmeM4SRwI5R3/WORk9Y1TmqQBBt0VqrIkhLXxXR5A
 XfXz3kvYOd0neTCmUBkKSHWFMntlhlS/RwHoxcDXbBwq99uuNCXG0e1EY6nLFhYDizJRtmZCF
 66W4QiVoLDK9Pjk4BkbUL6d8xsr9tcFXFNDwkqg5FDbqee0L5yQBF7G36wJ3dv4Ump2jMzLNy
 sb+WnX/4uQDn2iN6Vo4EXz3Ok3ukqCn4IG96s8MPr1x7RfRpQ/42m2WBTyT//KNiclSglgH7g
 knci53OIsT1uxdDano2keSsuicsk3syYZc9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.08.22 um 10:51 schrieb Jeff King:
> This function has never used its repository parameter since it was
> introduced in 9ad2d5ea71 (sparse-index: loose integration with
> cache_tree_verify(), 2021-03-30). As that commit notes, it may
> eventually be extended further, and that might require looking at a
> repository struct. But it would be easy to add it back later if
> necessary. In the mean time, dropping it makes the code shorter and
> appease -Wunused-parameter.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  cache-tree.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 56db0b5026..c97111cccf 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -857,9 +857,7 @@ int cache_tree_matches_traversal(struct cache_tree *=
root,
>  	return 0;
>  }
>
> -static void verify_one_sparse(struct repository *r,
> -			      struct index_state *istate,
> -			      struct cache_tree *it,
> +static void verify_one_sparse(struct index_state *istate,

This also removes the cache_tree parameter, which has never been used as
well, but is not mentioned in the commit message.  A good change, to be
sure.

>  			      struct strbuf *path,
>  			      int pos)
>  {
> @@ -910,7 +908,7 @@ static int verify_one(struct repository *r,
>  			return 1;
>
>  		if (pos >=3D 0) {
> -			verify_one_sparse(r, istate, it, path, pos);
> +			verify_one_sparse(istate, path, pos);
>  			return 0;
>  		}
>

