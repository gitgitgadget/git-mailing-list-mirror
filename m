From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug report] git fetch/push fails from sub-directory
Date: Tue, 20 Sep 2011 14:59:42 -0700
Message-ID: <7v62km6fjl.fsf@alter.siamese.dyndns.org>
References: <j5b1qa$pki$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frederic Heitzmann <frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 23:59:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R68M3-0004cB-VJ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 23:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab1ITV7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 17:59:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab1ITV7q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 17:59:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE5EA428D;
	Tue, 20 Sep 2011 17:59:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HfSy4aRr0+wo3TK6jTMRDVYn1sc=; b=cDolwx
	1P/Cp3YZOr812+kgRpGRkCfYH0FrsbmZx+kSFgsBVzrq4X47Ih4XlmV9M7OenadO
	Jh7iqoMKOqBejA5S5GFQb3+A1MhbKY5lGjcJUQc+dJHTZum7Ot3DvCGUCGjErEiB
	gFmqSSn4HUBwlROaK/3kWbvdZ5dkXdjaLWX84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dTbiN62ieTkL9yA0istgWWLfN9LoGM+z
	Wldn3RXgvOvHT4A6fjmOp+7nL88PYxWubWlc6hhyjap0dP1r5/Dd7t8aotgAoPle
	ENZKjdORA+Bz0DvUw0ET+nw3EZjSjDaynlYVM1MRW5U0Zib9B8I2yfh0xQ4zK84L
	0ALmAYq5aes=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6C72428B;
	Tue, 20 Sep 2011 17:59:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5648C428A; Tue, 20 Sep 2011
 17:59:44 -0400 (EDT)
In-Reply-To: <j5b1qa$pki$1@dough.gmane.org> (Frederic Heitzmann's message of
 "Tue, 20 Sep 2011 23:50:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D941128E-E3D3-11E0-990D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181798>

Frederic Heitzmann <frederic.heitzmann@gmail.com> writes:

> I found a bug in git fetch, with local repositories.

> cd repo2
> git fetch ../repo1	# OK
> cd d
> git fetch ../../repo1	# failed

It has always been like this.  You can give a full path to the repository
from the root, or perhaps define a nickname to refer to the remote (see
"git remote add") and use it instead.
