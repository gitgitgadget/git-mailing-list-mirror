From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Wed, 12 Dec 2012 11:57:47 -0800
Message-ID: <7v38zb3ux0.fsf@alter.siamese.dyndns.org>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:58:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TisRR-0004FP-4V
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 20:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab2LLT5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 14:57:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602Ab2LLT5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 14:57:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D1F996D6;
	Wed, 12 Dec 2012 14:57:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j8dewzpfpzWdYrLy8LGxQBkE7x0=; b=NltZkp
	JhKcTtFq5TbYMpwVZebH7RoNv4vYaNWJKlNJsT1HwZeKEqVLVGUYBvwG5BUVERYo
	Bgr0HJVQyZu8YjXDdOG1JqTEcXXLqrgoxpg7QSsnSi5ixr2F2LMDsiexgHoKvCtd
	IB/kJnHEUr7ARcSdbVkroRZnU2oQudAyDuv+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZbWQXFImRmI8J5Cyj532Q3rOsPrKJEBc
	Y4hmqUVdlr+TMtTK7sfVVPAw5dJ+DD7lmlpx4l72yfEbjIFxQyE/DT7SiwpPzgqz
	jGyo9BloLv0gzoDWv183nxzLK9reuM/zH7kfA+DSsdEu8RNAVGdu8uaC06wPzyTG
	c1dnc4iiaew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B19996D5;
	Wed, 12 Dec 2012 14:57:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91F6B96D3; Wed, 12 Dec 2012
 14:57:48 -0500 (EST)
In-Reply-To: <20121212094432.6e1e48c8@chalon.bertin.fr> (Yann Dirson's
 message of "Wed, 12 Dec 2012 09:44:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3432B246-4496-11E2-BAD3-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211390>

Yann Dirson <dirson@bertin.fr> writes:

> ....  In this respect, they seem to be
> lacking a few features, when compared to "replace" refs, but they have different
> uses, ...

Not reallyl; grafts were old hack whose use is still supported with
its original limitations; replace is meant to replace all uses of
grafts while removing grafts' largest warts.
