From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression in git-gui since 2c5c66b... Merge branch
 'jp/get-ref-dir-unsorted
Date: Sun, 16 Oct 2011 17:35:45 -0700
Message-ID: <7vfwispi8u.fsf@alter.siamese.dyndns.org>
References: <4E9B1E32.7030101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 02:35:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFbBO-0000qE-Pe
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 02:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab1JQAfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 20:35:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59715 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044Ab1JQAfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 20:35:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AA0F6DED;
	Sun, 16 Oct 2011 20:35:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HFacGEMg7aRLmMzPpy0HYLTk8PU=; b=kcC4wk
	G09Lva5YIvS89pj0tlT4BHu76Rn3M1Mx9XChOGFHdj3S1XZXTwFnwVKKwRKaP35t
	Wh5Af2+TVt5+eRNe+/RHSuYoYYraDMs2y8sh2js8HCd20CtL9gbzVb3O6zofZAJW
	NhQOi2RB+89rRpfpvM6gGAcg0tg2LcyX9Vu9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pQmJ8pa2aco9kpwq2DVbM8ukvHt7BwmO
	zmvlgglY2jLEuFkpevf6OdAiK4vZXLNMbKeOmlwZImKk7izzCb4t5WIvhXhVbrqc
	f4TMpaIeezuFhLqZ5ijeTQmkYC38W+S1l8pMM+pjyybfQ92/bASVojBOPCESeb8J
	rCQckwGUu78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 523D46DEC;
	Sun, 16 Oct 2011 20:35:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA7366DEB; Sun, 16 Oct 2011
 20:35:46 -0400 (EDT)
In-Reply-To: <4E9B1E32.7030101@gmail.com> (Mark Levedahl's message of "Sun,
 16 Oct 2011 14:10:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F480F436-F857-11E0-A301-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183746>

Mark Levedahl <mlevedahl@gmail.com> writes:

> I have a project organized as a number of nested git modules (not
> using git-submodule), and frequently use git-new-workdir to create the
> nested modules.
>
> Since the above merge-commit, git-gui is confused by this arrangement
> and reports every file in every nested module as being an untracked
> file in the top-level (super) project.

Could you come up with a simple reproduction recipe that prepares a
superproject that has no file of its own, a submodule with a single file
tracked, and attaches another workdir? If running git-gui in the resulting
directory makes it misbehave, we could then isolate what git command that
is invoked by git-gui has changed its behaviour.

Thanks.
