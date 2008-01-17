From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Thu, 17 Jan 2008 17:07:17 +0000
Message-ID: <b0943d9e0801170907x9c4721cy4e5ac886eb61e0a5@mail.gmail.com>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com>
	 <200801162147.33448.kumbayo84@arcor.de>
	 <200801162158.26450.kumbayo84@arcor.de> <m3y7aplbie.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Peter Oberndorfer" <kumbayo84@arcor.de>,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Dan McGee" <dpmcgee@gmail.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 18:07:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFYDY-0006aM-S7
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 18:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbYAQRHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 12:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbYAQRHU
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 12:07:20 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:14441 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbYAQRHT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 12:07:19 -0500
Received: by rv-out-0910.google.com with SMTP id k20so607470rvb.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2008 09:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=C++Wnbch9CjIycoYN6pxgyjiW9ajsEIXkYeT9YPFb70=;
        b=gmX1kJ9K43z1yJ+PFuV1luaLULsGfkUy+Cv2a7Zc857j9CV5lm8htak6UXOb39Uza5jXReOPKwsQKNwOfm1AsC4rFMGwZJ2EVgqoz5dnkByoIXLsNgHvZzu3VVK/qF4eMIafDk8hgyUqtn1s5Kb18a1Yj4puiWy/cabeP749RmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fRJjWd8yWNGC4iOi8PNO1YutiELJuAbZkXgghRj27CUHedxkG7PpgwyCEeENIKnktm2qAtDXB93fQd6UlkAstkLEldF8grlkk7aaJzKG5XSpy7sC1sEsuhmcPhYcCRJ0h0vUPIM1T9zh3+oH5V6EvLoBWFtdEZ6qlJ8h8hk5QXQ=
Received: by 10.140.199.19 with SMTP id w19mr1606449rvf.219.1200589637567;
        Thu, 17 Jan 2008 09:07:17 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Thu, 17 Jan 2008 09:07:17 -0800 (PST)
In-Reply-To: <m3y7aplbie.fsf@roke.D-201>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70874>

Hi,

Now I'm back from holiday and I'll start merging patches. Thanks for the fixes.

On 16/01/2008, Jakub Narebski <jnareb@gmail.com> wrote:
> Strange that StGIT didn't abstracted out reading git config, like
> Git.pm and gitweb.perl did.

The initial implementation was to use Python to parse the config file
but it was dropped in favour of the git-config tool. It might be a bit
slower but, at least, we don't need to follow any future syntax
changes.

> BTW. will StGIT be using libgit-thin + PyGit, or is it not ready yet?

The last commit to the libgit project seems to be in August 2007. Is
it still maintained? If GIT will provide a stable API and library, we
might use it but I don't think it would bring a great performance
improvement. Most of the time, in my case, seems to be spent in calls
list git-diff-tree. A few tens of milliseconds avoided by not calling
an external tool would be unnoticed.

-- 
Catalin
