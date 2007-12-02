From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-merge --no-commit commits
Date: Sun, 2 Dec 2007 19:00:09 +0100
Message-ID: <200712021900.10295.jnareb@gmail.com>
References: <19f34abd0712020857m757c57cfr358a81e47f38fac8@mail.gmail.com> <m3bq99vx7t.fsf@roke.D-201> <19f34abd0712020918w1640389kb0ca006b2051a678@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Vegard Nossum" <vegard.nossum@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 19:00:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyt7Q-0007Ov-Fj
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 19:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbXLBSAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 13:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbXLBSAQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 13:00:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:32386 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbXLBSAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 13:00:14 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2547660nfb
        for <git@vger.kernel.org>; Sun, 02 Dec 2007 10:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=AOOrCmi+3NnzUszT4MUBc4hNVdEcvh0o1vDVIO0c2Us=;
        b=TnemyelLycc1igk/Hkp1Hr6jxe555ySsPlWguJK1iMIzzIMVTJ2KyCr39WbtDAIJ/OB/GAbdCJd4bZ8hvkc87Zwykn+W3IK7S/IZd6RsFZm7kuvOqPb3lr0/pqTBW3hBtP3zmcih8uZ9/7N8A6cgIYEb8onSqac6bhidOKrmWEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=x3v7FwxvlIs/PSzy0c1rjl1GGswonQ2or+XP3SAOu4KOxB7WDnHHMN1MavYPzr2M83SNfgVfVAuB8kP5miUeW62epsP7yhPKFONZlFB+wy69+q74Aw28DYoYb7Hj+YRRcoEoGeGMeqzvnEyR5rFP+Jx/9BgfRkK3MfSXjuUnGus=
Received: by 10.86.89.4 with SMTP id m4mr9698933fgb.1196618412751;
        Sun, 02 Dec 2007 10:00:12 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.251.146])
        by mx.google.com with ESMTPS id l19sm10895867fgb.2007.12.02.10.00.10
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Dec 2007 10:00:11 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <19f34abd0712020918w1640389kb0ca006b2051a678@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66803>

On Sun, 2 Dec 2007, Vegard Nossum wrote:
> On Dec 2, 2007 6:10 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> "Vegard Nossum" <vegard.nossum@gmail.com> writes:
>>
>>> I am using git 1.5.3.4 and just did the following (v1 and v2 are
>>> branches; v1 is a parent of v2):
>>>
>>> git checkout v1
>>> git merge --no-commit v2
>>>
>>> It simply fast-forwarded AND committed even though I explicitly told
>>> it not to. What gives?
>>
>> The --no-commit option doesn't prevent fast-forward because
>> fast-forward doesn't really _create_ a commit (and -no-commit is
>> really about commit creation). It just advanced ref (branch head).
>>
>> You probably wanted to use
>>
>>   $ git merge --no-commit --no-ff v2
> 
> Yes. Thanks. Isn't that counter-intuitive, though? The manpage says
> that it lets you review the changes first. I assumed this would
> include fast-forwarding as well. 

But for fast-forward there are no "changes" to review. Just updating
branch head. Fast-forward means no new commit.

> There is no --no-ff in my git-merge 
> manpage. Maybe I need a newer version?

It looks like it is not in any released version. I've found description
in 'master' version of Documentation/merge-options.txt
-- 
Jakub Narebski
Poland
