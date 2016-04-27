From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/4] Add --base option to git-format-patch to record base tree info
Date: Wed, 27 Apr 2016 08:04:45 -0700
Message-ID: <xmqqr3dray9e.fsf@gitster.mtv.corp.google.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
	<CAGZ79kajpAtbHaKLaLHN5+qUOvBofFs-q-vUYWua49GWK7FO9Q@mail.gmail.com>
	<xmqqlh40gs9o.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZg3OpR8k45=q1m-g=t+aGGs8VDYBrBYaBU_DbfuuoBig@mail.gmail.com>
	<xmqqd1pcgr3s.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZNV+g3_Rmpynh-WQVc3dW6nuNDsTM=gTxNuJnr3V3Azg@mail.gmail.com>
	<xmqq4maogpsw.fsf@gitster.mtv.corp.google.com>
	<20160427073350.GA30342@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Fengguang Wu <fengguang.wu@intel.com>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Ye Xiaolong <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 17:04:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avR1K-0004DK-48
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 17:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbcD0PEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 11:04:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752046AbcD0PEt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 11:04:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB33A14BA0;
	Wed, 27 Apr 2016 11:04:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jth61TzzjtYQguM3z/tjPsNkSfY=; b=fp5Eus
	coEB3loLxDMOBUOaR7ug2H/qd1sW2xNJiaYpdK8XdLQZNeNUdSqAFY38kxov5Q+A
	zC0xwc6jNYrM3hI1OlCx2ujJe15hLvp0Y2XOTvt2Ez/UZNbfT32zT3H3VEr/fzmd
	CqT4qB0urbEGuY0xobiwemb2xQsz11PhZ7SrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NEM7/LflZvZzAzzK+QP95mCIPIKNwEje
	sGKSy1IhExVg73Abu/Pl9pB9ts4AxepH+5LW5/it1gvf3oJJ0cQoXQYvT488mtmH
	IA6ldo1AD1yaim8PXAzTX/KTBNo8Velw/hkLKe3PWKls0m6ZrNcYCIyYauNthvXh
	Qz+GQGqhFSw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C228314B9F;
	Wed, 27 Apr 2016 11:04:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F18E414B9E;
	Wed, 27 Apr 2016 11:04:46 -0400 (EDT)
In-Reply-To: <20160427073350.GA30342@yexl-desktop> (Ye Xiaolong's message of
	"Wed, 27 Apr 2016 15:33:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 61B52DAC-0C89-11E6-9085-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292727>

Ye Xiaolong <xiaolong.ye@intel.com> writes:

> On Tue, Apr 26, 2016 at 11:58:39AM -0700, Junio C Hamano wrote:
>
>>Let's hear from folks at Intel ;-) Both of the above sounds like
>>sensible enhancements to me.
>
> Shall I squash these enhancements in this series, or I need to make
> another patch for them?

The update being discussed is not a "oops, the series without this
update is embarrassingly flawed" fix, but rather "the series is good
enough to be used as-is, but here is to potentially make it even
better", I'd prefer to have it as a separate, follow-up patch that
applies on top of what has been queued.  That way, if this turns out
to be not so good idea, removing it alone while preserving what is
already there will be easier, and also others who will be studying
the code to further enhance the heuristics of base selection in the
future will benefit.
