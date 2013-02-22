From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is this a bug?
Date: Fri, 22 Feb 2013 13:48:46 -0800
Message-ID: <7vehg8c94x.fsf@alter.siamese.dyndns.org>
References: <937BB05095F39E46B969256AA776205322B2CF15C7@ST-EXCL29.statoil.net>
 <CABPQNSY4ordHh2ee8mk-2kCD40+sMf_SxrjfzGbkyGGTNW1TzA@mail.gmail.com>
 <CACsJy8DjatRbL=J-MZmQFnd+_7i-WwYHSnkY_ga++fx1R5Whmw@mail.gmail.com>
 <CABURp0rO5zJywFN16=Sn20b2DAVA7XBs4EC4GxGbxftXqUS6gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	David Wade <DAWAD@statoil.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 22:49:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U90Uj-0006rg-AF
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 22:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757797Ab3BVVsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 16:48:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757330Ab3BVVst (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 16:48:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2F0CB070;
	Fri, 22 Feb 2013 16:48:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8LukC7xOgF7tnZiQAIsxjN+JEQc=; b=PPFL+D
	/dfb3HTh4TZOfxYazjBAXp/19304gF2OPAzoU5ebBXN+/E9zxBQmx8BWdPyye6qE
	YFz06WTj1IiU99nUrQYjFGEP5pkSa0h+0m/797WwHCSeQNzlxNwiuwl43OdHC0Tk
	TlFIEqRf3Zu38IbCdQL13PhP3OZOY4zGMfgKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZgTNBTZjilWPtaQreVdWgbHocPzAWMun
	Glr4L81o9EuZk+z7ET5pJeaEJXn8ZJ5y4cyhcfLmCFbMiTTa8lXdRqJAf3HhK94j
	8qCxz6pbpIpslWUozbUIWylUv2XxeDlaOc0ZRAXqUKiX2Uuk0aRIDJMwxT9PCUNg
	L/BPCgflCp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7A53B06F;
	Fri, 22 Feb 2013 16:48:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CEECB06D; Fri, 22 Feb 2013
 16:48:48 -0500 (EST)
In-Reply-To: <CABURp0rO5zJywFN16=Sn20b2DAVA7XBs4EC4GxGbxftXqUS6gA@mail.gmail.com> (Phil
 Hord's message of "Fri, 22 Feb 2013 14:29:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A37B1626-7D39-11E2-88DA-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216865>

Phil Hord <phil.hord@gmail.com> writes:

> Or maybe --amend should imply --cleanup=whitespace.

I am fairly negative on that.

Such a hidden linkage, even if it is documented, is just one more
thing people need to learn.

It _might_ be interesting (note: I did not say "worthwhile" here) to
think what happens if we scanned the message (either coming from the
commit being amended, -F file option, or -m message option), picked
a punctuation character that does not appear at the beginning of the
lines in it, and automatically adjusted core.commentchar if '#'
appears at the beginning of one of the lines, though.
