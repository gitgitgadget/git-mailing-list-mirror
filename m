From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Mon, 1 Feb 2016 21:26:54 +0100
Message-ID: <56AFBF8E.7090809@web.de>
References: <xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
 <xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com> <20160125144250.GM7100@hank>
 <xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
 <xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>
 <20160127151602.GA1690@ecki.hitronhub.home>
 <xmqqd1sm9730.fsf@gitster.mtv.corp.google.com>
 <xmqqmvrq7nok.fsf@gitster.mtv.corp.google.com>
 <20160128070959.GA6815@ecki.hitronhub.home>
 <xmqqk2mtmlu9.fsf@gitster.mtv.corp.google.com>
 <20160130081306.GA2931@ecki.hitronhub.home>
 <xmqqlh74wb0r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 01 21:28:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQL5T-0004ND-7G
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 21:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbcBAU2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 15:28:18 -0500
Received: from mout.web.de ([212.227.15.3]:50141 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652AbcBAU2P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 15:28:15 -0500
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0M89jd-1aCmFU2f9F-00vjnd; Mon, 01 Feb 2016 21:26:58
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <xmqqlh74wb0r.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:oehoTNRWBvalUFsj+GJZbzU5D5Sfb4ogf+vMko4CCwaOTbKAu0B
 niZrtPXvAEiqIsAjAOurcw1GunZoLiGurk9qGDKX8dH/jsrtjeYEL7mG1ZEURIWEilrZt22
 MXAL/ZuCui+jTkUbr8GnDqXCXPTK2l4bkbybQwz9uCprODX7axBosLc+q4LsBwYPtjnx7O7
 gipjzvZ1I902qngFAf3zA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l7j4HPjL3go=:lBB5+9SYpdogAtfppf/tas
 TvqyejflJlKv4/Qq1XAICKbXV5G4Hvvj+hvXm0g7iR/L3xqEWKCPIymSb2x+3ZJmxK2CTdWxX
 oRAWy4TPLZU8x00mtLr1jZMAFFiQKjPVHyjiFpR0v7CBQXXTZToUjcqWwyrQh3EENZLeXNXno
 ner3EuWOXJHq1fI1VFrAeQNEoRjTRpgDFfJlCqPMzsEUXIl1VIcEf43H1Az3K5h416GMpOh8J
 S9ZkgyQWsitVy9UQLC39w6/w1WNLiXSg0BlSAjGKT2+g4wRfqv09pbLLkL8t7sjC3ilYcFBgY
 +kiicJmM47TsGVJlp5JJ9oEgOEUT1lkOG79gLBvG7TRtDPCoND7BITnQFNKvXHyiN19Ipt3kZ
 zSPlB64RIWckJ7rK1RxrgtZ5Ag0jLhFXkhMqZZejfmbBJ1K5gFUWkwnzLNMsGJ8bEVQXuR0/y
 IjhQ4uxLPgHpTQjgHvAkKxO1QGdtRAAiTohTrAbuIAm+5aQfgxHGk2AgxZ4i8OV/1jBMhBXY5
 +CwljvsB2Bcn7NblaIbakPrjiCQ8GqLXtTflBX8tfK+LrSXnvAyCTyVPURn8aMnlbmX9KrvSq
 Ias8myS9yb2DV1sWQ7q0eDUhsE3vtDY8kKY3qh38mjtVraZQx8e7vCIfJIUaJJod3sdB2FjkZ
 sYEfhGVA0iFG+lMM6jvjoZpboWgOeIVDubuPX//4Aqm3oTr22/JMPquJvv5J6+F/IfUq8Y1bu
 EmWRmX41n8lCx0bYNf4gENJO6j4eHQ4KPJ7cKCC3PwTOMjzR4c3BtwNFA6yHz63E0AtwRWrF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285213>

On 2016-02-01 19.17, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
[]
> 
> IIRC, autocrlf=true would strip CR at the end of line in to-git
> conversion, and would add CR in to-worktree conversion.  So some eol
> conversion may only act in to-git, but some others do affect both,
> and without needing you to touch attributes.
That depends, which version of Git you are running.
It has changed from the first version of core.autocrlf:

commit c4805393d73425a5f467f10fa434fb99bfba17ac
Author: Finn Arne Gangstad <finnag@pvv.org>
Date:   Wed May 12 00:37:57 2010 +0200

    autocrlf: Make it work also for un-normalized repositories

    Previously, autocrlf would only work well for normalized
    repositories. Any text files that contained CRLF in the repository
    would cause problems, and would be modified when handled with
    core.autocrlf set.

    Change autocrlf to not do any conversions to files that in the
    repository already contain a CR. git with autocrlf set will never
    create such a file, or change a LF only file to contain CRs, so the
    (new) assumption is that if a file contains a CR, it is intentional,
    and autocrlf should not change that.

    The following sequence should now always be a NOP even with autocrlf
    set (assuming a clean working directory):

    git checkout <something>
    touch *
    git add -A .    (will add nothing)
    git commit      (nothing to commit)

    Previously this would break for any text file containing a CR.

    Some of you may have been folowing Eyvind's excellent thread about
    trying to make end-of-line translation in git a bit smoother.

    I decided to attack the problem from a different angle: Is it possible
    to make autocrlf behave non-destructively for all the previous problem cases?

    Stealing the problem from Eyvind's initial mail (paraphrased and
    summarized a bit):

    1. Setting autocrlf globally is a pain since autocrlf does not work well
       with CRLF in the repo
    2. Setting it in individual repos is hard since you do it "too late"
       (the clone will get it wrong)
    3. If someone checks in a file with CRLF later, you get into problems again
    4. If a repository once has contained CRLF, you can't tell autocrlf
       at which commit everything is sane again
    5. autocrlf does needless work if you know that all your users want
       the same EOL style.

    I belive that this patch makes autocrlf a safe (and good) default
    setting for Windows, and this solves problems 1-4 (it solves 2 by being
    set by default, which is early enough for clone).

    I implemented it by looking for CR charactes in the index, and
    aborting any conversion attempt if this is found.
-----------------------
And my intention is to do a similar fix for the attributes.
More patches coming.
