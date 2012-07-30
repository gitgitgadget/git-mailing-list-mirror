From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 18:11:40 +0530
Message-ID: <CAMK1S_hhYi=dLrPy2j28=QMi-UDg7ZGXU=t9WqykVmx3XRyswQ@mail.gmail.com>
References: <jv5tln$96e$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Badie <thomas.badie@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 14:41:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvpIB-0000iK-K6
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 14:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab2G3Mlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 08:41:42 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39520 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753827Ab2G3Mll (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 08:41:41 -0400
Received: by lahd3 with SMTP id d3so3366511lah.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Mjb1BzmxSSmZ44Oc/oJ2F/C0+30Nh21HRwhGDTtTvrQ=;
        b=HjVxfaWQV5coQwyF9qbrbgs3/kjtWg/f9tkJ8TUw/U4Ab++cEzg9Cj57yJZGFnPi1y
         NSe1F4jV2g68+mM9JzwGX9KBjOyPAIf/tRGyKSJhqACzqCRo0KMC1sFcVvdd7ubqx5Zw
         YrT0uwbvz0M7hkHBOkiykaF0OetObgYzMLCeoCMpFPm4Tjz1jHkU7VbbnnBZ+bgXn+f1
         r/JPq/m1BK+TF8dPc+r48pfkXJiVLC+PL8dyhQheMtTgafArivyax54TnrZ+gc4orQ3H
         OLDMPNFX2g3l+8opUZT4p6eYg+hiNllDBCLF3kzkiQGgQPUAWCMeKWzkUcqruthqq9HJ
         lzdw==
Received: by 10.152.106.233 with SMTP id gx9mr11292435lab.48.1343652100322;
 Mon, 30 Jul 2012 05:41:40 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Mon, 30 Jul 2012 05:41:40 -0700 (PDT)
In-Reply-To: <jv5tln$96e$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202540>

On Mon, Jul 30, 2012 at 5:41 PM, Thomas Badie <thomas.badie@gmail.com> wrote:
> Hi all,
>
> When I should fixup or squash a commit, I nearly never
> remember how to get the sha1 of the commit I want to fixup.
> Because sometimes HEAD~n is not enough, I make `git log`,
> copy the sha1 of the right commit and paste it in my git
> fixup command. So I wrote a perl script to avoid the usage
> of the mouse. And after discussion with some of my friends,
> this can be generalized as a generic command line interface
> tool to get a sha1.
>
> The idea is to have a perl module which run through
> the log history and print 10 shortlog associated with a number
> from 0 to 9, and a message below "Select commit [| 0, 9 |] or
> next row ?" or this kind of message with several options.

In general, I prefer nothing to be *interactive*, so I would vote an
emphatic no.

Also, try "tig" and see if you can customise it.  For example, in
order to create a new commit that is meant to be a fixup of some other
commit, I 'git add' what is needed (either command line or tig again)
then hit "m" to the main window, scroll down to the commit concerned,
and hit "=".

That "=" comes from this line in ~/.tigrc:

    bind    main            =   !git commit --fixup=%(commit)

Please use such methods to keep interactivity where it belongs, is my opinion.
