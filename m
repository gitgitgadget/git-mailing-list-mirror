From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Janitors] value could be NULL in config parser
Date: Fri, 08 Feb 2008 22:04:42 -0800
Message-ID: <7v63wyfyx1.fsf@gitster.siamese.dyndns.org>
References: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org>
	<5d46db230802081720x122a807do6c63b6b3e435b4c5@mail.gmail.com>
	<200802090641.20171.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Govind Salinas" <govind@sophiasuchtig.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 07:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNiqz-0000SD-7Y
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 07:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbYBIGFd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Feb 2008 01:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbYBIGFc
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 01:05:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbYBIGFM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 01:05:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DC0871C6E;
	Sat,  9 Feb 2008 01:05:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 612FC1C6D;
	Sat,  9 Feb 2008 01:05:01 -0500 (EST)
In-Reply-To: <200802090641.20171.chriscool@tuxfamily.org> (Christian Couder's
	message of "Sat, 9 Feb 2008 06:41:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73198>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le samedi 9 f=C3=A9vrier 2008, Govind Salinas a =C3=A9crit :
>
>> Question.  Wouldn't it reduce the amount of validation we have to do
>> if whoever is calling back checked null and assigned an empty string=
?
>> If so, we can probably replace all these patches with one patch.
>
> This was discussed in this thread:
>
> http://thread.gmane.org/gmane.comp.version-control.git/72107/
>
> In short we can't do that now, but it may be possible latter, if we f=
irst=20
> deprecate using an empty string as boolean value "false" (while a NUL=
L is=20
> boolean value "true").

It may be the case that many in-tree config parser functions are
sloppy right now.  It however is never an excuse to break user's
existing repositories.
