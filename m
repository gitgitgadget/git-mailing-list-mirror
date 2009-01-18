From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH next resend] bash completion: refactor diff options
Date: Sat, 17 Jan 2009 23:18:27 -0800
Message-ID: <7vtz7xytdo.fsf@gitster.siamese.dyndns.org>
References: <1231679663-31907-1-git-send-email-trast@student.ethz.ch>
 <1232240603-11729-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 18 08:20:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LORwu-0000Nd-Rc
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 08:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758043AbZARHSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 02:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757674AbZARHSh
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 02:18:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756550AbZARHSg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 02:18:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3C5F51CC2B;
	Sun, 18 Jan 2009 02:18:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B6C291CC2A; Sun,
 18 Jan 2009 02:18:28 -0500 (EST)
In-Reply-To: <1232240603-11729-1-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Sun, 18 Jan 2009 02:03:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3809F72C-E530-11DD-AEF7-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106144>

Thomas Rast <trast@student.ethz.ch> writes:

> diff, log and show all take the same diff options.  Refactor them from
> __git_diff and __git_log into a variable, and complete them in
> __git_show too.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>
> ---
>
> Any news on this?

> +__git_diff_common_options="--stat --numstat --shortstat --summary
>  			--patch-with-stat --name-only --name-status --color
>  			--no-color --color-words --no-renames --check
>  			--full-index --binary --abbrev --diff-filter=
> -			--find-copies-harder --pickaxe-all --pickaxe-regex
> +			--find-copies-harder

The changes around pickaxe made me "Huh?".  For log pickaxe makes very
good sense but for a single diff it doesn't, yet the original seems to
have had them only on "git diff" and not on "git log", which feels wrong.

Other than that, I think the patch tries to achieve a great thing in the
longer term---we do not have to worry about common parts going out of sync
between diff and log family of commands.
