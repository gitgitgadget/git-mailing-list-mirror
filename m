From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Thu, 28 Aug 2008 15:58:46 +0200
Message-ID: <20080828135846.GA6874@cuci.nl>
References: <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <20080826074044.GA22694@cuci.nl> <32541b130808262201v4d7c1aa5r781720a80b79fcd0@mail.gmail.com> <20080827091800.GB484@cuci.nl> <48B54A3D.3080708@gnu.org> <7vej4aqsge.fsf@gitster.siamese.dyndns.org> <48B6A57A.6050109@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 16:03:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYi2T-0005DQ-Pl
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 15:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbYH1N6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 09:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbYH1N6s
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 09:58:48 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:33465 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbYH1N6r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 09:58:47 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 661FC5465; Thu, 28 Aug 2008 15:58:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48B6A57A.6050109@gnu.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94055>

Paolo Bonzini wrote:
>> It is either run by ssh (via command="" option in authorized_keys file),
>> by init/login (if in /etc/passwd), or by gitosis (and its equivalent).

>It is possible to run it with file descriptors closed via ssh, using
>command="git-shell 0<&- 1<&- 2<&-" in the authorized_keys file.

I don't consider this that relevant, however...

>It's true that in this case the user is also shooting himself, but given
>that git-shell is used to restrict operation to "safe" commands, this
>special case might be worth being worked around.

Since a programmer error in this case doesn't inflict just pain on the
user, but also is a potential security leak that can potentially be 
exploited by third party users, things are different, and it is worth
catering for.
-- 
Sincerely,
           Stephen R. van den Berg.

"Listen carefully, I shall say this only wence."
