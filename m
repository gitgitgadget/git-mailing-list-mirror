From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] mergetools/p4merge: Honor $TMPDIR for the /dev/null
 placeholder
Date: Fri, 21 Dec 2012 17:53:36 -0800
Message-ID: <7v38yysvhb.fsf@alter.siamese.dyndns.org>
References: <1356073023-15376-1-git-send-email-davvid@gmail.com>
 <7v4njf2xrk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Morton <admin@game-point.net>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 02:56:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmEKX-0007yk-2N
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 02:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352Ab2LVBxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 20:53:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45784 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832Ab2LVBxk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 20:53:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D08CA510;
	Fri, 21 Dec 2012 20:53:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nocvbXHLE75PLNR54Fz6ZT5MQcU=; b=pLgY62
	mWc8CZHoID+aBpUVWqEdjsy4TufA183EmF9kpPMpCTBfMvNVvlLu6Ky1yFHjoatG
	mN5hgXBBLm3k0d7rZV/DKYpu/y2HyFkKGVdR3Hz7IPwStpbCPgNGoz8uCfubYtkl
	+t1oKWPHN2/KGaWnNBs6WGg44cIpx/8NSV210=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ESxU7+QBj//nyWAGOk8OUEuKDt7f+X9a
	/jImcZTcZaGz63b7mXPEz22VA6lIktHi1Iq0zOT9WmIYU+18Ep5u49jnmZQQ0dx1
	wSQBUDX6+sE2pIVjthzW6SxrPrR00r9fRpUgy+5FKNLWWU0/QZppFI1HVAKx7XQR
	aYh5urfYuTY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BBEAA50F;
	Fri, 21 Dec 2012 20:53:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA81FA50D; Fri, 21 Dec 2012
 20:53:38 -0500 (EST)
In-Reply-To: <7v4njf2xrk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 21 Dec 2012 08:08:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67A54422-4BDA-11E2-899E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212023>

Junio C Hamano <gitster@pobox.com> writes:

> By the way, who is going to remove this temporary file once the
> command is done?

Nevermind; I can see that once the backend returns it is removed in
the same function.
