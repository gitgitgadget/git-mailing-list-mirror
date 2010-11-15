From: Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC] rebase: use @{upstream} if no upstream specified
Date: Mon, 15 Nov 2010 15:16:37 -0800
Message-ID: <1DFC8289-B208-412D-85A2-442714B19861@sb.org>
References: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com> <EDBF4929-2ECF-4CDD-9F0B-0EE3B6BA68A7@sb.org> <AANLkTi=sEVHTqWqcdztcEv6kTZgscVYZWr-N0SBMRwvc@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 00:16:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI8I2-0000Sc-8h
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 00:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758233Ab0KOXQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 18:16:41 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39379 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821Ab0KOXQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 18:16:41 -0500
Received: by ywg8 with SMTP id 8so17144ywg.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 15:16:40 -0800 (PST)
Received: by 10.151.9.8 with SMTP id m8mr10526918ybi.213.1289863000581;
        Mon, 15 Nov 2010 15:16:40 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id h70sm302671yha.46.2010.11.15.15.16.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 15:16:39 -0800 (PST)
In-Reply-To: <AANLkTi=sEVHTqWqcdztcEv6kTZgscVYZWr-N0SBMRwvc@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161525>

On Nov 15, 2010, at 3:06 PM, Martin von Zweigbergk wrote:

> On Mon, Nov 15, 2010 at 5:48 PM, Kevin Ballard <kevin@sb.org> wrote:
>> On Nov 12, 2010, at 12:55 PM, Martin von Zweigbergk wrote:
>> 
>>> With 'git pull --rebase', the user can configure the upstream repository
>>> to fetch from and reference to rebase against if none is specified on
>>> the command line.
>>> 
>>> However, if, instead of 'git pull --rebase', the user were to do 'git
>>> fetch' followed by 'git rebase', the upstream branch would need to be
>>> specified on the command line. This patch teaches 'git rebase' to
>>> default to the same configured upstream ref as 'git pull --rebase'
>>> uses.
>> 
>> What happens if one were to do `git fetch origin some_other_branch`
>> followed by `git rebase`?
> 
> Good question. What would happen with my patch is that you would rebase
> against your configured uptream.
> 
> The requirement to provide the upstream for 'git rebase', but not for
> 'git pull' was my inspiration, but maybe I should not mention that it
> the commit message. So maybe my motivation is flawed, but ignoring that,
> do you think it is sensible to default to '@{upstream}'?

I personally am not in favor of providing a default at all, but if we must,
then @{upstream} is a sensible one. I just think suggesting that this allows
you to split up `git pull --rebase` into `git fetch + git rebase` may be
confusing unless you make it clear that this only applies to an invocation
of `git pull --rebase` that names no branches.

-Kevin Ballard
