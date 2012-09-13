From: Junio C Hamano <gitster@pobox.com>
Subject: Re: is this behaviour expected for "git clone --single-branch"?
Date: Thu, 13 Sep 2012 11:45:48 -0700
Message-ID: <7v627h92xv.fsf@alter.siamese.dyndns.org>
References: <CAN0XMOJsVOCzp2_BOQVUKy3cV8JA9AG+=Bw4tC2ZzDfK0AcQVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, pclouds@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:46:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCEQM-0004Mc-EV
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab2IMSpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:45:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525Ab2IMSpv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:45:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C50498A0;
	Thu, 13 Sep 2012 14:45:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9rMDypLk50gwD8O5oYEUQnmOm6k=; b=AIvbwW
	lJR7yMpkO1ptSvFGaz1mCX13YopVzroKdt546fODBH9N5sswtM0Vw8dIeCwhUekT
	ubX3GiNrAaCdNmuodQ9cYb2ZafvmRkC6ZzMwJQTUoQ5jIYum8qGegBejTlwIcFhy
	0fSEQdpl1VEHey3Ohw6JOW5Qw25hTL2eVIU7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uvtGToU64fXh4VznulbvuGCd0ec7gyok
	R3L5/klvGFk+9uK2YlerwseeRzboZ3QnjtrVLW953nUtlpb+E62r71aS7K2nxt/E
	O9W6b7OcFZpzlk6iasfD+tqY8N5oexu9kL2hE6tTqBfUJQrBK2rHkA664M7XoOii
	VGGFp31xF3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7902B989F;
	Thu, 13 Sep 2012 14:45:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAD9F989D; Thu, 13 Sep 2012
 14:45:49 -0400 (EDT)
In-Reply-To: <CAN0XMOJsVOCzp2_BOQVUKy3cV8JA9AG+=Bw4tC2ZzDfK0AcQVg@mail.gmail.com> (Ralf
 Thielow's message of "Thu, 13 Sep 2012 20:38:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CE9C280-FDD3-11E1-88F9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205412>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> # looking again to my branches

Don't look at your branches, but look at how the refspecs are
configured by "git clone" in .git/config; I suspect we just write
the default 'refs/heads/*:refs/remotes/origin/*' pattern.
