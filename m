From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add case insensitive support in matching pathspec
Date: Fri, 04 Feb 2011 15:06:02 -0800
Message-ID: <7vei7nxuw5.fsf@alter.siamese.dyndns.org>
References: <1296751106-15316-1-git-send-email-pclouds@gmail.com>
 <201102032117.32745.j6t@kdbg.org>
 <AANLkTi=8-NibvV0NMCpA_KN6+x3GNa0mDr87jtWki_-S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 00:06:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlUjN-0003lJ-PW
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 00:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab1BDXGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 18:06:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab1BDXGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 18:06:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB8734DD2;
	Fri,  4 Feb 2011 18:07:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2MZl7Fv/ABJrZlWagJuUoKBZ7QU=; b=wRlocF
	Am0o9a072XBeLfrpAWOCZbY/WTr6ct7m2qCvlNXbGCiaQ0ls0ESpHPneKk6iTBK7
	i2La0TEqFaG9e8bWlY6d4FPhfcz8Dw/B4s8nSfRaEzd3LfOr+KYGnKQpadSRFVfi
	b1ZNryDFNR+XT06JCUjWxkaHXRoh2TUjAWQXY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TunGYcd4enS0kKCB01IzcLb1TfkhOKk6
	0Dx4o1hCg54OLHhzDwkS4llWWMASuUD6j4TWk6YIESfUD+lrDrN5q3Xs1SlHMiH+
	SfWtTfPy/Sb7jPDBEpDi+0Bmid/ZaegBPjsrbXMT633lk/K7SM4hPySrBQtePX6M
	yas/zZED0kQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A8E1F4DCF;
	Fri,  4 Feb 2011 18:07:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3781B4DC9; Fri,  4 Feb 2011
 18:06:57 -0500 (EST)
In-Reply-To: <AANLkTi=8-NibvV0NMCpA_KN6+x3GNa0mDr87jtWki_-S@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Fri\, 4 Feb 2011 20\:00\:17 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B451BA4-30B3-11E0-A34E-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166065>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> core.ignorecase should be honored only when files on the filesystem are
>> matched, IMO.
>
> Names in index, just as same as match_pathspec().

If the matched entities are names in the index, they should already be
canonical and we shouldn't be matching with icase, no?
