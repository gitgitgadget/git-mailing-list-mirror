Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D37B41F404
	for <e@80x24.org>; Mon, 17 Sep 2018 22:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeIREIa convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 18 Sep 2018 00:08:30 -0400
Received: from elephants.elehost.com ([216.66.27.132]:12276 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeIREIa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 00:08:30 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8HMd6KG006041
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Sep 2018 18:39:06 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     <git@vger.kernel.org>, "'Taylor Blau'" <ttaylorr@github.com>
References: <008d01d44ebc$0d668df0$2833a9d0$@nexbridge.com> <20180917192753.GF140909@aiede.svl.corp.google.com> <002501d44ed1$38a49ab0$a9edd010$@nexbridge.com> <20180917220209.GJ140909@aiede.svl.corp.google.com>
In-Reply-To: <20180917220209.GJ140909@aiede.svl.corp.google.com>
Subject: RE: [Question] Alternative to git-lfs under go
Date:   Mon, 17 Sep 2018 18:38:59 -0400
Message-ID: <002701d44ed7$3d30f1e0$b792d5a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJdFhyAAkhrROGH2xxxy0H9RARvggJHejCgApNWS7gBuewimKOu2fAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 17, 2018 6:02 PM, Jonathan Nieder wrote:
> Randall S. Becker wrote:
> > On September 17, 2018 3:28 PM, Jonathan Nieder wrote:
> >> Randall S. Becker wrote:
> 
> >>> Does anyone know whether it is practical to rework git-lfs under a
> >>> language other than "go"? GCC is not even close to being possible to
> >>> port to my NonStop platform (may have tried, some have died - joke -
> >>> trying). I would like to convert this directly to C or something
> >>> more widely portable. Is there a protocol doc out there I can reference?
> >>
> >> Can you say more about the context?  You might like
> >>
> >>  git clone --filter=blob:limit=512m <repo>
> >>
> >> which tells Git to avoid downloading any blobs larger than 512
> >> megabytes until you know they need them.  See
> >> Documentation/technical/partial-clone.txt
> >> for more details.
> >
> > Sorry, I was not clear. I am not having issues with large files or
> > blob limits.  Members of my community wish to use Git LFS support on
> > their enterprise git servers, so as platform maintainer for git on
> > NonStop, I am trying to accommodate them. The stumbling block is that
> > "Go" language will not port to the platform.
> 
> Thanks.  Then the answer is "no": there has not been a reimplementation of
> Git LFS in another language, and my advice to someone pursuing that would
> be to use the native Git feature described above instead (or to get Go
> working on their platform).
> 
> If I'm reading
> https://github.com/git-lfs/git-lfs/blob/master/CONTRIBUTING.md
> correctly, the preferred way to contact the Git LFS maintainers is using
> Github's issue tracker.
> 
> Thanks and sorry I don't have better news, Jonathan

It is the interoperability with existing Git LFS repositories that my community is requesting, not specifically any file size issues. Some want the locking function. The API looks fairly straight forward and I suspect a complete reimplementation will take less of my time than trying to get GO to actually run on the platform. Cross-compilation might be an option, but that's likely a tricky proposition that has not worked in the past - the issue there is that cross compilation requires Windows and Cygwin, which make configure rather confused and so far, not workable. Neither GCC nor GNULIB build completely in port attempts. So the answer is "NO". ☹

