From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv11 0/7] Expose submodule parallelism to the user
Date: Thu, 18 Feb 2016 11:46:39 -0800
Message-ID: <xmqqy4ahg5sw.fsf@gitster.mtv.corp.google.com>
References: <1455320080-14648-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 20:46:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWUXL-0008Br-VW
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 20:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947588AbcBRTqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 14:46:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946442AbcBRTqm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 14:46:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 623854585B;
	Thu, 18 Feb 2016 14:46:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8WrxkepI6+R46+Dl5Cvajws1mAM=; b=H/JR1j
	bHpCyLTgDvymCWnM3HhB5PF9/Bbezs+LemYEsjJNFrdzc8SmIFbhmp4D2jx6PhRN
	792L3a8WY6zwWpzzsDlF6gBytxLHFBcqLykaPGA+730de7Lme+BSRPtCudzwpjWR
	rxQvRNCskldgqeE45Urb3pSR1ax7L2bftsQCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WnTyx94R2/PjdfoMUleCEu1IMHvD01a2
	rbivi1fRKFnsTsr/XAiZ/9aIXbvlg9lvmqXEO8eEjSp36YLE3zYvDRTHJIUmeHhc
	UFKacZ8QGFGDjyhE5k+Tzm6UNOokVQIlFnHyhNA57JQl3stisWpwuirHAijSssaS
	vujceo3zTOU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 57CEB4585A;
	Thu, 18 Feb 2016 14:46:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CF7E845859;
	Thu, 18 Feb 2016 14:46:40 -0500 (EST)
In-Reply-To: <1455320080-14648-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 12 Feb 2016 15:34:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 549C7676-D678-11E5-BE4D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286616>

Stefan Beller <sbeller@google.com> writes:

>> This replaces origin/sb/submodule-parallel-update
>> and is based on origin/master
>>
>> * broke out the patch for redirecting errors to stderr in "submodule update"
>>   (Thanks Jonathan, Jacob)
>> * use git_config_int and manually check for less than 0.
>>   (Thanks Junio)
>> * use an enum consistently now for submodule update strategy
>>   (Thanks Junio)
>> * fixed the funny indentation
>
> * removed the indirect call to submodule_config, but made it directly
>   (Thanks Jonathan)

I just finished going through the series one more time, and other
than one small "huh?", everything looked good to me.

Let's seriously push this forward.

Thanks.
