From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git-fast-import doc problem and git-fast-export does not quote
 filenames correctly
Date: Sat, 04 Sep 2010 21:48:58 +0200
Message-ID: <4C82A2AA.3010408@alum.mit.edu>
References: <4C81E461.7010704@alum.mit.edu> <AANLkTimsVQ=mg2EUhUEO5ZWQMZoA72B=p2+1ZA=1qBtn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 21:49:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oryjt-0002sQ-Kp
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 21:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab0IDTtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 15:49:04 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:51002 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029Ab0IDTtC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 15:49:02 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEAB5B.dip.t-dialin.net [84.190.171.91])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o84JmwSJ001533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 4 Sep 2010 21:48:59 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.24) Gecko/20100317 Thunderbird/2.0.0.24 Mnenhy/0.7.6.666
In-Reply-To: <AANLkTimsVQ=mg2EUhUEO5ZWQMZoA72B=p2+1ZA=1qBtn@mail.gmail.com>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155348>

Sverre Rabbelier wrote:
> On Sat, Sep 4, 2010 at 01:17, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> The first problem is that the doc seems to allow NUL bytes (which I
>> suspect are not really allowed)
> 
> Fast import keeps reading until it finds a '\n' and stores data in a
> strbuf, so I don't see why 'NUL' would not be allowed.

I guess I just found it hard to believe that git, with all of its
scripts, would really be able to handle NUL characters in filenames.
Moreover, even if git allows it, I think NUL is prohibited in posix
filenames, so it would be pretty pointless.

In the end, I asked this question to help figure out what filenames
"cvs2git" should allow through to git.  A NUL character could only get
into a CVS filename if the user writes some strange code to transform
the filename, so I guess I don't mind letting it through to git if there
is some chance that git can handle it.

> [...] Backslashes are allowed, and it seems they need to be escaped as
> usual. Perhaps Shawn can confirm that this should just be updated in
> the docs.

Thanks for the info!  Assuming that Shawn doesn't contradict you, I will
let any characters through and quote characters as you suggest.

Michael
