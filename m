From: Junio C Hamano <gitster@pobox.com>
Subject: Q: do people compile with NO_FNMATCH on OpenBSD 5.2?
Date: Tue, 18 Dec 2012 12:00:38 -0800
Message-ID: <7va9tbf7vd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 21:01:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl3MA-00041Q-BA
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 21:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab2LRUAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 15:00:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab2LRUAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 15:00:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D421A150;
	Tue, 18 Dec 2012 15:00:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	TzBDx/i5+QX1AHkrd1nlB9AIIc=; b=X/AWG4vKd9OM9lcFgazB7ukOBFIq8MUrR
	YPldI9EDtu9RWelrFOIFj3xKot9ypW7HF0hnjOV7W6QXhTl8TK6AI3huFuCgL3GM
	Ue2FwOm0dxYFvztgqTKzAGH+LWFVZfSJgsE0jxfFjc2fev89vGMlL6d5D9d5Eqxf
	nzpLEWyAyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=WUT
	+nQsBIJC8hMFJal4W+j5MjdzMxrsReRrcoOY6tW9yOQu5VYu3p7C7kDHksC3dDOh
	d7Ap8yEfoBNVXyIkuD/AW4ILiEIKruYpdnu9QQSCsgdHOlvY+/F41VZcW8PxJnJ9
	hS3aIuOOWXtvZMjD/hc/vpv1f49WFtcF7LM9Rqq8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A4B3A14F;
	Tue, 18 Dec 2012 15:00:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1A7FA14E; Tue, 18 Dec 2012
 15:00:39 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98B75F80-494D-11E2-A8EB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211781>

I seem to get a failure from

    git ls-files "a*"

in t/t0000-basic.sh if I link with platform's fnmatch().
 
