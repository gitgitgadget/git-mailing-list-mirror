From: Junio C Hamano <gitster@pobox.com>
Subject: Re: write() _will_ fail on Mac OS X/XNU if nbytes > INT_MAX
Date: Fri, 10 May 2013 16:36:55 -0700
Message-ID: <7vy5bmxv8o.fsf@alter.siamese.dyndns.org>
References: <CAEDE852zw9EhmnVaWb_oa_BX_d_--TZoTcs1kgkMPHooM_E6Cw@mail.gmail.com>
	<7v4nffpbct.fsf@alter.siamese.dyndns.org>
	<CAEDE8504Pa_hRcHBLt4S9CL74noqrX3fWGCSf+x45zCr_43+5A@mail.gmail.com>
	<7vbo8j600q.fsf@alter.siamese.dyndns.org>
	<CAEDE8507jPW4sKW7-xX5-+3YpFgfzkXzeskCNRrD7T6ynxgdNA@mail.gmail.com>
	<7va9o2zba9.fsf@alter.siamese.dyndns.org>
	<CAEDE851rRw24Dpxugt3_qJBtROdfcv4c6kskaizXnVy=gYVCBg@mail.gmail.com>
	<CAEDE853WiuoPenuuBgPehTg89_cLfBckr3CD=fEMuXTXwVv5kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Filipe Cabecinhas <filcab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 01:37:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaws3-0001GR-Mv
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 01:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674Ab3EJXg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 19:36:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44546 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754418Ab3EJXg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 19:36:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2B031EAC8;
	Fri, 10 May 2013 23:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TYDKGJ6cVKuSAaYEwPDRfO8RbF0=; b=fE8iXe
	DzEpkJa5nQrMj3r8bVVTmPQS0ks+bnj5+7wIGZBz3yZW6D2hG1P8TDCaaSwfYRpd
	SdYGY2dXpHSRyqiMmiMIo8qHeSYi1avG/I+DAE2WJjn68jLuAtSC8N9kVLUHhROz
	Zr/fRCzQW89jTdsb+KKjGQMbhvorqRW1AZya4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bozumts8iRn/RhLil8p9ozaIQZIYcGZ0
	r1r+f3tUXrGjWzGIh5zfakXn4RDsTiaaCfvH1v1lTAeLBq5hczp1cPUsFfFIlsQs
	rS6AMvEyEOYjyRmY8CM0wY58FKVGqK8oJoM+GE01Snu6tpOGu9APEeHQzXia0N1g
	64BiocmffTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96FBF1EAC5;
	Fri, 10 May 2013 23:36:57 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D45B1EAC1;
	Fri, 10 May 2013 23:36:57 +0000 (UTC)
In-Reply-To: <CAEDE853WiuoPenuuBgPehTg89_cLfBckr3CD=fEMuXTXwVv5kQ@mail.gmail.com>
	(Filipe Cabecinhas's message of "Fri, 10 May 2013 16:19:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80E10378-B9CA-11E2-8818-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223922>

Filipe Cabecinhas <filcab@gmail.com> writes:

> It compiles cleanly and runs. I'm running the test suite anyway, but
> don't expect any change from your latest patch.

Heh, I do not think we did write(2) of that many bytes in our test
suite ;-)

Thanks.
