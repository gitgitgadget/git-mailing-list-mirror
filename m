From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] custom strategies in builtin-merge
Date: Fri, 25 Jul 2008 17:33:17 -0700
Message-ID: <7viqutpjqq.fsf@gitster.siamese.dyndns.org>
References: <20080725113316.GF32057@genesis.frugalware.org>
 <bd6139dc0807250450m25a932b8h68fcee13f8c343dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sat Jul 26 02:34:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMXjt-00011T-Cz
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 02:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbYGZAdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 20:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbYGZAdZ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 20:33:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbYGZAdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 20:33:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C460B3BC03;
	Fri, 25 Jul 2008 20:33:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 479233BBFF; Fri, 25 Jul 2008 20:33:19 -0400 (EDT)
In-Reply-To: <bd6139dc0807250450m25a932b8h68fcee13f8c343dc@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri, 25 Jul 2008 13:50:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 752EE7CC-5AAA-11DD-980B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90138>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> On Fri, Jul 25, 2008 at 13:33, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> 1) Maintain a list of commands that has a git-merge- prefix, but not a
>> strategy. This list would currently contain "base, file, index,
>> one-file and tree".
>
> Sounds a bit error prone, and could lead to unexpected results if/when
> someone creates a new command ('git merge status' anyone?) which is
> then suddenly treated as a merge strategy.
>
>> 2) Require custom strategies to have a different naming scheme, like
>> if "foo" is a custom strategy, then it would have to be named
>> git-merge-custom-foo, _not_ git-merge-foo.
>
> I think this is cleaner, what would be even nicer is to change the
> current names too, so name them all "git-merge-stragegy-foo".

I think you could retroactively impose "git-merge-strategy-" prefix rule
and grandfather the existing ones by maintaining a list of them that by
definition will not grow anymore.
