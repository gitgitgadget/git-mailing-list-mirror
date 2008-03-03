From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to "git add ." when some files are not accessible
 (permission denied)?
Date: Mon, 03 Mar 2008 12:06:35 -0800
Message-ID: <7vmypfh8s4.fsf@gitster.siamese.dyndns.org>
References: <47C95E34.1050306@dirk.my1.cc>
 <20080302011900.GC22843@coredump.intra.peff.net>
 <47CC4EAC.1050905@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon Mar 03 21:08:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWGwn-0000ap-Ex
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 21:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbYCCUGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 15:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754829AbYCCUGr
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 15:06:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610AbYCCUGr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2008 15:06:47 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 196EF31D2;
	Mon,  3 Mar 2008 15:06:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 75FC831D0; Mon,  3 Mar 2008 15:06:38 -0500 (EST)
In-Reply-To: <47CC4EAC.1050905@dirk.my1.cc> (Dirk =?utf-8?Q?S=C3=BCsserott?=
 =?utf-8?Q?'s?= message of "Mon, 03 Mar 2008 20:17:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75980>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

> This way prepared, I used "git ls-files -o | xargs git add -v" until
> most of my files were added.
> ...
> Caveat: filenames containing blanks are not handled properly as they
> are not surrounded by quotes. "git add" thinks of them as two or more
> files and fails.

Perhaps "git ls-files -z -o | git update-index --add --stdin"
