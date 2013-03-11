From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A bug or unhandled case
Date: Mon, 11 Mar 2013 09:53:30 -0700
Message-ID: <7vk3pdaned.fsf@alter.siamese.dyndns.org>
References: <CABB6UqEfx=ssbiD1+2HA3AtmSrFeJeg5fmU3z1SKukNsKvd4qw@mail.gmail.com>
 <7vvc8xaoia.fsf@alter.siamese.dyndns.org>
 <CABB6UqHgcsx9oK2GHhmwpuhv+T3aMAJk_udw8enkGB3OutzbNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Janiszewski <janisozaur@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 17:54:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF5z5-000541-JW
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 17:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab3CKQxd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Mar 2013 12:53:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab3CKQxc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Mar 2013 12:53:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C7CFB253;
	Mon, 11 Mar 2013 12:53:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CUYGBeKhkQPN
	c4AYJZfvH7oKtng=; b=b5kemWO/PpJyi6vPu7KIyKjJ/4pqyE4MHyhknANY4T8B
	VtRbC11dPtXrrhqaaF0bChFGRkiOIrtH+G1bDgI9DG/S+hIVc8DIquZCKUXnKzIG
	gMfqifX4//rxa3rr/s2U+w17vuxQOB6l8zlRFSESFzjXXPkg5SQ2kDTgtxlvm0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=daVW2o
	R984l+Y4XN6a3runZ0JFDSZ40/4l83XWwzIEbm5dj4JKXyQDHC9PJwEYYIdr7yjF
	duKbfxXaIjQp/cluM0Zd1NMfCokWv4SeGnmnga5wzSJCW1VVQ6EX/QAnfjUJxGj+
	Tr2A9GWzsOwhfoL583J1HM8YbCHmAjuMHlRng=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40A2EB252;
	Mon, 11 Mar 2013 12:53:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA9ABB251; Mon, 11 Mar 2013
 12:53:31 -0400 (EDT)
In-Reply-To: <CABB6UqHgcsx9oK2GHhmwpuhv+T3aMAJk_udw8enkGB3OutzbNg@mail.gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Janiszewski"'s message of "Mon, 11 Mar 2013
 17:39:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34938D3E-8A6C-11E2-B212-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217890>

Micha=C5=82 Janiszewski <janisozaur@gmail.com> writes:

> Hmm, indeed it works. Sorry for the confusion then (and a bit mistake=
n
> commands, but you got them correct).
> I wasn't aware of the -r option.

I think what tripped you was that "git branch" deals with branch
names, and not refnames (which is the underlying but lower level
concept).  "git branch -d refs/heads/master" is not a way to remove
your local mastar branch.
