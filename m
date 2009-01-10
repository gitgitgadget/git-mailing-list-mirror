From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb index performance (Re: [PATCH] gitweb: support the	rel=vcs-* microformat)
Date: Fri, 09 Jan 2009 17:44:50 -0800 (PST)
Message-ID: <m3y6xkylwu.fsf@localhost.localdomain>
References: <20090107042518.GB24735@gnu.kitenet.net>
	<gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net>
	<cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com>
	<20090107184515.GB31795@gnu.kitenet.net>
	<20090107190238.GA3909@gnu.kitenet.net>
	<20090107232427.GA18958@gnu.kitenet.net> <gk4bk5$9dq$1@ger.gmane.org>
	<20090108195446.GB18025@gnu.kitenet.net>
	<496691EC.1070805@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Jan 10 02:46:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLSvb-0000a8-D3
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 02:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbZAJBoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 20:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbZAJBoy
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 20:44:54 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:62818 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbZAJBox (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 20:44:53 -0500
Received: by ewy10 with SMTP id 10so10532852ewy.13
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 17:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=90LPb75/DSL6ZhDUN+7IwojstupTbbDWEc1EvcR+l64=;
        b=Z2C38zGmDu0jLINiFBel9SdU7Buz1r6PizFA/2dfBVZ9L1zLZvf2KHyCOeQsxzue6T
         TOAUilrCsSQ3DJZwqBqvWGm+8EgIjCPH8NcidVDtECHdwvMn3RmjNTibOaiF9aNNY2eO
         wK2w4seokYksFKPqHXabfaE0hLx6znKFRJdzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=jgePNhKJq8pP5dCdJnjzd+csL4hlq1S8dc26cS3YzktVUYoVyfrpLO8C774CKt3lDH
         LDTGZ2S+IxuKO4S8XB+DUqOv7hnKzqx2jF7ZpOpxSA5viZQ7ytzRMUFF6TZV3NBF0Mqd
         M+DypLFCQV1ty3iM1KyKyTzcbcOFFXC3z3sx8=
Received: by 10.210.119.5 with SMTP id r5mr30966306ebc.89.1231551890996;
        Fri, 09 Jan 2009 17:44:50 -0800 (PST)
Received: from localhost.localdomain (abwp34.neoplus.adsl.tpnet.pl [83.8.239.34])
        by mx.google.com with ESMTPS id 10sm1161081eyd.16.2009.01.09.17.44.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 17:44:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0A1ipFq029040;
	Sat, 10 Jan 2009 02:44:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0A1inxw029036;
	Sat, 10 Jan 2009 02:44:49 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <496691EC.1070805@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105062>

"J.H." <warthog19@eaglescrag.net> writes:
> Joey Hess wrote:
>> Giuseppe Bilotta wrote:
>>
>>>> There is a small overhead in including the microformat on project list
>>>> and forks list pages, but getting the project descriptions for those pages
>>>> already incurs a similar overhead, and the ability to get every repo url
>>>> in one place seems worthwhile.
>>>>
>>> I agree with this, although people with very large project lists may
>>> differ ... do we have timings on these?
>>>
>>
>> AFAICS, when displaying the project list, gitweb reads each project's
>> description file, falling back to reading its config file if there is no
>> description file.
>>
>> If performance was a problem here, the thing to do would be to add
>> project descriptions to the $project_list file, and use those in
>> preference to the description files. If a large site has done that,
>> they've not sent in the patch. :-)
> 
> No because all the large sites have pain points and issues elsewhere
> in the app.  Most of the large sites (which I can at least speak for
> Kernel.org) went and have built in full caching layers into gitweb
> itself to deal with the problem.  This means that we don't have to
> worry about nickle and dime performance improvements that are specific
> to one section, but can do a very broad sweep and get dramatically
> better performance across all of gitweb.  Those patches have all made
> it back out onto the mailing list, but for a number of different
> reasons none have been accepted into the mainline branch.

Additional issue is that when you add or delete repository (project),
you have to correct or regenerate projects_index file.  While it is I
think quite easy for git hosting sites such as repo.or.cz, it is
harder for sites which offer gitweb just like they ofer WWW homepages:
as a service, with repositories created (and descriptions updated)
outside of gitweb control.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
