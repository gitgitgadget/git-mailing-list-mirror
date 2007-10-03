From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Clone corruption to G4 MacOSX
Date: Tue, 02 Oct 2007 22:44:33 -0700
Message-ID: <7v3awshhvi.fsf@gitster.siamese.dyndns.org>
References: <82638874-6766-4DCD-BF5B-3893F9B5046F@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Wed Oct 03 07:44:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icx2Q-0006oO-GN
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 07:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbXJCFol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 01:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbXJCFol
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 01:44:41 -0400
Received: from rune.pobox.com ([208.210.124.79]:36828 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbXJCFok (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 01:44:40 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id A4B7413CABC;
	Wed,  3 Oct 2007 01:45:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CFC8C13C7B0;
	Wed,  3 Oct 2007 01:44:58 -0400 (EDT)
In-Reply-To: <82638874-6766-4DCD-BF5B-3893F9B5046F@cs.indiana.edu> (Perry
	Wagle's message of "Tue, 2 Oct 2007 21:29:07 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59790>

Perry Wagle <wagle@cs.indiana.edu> writes:

> include/linux/netfilter/xt_CONNMARK.h.  The involved files seem to be:
>
> include/linux/netfilter/xt_CONNMARK.h
> include/linux/netfilter/xt_DSCP.h
> include/linux/netfilter/xt_MARK.h
> include/linux/netfilter/xt_TCPMSS.h
> include/linux/netfilter_ipv4/ipt_CONNMARK.h
> include/linux/netfilter_ipv4/ipt_DSCP.h
> include/linux/netfilter_ipv4/ipt_ECN.h
> include/linux/netfilter_ipv4/ipt_MARK.h
> include/linux/netfilter_ipv4/ipt_TCPMSS.h
> include/linux/netfilter_ipv4/ipt_TOS.h
> include/linux/netfilter_ipv4/ipt_TTL.h
> include/linux/netfilter_ipv6/ip6t_HL.h
> include/linux/netfilter_ipv6/ip6t_MARK.h
> net/ipv4/netfilter/ipt_ECN.c
> net/ipv4/netfilter/ipt_TOS.c
> net/ipv4/netfilter/ipt_TTL.c
> net/ipv6/netfilter/ip6t_HL.c
> net/netfilter/xt_CONNMARK.c
> net/netfilter/xt_DSCP.c
> net/netfilter/xt_MARK.c
> net/netfilter/xt_TCPMSS.c
>
> I first noticed this corruption around August 14, 2007, when it seemed
> ...
>
> If I clone Linus's repository to a x86 machine, I get no corruption.
>
> My wild ass guess is that being big-endian is causing trouble.

Is the filesystem HFS+ that is case-losing?
