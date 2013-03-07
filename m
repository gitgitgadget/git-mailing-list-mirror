From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] p4merge: create a virtual base if none available
Date: Wed, 06 Mar 2013 23:25:52 -0800
Message-ID: <7v8v5zoem7.fsf@alter.siamese.dyndns.org>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
 <1362601978-16911-3-git-send-email-kevin@bracey.fi>
 <CAJDDKr6+VRnc-HK52woHHLtAqXau=76Gc+Ag=keiMGffuco64A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Bracey <kevin@bracey.fi>, git@vger.kernel.org,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 08:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDVDa-0002jS-0H
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 08:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab3CGHZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 02:25:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43055 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732Ab3CGHZz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 02:25:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E885E8BF6;
	Thu,  7 Mar 2013 02:25:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=URQBmnjd9HMybQxp9pD80VuoO2A=; b=FVJxWl
	nDIz3FXxo6vPTNhGflus/HEkRpVOnuue+DdgQrpMjFD7JS9dT3i0/TwE6RqdDimF
	iFtbcp5Ui/t/IMntemtDyxAoyuBCbe8+UIhbjIhSXf2FC2w8ik7nDCCehwgPkYbV
	HSLq94hMkHZnMLXct0SazYi9fqOoBxtehDVxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZtD17TTV/qOfnVm0AzajmJ3Pjrt/ZVVe
	qwvuAT64hagcf+/LXwVBlEjIts323bDjaztt9Rut/v/RWKt7AFaS+BVQ/kz6yB4v
	9ldjzRaByA2FSEBQwr2NWvI0uZDvBtKVhLH0ww9c2gnJkwhm3ntravsAJqqFAmPu
	bizbQqG2rgg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCD588BF5;
	Thu,  7 Mar 2013 02:25:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76BFC8BF3; Thu,  7 Mar 2013
 02:25:54 -0500 (EST)
In-Reply-To: <CAJDDKr6+VRnc-HK52woHHLtAqXau=76Gc+Ag=keiMGffuco64A@mail.gmail.com> (David
 Aguilar's message of "Wed, 6 Mar 2013 18:23:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F348F4E-86F8-11E2-9A8A-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217577>

David Aguilar <davvid@gmail.com> writes:

> How do we feel about this duplication?
> Should we make a common function in the git-sh-setup.sh,
> or is it okay to have a slightly modified version of this
> function in two places?

It probably is a good idea to have it in one place.  That would also
solve the @@DIFF@@ replacement issue you noticed at the same time.
