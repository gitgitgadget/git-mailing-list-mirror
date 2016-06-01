From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule operations: tighten pathspec errors
Date: Wed, 01 Jun 2016 14:20:38 -0700
Message-ID: <xmqqtwhcwqqh.fsf@gitster.mtv.corp.google.com>
References: <1463793689-19496-1-git-send-email-sbeller@google.com>
	<xmqqd1o8vbc4.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbdfEJ1iSpOJ=HfHP=EvVxB9Sv+5Zk+goLSOJphh8ZZ+w@mail.gmail.com>
	<xmqqy46owr0n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 23:20:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8DZG-0004WA-8c
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 23:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbcFAVUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 17:20:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750824AbcFAVUl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 17:20:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A0029228E6;
	Wed,  1 Jun 2016 17:20:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D5iXESrL16olG5CrM4D0RSmzBQs=; b=LInTR7
	A8KRRpBw1H2ODSjsaCj+FBODVy9bcy0W5kq/PTqTvCznQXhOb5uuOx8TbTXv9YAg
	PMBK7HVh6GHWaoJQy7eJRCp5vimOd7R6ezZUOrYjWwot5J1oudwbHbDOKJuheXGk
	8k1XDSnUi0/NZAoY1nna4eHygQAqHxrycBqe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OLqVRdkQRvp2F0gZZO3kUz0T2YZ6rpg7
	5UoTmlRsiml/MbrmFmgYBPclSCoBX6NFymVFhJWDAWLEt85xtlwx67TbCPrzY4Hl
	o/bCgYXsfYi+5SPAX28GTOMLFLZDfEbx4DNGd9cVaKd9IR52pu78nY0Tgi22U8nI
	6OM+um9AK1g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 985DB228E5;
	Wed,  1 Jun 2016 17:20:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25796228E4;
	Wed,  1 Jun 2016 17:20:40 -0400 (EDT)
In-Reply-To: <xmqqy46owr0n.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jun 2016 14:14:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B0DB90DA-283E-11E6-89A5-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296168>

Junio C Hamano <gitster@pobox.com> writes:

>> Ok I'll fix the variable names; I think for consistency with e.g.
>> ls-files --error-unmatch
>> we would want to be loose by default and strict on that option.
>
> I do not think the "typo-prevention" safety measure should suddenly
> be turned into opt-in; I'd suggest "--unmatch-ok" instead.

Sorry, I should have grepped before hitting "send".  I think this is
in line with "git rm --ignore-unmatch".  We complain by default, but
the user can choose to squelch.
