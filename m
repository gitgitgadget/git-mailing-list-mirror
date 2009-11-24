From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-send-email --expand-aliases
Date: Mon, 23 Nov 2009 23:25:44 -0800
Message-ID: <7vfx84jsef.fsf@alter.siamese.dyndns.org>
References: <20091123221628.GE26810@ldl.fc.hp.com>
 <7v6390sqhz.fsf@alter.siamese.dyndns.org>
 <20091124004554.GA27643@ldl.fc.hp.com>
 <b8197bcb0911232312l251dfbc9va671388cfb7fe57b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Chiang <achiang@hp.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 08:26:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCpmj-0002yY-KI
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 08:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497AbZKXHZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 02:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757401AbZKXHZu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 02:25:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757301AbZKXHZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 02:25:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1FF2A1BC9;
	Tue, 24 Nov 2009 02:25:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mYS1NX4LVIjyqItIPypHI8Zf/Us=; b=FEn4Bm
	NleK/iSR4hCPr9ss/fcLXpJMN0k5m9l7KXi6SS8Jo5l45D7Wbzf3yqZQuzJ3DuPb
	JvCKEU7HomMLojI8mcVWvNWdWnXGq2iezwkzaH80nkLgLhgY2JG8+EibFqjbZM49
	GNnv3mWm7j24Ye/cftq9jLkJR/DuoUvyElXZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eX+vFryKYNXbFqgf3CWbfXzIdfmwqsPt
	Hf01mMdOmNJhmZKpgBLJedhUb84sKXCSDyHVWJSuiPdborBB+bCoZwQIjqFenaeO
	vOlTmiMLuFcNmP2hfK3fElP3lDwJNIkJFdalRqbLUdd+blahE0YFWzLlhREk5HTO
	p2vbyLCwJ3g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 720BFA1BC8;
	Tue, 24 Nov 2009 02:25:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EBF72A1BC7; Tue, 24 Nov 2009
 02:25:45 -0500 (EST)
In-Reply-To: <b8197bcb0911232312l251dfbc9va671388cfb7fe57b@mail.gmail.com>
 (Karl Wiberg's message of "Tue\, 24 Nov 2009 08\:12\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 981517A8-D8CA-11DE-8667-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133564>

Karl Wiberg <kha@treskal.com> writes:

> I think that sounds like a splendid idea. It would be interesting to
> see just how thin a wrapper around git send-email (and format-patch)
> stg mail could become, without sacrificing features anyone actually
> uses. The main complication could be stg mail's templates.

Why do you even need to run format-patch?  If stg mail supports a good
templates to prepare message files, it would be natural to keep using that
to prepare message files.
