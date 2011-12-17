From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] [PATCH] gitk: fix the display of files when filtered
 by path
Date: Fri, 16 Dec 2011 22:31:34 -0800
Message-ID: <7vy5ubemk9.fsf@alter.siamese.dyndns.org>
References: <87hb14wg4l.fsf@fox.patthoyts.tk>
 <CAJDDKr6rVaX_=SZZeEAs950yuNDvi8sOkzrUK7LnCrK6MYfscg@mail.gmail.com>
 <alpine.DEB.1.00.1112151023280.2615@bonsai2>
 <CAOeW2eHD7Xutf+pHDyMOo=uZC9PSFZi+aMq1Rx80iTKPFApr8A@mail.gmail.com>
 <20111215225945.GG20629@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Aguilar <davvid@gmail.com>, Git <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Dec 17 07:31:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbnoM-0004py-PM
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 07:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab1LQGbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 01:31:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab1LQGbh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 01:31:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A20DA4558;
	Sat, 17 Dec 2011 01:31:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pUqsgdUqC1lZZIU7i9s7K0dyBNs=; b=u2hFW1
	hCYwpbHQvQ7lPjxYQYYoBBWaUtFVzt0B7G35ITtDSCgJZ8itUD3rDK+1OtX4LGi7
	N4aRRr2V3ZwWebd2+JchvlkSGa2whTyrv4elBuTp3/O5paYpkxZnT0gn5NFX73VX
	+w1keGdlcjv8NzpOUKemh6MI35bUEhavU7xNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rkPuQ6aaiUDdXsxkigljqy5DJQy+S+kW
	4f90sl1zh/5MCLqgIYqvZYr+Ot38osJcebA6dQRu5XzzqVfSsetCuj2GNtt83AcF
	3hNbd0BEeBMPqbqXUBDVWxtoA22vgz2HcOlw+4UKN1ZBMItTsjIpsG49FZ230Jax
	jan5YLSTuWA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 991DF4557;
	Sat, 17 Dec 2011 01:31:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20B604556; Sat, 17 Dec 2011
 01:31:36 -0500 (EST)
In-Reply-To: <20111215225945.GG20629@bloggs.ozlabs.ibm.com> (Paul Mackerras's
 message of "Fri, 16 Dec 2011 09:59:45 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4DB7426-2878-11E1-80BA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187351>

Paul Mackerras <paulus@samba.org> writes:

> On Thu, Dec 15, 2011 at 11:42:38AM -0800, Martin von Zweigbergk wrote:
>
>> git://git.kernel.org/pub/scm/gitk/gitk.git is still down.
>
> I have just created a repository on ozlabs.org for gitk, since I don't
> have kernel.org access at this point.  The repository is:
>
> git://ozlabs.org/~paulus/gitk.git
> ...
> Your patches are in the master branch.  I applied them back in July
> but then kernel.org went down.

Thanks.

All pulled and resulted in one liner update to the draft Release Notes for
the next release.

diff --git a/Documentation/RelNotes/1.7.9.txt b/Documentation/RelNotes/1.7.9.txt
index cd3c256..f476667 100644
--- a/Documentation/RelNotes/1.7.9.txt
+++ b/Documentation/RelNotes/1.7.9.txt
@@ -4,6 +4,8 @@ Git v1.7.9 Release Notes (draft)
 Updates since v1.7.8
 --------------------
 
+ * Accumulated gitk updates since early this year.
+
  * git-gui updated to 0.16.0.
 
  * git-p4 (in contrib/) updates.
