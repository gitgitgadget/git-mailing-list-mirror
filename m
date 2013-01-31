From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Fix msvc build
Date: Thu, 31 Jan 2013 11:28:31 -0800
Message-ID: <7vmwvpgnj4.fsf@alter.siamese.dyndns.org>
References: <510AB766.4030806@ramsay1.demon.co.uk>
 <alpine.DEB.1.00.1301311956470.32206@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 31 20:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0zoe-0008Ft-B7
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 20:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753716Ab3AaT2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 14:28:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54970 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339Ab3AaT2e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 14:28:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F00BB26E;
	Thu, 31 Jan 2013 14:28:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rn6EyNK9+xkKmQaQxvtsnh7IbEg=; b=vAK4N3
	0cmmZgp2onMzfbZwAUU8k6fOQ1MAoiDgtzMmvubwSOymxQKiZ3amDGL3w2rXjs8c
	dT/WY5UhXMWQi6lvI+sLxGnvuHx4vaRYbinHgLlI4zYCsxesUcbJfJi0ksqmoB3S
	JSaMOyQPjw0pmip/bzTyzgI/r6xsaHT6HpSgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mNhBpAanrl2LAE5X4jDU0ZNp8SCIQ7iq
	rEmUx0bru8wPSWK6aCkiqHaggrBHjyQmiU4RnMpKkak3AJw3D9bp13CFfF0ykz93
	QI5qvBOIKDPhl71qYXxTcNkBUEU+fRgjXxEW561sqgC8RiwRoDtqc18qOlRMBVbk
	vI1zzjmPMBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 236EFB26C;
	Thu, 31 Jan 2013 14:28:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B51DB267; Thu, 31 Jan 2013
 14:28:32 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1301311956470.32206@s15462909.onlinehome-server.info>
 (Johannes Schindelin's message of "Thu, 31 Jan 2013 19:57:21 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 662DFBE4-6BDC-11E2-A67A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215153>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Ramsay,
>
> On Thu, 31 Jan 2013, Ramsay Jones wrote:
>
>> As I mentioned recently, while discussing a cygwin specific patch
>> (see "Version 1.8.1 does not compile on Cygwin 1.7.14" thread), the
>> MSVC build is broken for me.
>> 
>> The first 4 patches fix the MSVC build for me. The final patch is
>> not really related to fixing the build, but it removed some make
>> warnings which were quite irritating ...
>
> Thanks!
>
>> Note that I used the Makefile, with the Visual C++ 2008 command line
>> compiler on Windows XP (SP3), to build a vanilla git on MinGW.  I'm not
>> subscribed to the msysgit mailing list, nor do I follow the msysgit fork
>> of git, so these patches may conflict with commits in their repository.
>
> Maybe you can Cc: the patch series to msysgit@googlegroups.com
> nevertheless?

OK.  The only thing I can say about these patches is that none of
them would affect my boxes would exercise, so I'll wait until I get
a final-for-application re-send from mysgit folks, preferrably with
their Acked-by: lines.

Thanks.
