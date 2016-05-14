From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 48/94] builtin/apply: rename 'prefix_' parameter to 'prefix'
Date: Sat, 14 May 2016 11:27:27 -0700
Message-ID: <xmqqy47c7awg.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-49-chriscool@tuxfamily.org>
	<xmqqbn4bdp8f.fsf@gitster.mtv.corp.google.com>
	<xmqq37pndn2x.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD05JuxG21MAV0wSYz+Vzqb8-unjW-rOSJ_c9YWWOoTTSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 20:27:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1eHy-0008OW-Fn
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 20:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbcENS1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 14:27:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752370AbcENS1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 14:27:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E427B1A459;
	Sat, 14 May 2016 14:27:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8ai8MrPpcs5OTk4875BFgutwWGs=; b=qR/NOw
	cC7LSlwnjJH5aBdaR3fOahDkJtpls3XYMiAjSXTuIOfLSZpm4/KAMp3tDwVDwmAk
	DkPn9as5YmP4ma7yGkkkRLum8UMuW1IGQtnukGOpNCGFbUwtf1MWgQRub/KPe+Q1
	VKzYz5eIn+f+FbOm/d1fVwv/dBJhMcVlD098g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=czQ+r3kt9goa4/Gnr/e84y/0VKML6RxE
	sf7FsdHLpZoZ9BX+Ckfsi1ALKZnEe14rLcps2I1zIodeo2S+YZOboTn/h3eDQM1K
	KnMTRf/LpWYTW3TPyu39sKPRaRImbySAch8sSYR1zzwpZ49HfnR1qdrjBV+RusGv
	RFJOISQHt8Q=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB5081A458;
	Sat, 14 May 2016 14:27:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54F7C1A457;
	Sat, 14 May 2016 14:27:29 -0400 (EDT)
In-Reply-To: <CAP8UFD05JuxG21MAV0wSYz+Vzqb8-unjW-rOSJ_c9YWWOoTTSQ@mail.gmail.com>
	(Christian Couder's message of "Fri, 13 May 2016 21:45:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 840FC51C-1A01-11E6-8BDB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294620>

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, May 12, 2016 at 10:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Up to this point, the conversion looks quite sensible, even though I
>>> think the organization of fields in apply_state do not look logical.
>>
>> I'd stop here for now, as everything before this step looks
>> uncontroversial.  Anybody whose tasked to move the global state for
>> these variables into a structure would reach the samestate after
>> applying these 48 patches, modulo minor differences in the way the
>> comments would say things, how the patches are split and how the
>> fields in apply_state() are organized.
>>
>> One thing that is missing is a counterpart of init_apply_state().
>> In the early part of patches where it added only "const char *"
>> borrowed from the caller and fields of intregral type, the lack of
>> clear_apply_state() did not mattter, but with a few fields with
>> "string_list" type, anybody who want to make repeated call into the
>> apply machinery would want a way to release the resource the
>> structure holds.
>>
>> Because 49/94 is a step to add an unfreeable resource, this is a
>> good place to stop and then add the clean_apply_state() before that
>> happens, I would think.  After that, I think both the contributor
>> and the reviewers would benefit if these early patches are merged
>> early without waiting for the review of the remainder.
>
> Ok, I will add add the clean_apply_state() and resend the patches up
> to that point soon, so that they can be merged early.

Two more comments:

 - Just like the change between v1 and v2, if we were to introduce
   clear_apply_state(), it would be nicer if it were done early in
   the series, ideally at the same time as init_apply_state() gets
   introduced, or at least no later than the first field that holds
   resource that needs releasing is added.

 - I didn't double check if 50 and later still had changes that
   belong to this "early batch that moves things into a struct" (aka
   cc/apply-introduce-state) topic, as I stopped at 49 and saw the
   need for clear_apply_state().  So 48 may not be the ideal place
   to stop.  From a cursory read of their titles, perhaps 49, 50, 56
   and possibly 60 should be in this early series?  While 60 does
   sound like an immediate follow-up to 09/94, it depends on a few
   "die elimination" changes, so I do NOT think it must be in the
   early batch.
