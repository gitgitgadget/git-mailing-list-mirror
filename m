From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: Computing the number of patches in linux-next tree
Date: Tue, 22 Jul 2008 11:23:28 -0700
Message-ID: <1216751008.13328.17.camel@brick>
References: <12c511ca0807220919q4db6ee1fr33dc70fe35c58efe@mail.gmail.com>
	 <alpine.DEB.1.00.0807221727210.8986@racer>
	 <7vabg9n93f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tony Luck <tony.luck@intel.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 20:24:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLMXI-0007W1-R6
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 20:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbYGVSXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 14:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbYGVSXc
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 14:23:32 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:34901 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbYGVSXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 14:23:31 -0400
Received: by yw-out-2324.google.com with SMTP id 9so847919ywe.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=ZzRTDqBpsGKLWxhRsyQvI222cfG+nX5PV14FieEWCzc=;
        b=R91cXxzj4OwF3naNX8m5WTWJ4odSN7RMVRrH+CQo8SxuJLF+Ap0bESewQTMevOG+N1
         HfrB8rgW0gQCYRmT7xZhuyiIgCT94DFfNaUfSSAtoiSRh4Xnkuj16zSa+NjE0mETZlgo
         BenRdKslC3n6psneUmTIRpi8j/3ok+9+WLJag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=dDHCKICftfF6sN8L75kkdZ469+9mESUl2LV9Zgc4TozENmgEZTnT+tyCwmgHmLvhO2
         d9ABrBL1iLi0Rni2Lpl+1sspk14iED4a8oJWjSDF9Z+IV/2VfrEKn7LUDXVnJJc2b9hP
         GSf1xc27s3nqSXuQH846WRg04NAP5VUq+wytE=
Received: by 10.142.157.15 with SMTP id f15mr1972744wfe.96.1216751009827;
        Tue, 22 Jul 2008 11:23:29 -0700 (PDT)
Received: from ?128.189.251.46? ( [128.189.251.46])
        by mx.google.com with ESMTPS id 27sm2873936wfa.2.2008.07.22.11.23.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jul 2008 11:23:29 -0700 (PDT)
In-Reply-To: <7vabg9n93f.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89509>

On Tue, 2008-07-22 at 10:04 -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 22 Jul 2008, Tony Luck wrote:
> >
> >> git tag | grep next- | sort | while read tag
> >
> > This should not be necessary... AFAICT "git tag" sorts its output already.
> >
> >> What does the "git-where-did-this-tag-branch-from-linus" command look like?
> >
> > git merge-base --all <branch1> <branch2>
> >
> > Be warned: there might be multiple merge bases.
> 
> I do not think that approach applies to linux-next, which is constantly
> rewound to the then-tip-of-linus and merge remaining bits.  The question
> is "where does this branch begin", which does not have an answer in git.

I thought that was what Stephen has the next/stable branch for:

git log --pretty=oneline --no-merges next/stable..next/master | wc -l

At least for each day you can find the number of patches....I don't
think he tags the stable points, so historically that may be a problem.

Harvey
