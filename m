From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Fri, 28 Aug 2009 17:50:28 +0200
Message-ID: <4A97FCC4.5070808@gnu.org>
References: <4A979690.1050601@gnu.org> <20090827203402.GC7168@kisimul> <vpqk50pasek.fsf@bauges.imag.fr> <20090827203402.GC7168@kisimul> <9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com> <20090827203402.GC7168@kisimul> <7v1vmxq6nw.fsf@alter.siamese.dyndns.org> <20090827203402.GC7168@kisimul> <fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com> <20090827203402.GC7168@kisimul> <20090828133708.GA11146@kisimul>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: seanh <seanh.nospam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 17:50:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh3j3-0000qG-0x
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 17:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbZH1Puo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 11:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbZH1Puo
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 11:50:44 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:40811 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZH1Pun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 11:50:43 -0400
Received: by ewy2 with SMTP id 2so2246642ewy.17
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=v8c2RA+As3aIl9wcnegMwrTWR3wnScGSg/2t7rKeXUI=;
        b=O8opKetfZiFJGxPUHBK13JbCj1/lLtc08ANPLxes4CWnNAe/uRvqzWOPo1Z6dBadnn
         +P/gic2Sf6Vbs8tiyFqKDkBY3eS7CYys4A7dbcHjc8xYmWkLDu1vhDQiwaWXXq9VrmWv
         V5gWQk9DLscj8Y45tHEQQVLnHKT1lse25lP6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=BRc4ZciHRiMKCSdJVGitZ+kA6tKWAk6cpjWP/XyFit/HiLz4H/1CaJmiv4Opv9l0h4
         +jl6QteOYNFiqDud9tK6FBo1UeLi+kcTJq1ST6UNlC55z8yozMA5w3CzNd9lY/rpO19O
         QcOqPNx1VM59SuQFEhu6a+TVF8ObU+m90D/UU=
Received: by 10.210.9.13 with SMTP id 13mr1512835ebi.7.1251474644218;
        Fri, 28 Aug 2009 08:50:44 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 28sm24027eye.40.2009.08.28.08.50.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 08:50:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20090828133708.GA11146@kisimul>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127306>

On 08/28/2009 03:37 PM, seanh wrote:
> In response to Matthieu and Paolo, I'm not sure I understand the git
> internals involved in the discussion around merge --squash, I had a
> feeling this would produce a 'merge' that git in some sense would 'not
> know about', since it sounds complex and I don't understand it I don't
> think I want to go there.

Yes, the problem is that git does not track what happens when you do 
"git merge --squash", which makes it harder to do merges after some time 
(because of conflicts).

The solution I gave (and Matthieu explained how it works, even though 
it's very technical) is a way to "explain" git what you did.  If you try 
it on a fake example with gitk, you should understand it better.

    mkdir test
    cd test

    # import
    git init
    echo a > test
    git add a
    git commit -m1

    # some changes happen in your local "fine grained" branch
    git checkout -b local
    echo b > test
    git commit -a -m2
    echo c >> test
    git commit -a -m3                                  ##<<<

    # the magic incantation brings those commit to master
    # (first two commands) and teaches git what happened (last two)
    git checkout master
    git merge --squash local; git commit -m'merge 1'   ##<<<
    git checkout local
    git merge master                                   ##<<<

    # more local changes
    sed -i s/b/d/ test
    git commit -a -m4
    echo z >> test
    git commit -a -m5                                  ##<<<

    # the magic incantation, again
    git checkout master
    git merge --squash local; git commit -m'merge 1'   ##<<<
    git checkout local
    git merge master                                   ##<<<

Use gitk at the points indicated with ##<<<

It is actually very similar to what you chose to do.  My commits to 
master, in practice, are your tags.  You may want to see how gitk's 
graphs looks in both scenarios, and choose the one that you prefer.

Hope this helps!

Paolo
