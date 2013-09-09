From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: [Proposal] Clonable scripts
Date: Mon, 9 Sep 2013 14:13:00 -0700
Message-ID: <CAE1pOi0TioYa2pWCe=8kFbrSNp847rHDUbxXdxBAe=jN3BkWxg@mail.gmail.com>
References: <CADoiZqpec6rPOgPLPQFFfLdE+Cc4ZKtWs0Q0VSfKGm3b1Lai2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Niels Basjes <Niels@basjes.nl>
X-From: git-owner@vger.kernel.org Mon Sep 09 23:13:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ8ly-0003A0-4a
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 23:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632Ab3IIVNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 17:13:22 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:57839 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013Ab3IIVNV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 17:13:21 -0400
Received: by mail-vc0-f171.google.com with SMTP id ij15so4318998vcb.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ahf0fOSeUw9k5BEGbURsbEr04eipwFwx74/09gbJaoA=;
        b=JkNZ2KCzl93XQyczVrup2/V47Xa4ev6q2owzi01+C7Q8ovPQGH6iTviHgWaPRbY8fP
         41O4oHBzrHvMOrhJfcleQXCfDsA32w7Zhk50H6ZRk/z7ZmeZI7mFjirRCVWHjuD/YfgF
         HnfxI7e0Wau3KUwXf3x7LoHKN7Zbm3SN6kDC5W7NwScn7/NdYnitCtDQW7h7oM+2sZjt
         N3Ybn1oj5WmMd0ajnSvkC56cHUwnN94T7ryj4P7U3Yw5GzfIUJ2SuEObTnV7jk6LV+y2
         Gu59YgBqbhRPkEsmA+hSOdbTmt9sVRHJWokLdzfW7sBm88iUqDX25gMAqstR1hs24XjP
         Qckg==
X-Received: by 10.220.145.132 with SMTP id d4mr19308304vcv.9.1378761201011;
 Mon, 09 Sep 2013 14:13:21 -0700 (PDT)
Received: by 10.58.65.70 with HTTP; Mon, 9 Sep 2013 14:13:00 -0700 (PDT)
In-Reply-To: <CADoiZqpec6rPOgPLPQFFfLdE+Cc4ZKtWs0Q0VSfKGm3b1Lai2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234377>

On 9 September 2013 13:48, Niels Basjes <Niels@basjes.nl> wrote:
> If those scripts were how ever written in a language that is build
> into the git program and the script are run in such a way that they
> can only interact with the files in the local git (and _nothing_
> outside of that) this would be solved.

That sounds interesting.

> Also have a builtin scripting language also means that this would run
> on all operating systems (yes, even Windows).

This would be *very* helpful. It's a total pain trying to get hooks
working across different OSes.

> So I propose the following new feature:
>
> 1) A scripting language is put inside git. Perhaps a version of python
> or ruby or go or ... (no need for a 'new' language)

That sounds nice but ...

> 2) If a project contains a folder called .githooks in the root of the
> code base then the rules/scripts that are present there are executed
> ONLY on the system doing the actual commit. These scripts are run in
> such a limited way that they can only read the files in the
> repository, they cannot do any networking/write to disk/etc and they
> can only do a limited set op actions against the current operation at
> hand (i.e. do checks, parse messages, etc).

... how would you prevent Ruby/Python/Go/$GeneralProgLang from
executing arbitrary code?

> Like I said, this is just a proposal and I would like to know what you
> guys think.

I love the idea but I'm not sure how feasible it is. I think you would
be forced to copy an existing language and somehow "make it secure"
(seems like a maintenance nightmare) or to create your own language
(potentially a lot of work). But perhaps something more declarative
might be usable?
