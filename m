From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added mergetool.kdiff3.doubledash config option
Date: Fri, 13 Jun 2008 23:17:51 -0700
Message-ID: <7vhcbwilps.fsf@gitster.siamese.dyndns.org>
References: <7vve0ez8z3.fsf@gitster.siamese.dyndns.org>
 <911589C97062424796D53B625CEC0025E46159@USCOBRMFA-SE-70.northamerica.cexp.com> <20080613145803.GE24675@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Patrick.Higgins@cexp.com, gitster@pobox.com, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Jun 14 08:19:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7P6q-0001S5-2Z
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 08:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbYFNGSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 02:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbYFNGSH
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 02:18:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbYFNGSF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 02:18:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B72673E89;
	Sat, 14 Jun 2008 02:18:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D7ADF3E88; Sat, 14 Jun 2008 02:17:53 -0400 (EDT)
In-Reply-To: <20080613145803.GE24675@mit.edu> (Theodore Tso's message of
 "Fri, 13 Jun 2008 10:58:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A440CD1A-39D9-11DD-8A0A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84962>

Theodore Tso <tytso@mit.edu> writes:

> On Thu, Jun 12, 2008 at 04:44:03PM -0600, Patrick.Higgins@cexp.com wrote:
>> I have found the following to be a way to distinguish the two
>> versions based solely on exit status. The broken one exits with 255.
>> 
>> kdiff3 --auto -o /dev/null -- /dev/null /dev/null
>> 
>> I'll work up another patch that uses this. This check adds about
>> 0.5s overhead. That seems a little high to me, but given that
>> mergetool is interactive, I guess that could be acceptable.
>
> Hmm, do we have a policy about whether or not it is acceptable to
> modify .gitconfig behind the user's back?  It would be nice if the
> check would be done once and then the result gets cached.  So if not
> in .gitconfig, maybe somewhere else.

The reason I suggested either a cheap runtime check or command line
override was because you can be accessing the same repository from two
different machines, with different kdiff3.  If you check once and store
the result in .gitconfig or .git/config, it would not help the situation a
bit, would it?
