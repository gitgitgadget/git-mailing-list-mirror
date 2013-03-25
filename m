From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Mon, 25 Mar 2013 11:31:44 -0700
Message-ID: <7vppynxre7.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
 <7v38vjz7sx.fsf@alter.siamese.dyndns.org>
 <CALkWK0mRnDMFLeVoG85CUZ48rf7X_jHV=0XP73WL7zp2OGpezQ@mail.gmail.com>
 <20130325182023.GA1414@google.com>
 <CALkWK0kx_uQy-97nByNXBOU4UruhvdjOeXCpKHR9mNUQHs5o=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 19:32:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKCBr-00033J-Tz
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 19:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766Ab3CYSbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 14:31:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932621Ab3CYSbr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 14:31:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9637CA283;
	Mon, 25 Mar 2013 14:31:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C4/ER6m3m24K+93gtpeU2gX6IU8=; b=uHdurj
	0jlEGG8+a+2hAzGeMU3Y4GS3GxSjCb94dkT0Q9VN8qRWTmyrHReQvINpUhiWynkh
	6+iBRwhk8Uz+hDYZle7rkpc7/IDQRsOq6EDWWQzRE9TGBXGL9BPmemdloBipIcSP
	yoGbUl5wFWdCRxP5XI/37+A8AxzQGjInEM3ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PJvNIs/Q0KZdFVbKH+kJljf/CvMzy3Mt
	CGcV1uHLzH09GrdlBESWu868vGlelNIGT9QpZAvGWUkNg5iHcAoDaAdGyO4BdCaE
	n5hBQ6hHnvHlfq31BKq5lj8gR2zjo9YORdQSHac+PwNiv5r3mJbiqOuEssZDqsL2
	Kv86j1NmUks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89F29A282;
	Mon, 25 Mar 2013 14:31:46 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EE40A280; Mon, 25 Mar 2013
 14:31:45 -0400 (EDT)
In-Reply-To: <CALkWK0kx_uQy-97nByNXBOU4UruhvdjOeXCpKHR9mNUQHs5o=A@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 25 Mar 2013 23:57:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FA26A9C-957A-11E2-90CD-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219062>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I'm talking about slightly better defaults at the porcelain level,
> at most.

If a change does not even have to break backward compatibilty, that
is a regular enhancement and independent from 2.0, no?
