From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach merge the '[-e|--edit]' option
Date: Fri, 07 Oct 2011 12:01:34 -0700
Message-ID: <7vobxsvd69.fsf@alter.siamese.dyndns.org>
References: <1318001347-11347-1-git-send-email-jaysoffian@gmail.com>
 <7vk48gwvyd.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz7-tTdgT=cqoKhK+fAhmESLnp93yHyxOF_NOY5Wx01+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 21:01:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCFfx-0004eb-Kp
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 21:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929Ab1JGTBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 15:01:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54311 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703Ab1JGTBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 15:01:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E49605CCD;
	Fri,  7 Oct 2011 15:01:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M18dbQwcohJTAGWAeL2jDXxEsx8=; b=ha7J2s
	lKrm1riFGDVulaStQOZCPvMsznSRPmMLqK/6bguDB971C4l9rskSG3N1vM/NR/au
	Sv3Xf+Ixse+EhzHh9JDd1+nUs8KEWThSh/aCzMlNsDSAEBJqVIJt2nAOrxnPmzcJ
	6PGh7g6vY9M3LmYD6SqvIzjhiHJ5Lakga7DGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zd8xfUZ+R7aj6c5tQivxhZkS3MFiEXYT
	AFKy3kGB4BvYQGFWJVSNIJGHSQ2DGlj8WFcCcLynPCWlarcamcsAq1UQBDwtFPla
	sxwmt6DQQTej9Mu/UO8xuGgW6H5+E8g6BmTqnKvpwBbeix+OLg6DCfXO71N5s/7J
	1ZUXdc9l3QQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC3F65CCC;
	Fri,  7 Oct 2011 15:01:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76A505CCA; Fri,  7 Oct 2011
 15:01:35 -0400 (EDT)
In-Reply-To: <CAG+J_Dz7-tTdgT=cqoKhK+fAhmESLnp93yHyxOF_NOY5Wx01+w@mail.gmail.com> (Jay
 Soffian's message of "Fri, 7 Oct 2011 14:01:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7371886-F116-11E0-8B78-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183097>

Jay Soffian <jaysoffian@gmail.com> writes:

> I actually think a better choice would be to remove commit_tree() from
> merge and always have it run commit externally. I'm not seriously
> suggesting that be done, but it would make git more consistent. But
> I'm not going to send in a patch which makes the situation worse.

Think about it. What I suggested does no way make the situation
worse. Your patch _does_ make it worse by changing the hook behaviour
between "merge -m 'foo'" vs "merge -m 'foo' -e".
