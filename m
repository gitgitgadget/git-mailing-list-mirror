From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to find and analyze bad merges?
Date: Thu, 02 Feb 2012 00:16:42 -0800
Message-ID: <7vd39xy7it.fsf@alter.siamese.dyndns.org>
References: <jgdgcv$h8n$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "norbert.nemec" <norbert.nemec@native-instruments.de>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:16:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsrqc-0007a2-72
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab2BBIQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:16:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51092 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754301Ab2BBIQo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:16:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 460707F4A;
	Thu,  2 Feb 2012 03:16:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5r04HZ19fI4HBkgj6VP4SGQeg/w=; b=M3Hi0N
	Sg8IllvzkAfjntusr2G/WToCr/bWHm6jvfLaMOrhAgQzF4APFl3OsN+aIN+XkRwo
	EX6eqGj17jEttOpvNWQ/wTuKMYdsUihKDmKQQ721hUrULpD5QJ8oCd9irulvI3mG
	EqcIZqxw4pY2+9zkvo4yikDBek7E5qWHnsFkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RAEVrTvoTtKSbluXAVAwASWgdW7GeRnA
	zHxIWCYwdX5Fql3uugCgy/Y1bdKyvxb3R49SYPxFUMP21SJf1i9PkrbshJ5A4bYB
	2E3JXmWJLvFyCmQF9hAQiUnJYJAIium+su1I1qujmzRbTxMqtm/PYzIk6oB69FkW
	r/CpRGj2VZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D1CD7F49;
	Thu,  2 Feb 2012 03:16:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C38BE7F47; Thu,  2 Feb 2012
 03:16:43 -0500 (EST)
In-Reply-To: <jgdgcv$h8n$1@dough.gmane.org> (norbert nemec's message of "Thu,
 02 Feb 2012 09:10:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DEAE8A2-4D76-11E1-91FD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189591>

"norbert.nemec" <norbert.nemec@native-instruments.de> writes:

> a colleague of mine happened to produce a bad merge by unintenionally
> picking the version of the remote branch ("R") for all conflicting
> files. Effectively, he eliminated a whole bunch of bugfixes that were
> already on his local branch ("L").
>
> Obviously this was a mistake on his side, but hey: everyone makes
> mistakes. The real problem is to find this problem afterwards,
> possibly weeks later, when you suddenly realize that a bug that you
> had fixed suddenly reappears.

Bisect?
