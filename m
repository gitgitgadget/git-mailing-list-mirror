From: Junio C Hamano <gitster@pobox.com>
Subject: Re: config-file includes
Date: Mon, 26 Sep 2011 14:12:08 -0700
Message-ID: <7vmxdr100n.fsf@alter.siamese.dyndns.org>
References: <20110923195829.GA27677@sigill.intra.peff.net>
 <CACsJy8BAVRAct=sxTpZ+b-ft1OjbY9oZG6uEXrcsTXw3CXnwSg@mail.gmail.com>
 <20110926192126.GA55743@gmail.com>
 <20110926200553.GA492@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 26 23:12:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ITJ-0005Gd-3p
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 23:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab1IZVMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 17:12:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab1IZVMM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 17:12:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B51904929;
	Mon, 26 Sep 2011 17:12:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9C7PCYshAVf00ngjNB0h5qaMnQ0=; b=fcw6cw
	oUSTSreqF8hAu3xA8UwDjHCUbPdLFzDlGgecMOtDs53dAgWs1MSUwp8JfNpnigHM
	AAGpBU6kdUzxenIQUmnlPIU/VZcrJuyaN7GCed3ihdqkrOVyQqC6UmhAy1MCcdZ8
	DTyOGQGMKTHZR/czDalDFAKTzE0UOoOadiwPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XxvKwDDfLa7GFa62Kk0P4/JlWJH9Nf2V
	Ll6Wcghqf53Q4BY/TDqzOPX5Q7c6g9upoILthy5/iTD5bAud201DXbmRfAmiR++7
	2b6U2R20Vacv4zwJCsv7jnz90RBIXzaLVQWbv8E91ePOypCs6YbFf9PUjvZiTptL
	wLqgVDI8B4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB4664928;
	Mon, 26 Sep 2011 17:12:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41443489C; Mon, 26 Sep 2011
 17:12:10 -0400 (EDT)
In-Reply-To: <20110926200553.GA492@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 26 Sep 2011 16:05:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32911708-E884-11E0-86E2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182164>

Jeff King <peff@peff.net> writes:

> We could allow arbitrary shell code like:
>
>   [include-if "test `uname -s` -eq Darwin"]
>
> Very flexible, though it makes me think we are getting a little
> overboard.  And it's an extra shell invocation whenever we read the
> config, which is ugly.

Let's not go there. It is not even like we only ever call git_config()
once in the lifetime of a process.
