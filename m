From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Fri, 07 Jun 2013 11:41:07 -0700
Message-ID: <7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
	<20130607000006.GA25731@goldbirke>
	<CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 20:41:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1bE-0006T7-BS
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757031Ab3FGSlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 14:41:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756991Ab3FGSlK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 14:41:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2247E26D8E;
	Fri,  7 Jun 2013 18:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=d3Bjg/Bvg/pL
	nlNswhCsHp/SuNM=; b=EHiNQkhdlWY5WGwJuN2Ih2l/um4HJGJB2Wxg8yG67jA/
	oIRZscA6VmY+m+mBf13gcUJPQ4RYN2rzLcvAL9bG7OtOn8t2FEznCaU/eXts6rJ1
	DsgRZYoEtImMTirexW5sCbZzoHYX3uF7KqIoZNX0l3VW/2KTwMO3/R8vxPy5xW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rCdb51
	W1cyCQ3lir21ImI+UYFaAKRXIkl4JXNpdu4s+by5V7s2pMU4nHLzHj2t+4XCj+h2
	AxNlWS245JCm4tv4yqPqHiBbTpXZHCOxtvhnuOy7KS9TWfwr/cu/1L2BR71SUINE
	xjkabXq/uvX6aG0byldUZ6FrWmoyp/oNXHimE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14CD226D8D;
	Fri,  7 Jun 2013 18:41:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62DE026D8B;
	Fri,  7 Jun 2013 18:41:09 +0000 (UTC)
In-Reply-To: <CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 7 Jun 2013 23:00:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1FB9330-CFA1-11E2-919F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226665>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> SZEDER G=C3=A1bor wrote:
>> the one at the top because
>> of the reasons given in $gmane/226272
>
> Sorry about the delay: I went to sleep for a couple of days :P
>
>> the one at the bottom because
>> of the misleading commit message (__git_complete_file() always
>> completed refs first as part of the ref:file notation, so it worked
>> just fine except for the ref1...ref2 notation; the real reason for
>> calling __git_complete_revlist_file() for difftool is to make clear
>> that difftool takes ref1...ref2:file, too).
>
> How am I (or anyone else) supposed to know the "intended" meaning
> __git_complete_file()?

"git log -Gcomplete_file -p contrib/completion" found this one:

commit 1d66ec587e7d903afdf12a81718772a9eadc15a1
Author: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Date:   Thu Mar 10 19:12:29 2011 +0100

    bash: complete 'git diff ...branc<TAB>'
   =20
    While doing a final sanity check before merging a topic Bsomething,=
 it
    is a good idea to review what damage Bsomething branch would make, =
by
    running:
   =20
        $ git diff ...Bsomething
   =20
    Unfortunately, our completion script for 'git diff' doesn't offer
    anything after '...'.  This is because 'git diff's completion funct=
ion
    invokes __git_complete_file() for non-option arguments to complete =
the
    '<tree>:<path>' extended SHA-1 notation, but this helper function
    doesn't support refs after '...' or '..'.  Completion of refs after
    '...' or '..' is supported by the __git_complete_revlist() helper
    function, but that doesn't support '<tree>:<path>'.
   =20
    To support both '...<ref>' and '<tree>:<path>' notations for 'git
    diff', this patch, instead of adding yet another helper function,
    joins __git_complete_file() and __git_complete_revlist() into the n=
ew
    common function __git_complete_revlist_file().  The old helper
    functions __git_complete_file() and __git_complete_revlist() are
    changed to be a direct wrapper around the new
    __git_complete_revlist_file(), because they might be used in
    user-supplied completion scripts and we don't want to break them.
   =20
    This change will cause some wrong suggestions for other commands wh=
ich
    use __git_complete_file() ('git diff' and friends) or
    __git_complete_revlist() ('git log' and friends), e.g. 'git diff
    ...master:Doc<TAB>' and 'git log master:Doc<TAB>' will complete the
    path to 'Documentation/', although neither commands make any sense.
    However, both of these were actively wrong to begin with as soon as
    the user entered the ':', so there is no real harm done.
   =20
    Suggested-by: Junio C Hamano <gitster@pobox.com>
    Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Now I do not recall suggesting it, and you (and I today after 2
years) may disagree with the rationale, but at least we can read
what was the "intended" meaning, I think.
