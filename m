From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2ter 2/2] gitweb: clean up gitweb_check_feature() calls
Date: Sat, 29 Nov 2008 14:26:49 -0800
Message-ID: <7viqq6yxqu.fsf@gitster.siamese.dyndns.org>
References: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1227959616-8056-1-git-send-email-giuseppe.bilotta@gmail.com>
 <7vej0u1d2c.fsf@gitster.siamese.dyndns.org>
 <7vzljiz1qn.fsf@gitster.siamese.dyndns.org>
 <cb7bb73a0811291416h4c227411u61bfe7033f0d2bae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 23:28:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6YIn-0004kI-9L
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 23:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbYK2W1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 17:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbYK2W1S
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 17:27:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbYK2W1R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 17:27:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D940480098;
	Sat, 29 Nov 2008 17:27:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9D4AA8008D; Sat,
 29 Nov 2008 17:26:50 -0500 (EST)
In-Reply-To: <cb7bb73a0811291416h4c227411u61bfe7033f0d2bae@mail.gmail.com>
 (Giuseppe Bilotta's message of "Sat, 29 Nov 2008 23:16:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E03849C8-BE64-11DD-B187-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101930>

"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:

> And this is precisely the reason why the first time I sent the patch I
> did the restyling in the same go: by not touching the
> clueless/careless callers and instead bringing gitweb_check_feature to
> act in scalar context, it would automatically fix those broken usages,

... which is very bad for reviewability purposes.

By explicitly fixing them before doing the "this will sweep all the
potential bugs under the rug", you can demonstrate a lot more clearly why
these changes are necessary.
