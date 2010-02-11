From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] git-push: send "To <remoteurl>" messages to the 
 standard output in --porcelain mode
Date: Thu, 11 Feb 2010 15:19:34 -0800
Message-ID: <7veikrs6m1.fsf@alter.siamese.dyndns.org>
References: <20100209054820.GA30907@cthulhu>
 <1d1ce7e0ad28fd0cad8d9d7bfeda04ba58be36d4.1265694627.git.larry@elder-gods.org> <45357037fd8f928759c9e9064736c62e793b84be.1265694627.git.larry@elder-gods.org> <be6fef0d1002111454w10ad965ej72699d1e185d2a9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Larry D'Anna" <larry@elder-gods.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 00:20:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfiKG-0003tz-NM
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 00:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381Ab0BKXTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 18:19:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757301Ab0BKXTt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 18:19:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10DDC99438;
	Thu, 11 Feb 2010 18:19:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qyud55cnDaocUIwLqlDU5LS3yi0=; b=e+UBnK
	poG3Sl+L4u7pY77BWHPvogmT4HLomintRSdD9yR71jAt9EF8zYIP0jbIsZOvUXiR
	54YitbKVrZS+AQwdN+0kyq/MFI0Q9nbktCWGgiH065peT8z+aSwITzkO+xLFzeH2
	dLFfUYbAqxh67RDT9Q9BXLvaYW/CmqtyeqfbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KRuhFrwHtIM6lw0IMMNNO1fiSO0iKa7Q
	IGyZY5qwLbCKTJTWDaG560pbo3qTxFF/4qzLjNBTxBSr4FQNSDSzh0nmuxzPyx2C
	Dkt5Werkk4w9j8uGK+FNAR9uoF2ujpJCguXomp0k9dzVBkLf9vjm4RCaFMYmKKhE
	8Hs+nIEPZxg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BFF2D99434;
	Thu, 11 Feb 2010 18:19:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1F029942D; Thu, 11 Feb
 2010 18:19:35 -0500 (EST)
In-Reply-To: <be6fef0d1002111454w10ad965ej72699d1e185d2a9f@mail.gmail.com>
 (Tay Ray Chuan's message of "Fri\, 12 Feb 2010 06\:54\:47 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE0DD2D0-1763-11DF-A55D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139640>

Tay Ray Chuan <rctay89@gmail.com> writes:

> If that's the case, then perhaps the "To: <destination>" lines should
> be sent to both stdout and stderr - stdout, for porcelain scripts as a
> "header", and stderr, to help the user make sense of any errors that
> occur ("oh, these errors were triggered when pushing to so-and-so
> remote").

Under --porcelain, to show or not to show is under control of the calling
script.  Not sending it to standard error stream doesn't cause any harm,
as the calling script can choose to echo it out to its standard error (or
standard output).
