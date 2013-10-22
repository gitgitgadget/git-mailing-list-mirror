From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible
Date: Tue, 22 Oct 2013 13:26:01 -0700
Message-ID: <xmqqtxg9rr1h.fsf@gitster.dls.corp.google.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
	<A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
	<660A536D-9993-4B81-B6FF-A113F9111570@gmail.com>
	<AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com>
	<79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com>
	<89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com>
	<FB9897CC-EDC7-4EBB-8DAB-140CEB5F93B3@gmail.com>
	<C876399C-9A78-4917-B0CF-D6519C7162F6@gmail.com>
	<87mwm5vkue.fsf@linux-k42r.v.cablecom.net>
	<BB9AEFCE-0E64-4EAA-8DEA-9A8125B8C553@gmail.com>
	<xmqqob6htbx9.fsf@gitster.dls.corp.google.com>
	<2CB6100D-747E-4F65-8F73-7BA381AC4BD4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 22:26:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYiWt-0002Rh-U7
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 22:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab3JVU0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 16:26:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038Ab3JVU0K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 16:26:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1AFB4C6F7;
	Tue, 22 Oct 2013 20:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hwVrevn3wuk1DHl86CnAgHRGB7E=; b=D1i2lW
	wfGWfETqadaVKRH0LyZfS51vfhRk6xVMLk5A3YNCfbrXoxMsYYW2vRJk6i9NeTA9
	762SC53Uq9VoaTsh20J6Q5aq7OmxlI5yPA7m5ShU3cvUf15mez56q12BzenU3ZcG
	YGNxrQwZT0SPLCdBKJ/HkUx+qz8Fq4D8KyaRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EovOSZPdM7CA23fT44+FStKjBTiksM8f
	6ZlEhxw6qtI9HkOi38wO2YVlPrWN6+W6DBCQA9zIbg+kH34YZ2xZpJWoXx8pGDdO
	uxfydRlemUIVIFory2RZDpSTh4FgsFoC+Tlr6awdDqCgZwI5UJmLym5OxsoKOep4
	CZr3rJgJVXM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95E804C6F6;
	Tue, 22 Oct 2013 20:26:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7BA84C6F4;
	Tue, 22 Oct 2013 20:26:08 +0000 (UTC)
In-Reply-To: <2CB6100D-747E-4F65-8F73-7BA381AC4BD4@gmail.com> (Yoshioka
	Tsuneo's message of "Tue, 22 Oct 2013 23:14:46 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2F65F160-3B58-11E3-AFE4-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236488>

Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:

> And, it might be a bit nicer for me if the patch can be
> rejected(or ignored as other patches) from the beginning if the
> concept does not fit anyway.

Yes, but...

> # Though I know we can know more after seeing the implementation, anyway :-)

... you are very correct about this.

Note that I am not rejecting the topic yet.  I am just saying that I
am not yet convinced the patch improves the situation where an
optimal solution (i.e. no information loss at all) cannot exist
because we do not have enough output columns to work with.

Thanks.

>> ...
>> So you are correct to say that I am still skeptical.
>> 
>> In any case, the output from "diff --stat -M" should match the
>> output from "apply --stat -M", I think.
