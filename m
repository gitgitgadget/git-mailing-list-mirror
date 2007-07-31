From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Add test case for basic commit functionality.
Date: Mon, 30 Jul 2007 21:18:26 -0700
Message-ID: <7vodhtgq99.fsf@assigned-by-dhcp.cox.net>
References: <11858309261111-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 06:18:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFjCC-0004nn-87
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 06:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551AbXGaESb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 00:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbXGaESa
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 00:18:30 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44099 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551AbXGaES3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 00:18:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070731041829.WATJ26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 31 Jul 2007 00:18:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id W4JU1X00o1kojtg0000000; Tue, 31 Jul 2007 00:18:29 -0400
In-Reply-To: <11858309261111-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Mon, 30 Jul 2007 17:28:42 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54318>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> +# Pick a date so we get consistent commits. 7/7/07 means good luck!
> +export GIT_AUTHOR_DATE=3D"July 7, 2007"
> +export GIT_COMMITTER_DATE=3D"July 7, 2007"

Other scripts use test_tick for consistent commits; just to let
you know, the above is as good if you intend to use only one
timestamp.

> +echo "bongo bongo" >file
> +test_expect_success \
> +	"initial status" \
> +	"git-add file && \
> +	 git-status | grep 'Initial commit'"

We tend to prefer to have the "create testfile" part also in the
test.

> +test_expect_failure \
> +	"fail initial amend" \
> +	"git-commit -m initial --amend"

Does it fail because it is initial, or because these two
options, "-m <msg>" and "--amend", are incompatible?

> +echo "bongo bongo bongo" >file

Ditto.

> +cat >msg <<EOF
> +	=09
> +
> + =20
> +Signed-off-by: hula
> +EOF

=2E.. except <<here text are left outside of test_expect_success
because there were reports that some shells cannot grok here
text in eval correctly.
