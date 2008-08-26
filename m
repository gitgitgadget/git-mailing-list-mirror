From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Tue, 26 Aug 2008 15:42:51 -0700
Message-ID: <7vabez2yac.fsf@gitster.siamese.dyndns.org>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
 <48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org>
 <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net>
 <7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
 <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net>
 <7vsksrad7o.fsf@gitster.siamese.dyndns.org> <48B44C61.2020206@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 00:44:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY7Gq-00060R-KX
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 00:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbYHZWnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 18:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbYHZWnJ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 18:43:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbYHZWnI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 18:43:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F6945CD61;
	Tue, 26 Aug 2008 18:43:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 61D1B5CD60; Tue, 26 Aug 2008 18:42:55 -0400 (EDT)
In-Reply-To: <48B44C61.2020206@gnu.org> (Paolo Bonzini's message of "Tue, 26
 Aug 2008 20:33:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 57223E30-73C0-11DD-82E9-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93829>

Paolo Bonzini <bonzini@gnu.org> writes:

> Junio C Hamano wrote:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> Paolo Bonzini schrieb:
>>>> +	/*
>>>> +	 * Always open file descriptors 0/1/2 to avoid clobbering files
>>>> +	 * in die().  It also avoids not messing up when the pipes are
>>>> +	 * dup'ed onto stdin/stdout/stderr in the child processes we spawn.
>>>> +	 */
>>> I see your point, but I don't have an opinion whether this stretch is
>>> necessary.
>> 
>> This is going too far.  Have you seen any other sane program that do this?
>
> Busybox.  But it runs setuid, as Steven pointed out.
>
> I say it's all (i.e. be this paranoid), or nothing.

I tend to agree, and I think what Stephen R. van den Berg said earlier in
the thread makes perfect sense.
