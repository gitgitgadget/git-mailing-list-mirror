From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update t3508 status
Date: Tue, 29 Jun 2010 10:22:24 -0700
Message-ID: <7vd3v9ah4f.fsf@alter.siamese.dyndns.org>
References: <1277775091-13313-1-git-send-email-newren@gmail.com>
 <7v4oglbxn6.fsf@alter.siamese.dyndns.org> <20100629165032.GA7699@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: newren@gmail.com, git@vger.kernel.org, chriscool@tuxfamily.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 19:22:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTeWC-00076A-GY
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 19:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672Ab0F2RWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 13:22:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394Ab0F2RWg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jun 2010 13:22:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FF49C07B9;
	Tue, 29 Jun 2010 13:22:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HfanPliO729E
	WwRmYlDSHicgZxE=; b=H3MRLjY/zzCNota/EKvJnl8ybKkVWoF10f9HFCLjJwdZ
	8Rf1CA+8qWInpgsKzeAZwVAxHfoTsifDeKheYzGegSU6HD65aT4ig8VOrhqgG+q6
	0Z0y5pjDyjUdfmxD11sCft3meaw6ajurMz3IfwbimKtKAq+WGaIOwHan2diGnvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nmBkc6
	XCmLKoNTHwZO0wdit0ClZ1Y3cA4fZ0uxDrIMQAkSmrV4QSXWMU+EEZ3CiwVrI/Ow
	bnpDFDZpza1jWPJyuWIhzCuocELb8l3JC+qvUlGPoxvlfaIkAKpOLUqRHCmq+EeO
	S5i63O+3Tn1gqUesBGnpiDGKthjZbTdJP2pt4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2D45C07B7;
	Tue, 29 Jun 2010 13:22:30 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1249EC07B3; Tue, 29 Jun
 2010 13:22:25 -0400 (EDT)
In-Reply-To: <20100629165032.GA7699@burratino> (Jonathan Nieder's message of
 "Tue\, 29 Jun 2010 11\:50\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5E9FC7C-83A2-11DF-A2BA-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149922>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> newren@gmail.com writes:
>
>>> Test #8 of t3508-cherry-pick-many-commits.sh
> [...]
>> Curious.
>>=20
>> This test is broken in the second parent of 3af0bba8b (i.e. the tip =
of
>> cc/cherry-pick-stdin), but in 3af0bba8b, i.e. the merge result, it d=
oes
>> seem to be fine.
>>=20
>> What am I missing???
>
> The fix is in commit v1.7.2-rc0~6^2 (DWIM 'git show -5' to 'git show
> --do-walk -5', 2010-06-01):
>
>  disable --no-walk in this case so =E2=80=98git show=E2=80=99 and fut=
ure =E2=80=98git
>  cherry-pick=E2=80=99 can behave as expected.

Ah, that's it.  3af0bba (Merge branch 'cc/cherry-pick-stdin' into next,
2010-06-27) is on 'next', so this has to be queued as an evil merge of
your "DWIM" thing into cc/cherry-pick-stdin.  That way, when the latter
graduates to 'master', the test will be marked as "expect_success".

Thanks.
