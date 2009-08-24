From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Mon, 24 Aug 2009 15:21:40 -0700
Message-ID: <7vmy5o3laj.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home>
 <alpine.LFD.2.00.0908232320410.6044@xanadu.home>
 <7vocq5q0j7.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908240946390.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 00:22:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfhva-0004ym-3j
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 00:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbZHXWWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 18:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669AbZHXWWE
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 18:22:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbZHXWWD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 18:22:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6EDB9367E1;
	Mon, 24 Aug 2009 18:21:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3bjTyVcrgdFHBPL0/r73xZFvdzQ=; b=TR6K4H
	r1dLUiBLDcKyolu3iFRwrvaspOlFBXyIb/AztmKvB/nbstSbOB32LAQ8wr+fMvtZ
	U2ElCO/ebI9yQl4z7wJriTSDazHv6eEZh5krtxC0gPIH5jsLeW50TE1p5TozFUwJ
	swpHDEWvnW5mxcHJ3aLMmsagpgQO6jBXEo9P0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q3BDGtq9Bxnaff/RBnueFzGZGoQNKsNO
	yqmXLIVTrfnhKe0Oofsx4opNSMFEmWiscsY5hQTzo6o/oR5QlAcFe+JiX7X2ADHA
	dr9Ah1QXnfpC8cribBMxwwnQTlD/EQA4+TJr0k745pNc36Q52aaNTqPE4o04rnEU
	2Y6hxm8U1z8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 32FAA367DE;
	Mon, 24 Aug 2009 18:21:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8CFFC367DD; Mon, 24 Aug 2009
 18:21:42 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0908240946390.6044@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 24 Aug 2009 09\:55\:13 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 84B07B8C-90FC-11DE-B702-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126977>

Nicolas Pitre <nico@cam.org> writes:

> If you really want to get rid of that filtering, I'd still do it in a 
> separate patch.  That way if any issue appears because of that then 
> bissection will point directly to that removal alone.

Fair enough.
