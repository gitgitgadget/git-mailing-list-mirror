From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2011, #02; Sun, 20)
Date: Sun, 20 Mar 2011 17:06:32 -0700
Message-ID: <7vhbaxuyk7.fsf@alter.siamese.dyndns.org>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
 <7vtyexv6wl.fsf@alter.siamese.dyndns.org>
 <7vpqplv65o.fsf@alter.siamese.dyndns.org> <vpqlj09a303.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 21 01:06:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Se3-0002HW-Op
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 01:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab1CUAGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 20:06:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab1CUAGn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 20:06:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC1F24984;
	Sun, 20 Mar 2011 20:08:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wNG7+pmqYymI3HowyzMrCVlBbDw=; b=iu9OAa
	h+IV6ErV1QJGo9hEjk1sOmCmFDe13ySxksKn/J6V2Xs0EkIis+jOvfcovw93R68r
	6roz+HjlvB2oPRAoni0cPxv00dazxSOsk/rM6UQnBZhqwzhAYOzHmPAbtTQhQHcV
	iQJLMoulA8IH9CD6u2Lp65B/Hff/xJ3xCUcNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qBRHgX5oLQu0OQ0A+s9Ef7JeEhGnHQzh
	K1g0AxmhtzcEpw07JWaoxhi2BiOxi/ht53haQSzv2pCNksh/xDq7ylAM2U13QYg4
	XJzin+Z06kO0vovId3BQcw8XcVuGyrhTyW8VLxiVikJlqoAH4d+rmJ0f/7I4GTPm
	uihxmCLKWAg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 894BC4983;
	Sun, 20 Mar 2011 20:08:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 72BF1497F; Sun, 20 Mar 2011
 20:08:11 -0400 (EDT)
In-Reply-To: <vpqlj09a303.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun, 20 Mar 2011 22:36:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 516CAF86-534F-11E0-9824-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169537>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Unfortunately
>> we do not have a good way to let people who have already heard
>> about the transition to squelch it yet.
>
> How about an advice.addWithoutPath config variable to disable it?

I don't think it is worth it; I'd rather see :/ magic implemented earlier.

Another possibility is to error out on "git add -u" without pathspec in a
subdirectory as an error in 1.8.0, and then make it full-tree in 1.8.X in
a distant future, but that wouldn't be as pleasant.
