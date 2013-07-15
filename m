From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/19] Index-v5
Date: Mon, 15 Jul 2013 16:38:55 +0700
Message-ID: <CACsJy8AiRCRvGmj4ZV+sc68d1z=S7YrRgPtPgEK+-zzNg7HcsA@mail.gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com>
 <CACsJy8AhmYBjzqPtF3f9Gk8hq2bk8-PtFCto9_4AkRePomvhAQ@mail.gmail.com> <87ehb0cgqt.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 11:39:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyfFn-0000KH-Ad
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 11:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694Ab3GOJjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 05:39:31 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:42608 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666Ab3GOJjb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 05:39:31 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so15669406oag.27
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6ckTUxqUejXUpTTEcmu02Sv/xo+ExIN2AARK5eOl4aY=;
        b=AKRt9jb/8A9lbuheeC0laGVprO943RQB72KvD8CEc2MHqp4/cje8HvqmAKi2ZRHj3w
         GBotyC5A6Aw8OZCPGT+cjFa45XvenBL6PTBBW8zTSEotIS6x5L0/DJ0UMAoBZrYlbIN9
         wtTL8eID1CsockXWmPfp8F4NFE5/XdMFv96/J4BvjCqP2jL0o3mUT3ZgUS12m0yfjAXd
         oPsc0ozXZxxqeqDMG7gto8F1GqIQhjruTrE3sTyBVA2wsC4BfNgBx2goRIfo+VQuCT5x
         9S1m48OKcPiejXr85h0tqC1sSzdl1snU5F2k3HEcUOkZB6Y49d6nU61yqjinE2B9N/Zg
         uAIA==
X-Received: by 10.60.136.161 with SMTP id qb1mr42708168oeb.32.1373881170453;
 Mon, 15 Jul 2013 02:39:30 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Mon, 15 Jul 2013 02:38:55 -0700 (PDT)
In-Reply-To: <87ehb0cgqt.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230447>

On Mon, Jul 15, 2013 at 4:30 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>>  t/perf/p0003-index.sh                            |   59 +
>>>  t/t2104-update-index-skip-worktree.sh            |    1 +
>>
>> For such a big code addition, the test part seems modest. Speaking
>> from my experience, I rarely run perf tests and "make test" does not
>> activate v5 code at all. A few more tests would be nice. The good news
>> is I changed default index version to 5 and ran "make test", all
>> passed.
>
> I was using the test suite with index version 5 as default index version
> for testing of the new index file format.   I think that's the best way
> to test the index, as it covers all aspects.

We need other people to run the test suite with v5 to catch bugs that
only appear on other platforms. Perhaps an env variable to allow the
test suite to override the binary's default index version and a new
make target "test-v5" maybe.

> Maybe we should add a test
> that covers the basic functionality, just to make sure nothing obvious
> is broken when running the test suite with index-v2?  Something like
> this maybe:

Yep. v5 specfic test cases can cover some corner cases that the rest
of the test suite does not care. Haven't read your t1600 though.
--
Duy
