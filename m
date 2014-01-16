From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 6/6] Documentation: Describe 'submodule update' modes in detail
Date: Thu, 16 Jan 2014 13:55:37 -0800
Message-ID: <xmqqy52fy4km.fsf@gitster.dls.corp.google.com>
References: <20140114224246.GA13271@book.hvoigt.net>
	<4a8dca477ed5b190767d6a4619c593a83f86f082.1389837412.git.wking@tremily.us>
	<xmqqeh47znin.fsf@gitster.dls.corp.google.com>
	<20140116205521.GY2647@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 16 22:55:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3uug-0006Fz-Ay
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 22:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbaAPVzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jan 2014 16:55:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaAPVzk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 16:55:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3229623E6;
	Thu, 16 Jan 2014 16:55:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fLv277imB6CR
	g5IEzJTKfpcbFKI=; b=FXeSygJekOc8S24c+3GqWIvYR+VphGmCjVfbVEn8pKth
	pyFQiXdfgS5FVZS5yE3lk+msSTbSOvy0XuyGzt3usRWkMyUWxiLu75V5gUZvu9Uq
	4QE2SsCg600IJWAKBmy2CPxsIZ6cPrRThPHWzYQ/zEQ74mmPG6EEGkrYfu0FB6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nbHLTV
	IQiglJMgaDPue8yp8r0dFajypHsZ6rtWWumFXv7hBzvGzwY2wPVl+IosS9JC870e
	vQI3RBfwqEupqCeF9Y79kK6aCfinEX68HvbT5eIzqv+DWfIr1qeM30D1YGqwt0eG
	P3u+MlE3amPaFWPxzjK32+ng8I0emgoA5MD4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B31DC623E4;
	Thu, 16 Jan 2014 16:55:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1A87623E3;
	Thu, 16 Jan 2014 16:55:38 -0500 (EST)
In-Reply-To: <20140116205521.GY2647@odin.tremily.us> (W. Trevor King's message
	of "Thu, 16 Jan 2014 12:55:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EFC22B34-7EF8-11E3-A9A1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240538>

"W. Trevor King" <wking@tremily.us> writes:

>> A na=C3=AFve expectation from a casual reader of the above would be =
"The
>> superproject's tree ought to point at the same commit as the tip of
>> the branch used in the submodule (modulo mirroring delays and
>> somesuch),
>
> What is the branch used in the submodule?  The remote subproject's
> current submodule.<name>.branch?  The local submodule's
> submodule.<name>.branch (or localBranch) branch?  The submodule's
> current HEAD?

They are good questions that such casual readers would have, and
giving answers to them in this part of the documentation would be a
good way to give them a clear picture of how the command is designed
to be used.
