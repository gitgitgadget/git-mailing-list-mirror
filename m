Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9431FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 08:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbcF1IgT (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 04:36:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37906 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbcF1IgR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 04:36:17 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u5S8ZpbN017532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jun 2016 10:35:51 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5S8ZqNu015243;
	Tue, 28 Jun 2016 10:35:52 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	Jeff King <peff@peff.net>
Cc:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] connect: read $GIT_SSH_COMMAND from config file
References: <20160626111635.6809-1-pclouds@gmail.com>
	<20160627193322.GB10877@sigill.intra.peff.net>
Date:	Tue, 28 Jun 2016 10:35:52 +0200
In-Reply-To: <20160627193322.GB10877@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 27 Jun 2016 15:33:23 -0400")
Message-ID: <vpqwpl9yal3.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 28 Jun 2016 10:35:51 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5S8ZpbN017532
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1467707755.77056@wTomMPYbYfZyusoOzgenQQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Jun 26, 2016 at 01:16:35PM +0200, Nguyễn Thái Ngọc Duy wrote:
>
>> +	use the specified command instead of 'ssh' when they need to
>> +	connect to a remote system. The command is in the same form as
>> +	'GIT_SSH_COMMAND' environment variable and is overriden when
>> +	the environment variable is set.
>
> Probably s/'GIT_SSH_COMMAND'/the &/.

I think so. I'd write either "same form as `GIT_SSH_COMMAND`" or "same
form as the `GIT_SSH_COMMAND` environment variable`.

> Are we using backticks for typesetting environment variables now? That
> has always been my preference, but I haven't kept up with the typography
> patches that have been flying lately. +cc Matthieu.

Yes, we've tried to make the docs a bit more consistant, and to document
that better in Documentation/CodingGuidelines:

 An environment variable must be prefixed with "$" only when referring to its
 value and not when referring to the variable itself, in this case there is
 nothing to add except the backticks:
   `GIT_DIR` is specified
   `$GIT_DIR/hooks/pre-receive`

> (Similar question for commands like 'git fetch').

Backticks too:

   Literal examples (e.g. use of command-line options, command names,
 branch names, configuration and environment variables) must be
 typeset in monospace (i.e. wrapped with backticks):
   `--pretty=oneline`
   `git rev-list`

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
