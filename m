From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] clone --single: limit the fetch refspec to fetched
 branch
Date: Tue, 18 Sep 2012 09:57:38 -0700
Message-ID: <7vipbbnu9p.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BGBwNp-oDsnB1QObrVLU54rtDmGGBF=Muww8ZJjfZScA@mail.gmail.com>
 <1347909706-22888-1-git-send-email-ralf.thielow@gmail.com>
 <7v8vc8v1wd.fsf@alter.siamese.dyndns.org>
 <CAN0XMOKCsjfG-DgV_rr99mYXHBSKryL1O46X+7r5ie+=2aKmmA@mail.gmail.com>
 <7vlig8s50o.fsf@alter.siamese.dyndns.org>
 <CAN0XMOKCZL+X1QNW7CPmu-wdpVN0HjK=3z-sTz5naSQ5RW3x4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 18:57:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE17R-0000Wn-TZ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 18:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab2IRQ5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 12:57:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab2IRQ5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 12:57:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE7C98E60;
	Tue, 18 Sep 2012 12:57:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OHio4QsO3tpY0Cjj8z+L/vK4ULw=; b=uFOPWv
	TLp6/2hacZvfbS+3UDCYJyTzFy2qmzzRjR0Wa7up4wU+uowp1spbWgomfBSM+GhX
	j9AyZnzBzRebyDDMvGWBFlP0g9uCbmrIgNxX7oTs+9hf7JqtYYIJgzVCGwEV+mWE
	e56A7yPOuWbhyu9R+rsAzZcx2raij3smlzVcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aTW5QiAMNLwae5cpeajqyEvkJ1gJVmzb
	EqQRtOrNi2hU7anfArlZLDXLf8hZ7ftw+7DVjSOguNS+A4nWXY3QZ/McMeizX9vw
	MpaRm26ifPakPY3+oLPjYibi3fg/d0w5ezJNipCUUkXhJ3g9IDQ4JQe4I8bokB1C
	s5k2Nd/UAic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AE628E5F;
	Tue, 18 Sep 2012 12:57:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AB988E5B; Tue, 18 Sep 2012
 12:57:40 -0400 (EDT)
In-Reply-To: <CAN0XMOKCZL+X1QNW7CPmu-wdpVN0HjK=3z-sTz5naSQ5RW3x4w@mail.gmail.com> (Ralf
 Thielow's message of "Tue, 18 Sep 2012 16:08:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4FF83F0-01B1-11E2-B31D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205837>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> IMO if a user uses "clone --single-branch --branch <tag>", then he/she
> wants to have this tag only. Why should the next "git fetch" fetching
> something different?

OK, I can buy that.
