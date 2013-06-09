From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] completion: clarify ls-tree, archive, show completion
Date: Sun, 09 Jun 2013 13:56:20 -0700
Message-ID: <7vbo7fovez.fsf@alter.siamese.dyndns.org>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-7-git-send-email-artagnon@gmail.com>
	<20130603192555.GK2192@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 09 22:56:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlmfK-0004FD-8T
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 22:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162Ab3FIU40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 16:56:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120Ab3FIU4Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 16:56:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8C5525023;
	Sun,  9 Jun 2013 20:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GiyGIvvMVx/5
	S/BVQGXV48uf+Q0=; b=HSIet1ZR/m6eZy8CM00Cr6ELHlVo1MfVZ1dSvDLtc7RO
	DK7wvIylTijVz8J8f5vYHXs7BDf8b4rPB0xlHC1ArQ2uxNNFMcnrwbvQVu32FJko
	VNAURIOZfHMhxjOwfUUuqjQ5bsH11E5WYeh/8VP888eZ8Nmm/IkaSEusXDHIfJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=V/P53m
	aKkPXOzZXLCIS8Wis42asA22nDem335CXORUUb734XUkC3HadGQSOQSsNy54ccO/
	RCi4aM7sIQMxfHQouO5A29QRL+qjkdSc3nazV0mA3dtFl9v1zaBwLsXjFLUcTdgH
	5nA0aDUjp/rmrPvseP4QayVhDiogfE4T0erXQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC95325021;
	Sun,  9 Jun 2013 20:56:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DD3B25020;
	Sun,  9 Jun 2013 20:56:22 +0000 (UTC)
In-Reply-To: <20130603192555.GK2192@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Mon, 3 Jun 2013 21:25:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A718124-D147-11E2-81AC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227167>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Now, __git_complete_revlist_file() provides completion both for this
> master:Doc<TAB> notation and for revision ranges, i.e. for
> master..n<TAB> and master...n<TAB>.  However, since neither git
> ls-tree nor git archive accept revision ranges, calling
> __git_complete_revlist_file() in their completion function would be
> misleading.

ohh, I missed this part, and you are right.

> git show is special, as it understands both the master:Doc<TAB>
> notation and revision ranges, and even the combination of the two, so
> calling __git_complete_revlist_file() there would indeed be better.
