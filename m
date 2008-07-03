From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Git looks for repository in wrong directory
Date: Wed, 02 Jul 2008 17:31:35 -0700
Message-ID: <7vtzf76c60.fsf@gitster.siamese.dyndns.org>
References: <200807030216.28921.bombe@pterodactylus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?utf-8?B?4oCYQm9tYmXigJk=?= Roden <bombe@pterodactylus.net>
X-From: git-owner@vger.kernel.org Thu Jul 03 02:32:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KECkZ-0005bN-9F
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 02:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYGCAbn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2008 20:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbYGCAbn
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 20:31:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbYGCAbm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jul 2008 20:31:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 20ABBA324;
	Wed,  2 Jul 2008 20:31:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 76A73A323; Wed,  2 Jul 2008 20:31:38 -0400 (EDT)
In-Reply-To: <200807030216.28921.bombe@pterodactylus.net> (David
 =?utf-8?B?4oCYLiBCb21iZeKAmQ==?= Roden's message of "Thu, 3 Jul 2008 02:16:26
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 67E3B5A4-4897-11DD-89E8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87213>

David =E2=80=98Bombe=E2=80=99 Roden  <bombe@pterodactylus.net> writes:

> git clone r1 r1.git
> cd r1
> echo b > b
> git add b
> git commit -m "b"
> cd ..
> git ls-remote r1
> git ls-remote r1/.
>
> shows that Git searches for a repository in the wrong place. I think =
the last=20
> two commands should output exactly the same but "git ls-remote r1" ac=
tually=20
> lists the contents of "r1.git". Is that a bug or is this (extremely=20
> confusing) behaviour intended?

This is age old usability feature that lets you say "ls-remote r1" even
when you do *not* have "r1.git", and is not limited to the local file
transport but also applicable when peeking a remote repository over the
native transport.

If you have both, you already have found the way to disambiguate ;-)
