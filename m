From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH (resend)] Let core.excludesfile default to ~/.gitexcludes.
Date: Thu, 26 Nov 2009 14:39:53 +0100
Message-ID: <4B0E8529.3040609@drmicha.warpmail.net>
References: <1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr>	 <1259231726-5218-1-git-send-email-Matthieu.Moy@imag.fr>	 <4B0E6DC9.3070105@drmicha.warpmail.net> <36ca99e90911260501q571929e5l114cb0af9f374a98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 14:41:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDeaq-0006KZ-DY
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 14:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760071AbZKZNk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 08:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760050AbZKZNk4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 08:40:56 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:36871 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759801AbZKZNkz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 08:40:55 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3542AC1D34;
	Thu, 26 Nov 2009 08:41:02 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 26 Nov 2009 08:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=RU4jVMHzob9daCqo2SXkXjfmAbk=; b=Y3wFkl18ysnRSIlLfNoeTHVRYoCDzzEqDYpza7axtHiQTj68b3IuzC2Zrcz+IrD2YpC1P0LneFH3rMKHaWDxkl69zJl52vfhgz4XJ4yZruumouhjydzk8+TsOR3yOFlkkPX82SNiUlmqSJ9j/+3A0wWw3DfqKfN0whMcz+pk89Y=
X-Sasl-enc: h5M11dDFN/KKwUXNS4axqcGXMebUAnpc9CIHMAUSxxkl 1259242861
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5A37972D36;
	Thu, 26 Nov 2009 08:41:01 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <36ca99e90911260501q571929e5l114cb0af9f374a98@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg venit, vidit, dixit 26.11.2009 14:01:
> On Thu, Nov 26, 2009 at 13:00, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Matthieu Moy venit, vidit, dixit 26.11.2009 11:35:
>>> Most users will set it to ~/.gitsomething. ~/.gitignore would conflict
>>> with per-directory ignore file if ~/ is managed by Git, so ~/.gitexcludes
>>> is a sane default.
>>
>> I'm sorry to jump in so late, and this may sound like bike-shedding, but
>> right now we have
>>
>> .git/info/exclude
>> .gitignore
>>
>> and this would add
>>
>> ~/.gitexcludes
>>
>> That is, three terms, or two, where one comes in two variations
>> (exclude/exludes). I always wondered why we have two.
>>
>> The reason for .gitignore is most probably the similarity to
>> .${othervcs}ignore, and that is a valid reason.
>>
>> I know we have ~/.gitconfig for the global version of .git/config, and
>> maybe that was just no good idea either. But I don't even dare
>> suggesting to rename it ~/.gitglobalconfig.
>>
>> So, in line at least with our term "global" (per user) config, I would
>> suggest to use "~/.gitglobalignore" for the global ignore file. Maybe,
>> eventually, we'll manage to rename .git/info/excludes to .git/info/ignore.
>>
>> On a somewhat larger scale, a good alternative strategy would be to have
>> a directory "~/.gitglobal/" in which Git would look for
>> ~/.gitglobal/config and
>> ~/.gitglobal/info/ignore or
>> ~/.gitglobal/ignore
>>
>> i.e. mirroring the repo structure or at least bundling everything in a
>> single dir, which would also be a good place for a global svnauthors
>> file and such, and for other global configuration files we don't think
>> of right now.
> I would vote for that too. Its more future-proof than a single new
> file. Also I would suggest to name this dir ~/.gitrc/. 

Now, that is bike shedding ;)

It seems to me that all ~/.*rc that I have are config files (.bashrc,
.xinitrc...), and all condif subdirs ~/.* are named by the
program/subsystem (.qt, .kde, .gnupg), which we cannot do any more, and
which is why I suggested .gitglobal. But I'd be fine with .gitrc.

> On the other
> hand the --global option to git config specifies the .gitconfig in
> your HOME.

That would have to change (ouch, ducking). Transition plan would be:

~/.gitconfig, ~/.gitrc/config::
        User-specific configuration file. Also called "global"
        configuration file. Git looks in these locations in the
	specified order and uses the first one it finds.

$(prefix)/etc/gitconfig, $(prefix)/etc/gitrc/config::
        System-wide configuration file. Git looks in these locations
	in the specified order and uses the first one it finds.

This would mean no surprises for users with existing config, one could
teach the new preferred locations exclusively, and at some future point
one could phase out the old paths.

Michael
