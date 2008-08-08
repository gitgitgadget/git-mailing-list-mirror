From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Teach git diff-tree --stdin to diff trees
Date: Fri, 08 Aug 2008 14:22:45 -0700
Message-ID: <7vk5erb3ru.fsf@gitster.siamese.dyndns.org>
References: <20080808204348.7744.46006.stgit@yoghurt>
 <20080808204829.7744.11661.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 23:24:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRZRH-0007sp-Dc
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 23:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbYHHVW5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 17:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbYHHVW5
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 17:22:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbYHHVW4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Aug 2008 17:22:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 628224D01B;
	Fri,  8 Aug 2008 17:22:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9C4374D019; Fri,  8 Aug 2008 17:22:48 -0400 (EDT)
In-Reply-To: <20080808204829.7744.11661.stgit@yoghurt> (Karl =?utf-8?Q?Has?=
 =?utf-8?Q?selstr=C3=B6m's?= message of "Fri, 08 Aug 2008 22:48:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A82E5CA-6590-11DD-B35D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91718>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> In addition to accepting lines with one or more commits, it now
> accepts lines with precisely two trees.

Hmm, slightly dissapointed (I actually was hoping you would also handle
more than two trees and run -m or -c or --cc on them).

"On the command line, you can give exactly two trees, not three nor one=
;
this two-tree form is now also supported in --stdin mode." --- that
justfication sounds like a good one (and that is why my dissapointment =
is
only "slight").

But the following two sentences are a bit confusing, especially it is
unclear what "This" refers to in the last sentence.

> When diffing trees, the -m, -s, -v, --pretty, --abbrev-commit,
> --encoding, --no-commit-id, -c, --cc, and --always options are
> ignored, since they do not apply to trees. This is the same behavior
> you get when specifying two trees on the command line instead of with
> --stdin.

Perhaps swap the sentences in the log message like this?

  When feeding trees on the command line, you can give exactly two tree=
s,
  not three nor one; --stdin now supports this "two tree" form on its
  input, in addition to accepting lines with one or more commits.

  When diffing trees (either specified on the command line or from the
  standard input), the -m, -s, -v, --pretty, --abbrev-commit, --encodin=
g,
  --no-commit-id, -c, --cc, and --always options are ignored, since the=
y
  do not apply to trees.

Thanks, now we can update that documentation change.
