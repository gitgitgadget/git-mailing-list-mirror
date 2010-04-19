From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 14:27:40 +0200
Message-ID: <vpq8w8j1vb7.fsf@bauges.imag.fr>
References: <201004180246.18263.jnareb@gmail.com>
	<20100418005917.GO10939@machine.or.cz>
	<201004180324.54722.jnareb@gmail.com>
	<20100418021223.GP10939@machine.or.cz>
	<n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
	<20100418223120.GB3563@machine.or.cz>
	<u2ve72faaa81004182346zdf4bd0b3m3341717b1555c0a9@mail.gmail.com>
	<vpqeiicey0d.fsf@bauges.imag.fr>
	<7vfx2rsy6y.fsf@alter.siamese.dyndns.org>
	<v2me72faaa81004190038y4aeefa80g9f60bb3b1e795e4b@mail.gmail.com>
	<20100419090734.GA10939@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Apr 19 14:33:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3q9u-0008JH-5C
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 14:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630Ab0DSMc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 08:32:56 -0400
Received: from imag.imag.fr ([129.88.30.1]:50778 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754509Ab0DSMc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 08:32:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o3JCRiXt015390
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 19 Apr 2010 14:27:44 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O3q4i-0001c0-QN; Mon, 19 Apr 2010 14:27:40 +0200
In-Reply-To: <20100419090734.GA10939@machine.or.cz> (Petr Baudis's message of "Mon\, 19 Apr 2010 11\:07\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 19 Apr 2010 14:27:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145292>

Petr Baudis <pasky@suse.cz> writes:

> On Mon, Apr 19, 2010 at 01:08:26PM +0530, Pavan Kumar Sunkara wrote:
>> On Mon, Apr 19, 2010 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > On the other hand, a proposal about giving multiple clients access to
>> > their own individual server-side checkouts (ala "workspace" in DELTA-V)
>> > would require some mechanism to maintain the state on the server end, and
>> > session management would be one ingredient necessary to achieve that.
>
> But what if I will want to give a link to my "workspace" to someone
> else? You can embed workspace id in the URL, in fact you would probably
> just use it instead of project name completely naturally. I still don't
> see any need for sessions.

One use-case I'd like this work to be able to address is:

Many of my colleagues don't want to use Git. If I send them a mail
with the cut-and-paste-ready "git clone" command, they'll still reply
asking for an attachment to an email, and they'll send me their
modifications the same way.

In a good write-enabled web interface, they'd browse the repository
online, pick a file, and the download page would point them to a URL
containing the filename, and the base commit, with a form to upload a
new version of the file.

Some time later, they could re-use the same URL, and upload the
modified version of the file. Actually, I could even do the first step
myself, and send them an email with the attachment and the URL, and
they'd upload their version whenever they want. The upload should
create a commit in a separate branch, starting from the base commit
contained in the URL. I could do the merge myself later in case of
non-fast forward.

That's a real senario, and I believe it would be a rather common
use-case of a web-based git client: a power-user prepares the work,
and sends well-prepared URL to newbies. This really requires GET
parameters.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
