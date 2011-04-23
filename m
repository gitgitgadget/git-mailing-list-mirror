From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC 5/5] Date Mode: Tests
Date: Sat, 23 Apr 2011 03:42:24 +0000
Message-ID: <f1ad6d6f-44c8-442c-a335-d0b4113c48d7-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
            <bbf61df6-b7fa-429e-866e-899354953cbd-mfwitten@gmail.com>
            <7vd3kfusva.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 05:47:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDToC-0007uY-C7
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 05:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070Ab1DWDqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2011 23:46:39 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61614 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab1DWDqi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2011 23:46:38 -0400
Received: by eyx24 with SMTP id 24so308996eyx.19
        for <git@vger.kernel.org>; Fri, 22 Apr 2011 20:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:references;
        bh=FKNO/IplwfoYrhZKf6S/t/zRoLfsjO0JVVj5mCnGlQw=;
        b=myZx7XNxfCgo2S2WdtyGv7Icgut2noT5msGdw6UDTfJ3LKBGQrwtpieqdJ1EcfnV66
         LaoxIRwOVmyKZvz04dFo9MBtTLIFz1ff6R81/qgsk6x7FLKQHnmSnyiOMHaOXarMd+oU
         9agJnRPko2cJIxpL1cCpFDSaskTFY31Pt7zO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:references;
        b=qZ3Em8yaE6fIMtJaud9lFIm1y/PP1b/6U4K8t2T1WtdCorGD+sM5zjzh5tysIArrvE
         Ak5+vTI4d5JeZHLTV9LksLQCRbB4NDxJRBEl4xXeg+4ZqKeRPS3d+KQ6icsOR8f4zWrn
         OlYMATmiqN5n/moSpLmrmiUOmG7h/OCsmAFUE=
Received: by 10.14.53.15 with SMTP id f15mr607673eec.101.1303530397071;
        Fri, 22 Apr 2011 20:46:37 -0700 (PDT)
Received: from gmail.com (tor-exit-router40-readme.formlessnetworking.net [199.48.147.40])
        by mx.google.com with ESMTPS id s49sm1149001eei.26.2011.04.22.20.46.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Apr 2011 20:46:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171949>

On Thu, 21 Apr 2011 15:44:41 -0700, Junio C Hamano wrote:

> I'd like to have part of the tests in this patch at the beginning of the
> series to document and protect the behaviour of the current --date related
> options, then your enhancement that adds --zone that lets the users
> specify the timezone and the format independently, and finally the
> remainder of this patch as an addition to the test script to document and
> protect the interaction between the two options (e.g. what happens when
> none or only one is specified? what happens when conflicting options such
> as "--date=local --zone=gmt" is given?).

I would split it up as requested, but I'm not sure that it's worthwhile; while
there is a certain appeal to such a natural progression, my feeling is that
the separate patches won't turn out to be usefully smaller (and thus more
easily verified, as I'm sure you desire), because every data structure and
code path deals with both simultaneously.

Moreover, the beauty of your proposed progression is lost on the fact that
these patches will be applied so close in time to each other; why bother
dealing with solely date mode formats when such a version will almost
certainly never be used?

Thus, it seems cleaner just to introduce the whole set of tests in one go.
