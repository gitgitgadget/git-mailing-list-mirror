From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t4109-apply-multifrag.sh problem on solaris -- looks like
 problem w/ solaris patch cmd
Date: Tue, 04 Mar 2008 11:32:20 -0800
Message-ID: <7v3ar670aj.fsf@gitster.siamese.dyndns.org>
References: <8ec76080803040822n5e463b50sff6639777246de7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Whit Armstrong" <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 20:33:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWcsu-0005NX-13
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 20:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760874AbYCDTca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 14:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758330AbYCDTca
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 14:32:30 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760160AbYCDTc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 14:32:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1157E3441;
	Tue,  4 Mar 2008 14:32:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 81A383440; Tue,  4 Mar 2008 14:32:23 -0500 (EST)
In-Reply-To: <8ec76080803040822n5e463b50sff6639777246de7b@mail.gmail.com>
 (Whit Armstrong's message of "Tue, 4 Mar 2008 11:22:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76130>

"Whit Armstrong" <armstrong.whit@gmail.com> writes:

> * expecting success: git apply patch1.patch patch2.patch patch3.patch
> *   ok 4: S = git apply (2)
>
> * expecting success: cat patch1.patch patch2.patch patch3.patch | patch -p1
> patching file main.c
> patching file main.c
> patching file main.c
> *   ok 5: S = patch (2)
> ...
>
> Is the answer to use GNU patch? Or is there a trick to make the
> Solaris version of patch work?

If we are reasonably sure that we will not be needing to change these test
vectors (and because "git apply" is now solid, I think we are), I think
the best way to address this is to prepare a new t/t4109 directory, store
the expected output in there, and compare output from "git apply" that is
being tested with the precomputed test vectors.


