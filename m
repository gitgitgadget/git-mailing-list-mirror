From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 0/4] ls-remote: introduce symref argument
Date: Sun, 17 Jan 2016 18:39:52 +0100
Message-ID: <20160117173952.GF7100@hank>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <20160117151622.GD15519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 17 18:39:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKrIY-0000Yb-7E
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 18:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbcAQRj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 12:39:26 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35564 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbcAQRjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 12:39:25 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so5114900wmz.2
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 09:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=w2D9aUOQZoTfaZ/lwM2vyV96Agui2gwZLzrCMb76Ix0=;
        b=Mv/LK6cJhDNOCS8uupnsJTdtdQWFtrv6McLbGCyMpcR8uCUovm22N2yalu1r4HCZwT
         UfI4L4+Xlu5KUPZ8Nz6RaQqVv9hY8Aiv+Bc30pq/qLUABvtYD3efkscZGKhDaocAbqye
         XR/YSGKIL7tUr+RGq+5j3ilzjfN7K+g0NXFPeyafSl72Yj07YrGn5XMcLsmUt5PTN87O
         b379/xKAfDhgJmMpdwoLzljFIzCBaPVMACmtOKWZa4YaNzIwxPukijc66gp/sIKlovEK
         jLYHR+GAJkojhlzEEhQB9znRBJo5JrHWlLGNALxeEgC3acLwDJK1IeEutG5INOb9/T2D
         Gd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=w2D9aUOQZoTfaZ/lwM2vyV96Agui2gwZLzrCMb76Ix0=;
        b=ElYz2yMn7BW+dN754RfZ08Eog4CxEbb4p8upsfcGOo2zl+xzEVbW3Vn4OqNUk5dsA2
         nNRPmRt8pjmBF+CGRRHjD//tpNo6ZB4OPqveFDhPwO90dPEC5RLWv4uHp5PbeCbSpUYS
         Ir/+wa0q5WzusOu0BiCmUVx+AC0jEU9KMU4X5kLXJ8iBHJ6Gvn2zL13XZMCLmTPaLMsK
         aNotxvLuxuYqQNB5asu+50aymUnBtk8FEJYIgm+j3S26bavNLYHXTdJ6t5BTdDl0q912
         yW5lTdqT9k5XVoliG3sjbZ4C0uUe+/K4PwJjbln03vLcyEtg2E667CyyZ5/FeFGXbgBw
         Z3Fw==
X-Gm-Message-State: ALoCoQn3uTHXy1Xkm41wjPZiYayFRmEiJYWFF0Fx+KV2KwUHEezOrzqWPsTlDdmFapQkRG4H1IEs4pdyYW3Npm1IE1SSrUYjJw==
X-Received: by 10.194.9.169 with SMTP id a9mr19764343wjb.60.1453052364564;
        Sun, 17 Jan 2016 09:39:24 -0800 (PST)
Received: from localhost ([95.233.44.41])
        by smtp.gmail.com with ESMTPSA id z127sm12043784wme.2.2016.01.17.09.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 09:39:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160117151622.GD15519@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284264>

On 01/17, Jeff King wrote:
> On Sun, Jan 17, 2016 at 12:03:58PM +0100, Thomas Gummerer wrote:
>
> > > I thought it might be nice for any porcelain which tries to wrap
> > > `ls-remote`, make some decision based on the capabilities, and then
> > > invoke another plumbing command. But I guess that is probably slightly
> > > crazy, and nobody is doing it.
> > >
> > > Something like `ls-remote --symrefs` probably would be a better place to
> > > start.
> >
> > Turns out adding this is pretty simple.
> >
> > The first two patches are documentation, which I noticed when reading
> > up about the command.  Patch three is a cleanup patch, which makes
> > ls-remote use the parse-options api instead of the hand-rolled option
> > parser.  Patch four is actually adding the option.
> >
> > Thomas Gummerer (4):
> >   ls-remote: document --quiet option
> >   ls-remote: fix synopsis
> >   ls-remote: use parse-options api
> >   ls-remote: add support for showing symrefs
> >
> >  Documentation/git-ls-remote.txt | 12 +++++-
> >  builtin/ls-remote.c             | 90 +++++++++++++++++------------------------
> >  t/t5512-ls-remote.sh            | 20 +++++++++
> >  3 files changed, 68 insertions(+), 54 deletions(-)
>
> Thanks for working on this. One of my favorite things about open source
> is when I realize I'm too lazy/busy to work on something, and then it
> magically appears in my inbox. :)

:) thanks for suggesting it, and thanks for the review!

> This looks like a good start. I left a few comments on the specific
> patches.
>
> -Peff

--
Thomas
