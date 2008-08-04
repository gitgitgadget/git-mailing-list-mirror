From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Git.pm: Fix internal git_command_bidi_pipe() users
Date: Mon, 04 Aug 2008 01:05:56 -0700
Message-ID: <7vtze12oij.fsf@gitster.siamese.dyndns.org>
References: <be6fef0d0808032149p651309a8o773dca5f16923ee1@mail.gmail.com>
 <20080804075313.21325.28396.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 04 10:07:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPv5t-0006lj-Oc
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 10:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbYHDIGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 04:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYHDIGE
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 04:06:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbYHDIGC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 04:06:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1816848646;
	Mon,  4 Aug 2008 04:06:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8B37448645; Mon,  4 Aug 2008 04:05:58 -0400 (EDT)
In-Reply-To: <20080804075313.21325.28396.stgit@localhost> (Petr Baudis's
 message of "Mon, 04 Aug 2008 09:56:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D501986-61FC-11DD-9C89-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91325>

Petr Baudis <pasky@suse.cz> writes:

> The hash_and_insert_object() and cat_blob() helpers were using
> an incorrect slice-from-ref Perl syntax. This patch fixes that up
> in the _close_*() helpers and make the _open_*() helpers use the
> same syntax for consistnecy.
>
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
>
>   Wow, the command_bidi_pipe API really is dirty. Of course, it is
> my fault as anyone's since I didn't get around to review the patches
> introducing it.

Sorry, delete is still broken with your patch, isn't it?

The earlier patch from Abhijit Menon-Sen does this properly for
close_hash_and_insert and close_cat_blob, which I've queued already.
