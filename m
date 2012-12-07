From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Weird problem with git-submodule.sh
Date: Fri, 07 Dec 2012 13:03:30 -0500
Message-ID: <50C22F72.6010701@xiplink.com>
References: <50C22B15.1030607@xiplink.com> <7vvccdhhod.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 19:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th2Gu-000136-A2
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 19:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423658Ab2LGSDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 13:03:20 -0500
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:60521 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423611Ab2LGSDT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 13:03:19 -0500
X-Greylist: delayed 1117 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2012 13:03:19 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp13.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id B50B01980D2;
	Fri,  7 Dec 2012 13:03:21 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp13.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 4EF2019808A;
	Fri,  7 Dec 2012 13:03:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vvccdhhod.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211186>

On 12-12-07 12:54 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> This is with git 1.8.0.1 on all the machines involved.
>>
>> One of our build machines is having trouble with "git submodule":
>> ...
>> Any ideas?
> 
> How and why is the IFS set differently only on one of your build
> machines?

It's not.  On all machines:
	$ set | grep IFS
	IFS=$' \t\n'

As I said, if I isolate the module_list() function into another script it
works fine, with the exact same environment that breaks in git-submodule.sh.

Also, note that at the top of git-submodule there's
	. git-sh-setup
which does
	unset IFS

		M.
