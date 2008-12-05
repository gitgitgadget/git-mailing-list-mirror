From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit] what happened to stg diff -r /{bottom|top}?
Date: Fri, 5 Dec 2008 22:26:44 +0000
Message-ID: <b0943d9e0812051426m624c4889o314c1894114d1487@mail.gmail.com>
References: <49395CC9.2010107@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dan Williams" <dan.j.williams@intel.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 23:28:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8j9X-0006R3-N4
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 23:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456AbYLEW0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 17:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755125AbYLEW0q
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 17:26:46 -0500
Received: from mu-out-0910.google.com ([209.85.134.187]:65179 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbYLEW0q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 17:26:46 -0500
Received: by mu-out-0910.google.com with SMTP id g7so141719muf.1
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 14:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wwBkEa1Ie+/va+ZMYhaj9dEWZG4ieYDU4LkGd/JNfoc=;
        b=hKDuIVpRuW8zQv6PebJZViJilzHiuanXmAE4TJSCgA1jEjZGsr81JuAzkRwGHzsZtr
         JxenDIdNML7TpQTsd7RALNPwjnHJ1P4oV24etFTvYLiuqPPdqaEv613eieyYRSRQfHoG
         i2Bc1z3ebcc3TDlPZzl6rd9BmWr3/yx6P5hSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oJDNUMj6ycR6FyS01EEauufVnApV/Br7P+2MXswJgPagyxfVrlSqFOmpFNxIYPr1NU
         stouDJKT8f2MeMY29TNjHBYowMoJKioQeHXZxsNTLy78Cj9M3L3bEwfQsstUsEkLA5cm
         jU++luC6ZqDRCJ7M8FQTTGCyT2hKV+D9JzO+I=
Received: by 10.223.109.200 with SMTP id k8mr462465fap.44.1228516004134;
        Fri, 05 Dec 2008 14:26:44 -0800 (PST)
Received: by 10.223.115.148 with HTTP; Fri, 5 Dec 2008 14:26:44 -0800 (PST)
In-Reply-To: <49395CC9.2010107@intel.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102419>

2008/12/5 Dan Williams <dan.j.williams@intel.com>:
> I noticed that with the latest StGit:
> # stg diff -r /bottom
> stg diff: /bottom: Unknown patch or revision name
>
> Before I bisect to find where this disappeared, is there a different syntax
> I should be using?

In the development (master) branch, we changed the syntax to make it
cleaner. A patch (its top) can be identified as [<branch>:]<patch>. It
also supports standard Git suffixes like ^, ~{...} etc. To access the
bottom of a patch, just use [<branch>:]<patch>^.

The bottom of the top patch could be accessed as HEAD^ (I've been
thinking about only allowing the caret for this, without the HEAD but
I didn't have time to try it).

-- 
Catalin
