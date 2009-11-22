From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule.c: Squelch a "use before assignment" warning
Date: Sat, 21 Nov 2009 18:59:14 -0800
Message-ID: <7vws1jl0xp.fsf@alter.siamese.dyndns.org>
References: <1258680785-42235-1-git-send-email-davvid@gmail.com>
 <7v8we17ha9.fsf@alter.siamese.dyndns.org>
 <c5plt6-5me.ln1@burns.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Bartoschek <bartoschek@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 22 03:59:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NC2fe-0002zY-Fs
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 03:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbZKVC7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 21:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753637AbZKVC7P
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 21:59:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbZKVC7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 21:59:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3759EA03C1;
	Sat, 21 Nov 2009 21:59:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FTJHTvC9CcXW4gfmf8ICXYkiCOA=; b=AOcdw2
	Unp74nz8pj738ORZtmizzNjY8THHCqoiCmMpShg7+7/fZGOUdimqiIMjo3jbp+a7
	Fos1J69BvY6iw7r+bkxftz7Jm1zIWqHOc3j3ofOuBbvc74G2gYjmBRIuUJgW5QDk
	au5vUvpsPFGNywmaSI6K0xYg3JhlubvrS/PDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gWxFxcIp04wiI1jo2V3p9qni8aIYZHT8
	xZNrReorFTJp7k4b1Y3xAAwCmR+6QPe6AS3aSqXOANhDPbElT7w/caSK+KQLJSNm
	le5wMPz8luuQh/vSwNV5X/nS6Zng37m+yRrpV5EafbLtDVqN9kp8jwjPie+mN1Sl
	f9dYPOdzNWQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 10A0EA03BD;
	Sat, 21 Nov 2009 21:59:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2168DA03BC; Sat, 21 Nov 2009
 21:59:15 -0500 (EST)
In-Reply-To: <c5plt6-5me.ln1@burns.bruehl.pontohonk.de> (Christoph
 Bartoschek's message of "Sat\, 21 Nov 2009 19\:46\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 070885F0-D713-11DE-B857-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133421>

Christoph Bartoschek <bartoschek@gmx.de> writes:

> Why is the compiler not complaining about the fake initalization? For 
> initialization a value is used that is not initialized.

That is a fairly well established idiom to tell gcc "you may mistakenly
think it isn't, but this is used".
