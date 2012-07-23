From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH lt/block-sha1 0/2 v3] block-sha1: avoid pointer
 conversion that violates alignment constraints
Date: Sun, 22 Jul 2012 22:10:48 -0700
Message-ID: <7vobn7njtz.fsf@alter.siamese.dyndns.org>
References: <20120722233547.GA1978@burratino>
 <7v8vebp0cl.fsf@alter.siamese.dyndns.org> <20120723045148.GA13623@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 07:11:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StAv4-00055H-DF
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 07:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab2GWFKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 01:10:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49702 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967Ab2GWFKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 01:10:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73C5D5B72;
	Mon, 23 Jul 2012 01:10:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nw0mQj2LFRv2dqDQUtxD2oxNqf4=; b=OCzMKU
	+utavFPHP1/60tDrsDpO9HQXZqbaJlY9wX6OG+GMv/vjBLAs422q0BT4HrSyNBL/
	hnU4sjHiSPWwgIKORHUGgnDjPaFLPZZQ7bSGaA5n/DWN7kxq1EgFXqPTJyPxEwWL
	dJZCUOL2m30qOGDxI1E2gwMjta4PEQbZmYM2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z1nIg7Kh60Vku9EU5EDhr319v82EcbD1
	zNj3H7ehm2nmqQWg7IoFEBNQkkKNCWj73LI149Heq/3mPVykfhivCmkL1a/pRK7r
	YS6pctXBhRnz6zYcATA9SXkZEboMFI8QAutyl2X2QZN7TWI8+7n4QghuXTD+BFHv
	BIJ5//rbDZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 602775B71;
	Mon, 23 Jul 2012 01:10:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE2695B6F; Mon, 23 Jul 2012
 01:10:49 -0400 (EDT)
In-Reply-To: <20120723045148.GA13623@burratino> (Jonathan Nieder's message of
 "Sun, 22 Jul 2012 23:51:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4B0E766-D484-11E1-A878-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201898>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Thanks.
>>
>> Did somebody actually compiled Git for Alpha, and even more
>> surprisingly on a big-endian variant of one?
>
> Logs from building for Alpha and running the test suite are here:
>
>  http://buildd.debian-ports.org/status/logs.php?pkg=git&arch=alpha
>
> The big-endian part was just my idiocy, sorry.

Hrm, do we want an update log message for 1/2 then?
