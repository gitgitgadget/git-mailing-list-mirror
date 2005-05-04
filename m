From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Tue, 03 May 2005 22:30:06 -0400
Message-ID: <427833AE.6030505@dwheeler.com>
References: <E1DSDER-0000kS-00@gondolin.me.apana.org.au>	<4274FB10.6090600@dwheeler.com> <20050502091027.6753998e.pj@sgi.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 04:21:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT9Vk-0004y1-3J
	for gcvg-git@gmane.org; Wed, 04 May 2005 04:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVEDC1Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 22:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVEDC1Z
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 22:27:25 -0400
Received: from aibo.runbox.com ([193.71.199.94]:60325 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261528AbVEDC1V (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 22:27:21 -0400
Received: from [10.9.9.9] (helo=fetch.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DT9bd-0008Tw-2I; Wed, 04 May 2005 04:27:21 +0200
Received: from [70.21.9.158] (helo=[192.168.2.73])
	by fetch.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DT9bc-0005U2-LV; Wed, 04 May 2005 04:27:21 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050502091027.6753998e.pj@sgi.com>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I reported:
>>One approach is to install a trap for SIGPIPE in
>>non-terminating command in a pipeline where the
>>later items might not process all the data, e.g.:
>>   (trap {} SIGPIPE; find .) | head -1

Paul Jackson wrote:
> Both the versions of bash that I looked at (2.05 and 3.0) _still_
> complain even if SIGPIPE is trapped - they just complain with
> a more terse message, unless DONT_REPORT_SIGPIPE is not defined.
...
> What bash do you have that this trap silences?

Actually, I have a working bash, so I can't test any of
these work-arounds.  I was merely foolish enough to quote
the Debian discussion, where someone reported that as a
work-around. I had hopes that it would help.
That'll teach me to pay attention to documentation :-).

I wonder, does a top-level trap work? E.g.:
  trap "" SIGPIPE
  ...

Anyone, good luck to those with broken bashes...

--- David A. Wheeler
