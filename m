From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 13:07:25 -0500
Message-ID: <CAMP44s2umN3prdPnb=kuvH4OrQqcKDyu8ExfkXHAR2nC=a6weA@mail.gmail.com>
References: <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
	<CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
	<CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
	<CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
	<CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
	<CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
	<CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
	<20130609043444.GA561@sigill.intra.peff.net>
	<CALkWK0kkGO8zoLSpZkaYgVr5eBX6AovYFxQZkgJKugSw0CmdXQ@mail.gmail.com>
	<20130609175554.GA810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:07:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulk1b-0006LS-Ka
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab3FISH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:07:27 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:48102 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab3FISH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:07:27 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so4862281lab.38
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EX2IjAxO2SvcLf+JOAjerIjidUm8YlYdgpRraElCuOI=;
        b=nOI0YtfUJS/OMpRHwRWgzLNd7hYbVAU+H+JVYuFjvPHnNGwt/DMItis1vt4zcCkKDF
         FezpZ5Y59K0tm7d/g+d/kP9IRdczXV8zdb1Q/VYb1qT/iRIYIaCPLFnVlYW7dICPeUK7
         1MkMx8tZs4IV7bSyyE10+6AnQr1W8jlWDvZM4FId03NaX2wOPoMIfFZpfQRc8lht9V8Y
         crlHtktIX5SSHmws5et+jjISK4s8Ge/B1IJrUfktxq9GSLwygxxzPZPn3mALKtNomu4i
         3rHS+Jy/NEp6vSIX6BKKiaOLfkjKgqk+ovR4Ppqxo4hHaPjtW8sKdIIBPan0N6YAdmO1
         ns5g==
X-Received: by 10.112.52.97 with SMTP id s1mr5020204lbo.8.1370801245487; Sun,
 09 Jun 2013 11:07:25 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 11:07:25 -0700 (PDT)
In-Reply-To: <20130609175554.GA810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227076>

On Sun, Jun 9, 2013 at 12:55 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Jun 09, 2013 at 03:28:48PM +0530, Ramkumar Ramachandra wrote:
>
>> Jeff King wrote:
>> > Sorry that I cannot show you the source code, but you may interested to
>> > know that libgit2 powers:
>>
>> Yes, I'm well aware of these: libgit2 is LGPL, because of which these
>> three proprietary applications have been made possible.  Isn't it
>> completely orthogonal to the discussion about how best to lib'ify
>> git.git though?  From what I understand, fc is not interested in
>> building another application leveraging libgit.a or libgit2; he's
>> interested in improving libgit.a and getting more users.
>
> Perhaps I misunderstood the discussion, but it looked to me that there
> was an assertion that libgit2 was not ready for useful work. I do not
> think that is true, and I tried to counter it with facts.

That was not the point. Take 'contrib/related/git-related', or any
useful script, and make it so it uses libgit2 instead of forking 'git
foo' commands.

It's not going to happen.

-- 
Felipe Contreras
