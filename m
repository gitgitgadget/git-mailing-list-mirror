From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Purpose of "struct object_entry *oe = oe;"?
Date: Thu, 1 Jul 2010 18:43:47 -0700
Message-ID: <69D6E995-8F0E-446C-90CD-758C160A7807@gmail.com>
References: <8039w681lo.fsf@tiny.isode.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 03:43:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUVIK-0003c7-N4
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 03:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756915Ab0GBBnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 21:43:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60199 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017Ab0GBBnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 21:43:51 -0400
Received: by pwi5 with SMTP id 5so400515pwi.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 18:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references
         :mime-version:content-type:message-id:cc:content-transfer-encoding
         :from:subject:date:to:x-mailer;
        bh=i3ShcddmclU5B+AD5DJ/0hVqPO95NUpZG0QScG0KNrQ=;
        b=exAqwQhhip96ainoq/y7PRJTrpg1sVT/XXEb7QHs0IoGw3WK2jSbZk8hUoQtEK4CyM
         hgM+0HL/O+J5ZqiwQWr4KjRmsaO1pP/d+WBNP/Pw1JcFtbuKBnfcK5HuaL5+Aj7EdtYE
         K87hCS7BWm9c2x1uxJdNpF4yrnzkrrGN1zxYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc
         :content-transfer-encoding:from:subject:date:to:x-mailer;
        b=Vi2TOeoA/us5x9x7cPsVGZAN6rgqnUoip1cHOGbwbb0CXrLWN2l00MoBhTkKgnc6xS
         JodpaEPI8q+vBXdX65f7TjLGCDudF7XOg4AWU1LePzcMsjGFuKITIPGBlgJiH246E+Ho
         ErMlxh3gKpO6RO3E8XiA6iEq3tkL3/AOOSVtg=
Received: by 10.142.158.12 with SMTP id g12mr19376wfe.147.1278035030317;
        Thu, 01 Jul 2010 18:43:50 -0700 (PDT)
Received: from [192.168.1.24] (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id g37sm109095rvb.5.2010.07.01.18.43.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 18:43:49 -0700 (PDT)
In-Reply-To: <8039w681lo.fsf@tiny.isode.net>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150099>

On Jun 29, 2010, at 5:28 AM, Bruce Stephens wrote:

> Out of curiousity, where did this convention/idiom come from, and  
> what's
> it for?
>
> I presume it's to remove a warning ("oe might be used  
> uninitialised") on
> a compiler (or something) that's clever enough to attempt such  
> analysis
> but too stupid to notice that the supposed initialisation is using
> something uninitialised (or perhaps the compiler's deliberately
> recognising the convention?).  Is that right, or does it actually do
> something more?
>
> I'm mostly surprised that it surprises me.  Is it used commonly in  
> other
> projects?  (It appears not to be mentioned in CodingGuidelines; should
> it be?)

I was wondering this myself.  My compiler complains in (and only in)  
the *presence* of this idiom, rather than its absence, so I undid it:

jj/warn/uninitialized branch on GitHub
http://github.com/jjuran/git/tree/jj/warn/uninitialized

jj/warn/uninitialized commit on GitHub
http://github.com/jjuran/git/commit/ 
8affbf2d8e46fbd5f3d6898aa07ea8548432e7bc
Signed-Off-By:  Joshua Juran <jjuran@gmail.com> (or s/gmail/metamage/)

A compiler that warns of uninitialized usage *unless* a variable is  
initialized *with itself* is doubly broken.

Cheers,
Josh
