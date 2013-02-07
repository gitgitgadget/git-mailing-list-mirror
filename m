From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Thu, 07 Feb 2013 15:41:05 -0800
Message-ID: <7v38x766b2.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com>
 <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
 <20130207233017.GD19397@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 00:41:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3b64-0004rc-QU
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 00:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945930Ab3BGXlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 18:41:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57860 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422745Ab3BGXlN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 18:41:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10CA2D2E7;
	Thu,  7 Feb 2013 18:41:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hYMVf/JfAF3xJAdh8ULvnsYJgJM=; b=TESDWH
	DgDekGTIuGarWd+T5hDv4jdKkQtAkmvHWpNMIy6/OGxQFwhm5j7NiLTp6fkqPb1R
	AxhaNLCHwdXX7vwtEOxe5J2Oo9oS6UaBt+YxxcVk9+WNATtmsdRNWwGBGBwZhK/p
	0X1MXyCaOHefeq4lqY5Vh15qXUvv/XWXPx8qs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=buYO0nFS88fjC4H6PWQQxdCeTuZgom+R
	rNCsJjCA+qCKt1NZcXfoOShqJp7mr6eoELzNVnJEhH2RxqXz6+qcv+xGtzv8tpHq
	S8/pApyrPTKMnP/JK4xcS1WCCCi4hFT+7PxZ1pZ4ex0A4shI6yuDhSVL0EMGEP1C
	syN7E2cL85M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B9A5D2D1;
	Thu,  7 Feb 2013 18:41:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6104BD2C7; Thu,  7 Feb 2013
 18:41:09 -0500 (EST)
In-Reply-To: <20130207233017.GD19397@google.com> (Jonathan Nieder's message
 of "Thu, 7 Feb 2013 15:30:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D962982E-717F-11E2-8079-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215736>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The usual incantation is "git push gerrit HEAD:refs/for/master".  Is
> the code review creation push that uses a different branchname from
> the branch the integrator pulls what seems backward, or is it the need
> to specify a refname at all on the command line?
>
> I agree that a "[branch "master"] pushremote" configuration would be
> handy.  pushremote instead of remotepush to be less surprising to
> people who have already seen pushurl.

I'd actually see this as Gerrit being weird.

If it wants to quarantine a commit destined to the "master" branch,
couldn't it just let people push to "master" and then internally
update "for/master" instead?
