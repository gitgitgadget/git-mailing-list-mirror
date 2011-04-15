From: Avner <avnermoshkovitz@lighthauslogic.com>
Subject: Re: [1.8.0] perl/Git.pm: moving away from using Error.pm module
Date: Fri, 15 Apr 2011 16:35:45 -0700 (PDT)
Message-ID: <1302910545319-6277964.post@n2.nabble.com>
References: <201102202346.36410.jnareb@gmail.com> <7v4o7xluph.fsf@alter.siamese.dyndns.org> <4D624632.80904@letterboxes.org> <AANLkTimwhYwQz9W3tAa2=Q0nJY8AoZYq=7KeX5O2Ca_G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 01:35:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAsYK-00083y-Bl
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 01:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273Ab1DOXfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 19:35:46 -0400
Received: from sam.nabble.com ([216.139.236.26]:59656 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab1DOXfp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 19:35:45 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <avnermoshkovitz@lighthauslogic.com>)
	id 1QAsYD-0004gp-AX
	for git@vger.kernel.org; Fri, 15 Apr 2011 16:35:45 -0700
In-Reply-To: <AANLkTimwhYwQz9W3tAa2=Q0nJY8AoZYq=7KeX5O2Ca_G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171648>

Using the packages Exception::Class and Carp together, compete to set the
eval_error variable ($@)
For example, throwing an object (of type Exception::Class) can result in the
eval_error variable ($@) getting a scalar type after the eval statement if
the Carp is fast enough to set a string (of type scalar) that contains the
error stack.
The result is that following the eval statement the catch sees a different
type than what it expects and does not react as planned.

Avi


--
View this message in context: http://git.661346.n2.nabble.com/1-8-0-perl-Git-pm-moving-away-from-using-Error-pm-module-tp6046799p6277964.html
Sent from the git mailing list archive at Nabble.com.
