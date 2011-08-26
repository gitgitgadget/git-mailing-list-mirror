From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I get a readable diff?
Date: Fri, 26 Aug 2011 16:17:13 -0700
Message-ID: <7vsjonbw5i.fsf@alter.siamese.dyndns.org>
References: <4E58216A.8060508@gmail.com>
 <YLOHfGzBBJxbxqM1qsJcnw-e9_g2VtXOgnU8xvQ_IlNrU6zqGVsN05yN5fm1zRD8rr_rz_2cO52ZPfqe5_03kZm5DwGQebZf_9jzyEsmGQw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruce Korb <bruce.korb@gmail.com>,
	GIT Development <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Aug 27 01:17:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx5eM-0001PF-HT
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 01:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612Ab1HZXRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 19:17:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60939 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753285Ab1HZXRP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 19:17:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ACF948F2;
	Fri, 26 Aug 2011 19:17:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t/rUbTk7wpMxQfO1vxx9zK3ByB0=; b=Xzx4YD
	nB4NSR2slWvnQQ9aepbaym9/yrCWng0ILeBMA+CTTMcPdT4vWz7GR9S/QGh3la/C
	KBvmXtQoiuavY2CwIWVuBO8+1I2h4HjLMovhm0SmjQflKZsu89a8FIe+nvdcoPEA
	MO8JpylxYVrMKwO8xupJsKE7cYZ7ExkXecMI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dlgACbWCwWNJy5xyY59CAKjnMcSTcvdU
	TqN4Odr4DK7OecxM4u/WrucFy9OsZhVdPDVrZNdkzXHn2C7208MYAfYfJlhIAe7g
	Zq0OfFMxudjr90H4jjbsF3tZVEKs0i3PTI4C2WfRYuWiLsqnFDRddI1TAqoZ7Zmz
	xSYaX4FLfgg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51EEE48F1;
	Fri, 26 Aug 2011 19:17:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD4E548F0; Fri, 26 Aug 2011
 19:17:14 -0400 (EDT)
In-Reply-To: <YLOHfGzBBJxbxqM1qsJcnw-e9_g2VtXOgnU8xvQ_IlNrU6zqGVsN05yN5fm1zRD8rr_rz_2cO52ZPfqe5_03kZm5DwGQebZf_9jzyEsmGQw@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri, 26 Aug 2011 17:58:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88C182F6-D039-11E0-96DA-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180209>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> On 08/26/2011 05:42 PM, Bruce Korb wrote:
>> I know I can pipe it through "cat", but I'd rather the clutter be gone.
>> There has to be a way.
>
>> ESC[1mdiff --git a/lustre/include/lustre_disk.h b/lustre/include/lustre_disk.hESC[m
> ...
> Your terminal does not support color.  Are you on an ancient system?
> or something exotic?
>
> You can disable it by setting the color.ui config variable in your
> "user" config file ~/.gitconfig like this:
>
>    git config --global color.ui never
>
> -Brandon

Another possibility is that the user has a LESS environment defined, but
without "R" to let it interpret the color. When we do not see "LESS" in
the environment, we play nice and give them FRSX, but if the user already
has LESS, we assume the user knows better than us and do not touch the
environment.  Compare:

    $ LESS=N git show
    $ LESS=NR git show
