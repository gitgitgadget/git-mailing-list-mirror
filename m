Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213EA1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 17:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeFKRs2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 13:48:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:50359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932768AbeFKRsY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 13:48:24 -0400
Received: from localhost ([188.192.2.98]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZkNy-1fgG1H31gs-00LSZu; Mon, 11
 Jun 2018 19:48:17 +0200
Date:   Mon, 11 Jun 2018 19:48:18 +0200
From:   Clemens Buchacher <drizzd@gmx.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] checkout files in-place
Message-ID: <20180611174818.GA8395@Sonnenschein.localdomain>
References: <20180610194444.GA1913@Sonnenschein.localdomain>
 <20180611020411.GE38834@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611020411.GE38834@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Provags-ID: V03:K1:TlI4ic4nfD1HpYaJNRWXLJhfMsaN4W437XYGi0FVKcFvM1DFNHg
 c2iBVddtHjKhgZD8HPG9Xs/fNgaktJ3sIeOM59Fw5YiWGoZ5auj4d8Ek46N+A+g9OqUrkf+
 5l1Wm/HDlrL3lBwC8pGE8X1zJNreSSibccf82PXK29b5uKhtt81e/y0fVcGMV8QdCPAVRKX
 hgzhn0fBbYua5WONJkbXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1jr9aaUXoks=:135b512xjkW4bQJ8eKCeD+
 BTBk3ZCtU6aXT1ACqX9BcxqEQIk+iZ4cSYa6lI+5KTfBM+dp8ySwm6gZDIR87a5++oVXFCB9l
 5wik450AYWjmlOeu4oNE5HOquf4yW0/0t7M8/wYrLHmkvLKfhhLjimdPUbWxPRNSPJSMzLWg3
 GN3oDApQCt1BJp1rvhbSQ76UItHFSCkM5IlDsKk2X1M5oLY//HXH2Cl44BDkLIb04MDgb0zSP
 2raop9+xc6gFmPls6X44nC9o+3Bg4+BG2Qj+vgHzCpuhFXyZcSqfaURCk9XNfsI3MrDLqA044
 YPQJ8yTa9Y55joW9t+8N3mULTssWR9JjrwZpqTG3k2WpDNhvVtY8yfB/dDi1wAAQeCNIf5dJ1
 qRjEpV8KyJV75MAGZTTdFuw6Zi2UxMF6HQ34isCSxDl2S6WKLVtjOr6d9PqUKh2iZPuVIMmVJ
 miwaYn3IpFAh5mG3u7UxpcYmHCEFdTiMkXN07V7a+bYDpgM7T84oKegghwwWXa97HLWUacJb8
 rmvlJgLIvuoQWVVaWHHoQfc/TEKnGiQHWRX3X4UlceJ8+7W16LTg6v42lqMK/t9ASQfvhwwNy
 /43qWbJnv/dNQosfcrD06t4jxCHmEakE+g+yDXBqyy1MyBJtjhmqCqAt84DChX5ihW3un10nf
 Qwmh5/n2CIgFAw62UnvoPZa8X+fjF2u/7qX1f6zMNmWO9OIoBv0pBvzb5pvfPkkRMGLxIZwdB
 z1/3ePdb634Xa4RxEfqFkmlXB3+1WoCfigBp7FQ5JffWGpFbsdw+KSxmH70=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 02:04:11AM +0000, brian m. carlson wrote:
> On Sun, Jun 10, 2018 at 09:44:45PM +0200, Clemens Buchacher wrote:
> > +	file prevent creating new files at the same path. Note that Git will not
> > +	update read/write permissions according to umask.
> 
> I'm wondering if it's worth a mention that running out of disk space (or
> quota) will cause data to be truncated.

As far as I know we make no guarantees about the behavior when running
out of disk space. There could be other side effects, so I cannot safely
state anything here.
