From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 0/6]  Expose submodule parallelism to the user
Date: Tue, 09 Feb 2016 13:39:03 -0800
Message-ID: <xmqq4mdh36o8.fsf@gitster.mtv.corp.google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 22:39:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTG09-0003RC-8c
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 22:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932764AbcBIVjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 16:39:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932471AbcBIVjH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 16:39:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F1FC437F1;
	Tue,  9 Feb 2016 16:39:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ryjYoxZ0jSnlQtwh/k3PlsDAqQ=; b=ena4+u
	gg8a0LpIxCBLnVDmkA8IfRfz91/6+GpgDpy/fvlbcsYRRuhtHHSsx31ZKy1jXRpv
	EeHDZMoUGbCUr8HIXy154Z8ijdl6LM6lRkY8gxrfdqPGNVjzepoX7bzgtc9Bj6X9
	JWVgguitCFrh6AJBybRowMjMHkYzd5aYTY/RE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J739ifLvz0iNOTfi9KoPyqmvpnGim2zm
	PLI1Ut+fC+HQdAnsJYzNHm2cTZpQl+yHRHf2aYitDGCx2KRd3gD39NUk7v9+zbSY
	NZApZKcvqCoXaU/xgZ8mRiSp3KnvnwyFvaSXV7e9erIB2DvtQPPzCWnoZgPOsSK8
	S5iugbXyTNw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 970A9437F0;
	Tue,  9 Feb 2016 16:39:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1EA2E437EF;
	Tue,  9 Feb 2016 16:39:05 -0500 (EST)
In-Reply-To: <1455051274-15256-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 9 Feb 2016 12:54:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8ACBAB90-CF75-11E5-AE6F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285870>

Stefan Beller <sbeller@google.com> writes:

> This replaces sb/submodule-parallel-update.
> (which is based on sb/submodule-parallel-fetch)
>
> Thanks to Junio and Jonathan for review!
>
> * s/config_parallel_submodules/parallel_submodules/ as it is not in config any
>   more. Also ease up the default setting. 
>
> * use an enum for submodule update strategy

Your earlier sb/submodule-init will need to be rerolled on top, as
it depends on ->update being a string, I think.

> * This seems to clash with 00/20] refs backend.
>> Applied this on top of a merge between the current 'master' and
>> 'sb/submodule-parallel-update' topic to untangle the dependency;
>> otherwise there is no way for this topic to make progress X-<.
>
> Anything I can do to help with easing the clash?

Perhaps try to rebase the series on top of such a merge (with this
updated series) yourself and propose it as a basis for the next
reroll for David?  In short, working together with topic(s) that
touch the same area?

Thanks.
