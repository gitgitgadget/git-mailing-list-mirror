From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: libreoffice merge(tool?) issue #3 ... (bogus)
Date: Fri, 25 Feb 2011 11:08:24 +0100
Message-ID: <4D677F98.7080502@drmicha.warpmail.net>
References: <1298388877.32648.171.camel@lenovo-w500>	 <993F66D7-7659-4AA5-9931-1EB66CAA01DB@silverinsanity.com> <1298565560.32648.258.camel@lenovo-w500>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org,
	kendy@novell.com, Norbert Thiebaud <nthiebaud@gmail.com>
To: michael.meeks@novell.com
X-From: git-owner@vger.kernel.org Fri Feb 25 11:11:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsueN-00037s-Ft
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 11:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512Ab1BYKLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 05:11:45 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57611 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932495Ab1BYKLo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 05:11:44 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CB1DC200FC;
	Fri, 25 Feb 2011 05:11:43 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 25 Feb 2011 05:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=QIa/3Gtyw5P+DbMXCJ43QSTJ+DA=; b=MSFlkg+v/GEmvL8k+8SXv8RLaDjRMhEjqHPwVp+nbPZULpOj4nKtaKqkba7YUljY1pwmwg+iYbttTKJGI+vjIxz8ft585dBgZJpw+BEfVzm+P3TD2VtPhtf/ECE6ucMrQyyv63cWBc6Mo08IwBu/vcTrWULCWU7l8AHdbW8HL/w=
X-Sasl-enc: 4uK7ZfFxLxHvfAlMJGsMkknkSjSzCMEWeSeU5xaLpcn/ 1298628703
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E883844847A;
	Fri, 25 Feb 2011 05:11:42 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <1298565560.32648.258.camel@lenovo-w500>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167896>

Michael Meeks venit, vidit, dixit 24.02.2011 17:39:
> Hi Brian,
> 
> 	First - it seems that the issue here was entirely bogus, not least
> because we had a bug with re-writing these makefiles as we checked them
> in; so hopefully only 2 issues pending ;-)
> 
> 	Anyhow - I tried your kind advice:
> 
> On Tue, 2011-02-22 at 10:55 -0500, Brian Gernhardt wrote:
>> FYI: `git clone foo bar` will use hard-links to copy the object
>> files and is both very fast and space efficient.  (See the
>> description of `--local` in git-clone(1), which is used by
>> default for local repositories since git 1.5.3.)  It's also
>> guaranteed to work while the correctness of `cp -lR` depends
>> on implementation details of git.
> 
> 	Sounds like just what I need. Unfortunately, it didn't clone some of
> the pieces I needed; eg. other configured remotes, I ended up with just
> 'origin' - which was unexpected (and less wonderful than cp -lR ;-).
> 
> 	Is that a feature ?

Yes, because by cloning someone else's config they could make you do
what they want (alias...).

I think in your case you can just copy over the .git/config and maybe
set up "alternates" so that you don't have to refetch the remote objects
which are not referenced by local refs. (Alternatively, clone --mirror,
then copy over config and turn into non bare.)

Maybe we do need "clone --copy" or something as a safe version of "cp -al"?

Michael
