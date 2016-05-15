From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Sun, 15 May 2016 11:19:58 -0700
Message-ID: <xmqq60uf6v5d.fsf@gitster.mtv.corp.google.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 20:20:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b20eM-0001UK-Ie
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 20:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbcEOSUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 14:20:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751019AbcEOSUF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 14:20:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A22B51B170;
	Sun, 15 May 2016 14:20:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7BfwB+Vbf4GnEhC3kKjdX3ae1sw=; b=rZBQaF
	lbbIvHHQLetbQ1HHL8+fXjo6WGbuBPk+2pEMK0BJZSK6+VicFaZGC5T6xCyD8wxZ
	PSlsJvOsPjbKYpz17mGa1lkaRf1vhTJRQHoENmO7H4yrvHdlwxBZFPCkD12kaClG
	ZewE1TlCURWo5Q6f9UPQlNzF0q1XDOFy1EbQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EcUfaNfFe5W2LGi9lHILvKNvRomuHtND
	XhXTHWp5NarFT/QVqKM4NsgGd+Cxvwojlv2ZiGrZX962JmHqUB4+7h5S5FofYmE+
	T5nnJ5xaYnVhl7Lb3sPfCLemYhewM8j6k2frDYg8ABmUW18UHsARgPrIe+nHQ2B0
	qEiiurPF4i0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8830E1B16F;
	Sun, 15 May 2016 14:20:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C1691B16C;
	Sun, 15 May 2016 14:20:02 -0400 (EDT)
In-Reply-To: <CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 15 May 2016 17:06:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A3E789BA-1AC9-11E6-BEF5-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294674>

Duy Nguyen <pclouds@gmail.com> writes:

> Instead of putting everything in under the same attribute name
> "label", make one attribute per label? Would this work?
>
> *.[ch] c-group code-group

The attribute subsystem expects that there will not be unbounded
large number of attributes, so this is not a good direction to go.
