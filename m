From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] difftool/mergetool: make the form of yes/no questions consistent
Date: Tue, 12 Apr 2016 14:15:09 -0700
Message-ID: <xmqqegaapm02.fsf@gitster.mtv.corp.google.com>
References: <1460472260.3214.23.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nikola =?utf-8?Q?Forr=C3=B3?= <nforro@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 23:15:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq5ea-0007cW-TN
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 23:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783AbcDLVPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 17:15:16 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753605AbcDLVPM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 17:15:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 71A2F55E2A;
	Tue, 12 Apr 2016 17:15:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MnWxyvGjgfbx
	PO6EoOmAwiy1aYU=; b=i6pJa3M61SQCdXq8FIi0UU1USGnnF8hriv5mPkKOnv6t
	DRNdD6kRSL2rKLEiiFRi1EQp1H4TRrIUetaWWHF1bD3G0xSI/Y1B1oYtxKiecnBg
	ZPOOwUcwXdpgZnTHj7C32bSp9FWc/5dNvAmJkYnXboVatWLgsAeVMHx2q6zmenU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bQSHp/
	uc8hNuepDdR6KKqTOAB8MDl/RpYTc+9Qt/hBln/J3Y0PTUg0mCISQpk1uSX+pOV+
	y+bTJA81zt/KjrXHVSuIxHwsH5YNQyboXFV2BA6OQS84Dd7m1OVFnA8M/hWZDpiJ
	NyN0XwpiAiM1yfxKyPxNt1bvSQmy9GhNc16pE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 68A0755E29;
	Tue, 12 Apr 2016 17:15:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DE8A455E26;
	Tue, 12 Apr 2016 17:15:10 -0400 (EDT)
In-Reply-To: <1460472260.3214.23.camel@redhat.com> ("Nikola =?utf-8?Q?Forr?=
 =?utf-8?Q?=C3=B3=22's?= message
	of "Tue, 12 Apr 2016 16:44:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A3F6729E-00F3-11E6-90E8-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291296>

Nikola Forr=C3=B3 <nforro@redhat.com> writes:

> Every yes/no question in difftool/mergetool scripts has slightly
> different form, and none of them is consistent with the form git
> itself uses.
>
> Make the form of all the questions consistent with the form used
> by git.
>
> Reviewed-by: John Keeping <john@keeping.me.uk>
> Signed-off-by: Nikola Forr=C3=B3 <nforro@redhat.com>
> ---
> Changes in v2: example dropped from the commit message

Thanks; have you run the test suite with this patch applied?

It is your responsibility to make sure that the expectation by
existing tests are still satisfied after your change, or update
their expectation to match the new (and hopefully better) world
order your patch introduces.

I needed to squash this in to make the tests pass, but because I am
not a difftool user, I do not at all know if the prompt produced
(and expected by the test) is sensible or not.

 t/t7800-difftool.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index ec8bc8c..df9050f 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -20,7 +20,7 @@ difftool_test_setup ()
 prompt_given ()
 {
 	prompt=3D"$1"
-	test "$prompt" =3D "Launch 'test-tool' [Y/n]: branch"
+	test "$prompt" =3D "Launch 'test-tool' [Y/n]? branch"
 }
=20
 # Create a file on master and change it on branch
