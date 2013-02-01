From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Thu, 31 Jan 2013 17:40:02 -0800
Message-ID: <7vmwvodd71.fsf@alter.siamese.dyndns.org>
References: <15540714.372461359682286477.JavaMail.weblogic@epml08>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git <git@vger.kernel.org>, Antoine Pelisse <apelisse@gmail.com>
To: jongman.heo@samsung.com
X-From: git-owner@vger.kernel.org Fri Feb 01 02:40:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U15cH-0005Wn-2g
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 02:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408Ab3BABkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jan 2013 20:40:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60230 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601Ab3BABkF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jan 2013 20:40:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D6A6B743;
	Thu, 31 Jan 2013 20:40:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uf+PMe9zMtFM
	VIt9lGTGc9Wjs3s=; b=iJ0gy86S6zxiq3WaSiCumCh1IGybfGjY6FunoOi9DzGE
	SRsyEzoWcepBQruMRi8im2CvCbmaWnOLSaa5jzDC+vWuQdPAk6jipcan+noHdS7l
	H9MHykaJV8i+6FckS8TNEhCj3RoTvBJYgehJQOym8qjmIntHW+oihPDATSc9AaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=r2exv1
	+wi9oR5mxB5wrO+rS1Ds+L0pOfhCSh+KCEo+SBj4538r9/ljuExjLIFi3/DkELmL
	mcBHXEw1ni8vjuwTPWubGZw5ZJCmay7AtFGiGljKV/xciaY9qaWKMfvrzoY6ceIs
	Ve3fAEqMkKdwAbOD9IE03eNu+5qhN1DLVUke8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21167B742;
	Thu, 31 Jan 2013 20:40:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D9AFB741; Thu, 31 Jan 2013
 20:40:04 -0500 (EST)
In-Reply-To: <15540714.372461359682286477.JavaMail.weblogic@epml08>
 (=?utf-8?B?Iu2XiOyiheunjCIncw==?= message of "Fri, 01 Feb 2013 01:31:27 +0000
 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D4A77D6-6C10-11E2-97D4-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215197>

=ED=97=88=EC=A2=85=EB=A7=8C <jongman.heo@samsung.com> writes:

> But usually when I build upstream Linux kernel, I don't do "make
> clean" after git pull..  I didn't expect that I needed "make
> clean" for git build.

We don't expect anybody need "make clean", either.  There is
something wrong in the dependency.
