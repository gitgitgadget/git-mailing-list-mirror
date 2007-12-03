From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Open external merge tool with original file extensions in all three files
Date: Mon, 03 Dec 2007 10:17:23 -0800
Message-ID: <7v63zfiqx8.fsf@gitster.siamese.dyndns.org>
References: <1196695874-22567-1-git-send-email-pinir@expand.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pini Reznik <pinir@expand.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:17:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFre-0007cx-Oe
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbXLCSR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbXLCSR2
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:17:28 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34520 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbXLCSR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:17:28 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B28422FA;
	Mon,  3 Dec 2007 13:17:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 502B49C7A6;
	Mon,  3 Dec 2007 13:17:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66940>

Pini Reznik <pinir@expand.com> writes:

> This required to be able to use syntax highlighting in meld during
> conflicts resolution....

> +    extension=`echo $path | awk -F \. '{print $NF}'`
> +    BACKUP="$path.BACKUP.$$.${extension}"
> +    LOCAL="$path.LOCAL.$$.${extension}"
> +    REMOTE="$path.REMOTE.$$.${extension}"
> +    BASE="$path.BASE.$$.${extension}"

I had to wonder what would happen in these cases:

 * path = "a/b/c/d"
 * path = "a/b.c/d"

I also think spawning awk for this is way overkill.
