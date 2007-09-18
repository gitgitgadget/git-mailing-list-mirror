From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Tue, 18 Sep 2007 13:19:08 +0200
Message-ID: <8c5c35580709180419i4500a2d4s8a997d45dd31944e@mail.gmail.com>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>
	 <11900461843997-git-send-email-hjemli@gmail.com>
	 <20070918005013.GA6368@muzzle>
	 <8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com>
	 <7v4phsxy55.fsf@gitster.siamese.dyndns.org>
	 <46EF7EA1.6020402@vilain.net> <46EF9687.6070304@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Eric Wong" <normalperson@yhbt.net>,
	"Andreas Ericsson" <ae@op5.se>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Chris Shoemaker" <c.shoemaker@cox.net>, git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:19:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXb6v-0002sQ-0e
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 13:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbXIRLTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 07:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755390AbXIRLTK
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 07:19:10 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:49279 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbXIRLTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 07:19:09 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1567513rvb
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iR8U96l1LUo9xurP5wCz7mRfsnXJzNp+g4M8Su4xQRk=;
        b=r+Mh2ivHuXsld52Fc/ekYWuW+aZYXdATzEc+kkiRi9r6Xw6YO5KMUqjdzcqcCtf8xqnBKuUR06xUEpJViHrn3mpQsnSp5PzPZoPSq7Tm1/GGOdEiSvPwBcuJMBF6ty19SUjqS0bJyKo+SH5WGJ6YdXzqm0gbbA6tjvbPSAXgFF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NUbQoRuHYNdq8GPd8F4zMzCCswtiyfTdiJC2Fq5Omk+kVypnsYOq+qwnpkHsmx8V2ELcSX2yym6lm4YumHyRy5bmRtpOYz+Qj2W2PfC9y7mPbeQewnGMfzY9QSqjBTh2DDDzesxJpAQ/OVq9CmfZWahU4vOOhvxuH480Lqai0pU=
Received: by 10.114.136.1 with SMTP id j1mr216342wad.1190114348078;
        Tue, 18 Sep 2007 04:19:08 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 18 Sep 2007 04:19:08 -0700 (PDT)
In-Reply-To: <46EF9687.6070304@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58579>

On 9/18/07, Sam Vilain <sam@vilain.net> wrote:
> I think that writing a real fast-forward merge should only happen on
> dcommit, not git merge, because that is what is required for SVN.

I don't think git-svn has any way of knowing that the user wanted a
merge, unless a merge commit is present. So the user would have to
specify the set of commits which should be considered a merge during
dcommit (this would actually resemble how merges are performed in
subversion).

Sidenote: this might be slightly controversial, but I've sometimes
missed a --no-ff option to 'git merge' when working on plain git
repositories; IMHO preserving the 'logical' merge history when the
merge of a topic branch results in a fast-forward can be interesting.

-- 
larsh
