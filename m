From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Mon, 09 Apr 2012 17:31:36 -0700
Message-ID: <7vwr5os9zr.fsf@alter.siamese.dyndns.org>
References: <7vy5q4tw3i.fsf@alter.siamese.dyndns.org>
 <1334016800-11574-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: schwab@linux-m68k.org, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Apr 10 02:31:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHOzo-0003yS-NS
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 02:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459Ab2DJAbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 20:31:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55309 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754048Ab2DJAbi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 20:31:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60CF26631;
	Mon,  9 Apr 2012 20:31:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KilxpfwYICEcBBPeDSng1wD2NrM=; b=P+07S4
	ZEEv1DwhezZJq8cIAAd6QvAXyuPVjeZDhYJh0d6ERADLfEdQblYqtmPaxjv+9F6o
	Ib6KRbn8TCdNsG5d2n2ABXIvZZiLpZ9BCskOs/927MItMwH2Q8xCakP/m3EPFWTK
	mNAyORxg84StC6pYVJ/515Z7rQAS+Oh73J/E0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W0SmDsREF3r+eFkXaw+TXRP7aH7Bl/cO
	qO1vhpj+dmqa9EaNIbD4eYnplK24TKAOpS/3oyNC4v0OniJU3S9WaQd+allbT59O
	7uyECRLW5/zIfKkw6ntEU1zpLEkcxIYioVhuU3bQRYAM4jP9y7FFvaa+fLVCrrJi
	IVjI4SOeOuc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57F036630;
	Mon,  9 Apr 2012 20:31:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5E84662F; Mon,  9 Apr 2012
 20:31:37 -0400 (EDT)
In-Reply-To: <1334016800-11574-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Mon, 9 Apr 2012 20:13:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88D1DADE-82A4-11E1-A5CD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195051>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> For some reason, I thought that using {x,y} range notation wasn't
> valid in this scenario, but I think I was mistaken.  It seems to be
> widely used elsewhere throughout the code.

Where?  Only two test scripts seem to use it and worse yet, one of them
uses it doubly incorrectly.
