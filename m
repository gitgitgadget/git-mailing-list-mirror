From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: nd/magic-pathspec exposes breakage in git-add--interactive on Windows
Date: Thu, 29 Aug 2013 15:01:38 +0200
Message-ID: <CALxABCZaeS9eC50CxeqHLrKm530YXH1TRKtSUQEsd81L3Jxwyg@mail.gmail.com>
References: <521EF02A.2020300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 29 15:02:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF1rP-0001WG-Jf
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 15:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab3H2NB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 09:01:59 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36581 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab3H2NB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 09:01:59 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so413302obb.32
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+WwVATfEM/SrxpEnYEEw4Mnvvmr0gMYj41/i8p7bpWg=;
        b=uK92CwvFtOlX9/oQHC036zRp9+m/oGuIATrPaY50crHkbh6BbpFC/8OSWUEIlmw+Q3
         ZxkOpXYCdxTjcqmRV+41Y+RqQSSZlEusTgvqbmRhxn74wNX6dCz6HXhZArh4rXYtiF+n
         pQUk809fq/w8Bx+BjsZmX+nkDlsJdEMT3FazpNkJOGfiL1y5WB7q6FJegKfObNzVaz2m
         OuL1UMlBdRlC3sjFICoDuEARI6oQGbY0fcWP+9goTSTdc+bFO1B2z0g27qox8nYpk3wf
         JhhacGlUGHhNt4yP5U7tUpn0zLp04CsF/fvllYX5VBsiOEPku30Dvb1Zs/+D/xlgOUVI
         H6lQ==
X-Received: by 10.182.131.166 with SMTP id on6mr2352309obb.60.1377781318602;
 Thu, 29 Aug 2013 06:01:58 -0700 (PDT)
Received: by 10.60.101.225 with HTTP; Thu, 29 Aug 2013 06:01:38 -0700 (PDT)
In-Reply-To: <521EF02A.2020300@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233251>

On Thu, Aug 29, 2013 at 8:54 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> It looks like on Windows we disallow arguments that contain double-quote,
> colon, or asterisk, and otherwise wrap arguments in double-quotes if they
> contain space. Then pass them through qx{}, which I can only guess what it
> does.

Well, the command interpreter of the platform implementation caused
this, I believe.
Quoting of the double quotes for it was too cumbersome for rarely used
combination
(windows, ActiveState Perl, and Git). I guess it is more popular now?
