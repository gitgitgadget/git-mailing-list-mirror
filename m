From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push --repo option not working as described in git manual.
Date: Mon, 26 Jan 2015 08:31:29 -0800
Message-ID: <xmqqppa1mrku.fsf@gitster.dls.corp.google.com>
References: <loom.20150126T091917-791@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jay Soffian <jaysoffian@gmail.com>
To: Prem <prem.muthedath@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 17:31:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFmZc-00071u-Rx
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 17:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536AbbAZQbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 11:31:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752697AbbAZQbc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 11:31:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F21F230C21;
	Mon, 26 Jan 2015 11:31:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hqchpzy4xrpsxD+/pB3ik5RF92c=; b=MLY3Lf
	EywUIJdM78Hw//yEheyezHCRaKhpb1OQscVpvL8cjEgwHbNBntmJ9zgbfio6wHdJ
	xwS1RlHPqxoOq7oZhONoElSgIaNGMUY4G0TqJ1VOwyHYU3TBezeKsoseixC3Bdmb
	ISz4JuIPdpaVPlAypCzIlxutso/IWTUCo/0bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=luuiczuVpLBQz+LcwdOP+MaBIVMID+Z1
	nhXUsF3sq2L4GHF2iLwFe6UqpXQkPaqTzAD6JCdjkMeSCjt28rdPO1/v+2Uy+NSi
	lnl1PQkYg2lxcgQ9ILPaAf5S1WEAll+0hSinV2iX4iZrMAAAPGXT6u3K4U4UZGkW
	/qY+DtbQ0tM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E751830C1E;
	Mon, 26 Jan 2015 11:31:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D97A30C1D;
	Mon, 26 Jan 2015 11:31:30 -0500 (EST)
In-Reply-To: <loom.20150126T091917-791@post.gmane.org> (Prem's message of
	"Mon, 26 Jan 2015 08:21:50 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C863B6B4-A578-11E4-96D5-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263034>

The conclusions from the last time we discussed this [*1*], the last
word was that

	git push $some_opt... --repo=$Repo $more_opt... $args...

is designed to work exactly like

	git push $some_opt... $more_opt... $Repo $args...

and the documentation that says otherwise is incorrect.  It seems
that we never followed up on this after we made that determination,
which is unfortunate.  We should at least correct the documentation.


[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/110827/focus=111715
