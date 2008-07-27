From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: Don't require tmp_obj_ file names are 14 bytes in
 length
Date: Sat, 26 Jul 2008 21:15:23 -0700
Message-ID: <7vwsj83quc.fsf@gitster.siamese.dyndns.org>
References: <6ruv3Y98_kSSVnJFTkV0PNdiNcQ3g-a3M4BhGoT7S1PorElp5tJAkw@cipher.nrlssc.navy.mil> <20080727023300.GB17425@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 06:16:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMxgN-0007mJ-95
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 06:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbYG0EPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 00:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbYG0EPb
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 00:15:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbYG0EPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 00:15:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8C4C433776;
	Sun, 27 Jul 2008 00:15:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BD3B833772; Sun, 27 Jul 2008 00:15:25 -0400 (EDT)
In-Reply-To: <20080727023300.GB17425@spearce.org> (Shawn O. Pearce's message
 of "Sat, 26 Jul 2008 21:33:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A5C71100-5B92-11DD-A0A6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90306>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>   Brandon Casey <casey@nrlssc.navy.mil> wrote:
>   > Since 5723fe7e, temporary objects are now created in their final destination
>   > directories, rather than in .git/objects/. Teach fsck to recognize and
>   > ignore the temporary objects it encounters, and teach prune to remove them.
>
>   jgit can't exactly follow the 14 character naming rule.
>   This should be a safe way around it.

More importantly, we might want to change the temporary filename to ensure
that it is 38 bytes in length in the future (cf. $gmane/85106).
