From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] tag: support --sort=version
Date: Fri, 21 Feb 2014 18:58:16 +0700
Message-ID: <CACsJy8BrfKckHzgwRnW_UMTjipuYWGVcumvCmQC9EG1Eq-MScA@mail.gmail.com>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
 <20140219140909.GA20128@sigill.intra.peff.net> <CACsJy8CL3rQx=QHf_eABCUqS+9kZXEmopUuCMiNCL+UPyvtbyw@mail.gmail.com>
 <20140220204345.GA3374@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 21 12:58:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGokm-00071D-JV
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 12:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207AbaBUL6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 06:58:48 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:43350 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156AbaBUL6r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 06:58:47 -0500
Received: by mail-qc0-f170.google.com with SMTP id c9so5401642qcz.15
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 03:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aFLW+RN8na+adhFypaQWBemk3LIuKQZiW4Da6nZBqaA=;
        b=tw/J1nh5FY8/dHYJt+zop9aDZ0pK40dFVK+FjhafTiK+ErCP+JsFUeeX+RSB2BHF8t
         sPHfRtbnpwPDzvymwGw63u/kwXTeYbHhzsSoZCjDUlwEsGLD4RVcJwAp5IDQU4saJYKs
         a9ux63V049oqlhwG53oqH1/RxKeovHxxZNPYHPNHb9ZNYAItw3Mgyu8TwZOBa+1JMbOn
         BPDDFtiLdmytkqZ64OCtCZ1NGfvfsJP4Xjhuayn9ZsBHGDRMwehvM6CLcPxglhEGcJsk
         SVUF4jI7MOJcrTyRo/91ASY4NRBxxlrEiLL8+psKdL7wGR98jjsTEoU2phAATq+5+nXp
         MyNA==
X-Received: by 10.224.161.5 with SMTP id p5mr9120530qax.88.1392983926889; Fri,
 21 Feb 2014 03:58:46 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 21 Feb 2014 03:58:16 -0800 (PST)
In-Reply-To: <20140220204345.GA3374@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242462>

On Fri, Feb 21, 2014 at 3:43 AM, Jeff King <peff@peff.net> wrote:
> I think I actually prefer the full word "version", as you have already.
> It's clear what it means, and we can extend the syntax generally to:

Agreed. It's hard to find a letter that reminds you about "version".

>
>   --sort=[-][comparison:]field
>
> like:
>
>   --sort=-version:subject
>
> for descending version-sort by subject.  And then as a special-case
> convenience, make "version" without a field default to
> "version:refname". There's no ambiguity because the set of comparison
> names and field-names is fixed, and we know there is no overlap.
>
> If want to, we can _also_ give a one-letter abbreviation to the
> comparison field, like:
>
>   --sort=v:subject
>
> but that is not necessary.

Why not reversed order? So its syntax could be

[ "-" ] FIELD [ ":" [ "version" | "v" ] ]

It fits better to current f-e-r syntax where modifiers are after the
colon. And it avoids the possibility that someone adds field "version"
and we can't tell what "version" is what.
-- 
Duy
