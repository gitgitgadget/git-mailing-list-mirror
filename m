From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] for-each-ref: `:short` format for `refname`
Date: Wed, 03 Sep 2008 11:36:04 -0700
Message-ID: <7vtzcxaxgr.fsf@gitster.siamese.dyndns.org>
References: <36ca99e90809030133r43fc5a3agad1aa38339a758a3@mail.gmail.com>
 <1220431352-30605-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 20:37:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaxEH-0002aH-6x
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 20:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbYICSgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 14:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbYICSgO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 14:36:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbYICSgN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 14:36:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A66495B293;
	Wed,  3 Sep 2008 14:36:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E17835B290; Wed,  3 Sep 2008 14:36:06 -0400 (EDT)
In-Reply-To: <1220431352-30605-1-git-send-email-bert.wesarg@googlemail.com>
 (Bert Wesarg's message of "Wed, 3 Sep 2008 10:42:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E919934-79E7-11DD-A3B6-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94833>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Try to shorten the refname to a non-ambiguous name.
>
> Changes in v3:
>  * don't compare sha1's, its ambiguous if the short name
>    resovles to more than one ref
>  * use xstrdup()
>  * use indexes for the loops to clarify backward/forward
>    direction

Please don't do "Changes in v3" in the commit log message; do so after
"---" is very welcome as it gives people on the discussion _right now_
to understand the context of the change.

Also please do not omit discussion in the commit log message, to help
people _not_ on the discussion right now.

Your earlier versions will not appear on the history anywhere, and v3 is
the _only_ variant available to the people who need to understand what
this change was made for and why the code to implement the change was done
in the way the patch shows.  Write your commit log message to help people
who have "git show $this" and nothing else to figure these things out in
year 2010.

Namely:

 * Why "shortening" is a good thing?  For what use case this new feature
   was invented for?

 * What are the definitions of "shortening" and "non-ambiguous" in this
   feature's context?

In addition, for a complex feature with different possiblilities, it is a
good practice to describe what alternatatives and pros-and-cons among them
were considered while reaching this final version.  This is to help people
who would want to explore enhancement possibilities later; you beforehand
warn them about dead ends you have already explored.  For this particular
patch/feature, I do not think it is necessary, though.
