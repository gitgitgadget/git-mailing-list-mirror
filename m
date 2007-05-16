From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: pull/push inconsistencies
Date: Thu, 17 May 2007 10:35:27 +1200
Message-ID: <46a038f90705161535t6f15bbedy661accb54a9bd8c5@mail.gmail.com>
References: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com>
	 <7vtzudhayr.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90705151811o2159aa5ai84a13e77e790e376@mail.gmail.com>
	 <7v646th8a2.fsf@assigned-by-dhcp.cox.net>
	 <20070516014002.GA8062@fieldses.org>
	 <46a038f90705151851i9027e01x993300b1b50d0285@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu May 17 00:35:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoS5n-0003Rf-J9
	for gcvg-git@gmane.org; Thu, 17 May 2007 00:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbXEPWf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 18:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754836AbXEPWf3
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 18:35:29 -0400
Received: from ag-out-0708.google.com ([72.14.246.241]:65434 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711AbXEPWf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 18:35:28 -0400
Received: by ag-out-0708.google.com with SMTP id 23so410500agd
        for <git@vger.kernel.org>; Wed, 16 May 2007 15:35:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tnfdVVYOu6ihvgnwD9o7sTWlBMTFAdEEE0uYGVMWbPZNGpWZCG1066i8gNj9dKQEpYaEZpEGeIIFvYboAIrgidKV2KRkAStS7VOcjke2YT/M5/GcirDnn+IvmQlZUt6WcAscvUNi1mLwOwMKxnHzCc5lqBu9yyOYTFitTjYDGqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ex2M+mnpW1ocIJbhV9JRgXkBmo8ZzO+ZujHgRpiqi9e3memQlOnAOZHgCseLb9YHnkCvd/gGAO7sPMQoEynaEycpEtHjjiXH0H7f2NkuDF7JePcgNJksmXPMYOWQHBPdYsMTaK6NJ6XBIONyLOlqIeoPetywHPoxktSrq+ChwUY=
Received: by 10.90.118.12 with SMTP id q12mr9033672agc.1179354927789;
        Wed, 16 May 2007 15:35:27 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Wed, 16 May 2007 15:35:27 -0700 (PDT)
In-Reply-To: <46a038f90705151851i9027e01x993300b1b50d0285@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47464>

On 5/16/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> I'm probably in a bad-communication day :-/

Ok - I just repro'd the problem -- maybe this helps clarify...

I have a checkout of http://git.catalyst.net.nz/git/moodle-r2.git (
see http://git.catalyst.net.nz/gitweb ) where I have the following
tracking branches:

  $ git branch
    mdl17-polhn
  * mdl18-local

I know that I am "all pushed out" - no local commits to push here. So
I start my day and do

 $ git-pull
 # brings some commits, but nothing to mdl18-local
 $ git-merge origin/MOODLE_18_STABLE
 # messy merge from the upstream branch I track...
 $ git-commit
 $ git-push
 $ git-push
 updating 'refs/heads/mdl18-local'
    from f3f1ae5c9f73fe6e0872dfe0e072521b6fe26463
    to   3af93dafbd9162423e5f0a720d4d2081313789e2
  updating 'refs/remotes/origin/MOODLE_18_STABLE'
    from 52abd5d7c4f0ac54cfc0463d5276c159a02a76c0
    to   4cfaa3c85ee54ec8c0891157a6becdd8db34eb52
  updating 'refs/remotes/origin/cvshead'
    from 7bf579b243717c470770b1457a7d1c50f6a8dff6
    to   e835361626c5cd27cabdc046fc0e23a2c6ff98db
  updating 'refs/remotes/origin/mdl18-ldc'
    from eb91f220ccbbeb1e8b43496d0172e6cd1b6549ea
    to   af4c6ee952057d11b2dbf55103a5c3134640b70f
  updating 'refs/remotes/origin/mdl18-topnz'
    from a08fdb4decfa7b92c3030801c08378ee629c038d
    to   347bc44adbfdf7b800334cbb532d436fa73e87ac
   (removed some tag-related noise)
  Generating pack...
  Done counting 212 objects.
  Result has 72 objects.
  Deltifying 72 objects...
   100% (72/72) done
  Writing 72 objects...
  Unpacking 72 objects
   100% (72/72) done
  Total 72 (delta 65), reused 0 (delta 0)
  refs/heads/mdl18-local: f3f1ae5c9f73fe6e0872dfe0e072521b6fe26463 ->
 3af93dafbd9162423e5f0a720d4d2081313789e2
  refs/remotes/origin/MOODLE_18_STABLE:
52abd5d7c4f0ac54cfc0463d5276c159a02a76c0 ->
4cfaa3c85ee54ec8c0891157a6becdd8db34eb52
  refs/remotes/origin/cvshead:
7bf579b243717c470770b1457a7d1c50f6a8dff6 ->
e835361626c5cd27cabdc046fc0e23a2c6ff98db
  refs/remotes/origin/mdl18-ldc:
eb91f220ccbbeb1e8b43496d0172e6cd1b6549ea ->
af4c6ee952057d11b2dbf55103a5c3134640b70f
  refs/remotes/origin/mdl18-topnz:
a08fdb4decfa7b92c3030801c08378ee629c038d ->
347bc44adbfdf7b800334cbb532d436fa73e87ac

As you can see, it talks about updating lots of refs. Nonsense -- I
think it's a bug. The only ref being updated is origin/mdl18-local on
the remote repo, and it should update the local
refs/remotes/origin/mdl18-local.

cheers,


m
