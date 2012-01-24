From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Fail to add a module in a subdirectory if module is
 already cloned
Date: Tue, 24 Jan 2012 14:38:05 -0800
Message-ID: <7vd3a83ewi.fsf@alter.siamese.dyndns.org>
References: <jfmvpp$4v7$1@dough.gmane.org> <4F1F1E5F.2030509@web.de>
 <7vhazk3ibk.fsf@alter.siamese.dyndns.org> <4F1F2642.1070707@web.de>
 <4F1F2D38.9050909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 24 23:38:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpp0K-0008EA-A7
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 23:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab2AXWiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 17:38:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36041 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147Ab2AXWiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 17:38:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB49B743E;
	Tue, 24 Jan 2012 17:38:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SUnIsZg1PbvhIymOUDwbC5Lyhk8=; b=MIakTQ
	Zy2t3KWmgwZNrFgYsx1bdIVXLoZiZqWZJCfBsXTikajbF1Mf8zjBb9CQG3kBKzEV
	GxFoEnmQqd4srrh/9Av2bVZcZpQ1OQZRz1t87q2cSjW8/Ku8i4QOvq5UWBrfW7Gc
	tnmu3AAlj4XWiIqZciFl5HgYCAmDfJt0Zfov8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P8gKCLtKvbBUwM3gd8jrPvguYZVNQY0z
	cbulKNYoM5zAAw4xt5meuCfjbzbr/oViJ7pr7SzwW8Hx5dG3TZO5ygcDjZvlTaZ7
	mMuMSsoit06PAsAFhOSnDdviNRNrKiJ0bB7Wrr05TCUrvtJtZbf9Bjn9VrFLyjN3
	2no+rEITyII=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3102743D;
	Tue, 24 Jan 2012 17:38:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 596FB743C; Tue, 24 Jan 2012
 17:38:07 -0500 (EST)
In-Reply-To: <4F1F2D38.9050909@web.de> (Jens Lehmann's message of "Tue, 24
 Jan 2012 23:14:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 160169C4-46DC-11E1-A2A0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189081>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Just for the record: I checked that and git-submodule does not set the
> SUBDIRECTORY_OK environment variable so every time it is not run in the
> top level directory it aborts with:
> "You need to run this command from the toplevel of the working tree."

Ah, Ok.
