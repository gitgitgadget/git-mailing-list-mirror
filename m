Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963051F859
	for <e@80x24.org>; Tue,  9 Aug 2016 21:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbcHIV2T (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 17:28:19 -0400
Received: from mout.web.de ([212.227.17.11]:60266 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932375AbcHIV2S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 17:28:18 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MhDkj-1btSNx2sy1-00MHjZ; Tue, 09 Aug 2016 23:28:04
 +0200
Date:	Tue, 9 Aug 2016 21:28:02 +0000
From:	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
Message-ID: <20160809212802.GA4132@tb-raspi>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
 <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
 <20160808203224.GA28431@tb-raspi>
 <20160809065110.GB17777@peff.net>
 <20160809113337.GA1143@tb-raspi>
 <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
 <20160809125958.GA1501@tb-raspi>
 <20160809132744.kjzmkgt2qiugeolj@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160809132744.kjzmkgt2qiugeolj@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:wKzHhGfKAnDzN7J+87GZIEzGtNAiooXAZif0kxVfVI//PsWbWHG
 Y934cyklbK/bwAR05qhMF30mml7KNTWGi9SLOwudaqz6xwYRaWRJEWBSubO4BYgFJFNmdZp
 Ach/VMyP5tXC51iLYq/B7VfsiK4CdJtOv6DVyhK5mUzynlG/XG/QlGjNXupQDKeWjT3P3Hw
 iIAYByG22P4Cq0MfJoI2A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:cw08oI79JAE=:VZZtfJNOHm8Bf5o8+yB8QF
 HMxc5+28bHWncFHOj1OWFrdkST5P91G0YLzrcdmi2+Ok10ToVVBWzrmgC/Rf+ptm9V2gv97il
 Lhze0E185MaG2kZcZR4mSeVF2FRZycg3UpL0cnru4mHFIiQTVMMQsazpT+cb0WES8vE0aVTiW
 36WWFlYK++BQySXHYjhCl0pTT9jgOUzDnXYUhcfU1N/9lzHwiOw4reflzSWe/HXymePeJl1It
 un0P0HCkN8uq0NvobM/IxKwbX4q2S9WH13ZNcxdecPn+A8qClW+dY2N4/8eZqiCTVFIpVot9N
 ZTm/yPuUtZjdsZP7Ak24GWXxvL3ZS+bZWrqbS7krD35m8wMk+fDOsWyV8xaZtEaaALeF0r2L4
 sqzdYoUIDjlsfXDVljS//89HDA0PO8L//yWDNinv9OqlrgusDx4E09JvY5F0Arj8FIqMtnA5B
 Ao4wst/wYygdsefMWKPINLI8cKx88/iRDQKpNvFGhn1QtoMN/wv8048YL+gOWIkLcmENH1Lj6
 /Ju+sdYPNfRqAYfpgpY/YfoepYBorqEJVC2lYowEUQiQqcCXqQ9adUO738RoSTuCtcLNBC2MT
 0aaOyVRUvkFpbxCOY6hxF+2be+OVC0JsrvwuOkwMbboGbjo2nrc0snbab5gmIAJbScfCklW7L
 TJTUshxn4F9eS0KvTI39KPly7NFwI+8em548Ylyj3v+JclzzdnrIGrbtAqfEypF3MBKtZLbNM
 E0dqnRZK3RwTU5s2QziN2SxCe5/387TRwSzZx2Xr6ELoBIz9UUfwO9hLqiA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

>   git -c core.autocrlf=$crlf add $fname >"${pfx}_$f.err" 2>&1
> 
> would make more sense. We _know_ that we have to do convert_to_git() in
> that step because the content is changed. And then you can ignore the
> warnings from "git commit" (which are racy), or you can simply commit as
> a whole later, as some other loops do.
> 
> But like Dscho, I do not actually understand what this test is checking.
> The function is called commit_chk_wrnNNO(), so perhaps you really are
> interested in what "commit" has to say. But IMHO that is not an
> interesting test. We know that if it has to read the content from disk,
> it will call convert_to_git(), which is the exact same code path used by
> "git add". So I do not understand what it is accomplishing to make a
> commit at all here.

It seems as if the test has been written without understanding the raciness.
It should commit files with different line endings on top of
a file with mixed line endings.
The warning should be checked (and here "git add" can be used,
or the file can be commited directly).
I'm not sure why the test ended up in doing both.

However, doing it the right way triggers a bug in convert.c,
(some warnings are missing, so I need some days to come up
with a proper patch)

Thanks for reporting & digging.
