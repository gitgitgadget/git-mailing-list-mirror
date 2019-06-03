Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA241F462
	for <e@80x24.org>; Mon,  3 Jun 2019 14:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfFCON7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 10:13:59 -0400
Received: from elephants.elehost.com ([216.66.27.132]:62178 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfFCON6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 10:13:58 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x53EDoiF006892
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 10:13:50 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqpnnzws9q.fsf@gitster-ct.c.googlers.com> <005f01d5194f$5cb08240$161186c0$@nexbridge.com> <nycvar.QRO.7.76.6.1906031544000.48@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906031544000.48@tvgsbejvaqbjf.bet>
Subject: RE: [ANNOUNCE] Git v2.22.0-rc2
Date:   Mon, 3 Jun 2019 10:13:44 -0400
Message-ID: <003701d51a16$913f38e0$b3bdaaa0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQI9ewXcnn13ik5Raf3QyvarMXUJiQIXiE0FAUvJ1dClnhqPoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, June 3, 2019 9:50 AM, Johannes Schindelin wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org
> Subject: RE: [ANNOUNCE] Git v2.22.0-rc2
> 
> Hi Randall,
> 
> On Sun, 2 Jun 2019, Randall S. Becker wrote:
> 
> > Just a few small nits from RC2 test results on the NonStop TNS/E
> > platform:
> >
> > 1. t0021 subtest 15 is being flakey. It fails on the first run (make
> > -k
> > test) but succeeds when run in isolation. This is new on the NonStop
> > TNS/E platform. t0021 has been a bit flakey in the past, but not
> > recently. Just thought I'd mention it. It's only slightly
> > disconcerting because I make very heavy use of smudge filters but
> > since it runs fine in isolation, I'm going to assume it is fine. We
> > had one unsubstantiated report of an occasional misfire of smudge
> > filters, but no substantive evidence at this point to reproduce the
situation.
> 
> t0021.15 is indeed flaky, and not only for NonStop. It is so flaky, even,
that I
> opened https://github.com/gitgitgadget/git/issues/241

Thanks.

> > 2. t7519 subtest 25 still does not pass (previously reported for RC1)
> > when run via "make -k test" the first time. This runs successfully
> > when run in isolation or the second time.
> 
> I offered a fix for that in js/fsmonitor-unflake, and it already made it
into
> `next` (and hopefully into v2.22.0) as you can see here:
> https://github.com/gitgitgadget/git/commit/b5a81697520 (look for the
> branch symbol below the commit message).

I'll keep an eye out for it. We are good with RC2 anyway.

> > 3. t9001, t9020, t9600, t9601, t9602, t9604, fail, but should not run
> > on platform (not new, just a reminder). We do not have sendmail or
> > subversion.
> 
> At least for Subversion, this should be detected. For send-email, I don't
> know... There *was* a bug in t9001 where it failed to mark a send-email
> tests cases with the `PERL` prerequisite, but that was fixed, and I guess
you
> have Perl anyway?

Yes, we do have Perl on the box. However, the send-email functions do not
work - probably missing modules. As far as SVN goes, we have the git SVN
modules, but not the actual SVM modules in our Perl. There has been some
effort to port those, but we have had CPAN issues for a while now. I am
trying to find a resource to help with porting - personally, I could really
use the SVN module to allow svn2git to function on box. That would make my
life a whole lot easier.

Cheers,
Randall

