From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-clean: Display more accurate delete messages
Date: Wed, 02 Jan 2013 13:10:53 -0800
Message-ID: <7v1ue32sv6.fsf@alter.siamese.dyndns.org>
References: <1357091159-22080-1-git-send-email-zoltan.klinger@gmail.com>
 <7vfw2j2vlp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 22:11:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqVam-0000UV-7u
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 22:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773Ab3ABVK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 16:10:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702Ab3ABVK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 16:10:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDF19A07C;
	Wed,  2 Jan 2013 16:10:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GWbjqjygqsZgIvgL7hkTgw0S9jo=; b=Nnt13z
	Wy+vs1R3qRWbUyQXcs4HesQRjj7WaH2hJzT5pM31spjK8Rq3wLi+UivpIVBcnfde
	zyJ3Uze7P6tZCxEXW8egijTkx9NpkUM8AwAzoy8Ol5nmtuLFClbSsBS0LLvOlzTj
	IShTIsXSPYKLuqzinFkmRSJa5DCz7ekDJ8iV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fs1EVNmxyBpQ5h5VvuBrp6jfMmsuK1h8
	uJeAzo5JjM5xEYvuISatLbyaEevQtmGqLU22m5wI6/FSomu84xA2bNMeyf9LaTml
	mEUShZR1xwzHyL2IsFDDJ6l+lDXPn17FCAwAk0Xu7XkIrWYUcaELoMtFeNgY6YOT
	SPUKpf/b+mQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE998A07B;
	Wed,  2 Jan 2013 16:10:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57EE2A07A; Wed,  2 Jan 2013
 16:10:55 -0500 (EST)
In-Reply-To: <7vfw2j2vlp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 02 Jan 2013 12:11:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E59645DA-5520-11E2-9C40-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212542>

Junio C Hamano <gitster@pobox.com> writes:

> Zoltan Klinger <zoltan.klinger@gmail.com> writes:
>
>> +static const char* MSG_REMOVE = "Removing %s\n";
>> +static const char* MSG_WOULD_REMOVE = "Would remove %s\n";
>> +static const char* MSG_WOULD_NOT_REMOVE = "Would not remove %s\n";

I also noticed that this message is not used, which mwans that the
program used to say "Would not remove" for some paths but the
updated one will never do so.
