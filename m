Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D01C20960
	for <e@80x24.org>; Mon, 10 Apr 2017 18:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752959AbdDJSWK (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 14:22:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36390 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752419AbdDJSWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 14:22:09 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 114A620960;
        Mon, 10 Apr 2017 18:22:09 +0000 (UTC)
Date:   Mon, 10 Apr 2017 18:22:09 +0000
From:   Eric Wong <e@80x24.org>
To:     Julian Goacher <julian.goacher@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Modifying a bare repo directly
Message-ID: <20170410182209.GA18358@dcvr>
References: <CAG_DJYk3D=sPm6rhGRD_wF4dnJqSU_M+c=NWP4Q5ExBap_-kPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_DJYk3D=sPm6rhGRD_wF4dnJqSU_M+c=NWP4Q5ExBap_-kPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julian Goacher <julian.goacher@gmail.com> wrote:
> Is it possible to modify a bare repo directly? e.g. is it possible to
> insert a file into a bare repo without first cloning a non-bare copy?
> I'm thinking along the lines of a command or sequence of commands that
> modifies the file index and then copies the file blob into /objects,
> but in a situation where the new file exists separately from the
> target repo.

Yes.  You can use the commands Ævar and Jeff talked about as
(those are probably the easiest).  "git fast-import" is also
great to avoid using an index entirely; it can be much faster
for mass modifications.
