From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/9 v4] difftool: fix regression in '--prompt' options
Date: Thu, 22 Mar 2012 09:59:06 -0700
Message-ID: <7v3990zi5h.fsf@alter.siamese.dyndns.org>
References: <1332358560-13774-4-git-send-email-tim.henigan@gmail.com>
 <1332381236-16004-1-git-send-email-tim.henigan@gmail.com>
 <7viphxz37j.fsf@alter.siamese.dyndns.org> <871uoljbe9.fsf@thomas.inf.ethz.ch>
 <CAFouetjqzAwCe3mHkpJB4Xod4rJEF9OD77ch906TGUd9+-KZWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 17:59:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAlM4-0004q6-Ck
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 17:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030961Ab2CVQ7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 12:59:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab2CVQ7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 12:59:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 653A26566;
	Thu, 22 Mar 2012 12:59:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tSHOYfVFbXbJvCKCpLONqKKzlS8=; b=aMy7TF
	WnmzxFPsPtf37kOo8hFbmCzTu6wtkV6OoagFIdcs/+WA39HFpLyaS02/E5BRwxTd
	OFYkKtQkb/sgxgHbjcQsDU2JQPXW39QkGbwZCTpJ7sscP72snJ2bXY08rmbBONxd
	SVaYqBA0OMA575N2VSBHSMmwz2iT1tz/ITqGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N5/SFhtunIV5BIozzMrS+EmCbKOtuPDR
	Q/PxGnnsFt+rvWhRlS8FtJR6IZjNFJQU74i+pD85UDu7/+Aasd4z8TYtf3YKRid7
	pKQP0lzIe+hO9BAmbWQ52TYLB78s4tM3HpH2F6ysoYKqYgE1LaCwf6HFHZ576ph0
	RKSN9mpsHUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D4686565;
	Thu, 22 Mar 2012 12:59:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4BA56564; Thu, 22 Mar 2012
 12:59:07 -0400 (EDT)
In-Reply-To: <CAFouetjqzAwCe3mHkpJB4Xod4rJEF9OD77ch906TGUd9+-KZWA@mail.gmail.com> (Tim
 Henigan's message of "Thu, 22 Mar 2012 09:51:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56B84CB2-7440-11E1-8EEC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193666>

Tim Henigan <tim.henigan@gmail.com> writes:

> v5 of the patch will use Getopt to parse the '--[no-]prompt' options
> again.  I will also add a new patch to the series to implement
> '--no-gui'.

Sensible.  At that point, it should be rolled into an updated [1/9] so
that Getopt::Long is used correctly from the get-go, I think.
