From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1700: make test pass with index-v4
Date: Fri, 20 Mar 2015 11:06:53 -0700
Message-ID: <xmqqtwxfee6a.fsf@gitster.dls.corp.google.com>
References: <1426864165-7334-1-git-send-email-t.gummerer@gmail.com>
	<xmqqsiczfuqa.fsf@gitster.dls.corp.google.com>
	<20150320173750.GA6545@hank>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= =?utf-8?Q?_Duy?= 
	<pclouds@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 19:07:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1K1-0003XI-JF
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbbCTSG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:06:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750956AbbCTSG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:06:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FFE140F20;
	Fri, 20 Mar 2015 14:06:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fQ4VzSzs1gKJFmU4EJEY/B9cN1w=; b=t0Elfv
	xWppr3sftRKiwWcxFUtPeFkFY2Ih3bgOoUMx+CTacwtP9ELT+eIGkOfH12xeU07G
	tEmC7B1QVBje7KJ5EhiaN5pLZE/+moXFSgRkkCEHlN4DOhbH9Cmpi8xAs4c/rIG1
	jHHsVvQd5TMdZHWqks1dKBFj8iicJudbtLdVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i/Pz962lPF7EW4xxZn1wx/hiqhVhtr+T
	T2O8N0/sX1Lo9kYJf4mAVt/Tob1Equs6xbrKYq2HVduPD2rSWqRxggWirTjEo+ql
	l5ulvXVt374kp5MiEVtUUUS3l1mQl9LSXOwhlrbHZnLikGJULaiykmf6HfDv+Vm0
	i/cQEqZFIZs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97D4440F1F;
	Fri, 20 Mar 2015 14:06:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF77A40F1E;
	Fri, 20 Mar 2015 14:06:54 -0400 (EDT)
In-Reply-To: <20150320173750.GA6545@hank> (Thomas Gummerer's message of "Fri,
	20 Mar 2015 18:37:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E460F8D6-CF2B-11E4-84CE-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265928>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 03/20, Junio C Hamano wrote:
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>>
>> > The different index versions have different sha-1 checksums.  Those
>> > checksums are checked in t1700, which makes it fail when run with index
>> > v4.  Fix it.
>>
>> I am more interested to see how you managed to use index v4 in the
>> tests be described next to "when run with index v4".  I thought we
>> were controling these things fairly tightly (e.g. we disable hooks,
>> move $HOME to avoid getting affected by your personal settings,
>> etc.).
>
> The tests can be run with index-v4 by setting TEST_GIT_INDEX_VERSION
> in config.mak.  This configuration was introduced in 5d9fc88 test-lib:
> allow setting the index format version.

An updated patch to mention "when run with TEST_GIT_INDEX_VERSION=4"
in the log message was what I was asking for ;-)
