From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] Segfault in git rev-list --first-parent --bisect
Date: Fri, 22 Aug 2008 21:51:43 -0700
Message-ID: <7vhc9c49ls.fsf@gitster.siamese.dyndns.org>
References: <32541b130808222020v146e015dm8a98a005ad3e76a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git ML" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 06:53:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWl7e-0006jJ-EQ
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 06:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbYHWEwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 00:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbYHWEwD
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 00:52:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbYHWEwC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 00:52:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C31D64268;
	Sat, 23 Aug 2008 00:51:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1A4B064267; Sat, 23 Aug 2008 00:51:49 -0400 (EDT)
In-Reply-To: <32541b130808222020v146e015dm8a98a005ad3e76a7@mail.gmail.com>
 (Avery Pennarun's message of "Fri, 22 Aug 2008 23:20:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3734EF9E-70CF-11DD-852D-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93418>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> I've tried the following command sequence in git 1.5.6, 1.6.0,
> 1.6.0.8.ga578a, and 1.6.0.90.g436ed.
>
>     $ git clone git://repo.or.cz/versaplex.git
>     $ cd versaplex.git
>     $ git rev-list --first-parent --bisect 5109c91 ^d798a2bfe094
>     Segmentation fault
>
> Removing either the --first-parent or the --bisect makes the segfault go away.

Don't use them both then.  I do not think --bisect pays any attention to
the usual revision traversal rules.
