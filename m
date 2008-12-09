From: "Lars Hjemli" <lh@elementstorage.no>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 9 Dec 2008 11:31:50 +0100
Message-ID: <8c5c35580812090231u28076844nf5a9225349c20801@mail.gmail.com>
References: <1228815240.18611.48.camel@starfruit.local>
	 <8c5c35580812090149lc6dd79cj60a9d23c18089557@mail.gmail.com>
	 <1228817565.18611.54.camel@starfruit.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 11:33:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9ztu-00078p-Me
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 11:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbYLIKbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 05:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680AbYLIKbw
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 05:31:52 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:17840 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbYLIKbv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 05:31:51 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1576070rvb.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 02:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=MeZYlovi+cmUw1t4Xc+CtbvghZIhWVEJM0XnKZwtCyA=;
        b=m36PwZwknDBcZ/0fyquyyDf+h/p8D7Aoswwah+zGE3yUj/0KkfTpsQZ3UNpD8WdTDG
         HPHJxP02X9RNDw+ugmpne/Lvb4p9KDLinRcJyQkhGtS5CXmBalG3RW8ype2u2W/sF5bR
         UJBDHW3bFtcdCegJkffFw7ADmjDUO1cvpnls4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=QMWmjRwDGBVmH3pW4j3ReBBbmtDJh1PhecHj2wszYnUZXANFxjK6hh5vGChf3RyHkd
         u+pwjZhd3ORffIiD6bciQRj5qzd1Sy2GTLJxLToqSz/KDEeNqAOT/W510a5t2p0LA++H
         93lVch5YIcwFt5yRbVCJjygytKi099Xj0N4RM=
Received: by 10.114.199.3 with SMTP id w3mr3098218waf.181.1228818710350;
        Tue, 09 Dec 2008 02:31:50 -0800 (PST)
Received: by 10.115.106.12 with HTTP; Tue, 9 Dec 2008 02:31:50 -0800 (PST)
In-Reply-To: <1228817565.18611.54.camel@starfruit.local>
Content-Disposition: inline
X-Google-Sender-Auth: a6357674cbd29077
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102623>

On Tue, Dec 9, 2008 at 11:12, R. Tyler Ballance <tyler@slide.com> wrote:
> On Tue, 2008-12-09 at 10:49 +0100, Lars Hjemli wrote:
>> On Tue, Dec 9, 2008 at 10:34, R. Tyler Ballance <tyler@slide.com> wrote:
>> > Is there a header macro I can define or a config option I could define
>> > to make --no-ff on `git pull` implicit instead of explicit?
>>
>> Try this:
>> $ git config branch.stable.mergeoptions "--no-ff"
>
> I recall stumbling across this a while ago looking at the git-config(1)
> man page, but this isn't /quite/ what we need.
>
> I'm talking about forcing for *every* pull, it's a safe assumption to
> make that we want a merge commit every time somebody fast-forwards a
> branch.

$ git config alias.xpull "pull --no-ff" ?

But are you sure you never want a fast-forward on _any_ branch? I use
--no-ff unconditionally on the master and stable branches as $dayjob,
to make sure that the merging of feature/bugfix-branches are
explicitly noted in history, but I almost never use it on other
branches.

--
larsh
