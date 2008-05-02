From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-bisect.sh: don't accidentally override existing
 branch "bisect"
Date: Fri, 02 May 2008 10:38:08 -0700
Message-ID: <7v8wysy5bz.fsf@gitster.siamese.dyndns.org>
References: <20080430164613.28314.qmail@b31db398e1accc.315fe32.mid.smarden.org>
 <20080502082232.GA20020@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri May 02 19:39:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrzE1-0003xU-AS
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 19:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759122AbYEBRiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 13:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758232AbYEBRiY
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 13:38:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245AbYEBRiX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 13:38:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F6314FCE;
	Fri,  2 May 2008 13:38:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B07DB4FC8; Fri,  2 May 2008 13:38:18 -0400 (EDT)
In-Reply-To: <20080502082232.GA20020@diana.vm.bytemark.co.uk> (Karl
 =?utf-8?Q?Hasselstr=C3=B6m's?= message of "Fri, 2 May 2008 10:22:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8F870E66-186E-11DD-B32A-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81013>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2008-04-30 16:46:13 +0000, Gerrit Pape wrote:
>
>> If a branch named "bisect" or "new-bisect" already was created in
>> the repo by other means than git bisect, doing a git bisect used to
>> override the branch without a warning. Now if the branch "bisect" or
>> "new-bisect" already exists, and it was not created by git bisect
>> itself, git bisect start fails with an appropriate error message.
>> Additionally, if checking out a new bisect state fails due to a
>> merge problem, git bisect cleans up the temporary branch
>> "new-bisect".
>
> Makes me wonder why bisect has to use a branch at all, and not just a
> detached HEAD ... I seem to recall this having been discussed before,
> but I can't find it now.

Only because the mechanism predates detached HEAD and no other reason.
Whoever wants to update it to use detached HEAD needs to design what
should happen when the bisection was started while the HEAD is detached
(should we come back to the same HEAD?  how? ...), but other than that =
I
do not offhand see fundamental difficulties.
