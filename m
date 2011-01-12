From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Bug] Gitweb corrupting files?
Date: Wed, 12 Jan 2011 10:05:45 -0800 (PST)
Message-ID: <m3hbdeatgn.fsf@localhost.localdomain>
References: <AANLkTim84sSWr=WRgjiY=Y3Mq7Tgojv9CpLrNjQMJfHR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Severin Gehwolf <jerboaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 19:06:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd55G-0003PZ-Cx
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 19:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab1ALSFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 13:05:51 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41068 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462Ab1ALSFs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 13:05:48 -0500
Received: by wyb28 with SMTP id 28so843348wyb.19
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 10:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=KCT2rxie8l7V9EVXWAvAspiGv6P8yQgWbPPFbSA4cUA=;
        b=uRYxcElt2RaE57pv0orPpw1tjLJmBLvvA6nIaalaEeknX5vzRSV/IvPwW4kOsmDCql
         nqWwl/z6junrURiWINBS9F9HdXZH9xXaGBNjYLsJ5nI1dRxuc6FjQS3SrGlp+H9iSwhy
         NM4kdCDCGSoGGVYpgloOWFQl1Kq1jmzZYjGMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=vDY4XduM2Pe2ysem1tvaB9z3mcok4pSAQz/N1RFbRT/Hv+46f8ZeM4wjWjVyvOEON5
         q/JfIDNmQzDAO1ZF89T9rcpFvmlDOmSUewyhzZqqdQ1JfS3IxC5lqvcLQlGaK2dCjT6n
         LjVmQthIYsNp98BABb5r5+mep5sokmaFsfjgo=
Received: by 10.216.141.16 with SMTP id f16mr1064708wej.80.1294855547224;
        Wed, 12 Jan 2011 10:05:47 -0800 (PST)
Received: from localhost.localdomain (abwu145.neoplus.adsl.tpnet.pl [83.8.244.145])
        by mx.google.com with ESMTPS id o51sm494393wes.39.2011.01.12.10.05.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Jan 2011 10:05:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p0CI5N64028760;
	Wed, 12 Jan 2011 19:05:33 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p0CI5CWu028756;
	Wed, 12 Jan 2011 19:05:12 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTim84sSWr=WRgjiY=Y3Mq7Tgojv9CpLrNjQMJfHR@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165022>

Severin Gehwolf <jerboaa@gmail.com> writes:

> It appears that Gitweb corrupts files when it is being used for
> creating compressed tarballs of sources.

E.g. http://egit.eclipse.org/w/?p=egit.git;a=snapshot;h=6b528445c3e543688b990e0a631c5f0238b02741;sf=tbz2
error in egit/org.eclipse.egit.ui/src/org/eclipse/egit/ui/internal/dialogs/BranchSelectionDialog.java

> A more precise description of the behaviour I'm experiencing is here:
> https://bugs.eclipse.org/bugs/show_bug.cgi?id=317882

Couldn't you post summary of the above here?
 
> Unfortunately I have no knowledge about the version in use at eclipse.org.

It's git and gitweb version 1.6.4.4.


>From original bugreport:

   And it built fine. Then, I tried checking out sources from command line using
   the git client:

   git clone git://egit.eclipse.org/egit.git egit
   cd egit

   git checkout 6b528445c3e543688b990e0a631c5f0238b02741
   cd ..
   tar -cjf egit_test.tar.bz2 egit

This should be

$ git archive --format=tar 6b528445c3e543688b990e0a631c5f0238b02741 |
  bzip2 > egit_test.tar.bz2

   just to make sure that it isn't a problem of how tarballs are created when
   using the above URL. It seems the file in the repository is corrupted (although
   I'm not entirely convinced).      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Git version 1.6.4.4 is long since fixing bug with not using ':raw'
(binary) output layer with binary files.  Also I don't see how it
could have corrupted only 2 files, without making [compressed] archive
un-compressable (invalid).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
