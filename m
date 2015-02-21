From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: add disassociate alias to dissociate option
Date: Fri, 20 Feb 2015 23:13:47 -0800
Message-ID: <xmqqzj87wxck.fsf@gitster.dls.corp.google.com>
References: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>
	<1424459423-11727-2-git-send-email-mattwhiteley@gmail.com>
	<20150221062754.GC29665@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matt Whiteley <mattwhiteley@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 21 08:13:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP4GA-000333-Cn
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 08:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbbBUHNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 02:13:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751133AbbBUHNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 02:13:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B8A3031B4C;
	Sat, 21 Feb 2015 02:13:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I9Qd6u+1BmbINCBJcF/pCmgFfWY=; b=xBmcUC
	0rKBAfgrqIA13i6ErzpzZvf5GVWUJhy6h9zOXnab6HYE89ObniJ/qMZgnIjRSPjG
	qZ66jFlcSBDtp258JdiOqsZCJls6Dm74QSXbZQ0uxCfhTkwQnW2T5Dlnmmv60hQG
	ghZXP+HiZxmlxP5+MGM2ukiI8dTkkTNscSz2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WhahDfMdZ4PjtOMDu1fFzTVlLjc0Tm6f
	MiJFNPCMp3Yq1ZD35EHtvTumUPD0zzdJ3OjGaITmnqQPaZovp8Vo84vZjKxezmbZ
	biWEd7+7QTtZCDLYQhx/NKhwhvEasdJalU6xqFnCUcSkIauYc3YEks5poo6kZzcg
	Vdfuzjekwq8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B095F31B4B;
	Sat, 21 Feb 2015 02:13:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3895F31B4A;
	Sat, 21 Feb 2015 02:13:48 -0500 (EST)
In-Reply-To: <20150221062754.GC29665@peff.net> (Jeff King's message of "Sat,
	21 Feb 2015 01:27:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E17D682-B999-11E4-A1C7-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264213>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 20, 2015 at 11:10:22AM -0800, Matt Whiteley wrote:
>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 316c75d..7e193ae 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -97,6 +97,8 @@ static struct option builtin_clone_options[] = {
>>  		    N_("clone only one branch, HEAD or --branch")),
>>  	OPT_BOOL(0, "dissociate", &option_dissociate,
>>  		 N_("use --reference only while cloning")),
>> +	OPT_BOOL(0, "disassociate", &option_dissociate,
>> +		 N_("use --reference only while cloning")),
>
> Should this second one be marked as OPT_HIDDEN? I do not think we need
> to show both in "git clone --help".

For that matter, I am not sure why we want to add this synonym in
the first place.

http://www.merriam-webster.com/dictionary/dissociate

    : to end your relationship with or connection to someone or
    something : to separate (yourself) from someone or something

which is exactly what I wanted the option to achieve.
