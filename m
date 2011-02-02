From: Junio C Hamano <gitster@pobox.com>
Subject: Re: untracked symlinks are less precious than untracked files?
Date: Wed, 02 Feb 2011 12:03:39 -0800
Message-ID: <7v7hdixkys.fsf@alter.siamese.dyndns.org>
References: <201102022025.06140.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Feb 02 21:03:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkivh-00026k-8b
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 21:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab1BBUDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 15:03:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab1BBUDr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 15:03:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DB1D33CE;
	Wed,  2 Feb 2011 15:04:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sailYMsEFok1PPwJaUKAWn1APVg=; b=KZ1zqe
	WFdQWMNsPW1/iTHFQ5wnDvDeyUmalyMbCE/zeamJfLcn7HvhmK1rMPnwV/jkze6Z
	Oclsx6ywP++x81KgqM0Fs9/m4nJ8gm83SgaQ+hkJCZTMprbD4LkpWckeC2oIufYc
	hJE7T1m1HxFABi4CJxKUmXh1zGJTd1ocydQvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hJFantnluJcQXuHGKk3kcROF1KrSiPaD
	bT4b7weSMIiHAlXzhtFEnOUwntXBEYnaN3efLD4a1IhRfJTGV6/EiGfqLLgIjd/V
	C7cRFWZaFGrLswbDg/8eipFwFH4+9AzQlCcmz/FXRaUI1QXVxrmEqnRNSYAW4ugc
	OwzMIGbjZaY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78F7833CD;
	Wed,  2 Feb 2011 15:04:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9EF4333CA; Wed,  2 Feb 2011
 15:04:34 -0500 (EST)
In-Reply-To: <201102022025.06140.j6t@kdbg.org> (Johannes Sixt's message of
 "Wed\, 2 Feb 2011 20\:25\:05 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A96802EC-2F07-11E0-81B3-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165931>

Johannes Sixt <j6t@kdbg.org> writes:

> Is it by design that symlinks are less precious than files, or is it an 
> oversight?

I don't recall making conscious distinction between symmlinks and regular
files, so it is likely to be just a bug. Perhaps using stat() where
lstat() should be used and mistaking an error return as missing, or
something silly like that?
