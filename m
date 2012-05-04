From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: RFC: reflog for deleted branches
Date: Fri, 4 May 2012 06:47:56 +0530
Message-ID: <CAMK1S_jvdjLunMPGu6QidzN7YHt0UaENp-e-6kUcy4rcC_T72w@mail.gmail.com>
References: <4FA2F7DA.6020108@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri May 04 03:18:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ7A2-0002Ai-H7
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 03:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461Ab2EDBR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 21:17:57 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47870 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927Ab2EDBR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 21:17:56 -0400
Received: by obbtb18 with SMTP id tb18so3234274obb.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 18:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TZQjr9SOy+n1rXbWdHmZJJ1lEqMWDb1dDdFPe0QTEFA=;
        b=sLMAH1a65YWsv5uKjBeMTIJ2CJ7WYVSY5X6+zzTXLGAo71Bpu51Ih6rSEeeudx9pxU
         VKxnmPBeYPXVdxDfP42Ub51N0gyXWr7uk9luG0llqGASoacmXEtPWJukuuoMy8iau022
         XnL2mR5JJ8f63jVlV8e3XKScMm+1B2T3oEOVvIzZVdBFftN7IORKlObL/9x7COTP/xa2
         fjFIZD01Zj12go74DWgfIdTNVLrQBlgbKE8PL/9xh4BXhCI5P+lo4ynLgf6ou3WcCeFD
         pR9CL3V9vndF7vOT+yozLI+zPrWwh6jFRdaAFXRM1vwAZA/Ult5h0BE4aQQjGMVxlpZ3
         cmtg==
Received: by 10.60.4.1 with SMTP id g1mr5779250oeg.55.1336094276142; Thu, 03
 May 2012 18:17:56 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Thu, 3 May 2012 18:17:56 -0700 (PDT)
In-Reply-To: <4FA2F7DA.6020108@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196981>

On Fri, May 4, 2012 at 2:55 AM, Sven Strickroth
<sven.strickroth@tu-clausthal.de> wrote:
> Hi,
>
> an often heart question is how to restore deleted branches. Sometimes
> those can be restored by using the reflog of the HEAD.

I get by with:

    gitk --date-order $(git fsck | grep "dangling.commit" | cut -f3
-d' ') --not --branches --tags --remotes

Works for me because I usually remember *something* about the commit
message so then I type in "/" and the string and in a few
"Shift-downarrow"s I'm there.
