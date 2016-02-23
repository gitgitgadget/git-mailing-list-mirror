From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Tue, 23 Feb 2016 13:56:07 -0600
Message-ID: <87r3g3jj54.fsf@x220.int.ebiederm.org>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
	<1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
	<xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
	<20160223014741.GA21025@wfg-t540p.sh.intel.com>
	<xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
	<20160223091740.GA3830@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 23 21:06:37 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYJEC-0007On-8l
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Feb 2016 21:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbcBWUG1 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 15:06:27 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:45295 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755152AbcBWUGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 15:06:25 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
	by out02.mta.xmission.com with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <ebiederm@xmission.com>)
	id 1aYJDj-0004ay-S6; Tue, 23 Feb 2016 13:06:07 -0700
Received: from 67-3-245-179.omah.qwest.net ([67.3.245.179] helo=x220.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <ebiederm@xmission.com>)
	id 1aYJDg-0004O9-OU; Tue, 23 Feb 2016 13:06:07 -0700
In-Reply-To: <20160223091740.GA3830@wfg-t540p.sh.intel.com> (Fengguang Wu's
	message of "Tue, 23 Feb 2016 17:17:40 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-XM-AID: U2FsdGVkX1+VPT7LFzD7A+WnB+sdXOjDeK+1eRqqrbo=
X-SA-Exim-Connect-IP: 67.3.245.179
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
	DCC_CHECK_NEGATIVE,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
	XMNoVowels,XMSolicitRefs_0,XMSubLong autolearn=disabled version=3.4.0
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 TVD_RCVD_IP Message was received from an IP address
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.1 XMSolicitRefs_0 Weightloss drug
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Fengguang Wu <fengguang.wu@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2631 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 16 (0.6%), b_tie_ro: 13 (0.5%), parse: 1.17 (0.0%),
	extract_message_metadata: 4.3 (0.2%), get_uri_detail_list: 1.73 (0.1%),
	tests_pri_-1000: 5 (0.2%), tests_pri_-950: 1.99 (0.1%), tests_pri_-900: 14
	(0.5%), tests_pri_-400: 39 (1.5%), check_bayes: 37 (1.4%), b_tokenize: 11
	(0.4%), b_tok_get_all: 16 (0.6%), b_comp_prob: 3.7 (0.1%), b_tok_touch_all:
	3.0 (0.1%), b_finish: 0.94 (0.0%), tests_pri_0: 2498 (94.9%),
	check_dkim_signature: 0.82 (0.0%), check_dkim_adsp: 2053 (78.0%),
	tests_pri_500: 7 (0.3%), rewrite_mail: 0.00 (0.0%)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Wed, 24 Sep 2014 11:00:52 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287109>


Fengguag Wu, Xiaolong Ye, have you attempted to use the truncated
sha1 of the file the patch applies to?  Git already places a file sha1
at the top of a patch.  See the index line?

> diff --git a/fs/namespace.c b/fs/namespace.c
> index eccd925c6e82..3c3f8172c734 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c

As I understand it you are aiming for making a good guess what the patch
or patches apply to, having a set of file hashes looks like it would
give you that.

All it should take is to iterate over a patchset and for each file in
the patchset capture the first file hash.  Then in the smallish set of
maintainer trees see if that set of file hashes matches any of their
recent commits.  You should be able to prune the set of possible
maintainer trees even more by looking at the mailling list or lists
the patch was submitted to.

Before we talk about adding anything more I think we need a clear
picture of what you have tried with what already exists.  A decade ago
part of the problem was that not everyone used git.  At best it will
take a little while before everyone upgrades to a version of git diff
containing your changes, and if possibly even longer if they have to
start specifying an additional option when a diff is generated.

Eric
