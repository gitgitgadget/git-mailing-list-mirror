From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] log-tree: use custom line terminator in line
 termination mode
Date: Mon, 30 Apr 2012 21:27:14 -0700
Message-ID: <7vhaw0cyql.fsf@alter.siamese.dyndns.org>
References: <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
 <1335817705-24718-1-git-send-email-jk@jk.gs>
 <7vd36oesjr.fsf@alter.siamese.dyndns.org> <86ehr4r4u0.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>, git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Tue May 01 06:27:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP4gt-00079L-5n
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 06:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935Ab2EAE1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 00:27:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38620 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab2EAE1R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 00:27:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C81A7C43;
	Tue,  1 May 2012 00:27:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C1nUf37wRFNLDCRV0F/KAnxinHA=; b=hOh8hc
	oqQOU2fIPhoyLvcTrNrlXPMHU6KN9SM5ptKSwnsyLkh3ThJzW9jrneJdU2AdVIY/
	5SKUK0Vgj3Db3/FinDgJ7dZT+G6ts6l4mAuJS/PBrgwk81185H5pqkm3i/nlYtQX
	X4UhnykU23KROs14p6g8cGv0lvgd/8qzwdPzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z2NLGBf+U8K743zfWNlzaZvCoCR8yWQn
	I5o/nfq851OEQwGomlxC8dl+eGUnuhbYozI4vpojrrY75q1RepgHUmVcpVWpxUGe
	fzqHjGz19RNVRC1n1s8XqWgWpeCdSW+YotFULOjqvOw7n8amc2FYguM+lxE4wyGV
	wNMPY5eA0ho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 444097C42;
	Tue,  1 May 2012 00:27:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEFFF7C41; Tue,  1 May 2012
 00:27:15 -0400 (EDT)
In-Reply-To: <86ehr4r4u0.fsf@red.stonehenge.com> (Randal L. Schwartz's
 message of "Mon, 30 Apr 2012 19:51:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE57CAEC-9345-11E1-8C2C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196654>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:
>
> Junio> Having said that, are we sure that
>
> Junio> 	printf "add bar\0initial"
>
>
> Junio> works per specification, or merely works by accident in some
> Junio> implementation?
>
> From the POSIX spec
> (http://pubs.opengroup.org/onlinepubs/9699919799/utilities/printf.html):
>
>     In addition to the escape sequences shown in XBD File Format Notation (
>     '\\' , '\a' , '\b' , '\f' , '\n' , '\r' , '\t' , '\v' ), "\ddd" , where
>     ddd is a one, two, or three-digit octal number, shall be written as a
>     byte with the numeric value specified by the octal number.
>
> Looks pretty intentional to me.  \0 is a nul.

I was staring at the same passage, but somehow it didn't "click" for me
that the above is _not_ saying that the NUL would terminate the string.

So I was worried too much and needlessly.  Thanks.
