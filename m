From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 0/2] Update git-send-email-script with --compose
Date: Mon, 5 Sep 2005 23:16:57 +1200
Message-ID: <46a038f905090504166246dc0a@mail.gmail.com>
References: <11258971871874-git-send-email-ryan@michonline.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 13:20:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECEyL-0004yU-6n
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 13:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVIELRD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 07:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVIELRD
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 07:17:03 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:23259 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750971AbVIELRC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 07:17:02 -0400
Received: by rproxy.gmail.com with SMTP id i8so650071rne
        for <git@vger.kernel.org>; Mon, 05 Sep 2005 04:16:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FoBZ2faooMo6dyFuhj3lIEYAl0Q5edrTdsl4tXsgLu8ngEx5oJssIW0msN/c5Q6Sw0ZFRCABwzooVr5wf+7wYaggpIICmYRUet8394l3LqXL70io9YAe2of3T7STYkcNl9We0XyPIYecoVtYuL4zi+zQkYtyn6s+NqMHe59onpw=
Received: by 10.38.101.34 with SMTP id y34mr711648rnb;
        Mon, 05 Sep 2005 04:16:57 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 5 Sep 2005 04:16:57 -0700 (PDT)
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <11258971871874-git-send-email-ryan@michonline.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8090>

Ryan,

is it possible to fix the git-send-email script to "just work" reading
in the emails that `git-format-patch-script -o patchdir origin`
generates? I have a very ugly local patch to git-send-email-script
that

 - reads "from" from git-var, can be overridden by passing an explicit --from
 - reads "subject" from the first line of STDIN or file. If the line
doesn't start with [PATCH it provides the [PATCH] prefix. I found it
really confusing that it wants to get 'from' in the first line...
that's not what git-format-patch produces!
 - it never prompts for anything

I then invoke it with 

  git-send-email-script --to git@vger.kernel.org patches/0001-bad-uglypatch

and it "just works". I haven't sent them anywhere because I just
wanted it to work locally for me, and it's just a bunch of hacks. And
you are clearly using something other than git-format-patch to
generate those patchfiles -- and my patches would break that.

OTOH, it'd be great if it did support the git-format-patch output. Let
me know if you want bits and pieces of my hack - though it's trivial.

cheers,


martin
