From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added test case for mirror to not push stash refs
Date: Thu, 06 Nov 2008 08:58:10 -0800
Message-ID: <7vod0siyfx.fsf@gitster.siamese.dyndns.org>
References: <20081028212327.GA25358@sigill.intra.peff.net>
 <1225942397-20513-1-git-send-email-david@statichacks.org>
 <bd6139dc0811060034q14e47232n5f00471e5420efbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@statichacks.org, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Nov 06 18:00:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky8DA-0000HR-Dv
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 18:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbYKFQ63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 11:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbYKFQ63
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 11:58:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbYKFQ62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 11:58:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D952C93064;
	Thu,  6 Nov 2008 11:58:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A424A93062; Thu, 
 6 Nov 2008 11:58:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 20A129BA-AC24-11DD-AE6C-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100246>

"Sverre Rabbelier" <alturin@gmail.com> writes:

>> +               git push --mirror up
>> +       )
>> +'
>
> I don't quite get how this works, I don't see a test here anywhere to
> actually test that the stash refs were not pushed?

I agree that this test should check the receiving end.

The patch is relying on the fact that the receiving end would reject the
push if the sending end tries to push refs/$foo where $foo does not have
any slash.
