From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: git gc =?UTF-8?Q?=3D=3D=20git=20garbage-create=20from=20remov?=
 =?UTF-8?Q?ed=20branch?=
Date: Fri, 04 May 2012 10:58:15 +0200
Message-ID: <7c72f0810ec9647a9835e87ad100b603@ulrik.uio.no>
References: <hbf.20120503q14w@bombur.uio.no> <4FA38731.8010504@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri May 04 10:58:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQELL-000316-6F
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 10:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab2EDI6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 04:58:21 -0400
Received: from mail-out1.uio.no ([129.240.10.57]:51801 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753056Ab2EDI6T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 04:58:19 -0400
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SQELC-0006ev-2E; Fri, 04 May 2012 10:58:18 +0200
Received: from w3prod-wm01.uio.no ([129.240.4.214] helo=webmail.uio.no)
	by mail-mx2.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SQELB-0003QF-Lv; Fri, 04 May 2012 10:58:18 +0200
Received: from bombur.uio.no ([129.240.6.233])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Fri, 04 May 2012 10:58:15 +0200
In-Reply-To: <4FA38731.8010504@op5.se>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 2 msgs/h 1 sum rcpts/h 14 sum msgs/h 2 total rcpts 2404 max rcpts/h 20 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: B795E451F2F5AB6E4D64E44F50F3F5E6634C9990
X-UiO-SPAM-Test: remote_host: 129.240.4.214 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 345 total 2313430 max/h 663 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197007>

 On Fri, 04 May 2012 09:37:21 +0200, Andreas Ericsson <ae@op5.se> wrote:
> On 05/03/2012 08:38 PM, Hallvard Breien Furuseth wrote:
>> After removing a branch, 'git gc' explodes all objects
>> which were only in that branch.  Git filled up my disk that
>> way when I had cherry-picked from a big remote repo and then
>> did git remote rm.  Tested with Git 1.7.10.1 and 1.7.1.
>
> That's by design. It's added to save people who accidentally
> delete a branch or for some other reason really want to keep the
> objects they're about to delete.

 Keeping old objects for a while is by design, which I appreciate.

 Consuming gigabytes of disk space for this is a design bug.  Git should
 pack such objects when they breed too fast, just like other objects.

 If that's a hard design issue to get around, git gc should at least
 catch this and stop unless the user forces gc with some option.
 Users should not need to know that in certain circumstances, gc will
 ravenously eat their disk space without even giving advance notice.

> Use 'git gc --prune=now' with a recent* git and you'll avoid the
> problem.

 I don't want to prune.  Old objects have indeed saved me from
 accidents, as you mention.

 But it's good to know I don't need to throw away the reflog too.
 Thanks.

 Hallvard
