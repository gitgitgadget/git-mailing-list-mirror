From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] xdl_diff: identify call sites.
Date: Thu, 13 Dec 2007 23:03:57 -0800
Message-ID: <7v4pelvjtu.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
	<7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
	<7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
	<7vejdy4yuw.fsf@gitster.siamese.dyndns.org>
	<7v7ijorwnc.fsf@gitster.siamese.dyndns.org>
	<7vabof5mze.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0712122219160.20487@xanadu.home>
	<7vtzmmz0ov.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 08:04:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J34b5-0002PT-VG
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 08:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbXLNHEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 02:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbXLNHEN
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 02:04:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbXLNHEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 02:04:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 252BF7C03;
	Fri, 14 Dec 2007 02:04:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F31B7C02;
	Fri, 14 Dec 2007 02:04:04 -0500 (EST)
In-Reply-To: <7vtzmmz0ov.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 13 Dec 2007 14:31:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68252>

Junio C Hamano <gitster@pobox.com> writes:

> This inserts a new function xdi_diff() that currently does not
> do anything other than calling the underlying xdl_diff() to the
> callchain of current callers of xdl_diff() function.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  Nicolas Pitre <nico@cam.org> writes:
>
>  > On Wed, 12 Dec 2007, Junio C Hamano wrote:
>  >
>  >> Here are the topics that have been cooking.
>  >
>  > What about the blame speedup patch from Linus (Message-ID: 
>  > <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>)
>
>  I would prefer to do a bit more generic solution, not a special hack for
>  speeding up blame on prepend-only files, with a proper log message.

FWIW, I re-ran the gcc/ChangeLog annotation Linus cited and got similar
improvements (about 4x speed-up) with his version and this version and
their results seem to match.  I'll apply these to 'master' and push the
results out.
