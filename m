From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2012, #07; Mon, 23)
Date: Tue, 24 Jul 2012 07:42:18 -0700
Message-ID: <7vfw8hgr05.fsf@alter.siamese.dyndns.org>
References: <7vsjchhhhz.fsf@alter.siamese.dyndns.org>
 <20120724135838.GB14422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 24 16:42:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StgJh-00080Z-7w
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 16:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202Ab2GXOmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 10:42:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754588Ab2GXOmX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 10:42:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D1B46E65;
	Tue, 24 Jul 2012 10:42:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P7CCSjCBwzPVTStSOj97vytBBOU=; b=rkNUF7
	2fqkMy1JWAQHQ9a7ymHocE/5kVt/NQvPMTrL+LMqv9wHuHPF/2vTjsSYwVfcJQIb
	eJNCTgXcGAo9L0NRpDfynWQFiw/o+3b3ugyC6DU3cAlnJw1dKasyeOGgolGIIG6d
	l0Mp57oSZFTl7eBbXQUwB+CVKmib1PN+s4LAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MbPyTX4o9OQrfAwq0Oa1KXo5gPP2WKGx
	fMEI2oi/8bwbO7ppu8vwygVkwk1SEt8+ga2BR/ShAxJTwS4TS4erovHN2e46vrcS
	Go4ij2899yrRWY7K+ZCFLFnSScqKaQbrWTwHM4bKeaAj1uaEzBApdKlAwBiMfz4B
	eJYGz6Pn3c0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AA2D6E64;
	Tue, 24 Jul 2012 10:42:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08C0E6E63; Tue, 24 Jul 2012
 10:42:19 -0400 (EDT)
In-Reply-To: <20120724135838.GB14422@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 24 Jul 2012 09:58:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5A6925A-D59D-11E1-9738-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202042>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 23, 2012 at 10:10:00PM -0700, Junio C Hamano wrote:
>
>> * jc/test-lib-source-build-options-early (2012-06-24) 1 commit
>>  - test-lib: reorder and include GIT-BUILD-OPTIONS a lot earlier
>> 
>> Reorders t/test-lib.sh so that we dot-source GIT-BUILD-OPTIONS that
>> records the shell and Perl the user told us to use with Git a lot
>> early, so that test-lib.sh script itself can use "$PERL_PATH" in
>> one of its early operations.
>> 
>> Needs to be eyeballed by people who run tests with exotic options
>> like valgrind, --root=/dev/shm/somewhere, etc.
>
> I'm such a people. Both --valgrind and --root work OK with the patch.
> Reading the patch, I don't see any other problematic options, either.

Thanks; I've been running tests for 'pu' with --root pointing
elsewhere as well.  I probably should push this forward before the
tree gets busy again post relesae.
