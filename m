Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C8E20989
	for <e@80x24.org>; Thu, 13 Oct 2016 15:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754692AbcJMP16 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 11:27:58 -0400
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:43011 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754535AbcJMP14 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 11:27:56 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1buhv8-0003pX-VF; Thu, 13 Oct 2016 17:27:47 +0200
Date:   Thu, 13 Oct 2016 17:27:45 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v2 1/3] serialize collection of changed submodules
Message-ID: <20161013152745.GA29710@book.hvoigt.net>
References: <cover.1475851621.git.hvoigt@hvoigt.net>
 <10cd5be93601bc52388100e80b6c6735a7cacfb4.1475851621.git.hvoigt@hvoigt.net>
 <CAGZ79kZiY56-84aThH1F02E_HzCTAK3KSYLbyP1D5GUAt892cw@mail.gmail.com>
 <xmqqvawzbzb2.fsf@gitster.mtv.corp.google.com>
 <20161012130034.GA84247@book.hvoigt.net>
 <xmqq1szl5vvf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1szl5vvf.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 10:18:28AM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > Which seems quite extensively long for a static function so how about
> > we shorten it a bit and add a comment:
> >
> > 	/* lookup or create commit object list for submodule */
> > 	get_commit_objects_for_submodule_path(...
> 
> Or you can even lose "get_" and "path", I guess.  You are not even
> "getting" commits but the array that holds them, so the caller can
> use it to "get" one of them or it can even use it to "put" a new
> one, no?  "get-commit-objects" is a misnomer in that sense.  Either
> one of
> 
>     get_submodule_commits_array()
>     submodule_commits()
> 
> perhaps?  I dunno.

I like the last one. Will use 'submodule_commits()'.

Cheers Heiko
