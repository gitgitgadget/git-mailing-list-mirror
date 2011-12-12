From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] show tracking branches with their associated branch
 names
Date: Sun, 11 Dec 2011 23:14:58 -0800
Message-ID: <7vsjkq5h0i.fsf@alter.siamese.dyndns.org>
References: <1323502829.1698.6.camel@sdesktop> <4EE32C1B.8070306@lyx.org>
 <1323516226.1698.80.camel@sdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org
To: Santhosh Kumar Mani <santhoshmani@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 09:30:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra1HM-0004d2-Ay
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab1LLIa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:30:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54907 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab1LLIaY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:30:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B471289A;
	Mon, 12 Dec 2011 03:30:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=XqY3YBe9lbgcd3H4EseSX6vgpLQ=; b=ZYVXU+zA5ifFOFNKAxfg
	fJNN7VzNuQlorymlGUTcUBG8vQf4p5Mi+Fi08nxVIzha3jzU1L4n7r/0qpqErpmZ
	ZmwbtH6D4YB5doG6GN4hgJPRURZn8PXnOXlB6sbtfG/dy1yM6qf21DXYjg+12BrI
	kqdUcvuqy4SMUSCXu2PUvzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TgSdeqWcfZaz5a0VaTB6cBLDAZD6HWJWqipnQNID1kWrO2
	4yrinyA5rMmIuXBk07BFaC39ChpMvue8e7Iz8lFqXMucHbjyPjIRk/J6hrnyMW9R
	3fc3J5ijjCkj7EteUMlESHuTYWZsx2eagaE4PF8YgYdk24QbhJ7EHo1kL95NQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 923272899;
	Mon, 12 Dec 2011 03:30:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29A4D2898; Mon, 12 Dec 2011
 03:30:23 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88D1F7CE-249B-11E1-AB1D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186894>

Santhosh Kumar Mani <santhoshmani@gmail.com> writes:

> Of course, I could get this information in different ways. But it makes
> sense to have this information displayed by default.

It makes sense to make the various information available, but it does not
mean it makes sense to add it by default for everybody at all. Given that
against all common sense, many newbie web-tips and third-party documents
suggest "git branch | sed -ne 's/^\* //p'" as a way to find the current
branch in scripts, I am sure such a change will cause trouble to many
while only helping a few.

I wouldn't mind a new option --verbose-format=... that takes various
formatting letters similar to how --pretty=format:... does, though.
