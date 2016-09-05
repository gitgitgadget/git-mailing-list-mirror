Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6CD11F859
	for <e@80x24.org>; Mon,  5 Sep 2016 04:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbcIEEMy (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 00:12:54 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58899 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751031AbcIEEMx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 00:12:53 -0400
X-AuditID: 1207440e-dc3ff70000000931-33-57ccf0bc7537
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 19.54.02353.CB0FCC75; Mon,  5 Sep 2016 00:12:44 -0400 (EDT)
Received: from [192.168.69.190] (p57907BC3.dip0.t-ipconnect.de [87.144.123.195])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u854CfB9027622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 5 Sep 2016 00:12:42 -0400
Subject: Re: [PATCH v2 7/7] blame: actually use the diff opts parsed from the
 command line
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <cover.1471864378.git.mhagger@alum.mit.edu>
 <8192012a6bf725e0460522f9e67bab83b613127a.1471864378.git.mhagger@alum.mit.edu>
 <fe96d9e6-b306-0b57-8f24-6106b7e285cb@web.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <a6d9e9a7-76c4-5b26-0b49-55698369180d@alum.mit.edu>
Date:   Mon, 5 Sep 2016 06:12:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <fe96d9e6-b306-0b57-8f24-6106b7e285cb@web.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42IRYndR1N3z4Uy4weQlNhZdV7qZLBp6rzBb
        7F7cz2yx4uocZoszW4GsHy09zBabN7ezOLB77Jx1l91jwaZSj2e9exg9Ll5S9vi8Sc7j9rNt
        LAFsUVw2Kak5mWWpRfp2CVwZR9+eYS3YJlyx/oNPA+Nd/i5GTg4JAROJGd8us4DYQgJbGSXO
        /LTuYuQCss8zSdy494kJJCEsECOxdetKVhBbRMBV4vGymawQRTsYJX4s7WQCcZgF7jJKbPm+
        HqyKTUBXYlFPM1g3r4C9xLo5Z9m7GDk4WARUJBYcUgIJiwqESLQvWw9VIihxcuYTsCs4Bawk
        Pn5tYgIpZwYa07ZGBiTMLCAv0bx1NvMERv5ZSDpmIVTNQlK1gJF5FaNcYk5prm5uYmZOcWqy
        bnFyYl5eapGusV5uZoleakrpJkZIgPPtYGxfL3OIUYCDUYmH10L7TLgQa2JZcWXuIUZJDiYl
        Ud5ZB0+GC/El5adUZiQWZ8QXleakFh9ilOBgVhLhDXwLVM6bklhZlVqUD5OS5mBREudVW6Lu
        JySQnliSmp2aWpBaBJOV4eBQkuDd9w6oUbAoNT21Ii0zpwQhzcTBCTKcB2j4W5Aa3uKCxNzi
        zHSI/ClGRSlx3hSQhABIIqM0D64XloBeMYoDvSLMK/oeqIoHmLzgul8BDWYCGrxu92mQwSWJ
        CCmpBkbXuS5xOekfN15V6xHo5HqXn+GUs7TJRWFPiqzPMw2ens385rt9f582/uVg8uoW4wKG
        Vft6OMWWCNeeecjtvU+i58R6dj4H5jKFmWv6lF04iphyl13KXCxtfJ0ztf+8wKXJ3xdOtX3e
        uHVzJttmn6XfjVl2mSQ75JblHVm6eUt+61bN+RM4ViuxFGckGmoxFxUnAgC5PWAdGwMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/23/2016 11:56 AM, René Scharfe wrote:
> Am 22.08.2016 um 13:22 schrieb Michael Haggerty:
>> "git blame" already parsed generic diff options from the command line
>> via diff_opt_parse(), but instead of passing the resulting xdl_opts to
>> xdi_diff(), it sent its own xdl_opts, which only reflected the values of
>> the self-parsed options "-w" and "--minimal". Instead, rely on
>> diff_opt_parse() to parse all of the diff options, including "-w" and
>> "--minimal", and pass the resulting xdl_opts to xdi_diff().
> 
> Sounds useful: It allows more fine-grained control over which whitespace
> changes to ignore and which diff algorithm to use.  There is a bit of
> overlap (e.g. with -b meaning show blank boundaries vs. ignore
> whitespace changes), but with your patch blame's own options still take
> precedence, so there should be no unpleasant surprises.
> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>> Somebody who knows more about how diff operations are configured
>> should please review this. I'm not certain that the change as
>> implemented won't have other unwanted side-effects, though of course
>> I checked that the test suite runs correctly.
> 
> I don't qualify, but I'll comment anyway..
> 
>>  builtin/blame.c        |  11 ++--
>>  t/t4059-diff-indent.sh | 160
>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 165 insertions(+), 6 deletions(-)
>>  create mode 100755 t/t4059-diff-indent.sh
> 
> This new test doesn't call git blame.  Does it belong to a different
> commit?  And shouldn't the change to blame.c stand on its own, outside
> of this series?

Thanks for catching this. I squashed the test incorrectly; it was meant
to be part of the previous commit. I'll fix it in v3.

The reason that I would prefer to change `blame` as part of this patch
series is that I think it would be disconcerting for `git diff` and `git
blame` to use different heuristics when computing diffs. It would make
their output inconsistent.

But probably that means passing just the new option to `git blame`
rather than passing all possible `diff` options through.

> [...]

Your other comments may be moot given that changing `git blame` in this
way seems to have been a bad idea in the first place [1]. But I'll keep
them in mind if a new version contains similar code.

Thanks,
Michael

[1]
http://public-inbox.org/git/xmqqtwebwhbg.fsf@gitster.mtv.corp.google.com/

