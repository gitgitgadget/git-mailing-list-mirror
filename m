From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cmd_config(): Make a copy of path obtained from git_path()
Date: Mon, 17 Nov 2014 09:25:07 -0800
Message-ID: <xmqqtx1xyc24.fsf@gitster.dls.corp.google.com>
References: <1416123464-22874-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 17 18:25:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqQ3B-0004d1-Ve
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 18:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbaKQRZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 12:25:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750920AbaKQRZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 12:25:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A9D751E7F1;
	Mon, 17 Nov 2014 12:25:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k0muzsp1kY1yjiXFy+t+QWDmi7o=; b=Otzdrl
	IvQS8J53IyxQQEEOdjrru/PPw7iNUV1TvxTsbgMM1nI/SG1y/OIBXpMrD+vs4us0
	IneQXnWESC6/yodaYyiIU94gadOSAKMuRF39tSW+ABAkH6pIIxEJsW0WEKA3hbhB
	uhD7AuFrVOdmUCf/coZHayxB108Qz/1i1nUA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OzwBmR1Xnv04tPSGSNXDPq+EcnjEAkex
	ymOFLDcWlz7CNhreH/dnymjpZSjqswZ5S5Ll5H6J0DkrMR+VB+ugGQVYgAS+8VIP
	MPUvwdAdO6JzX9+NKBPChTfFqyf+oj8IKgBjiU+o3cSr4teMTwLOMy/sS1UXyyns
	IhPWb7ixSq0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A11371E7F0;
	Mon, 17 Nov 2014 12:25:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 139231E7EF;
	Mon, 17 Nov 2014 12:25:10 -0500 (EST)
In-Reply-To: <1416123464-22874-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sun, 16 Nov 2014 08:37:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AF1ED228-6E7E-11E4-BA93-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The strings returned by git_path() are recycled after a while. So make
> a copy of the config filename rather than holding onto the return
> value from git_path().

Good thinking.  I agree that is an accident waiting to happen.
