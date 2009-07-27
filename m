From: Robert Zeh <robert.a.zeh@gmail.com>
Subject: Re: git svn fetches the same revision multiple times for non-trunk branches
Date: Mon, 27 Jul 2009 18:56:17 -0500
Message-ID: <E9365F62-FD6F-4770-B177-9B8F0413C12C@gmail.com>
References: <CEAA2460-501C-48C1-BC33-B92A68C2161B@gmail.com> <20090725105111.GB13534@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 28 01:56:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVa3S-000873-W3
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 01:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbZG0X4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 19:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbZG0X4V
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 19:56:21 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:34919 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbZG0X4U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 19:56:20 -0400
Received: by pzk42 with SMTP id 42so309156pzk.33
        for <git@vger.kernel.org>; Mon, 27 Jul 2009 16:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=mxFwTeft8URq0G3TAdZdypnMLGkinUr0Sj2+sCyxAwk=;
        b=FUp2TzCzP/pmLwbKW0Xbygcey0P4BHFE0seCL18G1AwHuxn+50o9NXuwArABnbhmzz
         O7sqvRt3qog5IC+pgPfhLgW+dECJIhPSs/WX8IKY4c76k/uvcNkKBH3tNpTPq+poOjU6
         K4qFOu8li2bhclwuhoQpVasW4u7FaST4in4cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=DC7nDCnRlX3FYRNPBDvrDFuG94bGW6WMjwnXmVlL1kp+Q9f5ni8J/PH91Vi20lv+/J
         /NOq/6egWbjLsGPE8v8ylDt2C30DZqBS4wb0zpsXa4l3hiXczrX2aq/Avj0rLErbptmV
         XH6GRcwEKupRa5YKydTZ67U4+wEAYYsZKC41w=
Received: by 10.115.23.18 with SMTP id a18mr10779364waj.41.1248738980964;
        Mon, 27 Jul 2009 16:56:20 -0700 (PDT)
Received: from ?10.0.1.199? (h-68-165-188-139.chcgilgm.dynamic.covad.net [68.165.188.139])
        by mx.google.com with ESMTPS id f20sm14801449waf.52.2009.07.27.16.56.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Jul 2009 16:56:19 -0700 (PDT)
In-Reply-To: <20090725105111.GB13534@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124203>

So is the basic problem that the history of the branch is unknown and  
we have to retrieve the history?

Robert
On Jul 25, 2009, at 5:51 AM, Eric Wong wrote:

> Robert Zeh <robert.a.zeh@gmail.com> wrote:
>> I am seeing git svn fetch repeatedly retrieve the same Subversion
>> revisions when it finds branches in our Subversion repository. We are
>> using the standard Subversion repository layout, with top level / 
>> trunk,
>> /tags, and /branches directories (and the git repository was  
>> created with
>> 'git svn init -s'). However, the problematic branches are often  
>> copies
>> made from a subdirectory inside of trunk, instead of trunk.
>
> Hi Robert,
>
> Yes, this is a known problem with some repositories and there's no
> automatic/easy[1] way to handle it with globbing tags/* or branches/*.
>
> You can try to track each tagged project independently or to setup
> individual fetche lines (like the one generated for trunk).  in
> .git/config for each tag/branch.
>
> [1] - Unfortunately SVN allows way too much freedom and thus ambiguity
> in how it treats tags/branches and that doesn't allow mapping those
> things to git very easily.
>
> -- 
> Eric Wong
