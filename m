From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: non-fast-forward advice breaks tests on OS X
Date: Thu, 12 Apr 2012 10:00:49 -0400
Message-ID: <20120412140049.GB367@gmail.com>
References: <9F768A58-DEB0-43E1-8AE4-B2A5C4E6CDE9@silverinsanity.com>
 <20120412133701.GA367@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 16:01:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIKa2-0007ja-IU
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 16:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070Ab2DLOAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 10:00:54 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:52503 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755490Ab2DLOAx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 10:00:53 -0400
Received: by qafi31 with SMTP id i31so5695819qaf.1
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/Nf6xJ3CNs0ks3pNCk+DJww0ef0FUlc8n8z0CcoQouY=;
        b=LZM1n2RTmvNLpEdHFTIe79Dv8GzNC0HPQTRudhrZxpeSd1peEgCFiinDY9D44uNtjR
         h9KgfdyPFJqwUQdE/G38Ami1Uw6wN9bs2ikczPxLXP1WuGAYwSkUFEweh+jOspp6wkid
         4/IuFjwYqLC1hJ7tTFme/1eMBN6vVC3gTHv+oezDGAMDRF6zKL1QKTmWcj4ZDGWvftkg
         jts+tytcDPtWw9ZIIl/X4ySfcJQn4VopI90wBOJ5Pxzy7Ap2TNOseAa+KXENTUcCv6Vd
         h4wDcWFVop9Nkm4jgtbLek4VjJ9htq+12u6XQxEr6/gxiBMoLLW4WKLGf9avLMaIG/C0
         j5dA==
Received: by 10.224.9.141 with SMTP id l13mr3967146qal.52.1334239252761;
        Thu, 12 Apr 2012 07:00:52 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id ew2sm11856666qab.11.2012.04.12.07.00.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 07:00:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120412133701.GA367@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195329>

On Thu, Apr 12, 2012 at 09:37:01AM -0400, Christopher Tiwald wrote:
> On Thu, Apr 12, 2012 at 01:49:14AM -0400, Brian Gernhardt wrote:
> > After a break in regularly compiling git on my Mac 10.7.3 laptop, I had a few tests fail:  t5540.15, t5541.{12,15}.  All of these tests use test_i18ngrep to test the output of git-push for the string "To prevent you from losing history, non-fast-forward updates were rejected".
> > 
> > Bisecting traced it back to f25950f: "push: Provide situational hints for non-fast-forward errors".
> 
> I also run 10.7.3 on a MacBook Pro. I will investigate this now and see
> if I can get tests to break. I know the original patch passed the test
> suite on this machine.

Ah ha, I wasn't running the proper tests. I'll send a patch to the
affected ones later today.

*** t5540-http-push.sh ***
# passed all 0 test(s)
1..0 # SKIP Network testing disabled (define GIT_TEST_HTTPD to enable)
*** t5541-http-push.sh ***
# passed all 0 test(s)
1..0 # SKIP Network testing disabled (define GIT_TEST_HTTPD to enable)
*** t5550-http-fetch.sh ***
# passed all 0 test(s)
1..0 # SKIP Network testing disabled (define GIT_TEST_HTTPD to enable)
*** t5551-http-fetch.sh ***
# passed all 0 test(s)
1..0 # SKIP Network testing disabled (define GIT_TEST_HTTPD to enable)
