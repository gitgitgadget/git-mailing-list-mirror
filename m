From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rename detection limit checking, cherry picking, and git am -3
Date: Sun, 16 Sep 2007 21:27:46 -0700
Message-ID: <7v3axd5325.fsf@gitster.siamese.dyndns.org>
References: <46EDF54F.5030503@gmail.com> <20070917034742.GG3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 06:27:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX8DE-0003Q5-BR
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 06:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbXIQE1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 00:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbXIQE1w
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 00:27:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:52598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbXIQE1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 00:27:52 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E0AC5134D9E;
	Mon, 17 Sep 2007 00:28:09 -0400 (EDT)
In-Reply-To: <20070917034742.GG3099@spearce.org> (Shawn O. Pearce's message of
	"Sun, 16 Sep 2007 23:47:42 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58384>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I actually don't see why cherry-pick can't be defined in terms
> of `format-patch|am -3`.  It probably would be faster in almost
> all cases.

Heh, people often suggested that rebase should get --merge as
default, and I resisted that.

I think it would make sense to do the consolidated backend for
rebase, revert, cherry-pick and am (I have been tentatively
calling this "git replay") primarily based on the "patch with
fallback to 3-way" like format-patch piped to "am -3", with an
option to do merge-recursive.
