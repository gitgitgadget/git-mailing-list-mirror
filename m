From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Tue, 26 Aug 2008 10:38:35 -0700
Message-ID: <7vsksrad7o.fsf@gitster.siamese.dyndns.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
 <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org>
 <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net>
 <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
 <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:41:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2Xi-00076l-0c
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759481AbYHZRit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759480AbYHZRir
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:38:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759098AbYHZRip (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:38:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BB31468A8F;
	Tue, 26 Aug 2008 13:38:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4175068A8E; Tue, 26 Aug 2008 13:38:38 -0400 (EDT)
In-Reply-To: <48B3A948.3080800@viscovery.net> (Johannes Sixt's message of
 "Tue, 26 Aug 2008 08:57:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D4261346-7395-11DD-B438-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93782>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Paolo Bonzini schrieb:
>> +	/*
>> +	 * Always open file descriptors 0/1/2 to avoid clobbering files
>> +	 * in die().  It also avoids not messing up when the pipes are
>> +	 * dup'ed onto stdin/stdout/stderr in the child processes we spawn.
>> +	 */
>
> I see your point, but I don't have an opinion whether this stretch is
> necessary.

This is going too far.  Have you seen any other sane program that do this?
