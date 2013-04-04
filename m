From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] remote-helpers: fix the run of all tests
Date: Thu, 04 Apr 2013 09:36:50 -0600
Message-ID: <515d9e126cd2a_69fd13fde1816811@nysa.mail>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
 <1364850872-21135-2-git-send-email-felipe.contreras@gmail.com>
 <CALWbr2wAqudzbfiSHmD1uAVQX3mtbf5vgr2JXbXEg7yzaKXJcw@mail.gmail.com>
 <20130401234016.GC30935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>, Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 17:38:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNmFO-0001Gz-9N
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760986Ab3DDPiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:38:13 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:41820 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760890Ab3DDPiM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:38:12 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy19so514439obc.15
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=u52gj5KtcGrME8GGk4mC5HX4B06yaiJ33JEoHvDzuyE=;
        b=vJlMM/n+/N6TNJYy9wWzq7yA5oovLg5YN1as3qYtLvJCTsTCfVtNfcM9CFPJqtIzVa
         S0SMX9td47jdFPutc4QiKdDLRnGpPjP5KvGztRUDIpGyqikO+IFZjISgbADepAufdnt4
         /p6m+XK0CVift7UBWqU4EjC6ZsRAuoWQndGQEIh1IIUFEHesnO7INVc8Fevk8M8TDEgR
         pLMrxzPpnmtSHwTj1SRHFtXTtILXS1/dJQCiA2qLfEz/GrcdGrezSZoiMcqE/QE7jba+
         lLJRCv4l/rG+DI5xLqg2gltl09ultIOu9UZJlV9QgHj1iu8TTSwGNOYLK0jMt2gwXZaR
         Tteg==
X-Received: by 10.60.10.3 with SMTP id e3mr4649276oeb.51.1365089892197;
        Thu, 04 Apr 2013 08:38:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ri7sm7149104oeb.6.2013.04.04.08.38.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:38:11 -0700 (PDT)
In-Reply-To: <20130401234016.GC30935@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220023>

Jeff King wrote:
> On Mon, Apr 01, 2013 at 11:46:00PM +0200, Antoine Pelisse wrote:
> 
> > On Mon, Apr 1, 2013 at 11:14 PM, Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > > +export TEST_LINT :=
> > 
> > I think "test-lint-executable" still makes sense here.
> 
> Also test-lint-shell-syntax, which finds a problem with the current
> code:
> 
>   $ cd contrib/remote-helpers
>   $ make test TEST_LINT=test-lint-shell-syntax
>   make -e -C ../../t test
>   make[1]: Entering directory `/home/peff/compile/git/t'
>   rm -f -r test-results
>   /home/peff/compile/git/contrib/remote-helpers/test-bzr.sh:139: error: echo -n is not portable (please use printf):   echo -n content > expected &&
>   make[1]: *** [test-lint-shell-syntax] Error 1
>   make[1]: Leaving directory `/home/peff/compile/git/t'
>   make: *** [test] Error 2

Indeed. I've fixed he problem, and added the two lint checks to the new version
of the series.

-- 
Felipe Contreras
