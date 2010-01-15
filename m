From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Test t5560: Fix test when run with dash
Date: Fri, 15 Jan 2010 11:53:35 -0800
Message-ID: <7vr5prxhz4.fsf@alter.siamese.dyndns.org>
References: <7vfx69hyd5.fsf@alter.siamese.dyndns.org>
 <4B5027B8.2090507@viscovery.net> <7vljfzz0yd.fsf@alter.siamese.dyndns.org>
 <201001152017.00121.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 20:53:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVsF0-0004q7-I4
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 20:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab0AOTxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 14:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294Ab0AOTxu
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 14:53:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab0AOTxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 14:53:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6474D91838;
	Fri, 15 Jan 2010 14:53:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gGVbjJHnF0hD762pPdgBKwWtEvQ=; b=kBFaMW
	xZmFXSa2lLqFZGu2N9vpOeCNIFyrQgdrjiIrlV9lkAkLAlQ8x5GMi2WHMEmBJVjz
	iH9/rD72RmEa44OAy87YALvrN38DhFwLZPNdBFw+OBW4xl320aa+FiGOy5P6Ic45
	FeKa9WTLYQY9ruQhdWjTSjiWaytCxTyqlEUIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yvm25RK1umkEsP8WdEqVh9V0anZ3syFQ
	+3R2+0O8mtfDWx5IR/O2QRchg1i1N+JXxRGUlzEyuHFmPdUhT+PPc25JnSy8p9je
	HB4ywFOv4U+J1LP/ByM9DgjD53gWpFFrbOpjZGfPqyERtNxMz7rMMK/MLp9/O+4S
	5svpLbAvTcQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11AB89182E;
	Fri, 15 Jan 2010 14:53:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFE7891829; Fri, 15 Jan
 2010 14:53:36 -0500 (EST)
In-Reply-To: <201001152017.00121.j6t@kdbg.org> (Johannes Sixt's message of
 "Fri\, 15 Jan 2010 20\:16\:59 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AFBAE108-020F-11DF-B4D0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137105>

Johannes Sixt <j6t@kdbg.org> writes:

> These are exactly the definitions that I meant. The statement that variables 
> are not exported is in "2.9.1 Simple Commands" 
> http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01
>
> "[If there is a command name], the variable assignments shall be exported for 
> the execution environment of the command and shall not affect the current 
> execution environment (except for special built-ins)."

Note the "except for special built-ins".  I was unsure yesterday because
it does not say "except for special built-ins and shell functions".
