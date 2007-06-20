From: Sergey Yanovich <ynvich@gmail.com>
Subject: Re: [PATCH 2/3] 'git-svndump'
Date: Wed, 20 Jun 2007 12:47:03 +0300
Message-ID: <4678F797.7000005@gmail.com>
References: <cff8d32813e43d9e1c75ad50824d95dbcd6f669c.1182235491.git.ynvich@gmail.com> <7d5543ebd8ac45e49a6d3f300e988189561512f1.1182235492.git.ynvich@gmail.com> <20070620064015.GB25840@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, J.Sixt@eudaptics.com, masterdriverz@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 11:46:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0wli-0003e9-Qk
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 11:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847AbXFTJq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 05:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756099AbXFTJq2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 05:46:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:8905 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbXFTJq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 05:46:28 -0400
Received: by ug-out-1314.google.com with SMTP id j3so301720ugf
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 02:46:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GuUxzJtqHu10kQO67vza4RuZcSDOiivZCUsCFUqXGeP8PhaQGlVBATy6isQ8ll+iwoWzoPJOflrI2g4T3iSHswc2yfdG745JH4uZ1lvg7hNlbwC3FgS2aVyg30mywEflVE8n4lF6brO8llHfukT9pQCxG4kUlaWh+Yw3/e22caw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cRVJVAIWZHP+Dzk7nj5P3gzMWz1A8s9GZFaGAJwz819MOAc52EZSS9cHEEgQXm/cj/bDVKee9StZvkZlyyfdQWqbzBaNgxS17aa+z1vqlKU+TUfXWbGB2FM/gXv9lvLOCHtwFIaJHa2jUwjucZss8MdOg9Wq7w1DKpOpXCNoYLc=
Received: by 10.78.137.7 with SMTP id k7mr181245hud.1182332786738;
        Wed, 20 Jun 2007 02:46:26 -0700 (PDT)
Received: from ?10.20.82.249? ( [212.98.161.164])
        by mx.google.com with ESMTP id c18sm159156hub.2007.06.20.02.46.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Jun 2007 02:46:25 -0700 (PDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <20070620064015.GB25840@muzzle>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50554>

Eric Wong wrote:
> We could probably just implement this directly in git-svn.  I'll try to
> find time to take a closer look at it this weekend or the next if I
> don't have time.  If you or anybody else feel comfortable doing more
> work in Perl, feel free to go ahead with it.

I would be happy to help, but I don't speak fluent perl. I had real 
trouble introducing a global variable, when patching 'git-svn' for root 
commit.

>>  Documentation/git-svndump.txt |   97 ++++++++++++++++++++++++++++++++++++++++
>>  Makefile                      |    1 +
>>  git-svndump-init.sh           |   85 +++++++++++++++++++++++++++++++++++
>>  git-svndump-sync.sh           |   98 +++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 281 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/git-svndump.txt
>>  create mode 100755 git-svndump-init.sh
>>  create mode 100755 git-svndump-sync.sh
> 
> I'm really not excited about having even more shell scripts in git.

The first name for this scripts was 'git-svndumb'. They don't do 
anything themselves. They just call 'git-svn'. It works like decoupling 
in object-oriented design. Old UNIX philosophy of 'big number of small 
tools'.

If you decide to incorporate then in 'git-svn', you'll need to 
contaminate it with knowledge of 'svndumb'. I am afraid, you'll need to 
peruse the whole file, putting 'if's here and there.

But, it doesn't really matter, which you way you go. I would be happy 
just to see this functionality in some future release of git.
