From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list --count: separate count for --cherry-mark
Date: Tue, 26 Apr 2011 10:37:30 -0700
Message-ID: <7vwrigewx1.fsf@alter.siamese.dyndns.org>
References: <3e743b672c3e20a245055e47671bc1af1039b60a.1303806237.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:37:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEmCm-00056s-8T
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 19:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757762Ab1DZRhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 13:37:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab1DZRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 13:37:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7857D3456;
	Tue, 26 Apr 2011 13:39:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zBse5bbkcExHYBKI9IE1DpFombQ=; b=orvkWc
	3ZOYoiA572PdbP7IOYNSXMlW/cu6cqdvXusm4Vdic6ZWPCRgzLWsqdNDbo1qUtgk
	3PXVaMyA+0ffxkzn7msnv5AURSYIrDeTi8qn3iQgqg2QF4tIV79DvE/sy57Z//mB
	ItIwoYbpYnJG0T/ZqxvzdKYbD9XoewhGHjqiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JO7RAprB6Lka0LAfengraM+d1N+eEzy9
	WX6hmSJGnflUTVHcPKiEz6177ncIwvnyOTkjIeNENfA6MxJbWoGJRyDKEm4Rlc9b
	zhCfEzpWDEAXekeS0NZnx/FcUngp0xcB39nM8uuVizEjL36Wr3e97c/iVVS1hZXr
	PoEawnqnOpE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 53F623455;
	Tue, 26 Apr 2011 13:39:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 727853454; Tue, 26 Apr 2011
 13:39:34 -0400 (EDT)
In-Reply-To: <3e743b672c3e20a245055e47671bc1af1039b60a.1303806237.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 26 Apr 2011 10:24:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27F940AC-702C-11E0-9A2C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172115>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When --count is used with --cherry-mark, omit the patch equivalent
> commits from the count for left and right commits and print the count of
> equivalent commits separately.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> I noticed this in passing. It does not break anything and can be done
> easily. It might even be useful for gitprompt, branch -vv and the like.

This is in the same spirit as your earlier change to not count filtered
commits, right?  Sensible.
