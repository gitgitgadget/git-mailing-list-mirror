From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: A couple of rebase --autosquash proposals
Date: Mon, 9 Dec 2013 10:39:12 +0100
Message-ID: <CAGK7Mr75jPCWWRDE9ohLXaxk-JuRosf8960KfJ0HknaAVq-qXg@mail.gmail.com>
References: <CALeEUB4mTpd9tHJCC9Ffrfe6L=m0+gaDsXYSFGaO_tMcxCX_nA@mail.gmail.com>
 <52A56887.4070909@viscovery.net> <52A58CBB.6040809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Brett Randall <javabrett@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 10:39:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpxJc-0003kE-04
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 10:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761112Ab3LIJjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 04:39:44 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:43854 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab3LIJjn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 04:39:43 -0500
Received: by mail-ob0-f173.google.com with SMTP id gq1so3429279obb.4
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 01:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ns0cQjpYuVDwpE25wLL52q44VSFqshiD9nyNzfMZCMs=;
        b=pu/ri4oHVdVpwFzRL6mXWpjBkLfkYWxz1wq/BFbCOLD9tI+POa8mkO9V5p9gMdMs1c
         fVTfEPyK4s3iJ/pBgnnFYX6LzYPke+nSnJUO/EopdUD3u1r19T/pKJdj0SglJKDEdNCs
         bhrMVREr8VJQAcFBRsuhhQTQe/Cnzmb/nXsewU+PYUr83vM3QYorU13h0pQVjleJdfae
         afJ5Ribi9KRyJmU9Fgwnblfre86yTa4haNq/s2QDSzILE5UyNzsMTxQgBjYX+rMrmX69
         Ed6GRUzd0oR+UNz9hdkniE06TSKKR3Vg6z1ERFzeVwmtRw2FeXxYOdAF1fcKk/E4M585
         iA1A==
X-Received: by 10.182.16.33 with SMTP id c1mr11981514obd.4.1386581982524; Mon,
 09 Dec 2013 01:39:42 -0800 (PST)
Received: by 10.76.187.102 with HTTP; Mon, 9 Dec 2013 01:39:12 -0800 (PST)
In-Reply-To: <52A58CBB.6040809@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239063>

> >> * fixup! or squash! on it's own would default to fixing-up the
> >> previous commit (or result of previous step of rebase if that was a
> >> squash/fixup).
> >
> > Why would you want that? To fixup the previous commit, just use 'git
> > commit --amend'. What am I missing?
>
> In the past I've used this kind of approach when doing merging/porting
> work with 3rd party code (or just large integrations). The first (and
> eventually final) commit introduces the new code. The subsequent fixups
> address build issues which are either errors in the 3rd party code
> (which I will want to submit bug reports for later and carry in my tree
> as real commits) or errors in my merging (which I want to squash into
> the merge commit). When faced with a screen full of compilation errors
> I'm not sure which of these 2 categories are applicable at the time so I
> tend to have lots of little fixups that I need to juggle around with git
> rebase once I've got the code compiling and passing some tests.
>
> All that being said I think allowing multiple "fixup!\n" stack up on
> each other might be a bit dangerous. There are cases where
> fixup!-fixup!-real might be useful but those would be hard to
> distinguish those from cases where someone absent mindedly forgot to put
> something after "fixup!".


You guys probably already know about it, but there is `git commit
--fixup SHA1` to create !fixup commits intended for a particular
commit. I think using this feature solves all the problem the OP has?

Philippe
