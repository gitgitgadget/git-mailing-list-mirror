From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [RFC] rebase: use @{upstream} if no upstream specified
Date: Mon, 15 Nov 2010 18:06:42 -0500
Message-ID: <AANLkTi=sEVHTqWqcdztcEv6kTZgscVYZWr-N0SBMRwvc@mail.gmail.com>
References: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<EDBF4929-2ECF-4CDD-9F0B-0EE3B6BA68A7@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Nov 16 00:06:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI88R-0003zS-RN
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 00:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758109Ab0KOXGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 18:06:45 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38281 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757299Ab0KOXGp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 18:06:45 -0500
Received: by qyk4 with SMTP id 4so15013qyk.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 15:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=oN41gnTlG6wmrPcU5CDwUJ2Ur9Hd3NbSNl83EanG2ac=;
        b=FqKrLakE7d948bND+dUs3a/4dTld+gdYt+LdsggUzyk1akIcuSfXFmso34Jo2Fhk+I
         kZDz5CQeTmMyP6IRn9ORe172Pq7RD0gR3Iqr5g1BvGTrZH4YMTHMLns8HiujlBzRzgJq
         d9rRa4nEfjPt5MJBEEXr5aAPmP5sjKG+yhy8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=b23NKp52mBMmJAouAsfsgIuKqH2sgzuljkra6NBmE6DUpLZXkUpOcYZLrF0AwyC0GB
         pvVNR3r2y6gGxj8g7OoKnAkfkf4Lk4POcqpd5TgUtibNqOHCF+1XHZyCwQxsh7BjfPhi
         Mx09dqKTPJnkRH2zvMZEExoRGBho/CvAYWuts=
Received: by 10.224.191.196 with SMTP id dn4mr5806099qab.225.1289862402945;
 Mon, 15 Nov 2010 15:06:42 -0800 (PST)
Received: by 10.224.138.5 with HTTP; Mon, 15 Nov 2010 15:06:42 -0800 (PST)
In-Reply-To: <EDBF4929-2ECF-4CDD-9F0B-0EE3B6BA68A7@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161522>

On Mon, Nov 15, 2010 at 5:48 PM, Kevin Ballard <kevin@sb.org> wrote:
> On Nov 12, 2010, at 12:55 PM, Martin von Zweigbergk wrote:
>
>> With 'git pull --rebase', the user can configure the upstream repository
>> to fetch from and reference to rebase against if none is specified on
>> the command line.
>>
>> However, if, instead of 'git pull --rebase', the user were to do 'git
>> fetch' followed by 'git rebase', the upstream branch would need to be
>> specified on the command line. This patch teaches 'git rebase' to
>> default to the same configured upstream ref as 'git pull --rebase'
>> uses.
>
> What happens if one were to do `git fetch origin some_other_branch`
> followed by `git rebase`?

Good question. What would happen with my patch is that you would rebase
against your configured uptream.

The requirement to provide the upstream for 'git rebase', but not for
'git pull' was my inspiration, but maybe I should not mention that it
the commit message. So maybe my motivation is flawed, but ignoring that,
do you think it is sensible to default to '@{upstream}'?
