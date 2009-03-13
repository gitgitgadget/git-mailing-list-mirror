From: Junio C Hamano <gitster@pobox.com>
Subject: Re: newb: Given a commit id, find which branches have it as an
 ancestor
Date: Fri, 13 Mar 2009 00:37:21 -0700
Message-ID: <7v3adhj2ku.fsf@gitster.siamese.dyndns.org>
References: <63BEA5E623E09F4D92233FB12A9F794302E0F9B2@emailmn.mqsoftware.com>
 <63BEA5E623E09F4D92233FB12A9F794302E0F9BA@emailmn.mqsoftware.com>
 <49BA07E5.2080701@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kelly F. Hickel" <kfh@mqsoftware.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 13 08:39:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li1yu-0000Tf-Mj
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 08:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbZCMHhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 03:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbZCMHhb
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 03:37:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55085 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbZCMHha (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 03:37:30 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ABF439D556;
	Fri, 13 Mar 2009 03:37:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 534AA9D553; Fri,
 13 Mar 2009 03:37:23 -0400 (EDT)
In-Reply-To: <49BA07E5.2080701@viscovery.net> (Johannes Sixt's message of
 "Fri, 13 Mar 2009 08:14:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CDE87C64-0FA1-11DE-B0AE-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113150>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Your best bet is perhaps that you create a branch at the commit
>
>   $ git branch tmp-branch your_sha1
>
> so that the commits are not lost, then you cherry-pick them to master.

It could be that there are more commits that are built on top of the one
you are aware of.  Finding unreachable commits from "git fsck --full"
might help you find them.
