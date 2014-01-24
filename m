From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/9] add --gpg-sign to rebase and pull
Date: Fri, 24 Jan 2014 12:06:09 -0800
Message-ID: <xmqqzjmlqh5a.fsf@gitster.dls.corp.google.com>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
	<20140124091444.GM10748@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Fri Jan 24 21:06:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6n1A-0005H6-BP
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 21:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbaAXUGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 15:06:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbaAXUGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 15:06:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBDF8651FD;
	Fri, 24 Jan 2014 15:06:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=umKnRbDUX7myKWTmmIk86E6t1Sw=; b=eQdIba
	J/WNFtr358vo1xm9LDtAIwTmHX2lhMTtHP0IRve0aI95LsMyFVukpAIsyPGSwRzt
	G96ReLxCVZoX1pTdT2FtHCjn1E6e5pziHFaZvbnBvGtC39kyufRv11rwl8/F7Tgm
	i+uW/76KLKZFadlXgt1cB4oY4F8zm9PoofSFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IBX5jQHUVGil53InbNUKLJBXlYo9TMfh
	Si7MSiN+8wF7o8oHNguh9MlzE4d7j8v671Vo9JoJKRm/eIGw7pSnZ2m8nYct0BeN
	9su7lyn3oU4TwF/OMsTabHEae2mlRtzojr7L95ep5ZqBzEEuCMX6ioAQbajUKGT6
	Q/TRY1eGD3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3679651FC;
	Fri, 24 Jan 2014 15:06:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADC4E651F5;
	Fri, 24 Jan 2014 15:06:12 -0500 (EST)
In-Reply-To: <20140124091444.GM10748@mars-attacks.org> (Nicolas Vigier's
	message of "Fri, 24 Jan 2014 10:14:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F9369638-8532-11E3-97CF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241028>

Nicolas Vigier <boklm@mars-attacks.org> writes:

> On Fri, 24 Jan 2014, brian m. carlson wrote:
>
>> This series was posted to the list some time back, but it fell through
>> the cracks.  This is a re-send of Nicolas Vigier's work with an
>> additional patch that adds --gpg-sign to pull as well.  I added my
>> sign-off to his patches because SubmittingPatches (section (c)) seems to
>> imply that I should, although I can rebase it out if it's a problem.
>
> Thanks!
>
> An improvement I was thinking to do on this series but had not time to
> do yet is to make the '--no-gpg-sign' option disable gpg signing when
> the commit.gpgsign config option is set to true.

By the way, a configuration variable that has no way of getting
overriden per invocation should not exist without a very good reason
("core.bare" is an example of a exception with a good reason---the
bareness of the repository does not change per command invocation).
An escape hatch "--no-gpg-sign" is a must-have requirement, not a
nice-to-have improvement.

Thanks for not forgetting.
