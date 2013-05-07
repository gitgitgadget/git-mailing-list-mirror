From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/7] git-clean: use a git-add-interactive compatible UI
Date: Tue, 07 May 2013 08:20:51 -0700
Message-ID: <7vmws6lsto.fsf@alter.siamese.dyndns.org>
References: <4a32eb7cc4e277fcbf4b46c13524874334bea2a3.1367867498.git.worldhello.net@gmail.com>
	<6276dc8861b40e8377586f30b85c33e92c4e68fe.1367867498.git.worldhello.net@gmail.com>
	<CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com>
	<cover.1367867498.git.worldhello.net@gmail.com>
	<c77c33fe295bb8577336d5bb4fe0d8da32f69df3.1367867498.git.worldhello.net@gmail.com>
	<217e7618e9b9d50a50461959b38984ac8be88651.1367867498.git.worldhello.net@gmail.com>
	<CANYiYbEE90zvhoRp3utOzRWXnpVGTcaruWDuCCHE77FmGwB2_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 17:21:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZji1-0000Cj-TS
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 17:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726Ab3EGPVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 11:21:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757193Ab3EGPUy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 11:20:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E7CC1CEF4;
	Tue,  7 May 2013 15:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gIakJPUzExZravJZGtAvBL9wuQg=; b=uzmirR
	gtt5TQW/p2fGQ1Xb2B3utP5tdhQBu7RtaDOC+EZy7VLUGFeJzhRfmcF/8mQc9K1s
	iD5w+9w1nDrFK8OC4P/MLuXdQExhj2OlTsdcMKVhYd2ScgksiZZs0fL1dg0zRsFc
	qRSfp9DzbKLItkFr4IaUdajuFCcQhlwpQosYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YGM2z72UXanVbaS/2CKFt6ZnvnzUEpdo
	UKqK/Xwo77lsN2MJmR+0Cgc7jHCJbxmx/lb895+1M96ZlTpM36oVaFnjwy+zWGyd
	zpTU14XeyhM1aSq9WQy0MrZvRQ7IpdWgwLyJZeRazioUtrnbstL6h+Ykq+TonrxU
	xcpftwCxqCU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 326811CEF3;
	Tue,  7 May 2013 15:20:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A816A1CEF1;
	Tue,  7 May 2013 15:20:53 +0000 (UTC)
In-Reply-To: <CANYiYbEE90zvhoRp3utOzRWXnpVGTcaruWDuCCHE77FmGwB2_w@mail.gmail.com>
	(Jiang Xin's message of "Tue, 7 May 2013 12:16:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5404DB6-B729-11E2-B3D8-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223579>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/5/7 Jiang Xin <worldhello.net@gmail.com>:
>> Rewrite menu using a new method `list_and_choose`, which is borrowed
>> from `git-add--interactive.perl`. We can reused this method later for
>> more actions.
>>
>> Please NOTE:
>>
>>  * Method `list_and_choose` return an array of integers, and
>>  * it is up to you to free the allocated memory of the array.
>>  * The array ends with EOF.
>>  * If user pressed CTRL-D (i.e. EOF), no selection returned.
>>
>> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>> ---
>>  builtin/clean.c | 410 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 367 insertions(+), 43 deletions(-)
>...
>> -void edit_by_patterns_cmd()
>> +void pretty_print_menus(struct string_list *menu_list)
>> +{
>> +       struct strbuf buf = STRBUF_INIT;
> unused buf should be deleted.
>
>> +       unsigned int local_colopts = 0;
>> +       struct column_options copts;
>> +
>> +       /*
>> +        * always enable column display, we only consult column.*
>> +        * about layout strategy and stuff
>> +        */
> remove the above comments.
>
>> +       local_colopts = COL_ENABLED | COL_ROW;
>> +       memset(&copts, 0, sizeof(copts));
>> +       copts.indent = "  ";
>> +       copts.padding = 2;
>> +       print_columns(menu_list, local_colopts, &copts);
>> +       strbuf_release(&buf);
> remove strbuf_release of unused variable : buf.
>
>> +}
>...
>> +               } else if (MENU_STUFF_TYPE_STRING_LIST == stuff->type) {
>> +                       struct string_list_item *item;
>> +                       struct strbuf buf = STRBUF_INIT;
> should call strbuf_release later
> ...
>> +       } else {
>> +               result = xmalloc(sizeof(int) * (nr + 1));
>> +               memset(result, 0, sizeof(int) * (nr + 1));
>
> Add initial for j here:


What is this message trying to achieve?  "self review"???

A bit puzzled....
