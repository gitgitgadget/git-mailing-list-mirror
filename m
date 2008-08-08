From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Enable parallel tests
Date: Fri, 08 Aug 2008 01:28:21 -0700
Message-ID: <7vprojgbbu.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <489BF95F.1070000@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Aug 08 10:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRNLq-0005rd-8L
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 10:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbYHHI2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 04:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYHHI2b
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 04:28:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbYHHI2b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Aug 2008 04:28:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 827C8599D3;
	Fri,  8 Aug 2008 04:28:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CDD89599D2; Fri,  8 Aug 2008 04:28:24 -0400 (EDT)
In-Reply-To: <489BF95F.1070000@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Fri, 08 Aug 2008 09:44:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FAB1FD5C-6523-11DD-8E2E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91633>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> test=3D"trash directory/$this_test"?
>
> The advantage would be that all trash was still inside "trash
> directory".  Not sure if the extra directory level would break
> something.  (Note: $this_test is defined a bit later in the script.)

The extra directory level may break some tests that refer to their
precomputed test vectors in ../tXXXX, but I think they should be fixed
regardless.  That's what $TEST_DIRECTORY is for.

I'd very much prefer having 't/trash directory/t1234-test-name/' so tha=
t
we can say "make clean" to clean "t/trash directory" in one go.
