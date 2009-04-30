From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Thu, 30 Apr 2009 10:53:08 +0200
Message-ID: <46a038f90904300153v22aa3e9fo407ff5084b58b5fc@mail.gmail.com>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>
	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>
	 <49F8B7D1.2090903@drmicha.warpmail.net>
	 <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>
	 <49F8C127.4000400@drmicha.warpmail.net>
	 <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 10:53:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzS1K-0007JN-4S
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 10:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbZD3IxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 04:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbZD3IxL
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 04:53:11 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:39036 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbZD3IxK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 04:53:10 -0400
Received: by fxm2 with SMTP id 2so1674327fxm.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 01:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b2Acq6ZaDnZ6Mq7VkJsGC9gp2AkvFrdM5k7d9tArquo=;
        b=SSImWtGWoukax2LtUk31cMGGFTkhkDd66uypSfO5JA9zRUMahSlbutQZLVkOgOERtJ
         7732jrsT9lXDs40/b2FsxT4HCclPZLXZSxMFI/4W99Vmo2ulfos4g0Z6+UvpF3YbuOkU
         PuJRoA2j05dH6y8npNwjW3cZTLGdFKMsvvvs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gKowZBCIBKEcELsPX151E5jEgY5AOLSHjEbNi5cbTB1ytOS9Ffs27rSAqpPeN0dHY9
         bKkxnMflxRwrMHzr0KWzPEh5RSkXmrciS22XqIm5DXxi9XgM9grmf4lDYTrc8Yo2lzuG
         Z1Mu5vhZHrt8hW3qZkOB+eRFur3kor5Oh4/L0=
Received: by 10.204.116.8 with SMTP id k8mr1234268bkq.110.1241081588336; Thu, 
	30 Apr 2009 01:53:08 -0700 (PDT)
In-Reply-To: <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118004>

On Thu, Apr 30, 2009 at 9:18 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> Bingo! Yes,
>
> ~$ which git-cat-file
> /usr/bin/git-cat-file
> ~$ /usr/bin/git version
> git version 1.5.6.3

Actually, after removing the git-core package and all its dependencies...

# same git version that succeeds on Fedora 9, here says:
$ git svn  clone  -T trunk  http://paintweb.googlecode.com/svn paintweb.git
usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>
error closing pipe: Broken pipe at
/home/martin/libexec/git-core/git-svn line 3252
cat-file --batch: command returned error: 129

error closing pipe: Bad file descriptor at
/home/martin/libexec/git-core/git-svn line 0
error closing pipe: Bad file descriptor at
/home/martin/libexec/git-core/git-svn line 0
$ git version
git version 1.6.0.6

# a newer git says...
$ git svn clone -T trunk --ignore-paths releases
http://paintweb.googlecode.com/svn paintweb.git
usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>
Unexpected result returned from git cat-file at
/home/martin/libexec/git-core/git-svn line 3526
Failed to read object 4b90eef95225bb9e34000e050d0cac8b84ab36f6 at
/home/martin/libexec/git-core/git-svn line 3527.

$ git version
git version 1.6.2.4.10.g2254d

... the plot thickens...

There is nothing in my env that would confuse git -- and my PATH has
~/bin as the first entry, trumping everything else. So perhaps the
debian package had nothing to do with this?

Perl SVN bindings? How do I debug that side of things?

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
