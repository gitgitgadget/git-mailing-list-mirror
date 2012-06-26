From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log: Handle new repository case.
Date: Mon, 25 Jun 2012 21:00:25 -0700
Message-ID: <7v7guuen8m.fsf@alter.siamese.dyndns.org>
References: <1340664813-96891-1-git-send-email-muhtasib@gmail.com>
 <7vobo7dlyl.fsf@alter.siamese.dyndns.org>
 <CAA3EhHK25rLU-gQNUG0cmJ4E1g+Ce6AHcMF6jzcco5QaTJE+jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leila <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 06:05:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjN1Q-0008Ff-3l
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 06:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995Ab2FZEAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 00:00:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695Ab2FZEA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 00:00:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A8959AC9;
	Tue, 26 Jun 2012 00:00:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=soyTxYds6CLe5GdXWhaBsHCFmvk=; b=B5MVM9
	joTUR8TmEqE7cNB0gPHhFCjmlUSRgQj9bGuCKxl75Cs/aF8FDGT53KgZfQ1ycOsm
	UxZJNmokoxNujiG4dA2FkIeQMRV8ET9arse3brApUxGilEG1WN2Wo+397ffVX7Y+
	KrLrfxsUf3n/DbWtYbDgnMGiQSXSqefvf7sdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h3FrgrOPsaOGWDe1xNUCiMAtAjQGfIpM
	PcESRJDhAeQyKXbKX6zmcDSLe4ivVNWa+xNJSDwLCReOL6O8DPhHOCwioBqMYk5Q
	bmA/vN4tALpLDqaBCKwnRe4UsOtNdU2cWJitKXICrrr2pa+xOEXeHxtwBd398PdO
	c0aFGy9VClo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 219209AC8;
	Tue, 26 Jun 2012 00:00:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEC899AC7; Tue, 26 Jun 2012
 00:00:26 -0400 (EDT)
In-Reply-To: <CAA3EhHK25rLU-gQNUG0cmJ4E1g+Ce6AHcMF6jzcco5QaTJE+jA@mail.gmail.com> (Leila's
 message of "Mon, 25 Jun 2012 22:42:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 765BBE20-BF43-11E1-8429-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200626>

Leila <muhtasib@gmail.com> writes:

>> I didn't think about other commands, but I do not think format-patch
>> wants to silently succeed without doing anything---it is definitely
>> a user error, no?
>>
>
> The other changed commands are git show, git whatchanged, git reflog.
> And I think for the initial repo case, they can just silently succeed
> vs display that error message.

What should happen if you say "git log/show/whatchanged" immediately
after running "git checkout --orphan foo"?  Should these commands
succeed silently?
