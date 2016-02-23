From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Tue, 23 Feb 2016 14:08:07 -0600
Message-ID: <87d1rnjil4.fsf@x220.int.ebiederm.org>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
	<1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
	<xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
	<20160223014741.GA21025@wfg-t540p.sh.intel.com>
	<xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
	<20160223091740.GA3830@wfg-t540p.sh.intel.com>
	<xmqq1t8319z0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fengguang Wu <fengguang.wu@intel.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 23 21:18:21 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYJPY-0000Bc-JX
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Feb 2016 21:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbcBWUSK (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 15:18:10 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:47676 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbcBWUSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 15:18:07 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
	by out02.mta.xmission.com with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <ebiederm@xmission.com>)
	id 1aYJP4-0006aJ-Kf; Tue, 23 Feb 2016 13:17:50 -0700
Received: from 67-3-245-179.omah.qwest.net ([67.3.245.179] helo=x220.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <ebiederm@xmission.com>)
	id 1aYJP1-0007lD-Fi; Tue, 23 Feb 2016 13:17:50 -0700
In-Reply-To: <xmqq1t8319z0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 23 Feb 2016 11:51:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-XM-AID: U2FsdGVkX1+UmeI4ET6jbd6CVFNecGQply5uYjph0Jc=
X-SA-Exim-Connect-IP: 67.3.245.179
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
	DCC_CHECK_NEGATIVE,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
	XMNoVowels,XMSubLong autolearn=disabled version=3.4.0
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 TVD_RCVD_IP Message was received from an IP address
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Junio C Hamano <gitster@pobox.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2516 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 3.3 (0.1%), b_tie_ro: 2.4 (0.1%), parse: 1.18 (0.0%),
	extract_message_metadata: 30 (1.2%), get_uri_detail_list: 7 (0.3%),
	tests_pri_-1000: 7 (0.3%), tests_pri_-950: 1.25 (0.0%), tests_pri_-900: 1.02
	(0.0%), tests_pri_-400: 43 (1.7%), check_bayes: 41 (1.6%), b_tokenize: 18
	(0.7%), b_tok_get_all: 12 (0.5%), b_comp_prob: 5 (0.2%), b_tok_touch_all: 3.4
	(0.1%), b_finish: 0.63 (0.0%), tests_pri_0: 519 (20.6%),
	check_dkim_signature: 0.60 (0.0%), check_dkim_adsp: 2.9 (0.1%),
	tests_pri_500: 1907 (75.8%), poll_dns_idle: 1899 (75.5%), rewrite_mail: 0.00
	(0.0%)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Wed, 24 Sep 2014 11:00:52 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287110>

Junio C Hamano <gitster@pobox.com> writes:

> Fengguang Wu <fengguang.wu@intel.com> writes:
>
>>> >> I have a mixed feeling about this one, primarily because this was
>>> >> already tried quite early in the life of "format-patch" command.
>>> >> 
>>> >>     http://thread.gmane.org/gmane.comp.version-control.git/9694/focus=9757
>>> >> 
>>> >> Only the name is different (it was called "applies-to" and named a
>>> >> tree object).
>>> >
>>> > Either commit or tree object will work for us. We can use it in
>>> > v2 if you prefer tree object.
>>> 
>>> Sorry, I think you misunderstood.  By "only the name is different", I
>>> didn't mean to say that the tree object name should be shown as the
>>> old proposal did.  What I meant but didn't explicitly say, as I
>>> thought it was sufficient to point at an old discussion thread, was
>>> that this was already tried and rejected.  This round uses different
>>> name but does essentially the same thing as the old proposal, and I
>>> do not think I heard anything new that supports this patch against
>>> earlier rejection by Linus.  That is what gave me a mixed feeling.
>>
>> I can understand the rejection by Linus in development process POV.
>>
>> However we are facing a new situation: in test robot POV, IMHO there
>> are values to test exactly the same tree as the patch submitter.
>> Otherwise the robot risks
>>
>> - false negative: failing to apply and test some patches
>> - false positive: sending wrong bug reports due to guessed wrong base tree
>
> I always get negatives and positives confused, so let me think aloud
> with an example.  Let's say that somebody worked on adding a new
> feature based on v4.2 codebase and sent in a patch series.  The
> series touched files in quiescent part of the system, these files
> are identical between v4.2 and the current codebase at v4.5-rc5, and
> the series applies cleanly to a "wrong" base tree at the tip of
> 'master'.  But it turns out that the series uses an old API that was
> removed in the meantime.  The test robot may say "the result of
> applying the series does not even build" and the developer would
> complain to you saying "You tested with a wrong version".
>
> I've already said that I can see the value this approach has for
> you.  By having the developer state which commit the series was
> based on, it will shield you from such a complaint, because you
> would not use closer-to-tip 'master' as the base, but instead use
> v4.2 codebase for the test.
>
> As I said, what is unclear to me is what value this apporach gives
> to the project.
>
>>> I can see that recording the exact commit object name allows you to
>>> claim that you identified the exact commit to apply the patch, and
>>> that you tested the exact tree contents.  It however is unclear what
>>> the value of such a claim would be to the project or to the
>>> integrator.
>>
>> The value of base commit info is: providing a solid ground to the
>> tester, to reliably avoid false positive/negatives.
>
> It is valuable for a testing organization to say "We tested this
> series on top of version X.  We know it works, we have tested on a
> lot more hardware than the original developer had, we know this is
> good to go."  It is a valuable service.
>
> But that is valuable only if version X is still relevant, isn't it?
>
> Is the relevance of a version something that is decided by a
> developer who submits a patch series, or is it more of an attribute
> of the project and where the current integration is happening?
> Judging from the responses from Dan to this thread, I think the
> answer is the latter, and for the purpose of identifying the
> relevant version(s), the project does not even care about the exact
> commit, but it wants to know more about which branch the series is
> targetted to.
>
> With that understanding, I find it hard to believe that it buys the
> project much for the "base" commit to be recorded in a patch series
> and automated testing is done by applying the patches to that exact
> commit, which possibly is no-longer-relevant, even though it may
> help shielding the testing machinery from "you tested with a wrong
> version" complaints.
>
> Isn't it more valuable for the test robot to say "this may or may
> not have worked well with whatever old version the patch series was
> based on, but it no longer is useful to the current tip of the
> 'master'"?  If you consider what benefit the project would gain by
> having such a robot, that is the conclusion I have to draw.
>
> So I still am not convinced that this "record base commit" is a
> useful thing to do.

So I don't know what value this has to the git project.

The value of Fengguag's automated testing to the kernel project is to
smoke out really stupid things.

- A developer forgot to actually compile test their code.
  An error report that the code does not even compile from Fengguag
  allows the patch to be dropped without spending any time on it.

- A developer failed to test some weird configuration option in
  like !CONFIG_SYSCTL.  Which results in build errors for people
  who use weird configurations but not for everyone.

- Similarly for changes to non-x86 architectures when making a cross
  tree change.  It is valueable to get feedback on architectures you
  can not compile yourself.

I have not see any great value attached to passing Fengguag's tests but
I have seen a lot of value where the tests don't pass for some stupid
reason and people can go fix it up.

The kernel is a weird project where it actually is a bit tricky to
compile test everything.

Eric
