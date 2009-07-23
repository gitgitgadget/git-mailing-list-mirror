From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] refactor: use bitsizeof() instead of 8 * sizeof()
Date: Wed, 22 Jul 2009 22:15:13 -0700
Message-ID: <7vljmg56am.fsf@alter.siamese.dyndns.org>
References: <1248298475-2990-1-git-send-email-madcoder@debian.org>
 <1248298475-2990-2-git-send-email-madcoder@debian.org>
 <1248298475-2990-3-git-send-email-madcoder@debian.org>
 <20090723050711.GB9189@coredump.intra.peff.net>
 <7v3a8o6l3v.fsf@alter.siamese.dyndns.org>
 <20090723051112.GA9372@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:15:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTqef-0005ji-WC
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 07:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbZGWFPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 01:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbZGWFPV
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 01:15:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbZGWFPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 01:15:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A2BBE76D;
	Thu, 23 Jul 2009 01:15:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BFD39E76C; Thu, 23 Jul 2009
 01:15:14 -0400 (EDT)
In-Reply-To: <20090723051112.GA9372@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 23 Jul 2009 01\:11\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D1357012-7747-11DE-BFB5-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123840>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 22, 2009 at 10:09:56PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Wed, Jul 22, 2009 at 11:34:34PM +0200, Pierre Habouzit wrote:
>> >
>> >>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
>> >> +#define bitsizeof(x)  (CHAR_BIT * sizeof(x))
>> >
>> > Isn't our style to use all-caps for macros? I.e., BITSIZEOF?
>> 
>> Perhaps but I'd say similarity between sizeof() and bitsizeof() calls for
>> consistency in the lowercase in this particular case.
>
> Fair enough. I just wanted to point it out in case nobody thought of it.

I've actually thought of using elemof() to call what is known as
ARRAY_SIZE() when we introduced it, but now it is way _too_ late ;-)
