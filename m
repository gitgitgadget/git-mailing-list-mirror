From: Ittay Dror <ittay.dror@gmail.com>
Subject: Re: connecting existing local git repository to svn
Date: Tue, 27 Jan 2009 14:48:00 +0200
Message-ID: <497F0280.2070400@gmail.com>
References: <497E8927.1060506@gmail.com>	 <497EE386.5050805@drmicha.warpmail.net> <497EE4E8.8070705@gmail.com> <bd6139dc0901270416u22b60fefp472935470b1db929@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 13:49:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRnOB-0007Zu-2w
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 13:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbZA0Mse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 07:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbZA0Mse
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 07:48:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:21437 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbZA0Msd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 07:48:33 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1157376nfc.21
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 04:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=k97MPNY92HhfUwZ4qNJPC2+t3q/YeV6ETmEHjt5Pcuc=;
        b=MI76+3FW8XEju/5Y0VLDBtQleVTLb84V0jnE/QZ4dYmspKO8tfOFY9MtHiUtxl/BIl
         aeW1xPV7uykBvjzs9Pn0YfWcjBlmesjhcRh5Emb3IqA5xsh9Gwk8ku/z0E9olhHauEnx
         zw6UyN4A5E7mlECZKvQbzETNBAHLW9Y1KBlCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=D4S/gbfUh2qFK3Dn3hTe7KJI6CpFMYCw6aHOaEFzRiszHIwSxybmDxUE7pKqEOUCBS
         HuGMsqmTbKXoZB4YTTdTAh2Q7/gwnjWWmvzQSObuxcftgb/iywiaU9K1J6i/xDiAQ9xf
         T84JVoNLRtClHvpMzcMf604ZiyDor82onh300=
Received: by 10.210.58.13 with SMTP id g13mr1820673eba.196.1233060511522;
        Tue, 27 Jan 2009 04:48:31 -0800 (PST)
Received: from ?10.10.2.8? ([212.143.191.180])
        by mx.google.com with ESMTPS id i3sm28816303nfh.0.2009.01.27.04.48.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 04:48:30 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <bd6139dc0901270416u22b60fefp472935470b1db929@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107340>



Sverre Rabbelier wrote:

> On Tue, Jan 27, 2009 at 11:41, Ittay Dror <ittay.dror@gmail.com> wrote:
>   
>> git: ----v1----v2----v3--v4---v5
>> svn:                     \---v4--v5
>>
>> so the svn history starts from v3, but the git history remains unchanged.
>>     
>
> Create the new branch from v3 then, and use git svn to pull it in.
> Then you can do 'git rebase that-svn-branch' on your git branch to put
> all commits (not as one big commit) on top of that branch point. Now
> you 'git checkout' that-svn-branch and do 'git reset --hard
> the-git-branch', which should now consist of
> v1--v2--v3--v4(git)--v5(git), etc. If you do 'git svn dcommit' from
> the that-svn-branch now it should dcommit to svn each of your git
>   
sorry, my ascii art was confusing:

git: ----v1----v2----v3--v4---v5
svn: v1-4---v5

v1-4 is v1 to v4 squashed together. (e.g., if i added a file in v2 and 
removed in v3 it will not appear in svn history)

hope it is clear now.

ittay
> commits individually. Of course, don't forget to make a backup before
> you start messing around :P.
>
>   
