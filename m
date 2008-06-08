From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix attribute handling in bare repositories
Date: Sun, 08 Jun 2008 13:46:05 -0700
Message-ID: <7vskvnirjm.fsf@gitster.siamese.dyndns.org>
References: <fcaeb9bf0806070821r5ba650c2x1fef7947fc4a2de5@mail.gmail.com>
 <484BF7BB.1090802@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 08 22:47:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5RnT-0001gW-Ft
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 22:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469AbYFHUqO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 16:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbYFHUqO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 16:46:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449AbYFHUqN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jun 2008 16:46:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B5A13CDE;
	Sun,  8 Jun 2008 16:46:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C206B3CDC; Sun,  8 Jun 2008 16:46:08 -0400 (EDT)
In-Reply-To: <484BF7BB.1090802@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Sun, 08 Jun 2008 17:16:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE34993E-359B-11DD-BA6F-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84316>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Nguyen Thai Ngoc Duy schrieb:
>> Hi,
>>=20
>> Currently attr.c will read .gitattributes on disk no matter there is=
 a
>> real worktree or not. This can lead to strange behavior.
>
> Yes, it probably shouldn't do that.  What about this patch?

Hmm.  I do not know if it breaks anything, but if you are indeed in a b=
are
repository, the files the codepaths affected try to read would not exis=
t
anyway, so I am not sure what this would fix, other than changing the
behaviour of check-attr from noticing that it was asked for nonsense an=
d
bail out to not noticing nor saying anything useful.
