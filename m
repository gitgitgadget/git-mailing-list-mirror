From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2013, #04; Thu, 15)
Date: Mon, 19 Aug 2013 09:53:47 -0700
Message-ID: <xmqqioz18vvo.fsf@gitster.dls.corp.google.com>
References: <7vbo4ypon7.fsf@alter.siamese.dyndns.org>
	<5210B42F.7050106@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 19 18:53:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBSiK-0005uA-GZ
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 18:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862Ab3HSQxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 12:53:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab3HSQxw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 12:53:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D6FE3A490;
	Mon, 19 Aug 2013 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0M4ArkrMy7lXH1/+PdVC3y0OnXU=; b=Sw3nht
	pGyQVKLz4xbEEBecJupKSgdPkQkoIzyxilai+I9+SPothCiVBCG1FOi7gr/ZaHxY
	9NFYNMrzW4Vgab0hRN6ABiDhMOVyu+k77pe65DksCQXtWeLY3HRbh4GRsNqIndoL
	2GEw76inDpvpt5vvuqTtW8LoEuI8Qx11FlVDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=izKyhOuh0s+9O1jUE2RbJ+LEgoF8odhw
	S5RiRir7GuTpNWr6PckbJRYtZL3WZJwh683qUHrVh1FFQ02hK+6HnsTjm7d1UT5/
	zzQgZU3u9qIXIPQuaT5idnYWfmF3PU6RmP6OAkU9cYfHDDU8IM/87LSuJph4njTt
	r38bodaet3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 708703A48F;
	Mon, 19 Aug 2013 16:53:51 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD24F3A48C;
	Mon, 19 Aug 2013 16:53:49 +0000 (UTC)
In-Reply-To: <5210B42F.7050106@kdbg.org> (Johannes Sixt's message of "Sun, 18
	Aug 2013 13:46:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EBD1A29A-08EF-11E3-9605-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232552>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 16.08.2013 00:36, schrieb Junio C Hamano:
>> Due to unfortunate regressions, two topics had to be reverted:
>>
>>   * An attempted fix to "git stash save", to detect that going back
>>     to the state of the HEAD needs to lose killed files, and/or
>>     untracked files in a killed directory, to prevent the command
>>     from proceeding without "--force".
>>
>>     This used "ls-files -k" that was unusably slow.
>>
>>   * An attempted enhancement to allow "@" to be used to name "HEAD".
>>
>>     This rewrote "@" in a ref where it shouldn't have,
>>     e.g. refs/@/foo.
>
> You still need to remove corresponding paragraphs from the release notes.

Indeed.  Thanks for reminding.
