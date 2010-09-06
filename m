From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] tree-walk: actually move tree_entry_interesting() to
 tree-walk.c
Date: Mon, 06 Sep 2010 16:53:59 -0700
Message-ID: <7vtym2sa20.fsf@alter.siamese.dyndns.org>
References: <1283645647-1891-8-git-send-email-newren@gmail.com>
 <1283748429-31076-4-git-send-email-pclouds@gmail.com>
 <AANLkTinV+Bo_EijJU2q5GVG=jr9GFAuQGo5KQpvf0K-V@mail.gmail.com>
 <AANLkTi=+iga89znGPgOV14+Z9AZ0qbzJJbN1wNAum=qX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 01:54:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OslVw-00063t-4X
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 01:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab0IFXyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 19:54:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165Ab0IFXyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 19:54:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 75F97D35F5;
	Mon,  6 Sep 2010 19:54:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wtHUIhrWcf+PHdO/90DKJyQSFfg=; b=XIR8gm
	fZANThV+gN+CudWz7dhOpUgnmJH52FLR7o5V19qswS17Bet6OmZgaGmOt5hK07M5
	2xwz6MAszynUE5CVO9OcxMpjv08K7CfbLZRR5wNz16NmrwKwbkWj8b6Dyujq9dwu
	7YFqarUzRKqp7u6VYR165K1gIs21iE5vPhOPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qF9xNS6QaA/DPEjw42J0S8oibaqg9Oa8
	X9QjMJvsSKNhFQmgp5on3HMZreFUWQdAnh5hA4XrDY8fQ4iMhTia50sagEnvwdbk
	+zZHwxfe3y4KOqoEYw6pDxgKIytLgNebQEv9iI34spOltOPyYb93BamFdjUZlTyo
	FE+T/vF3VJk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F536D35EF;
	Mon,  6 Sep 2010 19:54:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2735FD35ED; Mon,  6 Sep
 2010 19:54:00 -0400 (EDT)
In-Reply-To: <AANLkTi=+iga89znGPgOV14+Z9AZ0qbzJJbN1wNAum=qX@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue\, 7 Sep 2010 08\:20\:06 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 08A5DA4C-BA12-11DF-851E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155645>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Hmm.. or just use struct exclude_list, with diff_options.path{s,len}
> becoming exclude_list.base{,len}. exclude_list.pattern can be used for
> glob/regex matching (if we are ever going to support that).

If you are changing the API and structures around this area, you really
should aim to help us to support the globbing in diff-tree family just
like we do in ls-files family, so yes.
