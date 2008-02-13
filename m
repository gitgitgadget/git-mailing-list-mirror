From: Junio C Hamano <gitster@pobox.com>
Subject: Re: setup_path()
Date: Wed, 13 Feb 2008 12:00:40 -0800
Message-ID: <7v3arwpqxj.fsf@gitster.siamese.dyndns.org>
References: <20080213.044915.123319879.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Wed Feb 13 21:01:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPNnf-0008DO-To
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 21:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759303AbYBMUBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 15:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404AbYBMUBH
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 15:01:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbYBMUBF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 15:01:05 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 51A71412A;
	Wed, 13 Feb 2008 15:01:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 960B44126; Wed, 13 Feb 2008 15:00:59 -0500 (EST)
In-Reply-To: <20080213.044915.123319879.davem@davemloft.net> (David Miller's
 message of "Wed, 13 Feb 2008 04:49:15 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73817>

David Miller <davem@davemloft.net> writes:

> Shouldn't stand-alone programs other than git.c itself also call
> setup_path()?
>
> I have a problem where if I only install git into my own home
> directory ~/bin, I can't send pull requests over SSH to that machine
> successfully because the execvp() of "pack-objects" by git-upload-pack
> fails due to the PATH not containing "git --exec-dir"
>
> If I add a dummy setup_path(NULL) call to upload-pack.c, it works
> fine.

Yeah, Johannes Sixt had a patch to do exactly that earlier

	Message-ID: <47B182C1.60006@viscovery.net>
	http://news.gmane.org/gmane.comp.version-control.git/73651

and I think it is a good idea to apply it.
