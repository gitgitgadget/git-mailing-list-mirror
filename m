Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B0AD1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 08:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeKLSpw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 13:45:52 -0500
Received: from smtp54.i.mail.ru ([217.69.128.34]:41920 "EHLO smtp54.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbeKLSpw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 13:45:52 -0500
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2018 13:45:51 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=K4Yw60mFvPqfWc1iNlv0BhnEHLPSIE5JiuU7eI9+P9w=;
        b=ybAAz4ingFMvBnNLkaYgW83BF34HCGSxkfKcZcYGLs648LXRIDxituGUmt+6zBwHajhIG9AZHGxYA6jDbf0fjMFzHNYy5F6TZZzVmwI1HXNHBIEHjOVfIKQgSFB/eS2q6ImBFmrRXVNS8oqTvfn6lIi0A6n21J+2eNqqLBAFBvM=;
Received: by smtp54.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1gM7yT-0000fi-9I; Mon, 12 Nov 2018 11:53:37 +0300
Date:   Mon, 12 Nov 2018 11:53:35 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     yan ke <yanke131415@gmail.com>
Cc:     martin.delille@gmail.com, git@vger.kernel.org
Subject: Re: Add issue management within git
Message-ID: <20181112085335.r5mk6b3l4faloayn@tigra>
References: <881C01A7-82BB-4A4D-9CDC-6ECDA451B12B@gmail.com>
 <CAJosSJ4_PXrXUxn0WfFcR90SbDL0UWRRGPpxEjVwc=3NwWP+Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJosSJ4_PXrXUxn0WfFcR90SbDL0UWRRGPpxEjVwc=3NwWP+Jg@mail.gmail.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Authentication-Results: smtp54.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-77F55803: JXxPhqsJyJxaeFBL0qwpQZiHhPxsSuMfQ9paRVNoQbOLZUqHQzc8Uja1aZOal1a2YDhSNh2dm2w=
X-7FA49CB5: 0D63561A33F958A53CBD32A10B2019589697A987A9824FDD25D08569BA1E0BA08941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249D827CA74CCEABFF33AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE767C209D01CC1E34BCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7ADBA102BF550C2186D2E2BAABC068C2275ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 3EA917A0E6524472E50B252446CEFEA477A4C6F35B0BE88F8B654A8743373C52AE5D0ADEEBC53A88FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 09:35:31AM +0800, yan ke wrote:

> > This would be awesome to handle issue directly with git:
> > Having an offline version of the issues synced to the gitlab/github issues.
> > A lot of work is done on the issues and it is lost when migrating
> > from one service to the other.
> > Beside we don’t always have a good internet connection.
> > There is already a kind of integration between commit message fixing
> > issue automatically when merged in the master branch (with “fix
> > #143’).
>    Very very agree, now it is very difficult to find a solution when
> has some problem such build problem an so on! The mail-list is good to
> send patch es, but is it not suitable for problem track or problem
> solution search!
>    Now the Github or Gitlab is good to track issues, suggest to open
> the git issue track!

Please don't hijack the discussion: the original poster did not question
the workflow adopted by the Git project itself but rather asked about
what is colloquially called "distributed bug tracker", and wanted to
have one integrated with (or into) Git. That is completely orthogonal
story.

As to searching for Git issues / problem solutions - I'd recommend using
the search on the main Git mailing list archive [1] and the issue
tracker of the Git for Windows project [2].

The communities around Git also include the "Git Users" low-volume
mailing list [3] (also perfectly searcheable), and the "git" tag at
StackOverflow [4].

1. https://public-inbox.org/git/
2. https://github.com/git-for-windows/git/issues
3. https://groups.google.com/forum/#!forum/git-users
4. https://stackoverflow.com/questions/tagged/git

