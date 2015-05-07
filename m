From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-p4: fix handling of multi-word P4EDITOR
Date: Thu, 07 May 2015 13:16:06 -0700
Message-ID: <xmqqlhh0nny1.fsf@gitster.dls.corp.google.com>
References: <1431019501-30807-1-git-send-email-luke@diamand.org>
	<1431019501-30807-3-git-send-email-luke@diamand.org>
	<xmqqr3qsp8a0.fsf@gitster.dls.corp.google.com>
	<554BBCBE.1020408@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu May 07 22:16:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqSDO-0000M2-65
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 22:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbbEGUQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 16:16:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751096AbbEGUQI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 16:16:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 335064FBBA;
	Thu,  7 May 2015 16:16:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G0AtC6AoHkjLY+eV1UiFrUank1s=; b=sb87uf
	moTLldIfa00jMk1PhHmG4No5igirI3uKizq2gTYbk+CovAaWijEGwwvLPrnd8KrE
	35duUzmUxhriWm0a3+0203dbm9mWdsoWuWrS89hYlOkPYiQS4+UwzeP44AFldIAm
	DKUH00dkVr7Kl/IT9f7l8ILJO4lQC1ki4l2Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jqS3JPycBKPy6KvM1NBLzVsM2cU3EIYY
	ev6GtFhgIQojCKvw+G8mJ3FV7PuwUHDZkDRv1fGpMQS5ZiMmer+bTY7V1q17fM3w
	FPQPljTdPPp7gnM3dkmipgwVYKkUfkXEIdx7o2v9dydVOZUeKmRSw3TPhjdQlGSx
	4zKpdIBF8fs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B2CA4FBB9;
	Thu,  7 May 2015 16:16:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DC0A4FBB6;
	Thu,  7 May 2015 16:16:07 -0400 (EDT)
In-Reply-To: <554BBCBE.1020408@diamand.org> (Luke Diamand's message of "Thu,
	07 May 2015 20:27:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E526065E-F4F5-11E4-86DB-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268585>

Luke Diamand <luke@diamand.org> writes:

> On Linux:
>
> $ export P4EDITOR="gvim -f"
> $ p4 submit
> -- works as you would hope --
>
> $ export P4EDITOR="/home/lgd/My Programs/editor.sh"
> $ p4 submit
> sh: 1: /home/lgd/My: not found
>
> $ export P4EDITOR="/home/lgd/My\ Programs/editor.sh"
> -- works fine --

Good.  That is exactly I wanted to see.

Thanks.
