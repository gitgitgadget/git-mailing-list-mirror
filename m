From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [PATCH] send-email: confirm on empty mail subjects
Date: Tue, 25 Aug 2009 18:27:48 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0908251825150.21065@fbirervta.pbzchgretzou.qr>
References: <1249490994-23455-1-git-send-email-jengelh@medozas.de> <7vhbwlpigo.fsf@alter.siamese.dyndns.org> <alpine.LSU.2.00.0908241927300.5382@fbirervta.pbzchgretzou.qr> <7v1vn1gjlp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 18:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfysJ-0008VF-9T
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 18:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbZHYQ1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 12:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755151AbZHYQ1s
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 12:27:48 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:60177 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074AbZHYQ1r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 12:27:47 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 906891B7C4; Tue, 25 Aug 2009 18:27:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 89AD04040F1B;
	Tue, 25 Aug 2009 18:27:48 +0200 (CEST)
In-Reply-To: <7v1vn1gjlp.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127028>


On Montag 2009-08-24 20:19, Junio C Hamano wrote:
>>>
>>>> When the user forgot to enter a subject in a compose session,
>>>> send-email will now inquire whether this is really intended, similar
>>>> to what the Alpine MUA does when a subject is absent.
>>>
>>>This seems to break t9001...
>>
>> Did I miss something in building?
>>
>> 19:26 sovereign:../git/git-1.6.4.1 > quilt pu
>> Applying patch patches/send-email-empty-subject.diff
>> patching file git-send-email.perl
>
>Is this using 'pu' with your patch?

Ah no, `quilt pu` is an autoalias for `quilt push`.

>Near the tip of the 'pu' branch I
>have a iffy workaround to "unbreak" the issue, but it is a rather
>sledgehammer approach I do not feel comfortable enough to squash into your
>patch yet.

I see. Perhaps

	echo -en 'y\ny\n' | ...

would be more gentle? (Noting that, how else should it be,
many a shell do not have -e/-n again.)
