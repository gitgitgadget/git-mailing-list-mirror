From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Tue, 23 Feb 2016 22:30:04 -0800
Message-ID: <xmqqpovmmxhv.fsf@gitster.mtv.corp.google.com>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
	<1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
	<xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
	<20160223014741.GA21025@wfg-t540p.sh.intel.com>
	<xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
	<20160223091740.GA3830@wfg-t540p.sh.intel.com>
	<20160223103253.GE5273@mwanda>
	<20160223120015.GA10488@wfg-t540p.sh.intel.com>
	<20160223133135.GF5273@mwanda>
	<20160224025519.GB16562@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 24 07:30:25 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYSxs-00040I-HP
	for glk-linux-kernel-3@plane.gmane.org; Wed, 24 Feb 2016 07:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757025AbcBXGaK (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 24 Feb 2016 01:30:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756714AbcBXGaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Feb 2016 01:30:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9EAB23C9EA;
	Wed, 24 Feb 2016 01:30:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HnkAbbMSEh7zQL2rXtLZblguUrg=; b=xM5AMJ
	filpomw/B1UOoKwjoCfLFnmGiOH9EcPPMPdz4zqqaYVYx0iKRC987vrr5Eq1V2oJ
	x2n5YPrssL6Siy3BBBiW6ZfJ97+WqhZQcdCXXnBvBRJ3qo8q8u52cZh0hjlhbtWH
	ZsB9a6KGaPEVzjCFLvcG8xWwjC/fuLthlAZ94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=olmErNNLGhmQkwXKjfaH+cNIVT/d7e8i
	yv476HxqQZUQVybJ0OW2rY024LA675sDRSWzzhGZAaWtHYmLoLXkGfy0aZl6W5wL
	Anl+7whdPeULRYiH2k9fK4mSGdUtxujs3Ori3vuPejMNzYyt/7ibODaAbzwbE66+
	r18XGm7f9po=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94D2B3C9E9;
	Wed, 24 Feb 2016 01:30:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F1A773C9E3;
	Wed, 24 Feb 2016 01:30:05 -0500 (EST)
In-Reply-To: <20160224025519.GB16562@wfg-t540p.sh.intel.com> (Fengguang Wu's
	message of "Wed, 24 Feb 2016 10:55:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0B2DF658-DAC0-11E5-82E7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287172>

Fengguang Wu <fengguang.wu@intel.com> writes:

> The necessary lines for the robot are
>
>         base commit:
>         base patch-id:
> or
>         base tree-id:
>         base patch-id:

I will not repeat why a commit object name would be more appropriate
than a tree object name here (please see my response to HPA).

> The "base tree-id" will be useful if the submitted patchset is based
> on a public (maintainer) commit.
>
> The "base patch-id" will be useful if the submitted patchset is based
> on another patchset someone (likely the developer himself) posted to
> the mailing list.

Is there a database of in-flight patches indexed by their patch-ids
with a large enough coverage (hopefully those who maintain such a
database are using the --stable version of the patch-id for indexing
the patches)?  I am wondering how well this scales, especially if a
well-known commit named by "base commit" needs to be checked out and
then many in-flight patches identified by "base patch-id"s need to
be applied on top of it, to prepare the tree-ish the patch being
evaluated can be applied to.

This starts to sound more like something you would want to write in
the cover letter, or the trailer block next to Signed-off-by: at the
end of the first patch in the series.  Or even after the mail
signature at the very end of the message (incidentally that would
probably minimize the damage to the Git codebase needed for this
addition--you should be able to do this without touching anything
other than builtin/log.c).
