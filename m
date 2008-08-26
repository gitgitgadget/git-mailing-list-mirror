From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Tue, 26 Aug 2008 08:57:12 +0200
Message-ID: <48B3A948.3080800@viscovery.net>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu> <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org> <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 08:58:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXsVl-0003wy-8Z
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 08:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbYHZG5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 02:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbYHZG5P
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 02:57:15 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:9112 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbYHZG5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 02:57:14 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KXsUK-0007jY-K9; Tue, 26 Aug 2008 08:57:12 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5B14B54D; Tue, 26 Aug 2008 08:57:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <E1KXsL9-0004ef-Co@fencepost.gnu.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93719>

Paolo Bonzini schrieb:
> +	/*
> +	 * Always open file descriptors 0/1/2 to avoid clobbering files
> +	 * in die().  It also avoids not messing up when the pipes are
> +	 * dup'ed onto stdin/stdout/stderr in the child processes we spawn.
> +	 */

I see your point, but I don't have an opinion whether this stretch is
necessary.

However, *if* we do this, we must do it for all non-builtins as well!

-- Hannes
