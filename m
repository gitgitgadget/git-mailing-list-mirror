From: Junio C Hamano <gitster@pobox.com>
Subject: Re: config.c fixes
Date: Fri, 14 Dec 2007 11:43:00 -0800
Message-ID: <7v3au5rrjv.fsf@gitster.siamese.dyndns.org>
References: <20071214192852.GA24187@bitplanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 20:43:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3GRi-00085W-Kz
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 20:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbXLNTnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 14:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbXLNTnT
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 14:43:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbXLNTnT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 14:43:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 29BCD9DF5;
	Fri, 14 Dec 2007 14:43:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 59A199DF2;
	Fri, 14 Dec 2007 14:43:08 -0500 (EST)
In-Reply-To: <20071214192852.GA24187@bitplanet.net> (Kristian =?utf-8?Q?H?=
 =?utf-8?Q?=C3=B8gsberg's?=
	message of "Fri, 14 Dec 2007 14:28:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68332>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> While strace'ing builtin-clone I saw this horror:
> I think the best solution is to just parse up the entire config file
> up front and keep it in a data structure, make the changes and then
> write it all out at the end.

Yeah, that was what I suggested a few times when other people have done
config writing side, but without successfully getting past their skulls
(it is not Linus's nor my code).  It's about time somebody started to
clean up that mess.

The timing is a bit unfortunate, though.  I would have preferred to hav=
e
a week or so to cook this in 'next' before merging it part of -rc0.
