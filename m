From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list: refuse --first-parent combined with --bisect
Date: Sun, 08 Mar 2015 00:00:12 -0800
Message-ID: <xmqq1tkzudf7.fsf@gitster.dls.corp.google.com>
References: <xmqq61ag72gc.fsf@gitster.dls.corp.google.com>
	<1425763876-15573-1-git-send-email-me@ikke.info>
	<20150307231305.GA15619@vps892.directvps.nl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Sun Mar 08 09:00:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUW8L-0001vk-Vk
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 09:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbbCHIAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 04:00:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751026AbbCHIAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 04:00:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC7B7378BF;
	Sun,  8 Mar 2015 04:00:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O3acvfPAHDDvqAPIe8ddt5d8Zy0=; b=c2pMgh
	fqlCiwm+JcaQ+yVSq/KTWRF4rGu3XGsXWEcxnoa4bHsPRVMEvcmJbQPcR8EojXD6
	d/2KZymQTo6LF2OxinsDeLqO7BkSsmIPZhrtYww6jrzWpq5Y+kcWQFKlX2h/xEwb
	3e2qd/m2roV9yED4DVCX1R8CaPuCZ7mTVEhtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g/yx1atlooXAo/cT6g/nl/PhiHbxhNDh
	kWUzWuITkIb0qd0v71iDdF2E88fHDaKAYZLIOtIpZ0WHGu0lyVBNVgKT1MX0tGJv
	AvlrNvb6aenQsT+LZLZDE2waqptTkZM0m0GX3i1Mja6edl+MB02DbwoAoerNhFec
	9S4cFujo5Pc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4D21378BD;
	Sun,  8 Mar 2015 04:00:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19AF7378B6;
	Sun,  8 Mar 2015 04:00:14 -0400 (EDT)
In-Reply-To: <20150307231305.GA15619@vps892.directvps.nl> (Kevin Daudt's
	message of "Sun, 8 Mar 2015 00:13:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26CD3238-C569-11E4-86CB-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265043>

Kevin Daudt <me@ikke.info> writes:

> On Sat, Mar 07, 2015 at 10:31:16PM +0100, Kevin Daudt wrote:
>> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
>> index ff84a82..c271e15 100644
>> --- a/builtin/rev-list.c
>> +++ b/builtin/rev-list.c
>> @@ -291,6 +291,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>>  	if (revs.bisect)
>>  		bisect_list = 1;
>>  
>> +	if(revs.first_parent_only && revs.bisect)
>
> I should have added a space after the if.

Since you are practicing, let me say that a better way to do this is
to reroll the whole patch and have that comment after the three-dash
line.

That is, you respond to your message with a new patch that corrects
the above, and where you said "This is my first code patch, and
thought this was a nice exercise." in your first message, you would
say

  ---

   * changes from v1: corrected coding guideline violation that
     missed a SP between "if("

or something like that.

Thanks.
