From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] refactor: use bitsizeof() instead of 8 * sizeof()
Date: Wed, 22 Jul 2009 22:09:56 -0700
Message-ID: <7v3a8o6l3v.fsf@alter.siamese.dyndns.org>
References: <1248298475-2990-1-git-send-email-madcoder@debian.org>
 <1248298475-2990-2-git-send-email-madcoder@debian.org>
 <1248298475-2990-3-git-send-email-madcoder@debian.org>
 <20090723050711.GB9189@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:10:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTqZR-0004Pl-1p
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 07:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbZGWFKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 01:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbZGWFKL
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 01:10:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbZGWFKK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 01:10:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9493E74A;
	Thu, 23 Jul 2009 01:10:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 91005E749; Thu, 23 Jul 2009
 01:10:04 -0400 (EDT)
In-Reply-To: <20090723050711.GB9189@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 23 Jul 2009 01\:07\:11 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 182600E6-7747-11DE-B885-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123836>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 22, 2009 at 11:34:34PM +0200, Pierre Habouzit wrote:
>
>>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
>> +#define bitsizeof(x)  (CHAR_BIT * sizeof(x))
>
> Isn't our style to use all-caps for macros? I.e., BITSIZEOF?

Perhaps but I'd say similarity between sizeof() and bitsizeof() calls for
consistency in the lowercase in this particular case.
