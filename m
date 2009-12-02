From: Junio C Hamano <gitster@pobox.com>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Wed, 02 Dec 2009 10:03:17 -0800
Message-ID: <7v638pgsnu.fsf@alter.siamese.dyndns.org>
References: <cover.1259524136.git.brlink@debian.org>
 <7v8wdnooza.fsf@alter.siamese.dyndns.org>
 <20091201071234.6117@nanako3.lavabit.com>
 <7vmy23bl4o.fsf@alter.siamese.dyndns.org>
 <20091202192026.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Bernhard R. Link" <brlink@debian.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 19:03:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFtY7-0004hZ-NV
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 19:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbZLBSDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 13:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754864AbZLBSDY
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 13:03:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbZLBSDX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 13:03:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 843E6A3FCD;
	Wed,  2 Dec 2009 13:03:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yKcExjjwlhEdMVCsr64GUEW+vl8=; b=EDPXTK
	7PpeCm6fTFo38u6X0d+8ZbQWXP/VYZ4vdDD+w3PMCOkZFvZSGRCwr9vX+JjBJYTc
	6GIVsUiLAQaPP51FNoUGcjN9BS5+a7q3Xh32yh+VJorrOAWGLFjUCKXo6mD1Oe0f
	ekvd1umAw3hWap2Pii9FN5QsdNGiqYq3su8oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W02iCj7zdv1BHaht/Dw0OxU/EUPyP+No
	ZwaFiTSeLtmPljHxiuE1wcnwFRDhESHBGrC3R4RQmuq2dOu41GRQrSo1JaelU3/q
	q44y3+3yJDtlZ6Xu9htLawkdQK/zqIPVUZ2WhpNtg6ItcjArVkbn6nzDLGk7s1wz
	rBO2nXz/iHM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 56241A3FCC;
	Wed,  2 Dec 2009 13:03:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5F0DBA3FC3; Wed,  2 Dec 2009
 13:03:18 -0500 (EST)
In-Reply-To: <20091202192026.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed\, 02 Dec 2009 19\:20\:26 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC625632-DF6C-11DE-842A-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134364>

Nanako Shiraishi <nanako3@lavabit.com> writes:

>> In any case, at least this patch will make it start behaving a bit
>> more sanely.
>
> Thank you; it fixes the bug for me. Do I have to say 
>
>     Tested-by: Nanako Shiraishi <nanako3@lavabit.com>
>
> to ask you to include it in the new release?
>
>> -- >8 --
>> Subject: Do not misidentify "git merge foo HEAD" as an old-style invocation

Thanks for reminding me.  I almost forgot that I did that patch.
