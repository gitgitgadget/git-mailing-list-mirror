From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use faster byte swapping when compiling with MSVC
Date: Tue, 20 Oct 2009 09:55:41 -0700
Message-ID: <7v4opuovhu.fsf@alter.siamese.dyndns.org>
References: <hbi4mt$tjt$1@ger.gmane.org>
 <7vzl7mr1f5.fsf@alter.siamese.dyndns.org>
 <bdca99240910200156x48511478w9eaa2239eb8342b4@mail.gmail.com>
 <alpine.DEB.1.00.0910201149020.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:56:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0I0V-00045n-9y
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 18:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbZJTQzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 12:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbZJTQzx
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 12:55:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbZJTQzv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 12:55:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 082827E337;
	Tue, 20 Oct 2009 12:55:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=RxfaM/RfjdLtvgo/TdQoAvCItfA=; b=koMYlAbMOoruksqWuV6HWjd
	Nb/YhcbiRH3woEnIANV7EIcw6S/YIbJbgjdCUIvcO5fWn0A1SuIBg/zJ8Wdc6SGq
	guxQbPDlNBrP6Nhz604BjjBxZy5f+mDPEJyB/vg/2Ie6jCkfrDRgd7NfeANWq8Tv
	hFF5Ok9W6XmtzFnhp+hY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kYZYYUQoV9q/CKIkL+wZntzckJlWsrV4ftyS+4O3RNyPsoqhy
	VRi+12aCl/YaBkv/L6W0aWoum8sYjdhaKfaQ/W2IobMESETFd9YzgzF65h2K1QNH
	n0IdZwSaL3c920VNWSqgwSQABNbn3YRdcJqhEnMevbgtGVOHUGtX9a/W3Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BABF87E336;
	Tue, 20 Oct 2009 12:55:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C6DB97E32D; Tue, 20 Oct 2009
 12:55:42 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6BFF60C0-BD99-11DE-A852-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130814>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Well, in fact I am one of the msysgit poeple, although I mostly worked 
>> on the installer until now. In general, I like my patches to be 
>> reviewed, but this one is rather uncritical, I guess. So it's up to you, 
>> Junio, I'm perfectly OK with waiting for an ACK.
>
> Apart from the fact that I do not have MSVC (and I don't want it, either), 
> there is another strong reason why I think Sebastian does not need ACKs or 
> SOBs on MSVC patches: he has plenty of experience as a maintainer of a 
> rather big (commercial) software that has to compile on Windows, MacOSX 
> and several Unix-type OSes (and it is known that Sebastian is a Windows 
> guy).
>
> So I would trust Sebastian's patches (at least when it comes to MSVC) 
> without even reviewing them.

I very appreciate a strong Ack in a specific area like this.  I do skim
msysgit list from time to time, and in retrospect I realize I _could_ have
recognized Sebastian's name but somehow it didn't click.

I guess I should apply both patches to 'master', then.  Thanks.
