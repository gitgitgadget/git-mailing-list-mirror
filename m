From: Simeon Maxein <smaxein@googlemail.com>
Subject: Re: git filter-branch can "forget" directories on case insensitive
 filesystems
Date: Wed, 26 Jan 2011 00:26:58 +0100
Message-ID: <4D3F5C42.4040300@googlemail.com>
References: <AANLkTimOs9m==KaD3BNHcgkTTqNQF1yV0NLA_Ew+iS-N@mail.gmail.com> <4D3F38E9.9060902@googlemail.com> <201101252256.03644.j6t@kdbg.org>
Reply-To: smaxein@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 26 00:27:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhsI5-0006dY-0W
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 00:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753566Ab1AYX1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 18:27:07 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37182 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab1AYX1G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 18:27:06 -0500
Received: by fxm20 with SMTP id 20so383056fxm.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 15:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=gJtF5HgQ+33BAn7FOkR1903708SCDtqgQlbcwf9nMaI=;
        b=PTevqwkR4z5jkwuxZp/Ft4ybimh5LkIfLaK+zQEi2ACwb2RvX3NOxAKe48c1je8fRZ
         Uk8jrNJLn7FtBFvPMBBqpJC2nHhmxA858d84/5BRg3WyOjoErThhKKjaLmB6CdOWGfWv
         TEFWm8IG4vCFq3kB1jz7Wfbjj6HEqnO67ySXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=AxX+iC15ZVgDfJbculjzR/h3agoIYHheJpDVLWV7aQPNt37/SLZNl2mTkr3eQhWsNI
         u0HLv/U4Xmd96v7okLsu3YmFKKpc025KDSIovjkzrWInS3Wv03tRaNnKXuTdgchcj76F
         /gW7AQ8pRDOl8xQok2NB9oUBuPnUTJ3foIE2o=
Received: by 10.223.100.4 with SMTP id w4mr6471593fan.115.1295998024177;
        Tue, 25 Jan 2011 15:27:04 -0800 (PST)
Received: from [192.168.178.27] (kobz-590d7e94.pool.mediaWays.net [89.13.126.148])
        by mx.google.com with ESMTPS id 17sm5297985far.19.2011.01.25.15.27.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 15:27:03 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <201101252256.03644.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165487>

Am 25.01.2011 22:56, schrieb Johannes Sixt:
> On Dienstag, 25. Januar 2011, Simeon Maxein wrote:
>> In my opinion this is a quite serious issue, because files are lost
>> without any indication to the user. As of git 1.7.3.1 (tested on
>> Windows/NTFS with msysGit this time), the problem still exists. Please
>> give it a look. Fullquote of the problem description / steps to
>> reproduce follows.
>>> mkdir testdir
>>> echo 'abc' >testdir/testfile
>>> git add testdir
>>> git commit -m foo
>>> git rm -r testdir
>>> mkdir testDir
>>> echo 'abc' >testDir/testfile
>>> git add testDir
>>> git commit -m bar
> Please retry with current release condidate of 1.7.4; it has some 
> core.ignorecase improvements w.r.t. directories. It could well be that your 
> problem is fixed.
>
> -- Hannes
Thanks for the suggestion. The directory doesn't vanish anymore with
1.7.4, so a big Thank You to the developers for improving this. When
rewriting the second commit ls still prints testdir as lowercase though.
More of a nitpick, but it would still be neat to have it right.

The issue of extra files appearing during filter-branch (
http://article.gmane.org/gmane.comp.version-control.git/154662 ) is
still present.

Simeon
