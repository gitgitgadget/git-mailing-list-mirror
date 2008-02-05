From: "Chris Larson" <clarson@kergoth.com>
Subject: Re: [PATCH] Fix bug in parse_color that prevented the user from changing the background colors.
Date: Tue, 5 Feb 2008 11:48:39 -0700
Message-ID: <b6ebd0a50802051048s3db55f6yab79e8982fd81b81@mail.gmail.com>
References: <47A89E2A.9010905@kergoth.com>
	 <20080205203940.1dcff0ce.tihirvon@gmail.com>
	 <b6ebd0a50802051045t4949df68u7e405ea618403a31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 19:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMSrO-0001ti-Cg
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 19:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbYBESsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 13:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756118AbYBESsm
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 13:48:42 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:6893 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbYBESsl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 13:48:41 -0500
Received: by rn-out-0910.google.com with SMTP id i24so2798120rng.19
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 10:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=qAmNtrt/PLTbR8ptwD9Grx9Bc5VxZUKN7rDSFmv7stI=;
        b=hr4QBuekpQCeuDxfGcXsvwDGJAziMeTqBKiktyjfY1n2ygo6WCZXNkVzdzqyoESfe6W1tRR4PvZLo5LVpwKO3jlCCHtFjNFYLY/Dm0LT8zxB+vflr+nbFZbyVc0YaJnQOyG1GCi8F8cLaSt6AcNenx5VmCTCgfmQYaatQjXMAs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=TbTCORiMgWI9dOykLpXhKSKWomtitpj7b5mCm19aXNf67rUKf4nI2qQudYMyJ/Zt1YpNkAJpknuXKFStm2yGNJ2+BX1R0i/V0HwEefBV2tMsNPXMySpX6eDnrwIYQuLkQ9IR/0wMY4ud3Cv9MM0xxa2LWGycVc5fq8EIdtJvz1E=
Received: by 10.142.225.11 with SMTP id x11mr627772wfg.175.1202237320007;
        Tue, 05 Feb 2008 10:48:40 -0800 (PST)
Received: by 10.143.119.7 with HTTP; Tue, 5 Feb 2008 10:48:39 -0800 (PST)
In-Reply-To: <b6ebd0a50802051045t4949df68u7e405ea618403a31@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 2304a39fdc19c3db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72677>

On Feb 5, 2008 11:39 AM, Timo Hirvonen <tihirvon@gmail.com> wrote:
>
> Chris Larson <clarson@kergoth.com> wrote:
>
> > unable to convert the string in its entirety into an integer.
>
> > -    if (*name && !*end && i >= -1 && i <= 255)
> > +    if (*name && i >= -1 && i <= 255)
> >          return i;
> >      return -2;
> >  }
>
>
> My bug, sorry. I should have tested more.
>
> I think this new code accepts "7bold" (didn't test).  Maybe you should
> do something like this instead:
>
>        if (*name && (!*end || isspace(*end)) && i >= -1 && i <= 255)

Indeed, I should have tested more too :)  Just starting to mess with
the codebase, surprised at how clean it is (though I probably
shouldn't be).

> Untested of course.  BTW, your patch is whitespace corrupted.
>

Unsurprising... sometimes I really hate gmail :|  Anyone know if
there's a way to post with gmail without hosing the patch, or should I
switch to a non-web based solution?

Thanks,
-- 
Chris Larson - clarson at kergoth dot com
Dedicated Engineer - MontaVista - clarson at mvista dot com
Core Developer/Architect - TSLib, BitBake, OpenEmbedded, OpenZaurus
