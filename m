From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/5] difftool: Use symlinks when diffing against the
 worktree
Date: Mon, 23 Jul 2012 09:38:21 -0700
Message-ID: <7vzk6qmo02.fsf@alter.siamese.dyndns.org>
References: <7vzk6rnkgq.fsf@alter.siamese.dyndns.org>
 <1343023530-31463-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 18:38:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StLeR-00086P-54
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 18:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab2GWQi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 12:38:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59479 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754158Ab2GWQiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 12:38:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0786E6564;
	Mon, 23 Jul 2012 12:38:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kHQLzoSZoPL3cckGb/bwXG2HarQ=; b=gbqXOz
	QO8leq2U2G30O3ac5TLX1JOLEu14tcaxbcH11VlgTJ/Wpnb+LVlJl4KTnz17qi1T
	5ElneUfBpqIOmjbTEq75yR8Dj28tjwm0VIqxwAcz1Luw5TxFfM8S6gDfC87cCP4n
	hjSife5Uhct1NzUh80vMoFhLDqj4RFB8a+qc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vp/Rb7J5M5W75UETZwr4svVOGn9SsHrg
	6c2qLK0VsxybJiVm2I0Ju4uewz6rO+icXlVZxSIKM/m/3GM9fS7rfIgZ0DZt26Q7
	vbNsc8H841mC2OLmNu0JuY+10gIUNrYtTdjgaioP/D/EF7NnsHiu015ZgDoPSL/Y
	b4GL3p1o5Dc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E71AF6563;
	Mon, 23 Jul 2012 12:38:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 630EE6562; Mon, 23 Jul 2012
 12:38:22 -0400 (EDT)
In-Reply-To: <1343023530-31463-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 22 Jul 2012 23:05:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D12226E4-D4E4-11E1-A10D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201938>

David Aguilar <davvid@gmail.com> writes:

> Teach difftool's --dir-diff mode to use symlinks to represent
> files from the working copy, and make it the default behavior
> for the non-Windows platforms.
>
> Using symlinks is simpler and safer since we do not need to
> worry about copying files back into the worktree.
> The old behavior is still available as --no-symlinks.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Handles the case where an editor unlinks the original symlink,
> replacing it with a file.

Thanks; will replace.
