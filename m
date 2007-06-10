From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Add gitmodules(5)
Date: Sun, 10 Jun 2007 10:58:29 +0200
Message-ID: <8c5c35580706100158n7dabfce4y5f79f8943d8abb87@mail.gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	 <11814251322779-git-send-email-hjemli@gmail.com>
	 <20070610002802.GD31707@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sven Verdoolaege" <skimo@kotnet.org>, git@vger.kernel.org
To: "Frank Lichtenheld" <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:58:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJFo-00072e-Od
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbXFJI6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbXFJI6b
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:58:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:36382 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbXFJI6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:58:30 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1691634wah
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 01:58:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kjf2zv72ZPyptn67N+B0nIZtdQXfdvhoj05ReJUBFS2hF1noQ/u7YR5nB9p88929Og70Z5+mFSjVXbCrWIod7i0J+T8w9RY5J+Z0O0XNY7AOJgZT0c+i4q0Qfq5rjyCPhgUu5u3ZzgjMgS+VZBquN8YqTpvG9jtEZVqKnIFQcUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZkQI6rtE2vKxz66PcjcH5bbnJVxGcSI7QbMSSaciqomXOTYJm9WwuO0uDYCtVnK93CykV9SfYyc5t0wD19XkWn0xPoeIwLq28JqRoRBOUqBKiPZH2sTrNeacB8Yq0FrM8eueOVU3R2uwDe4ZFypfFvbLOg1UQkznS4HB78NWCg4=
Received: by 10.114.81.1 with SMTP id e1mr4300153wab.1181465909676;
        Sun, 10 Jun 2007 01:58:29 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Sun, 10 Jun 2007 01:58:29 -0700 (PDT)
In-Reply-To: <20070610002802.GD31707@planck.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49689>

On 6/10/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> The unofficial git documentation nitpicker at work ;)

That's good, keep it up :)

>
> On Sat, Jun 09, 2007 at 11:38:51PM +0200, Lars Hjemli wrote:
> > +The `.gitmodules` file, located in the top-level directory of a
> > +gitlink:git[7] working tree, is a text file with a layout matching the
>
> That link seems superfluous to me.

Yeah, what I really wanted here was a link to the definition of "git
working tree". I'll drop it.

> I would have used "syntax" instead of "layout".

Agreed

>
> > +requirements of gitlink:git-config[1].
> > +
> > +The file consists of sections named `module`, divided into one subsection
> > +per submodule. The subsections are named with the logical name of the
> > +submodule it describes.
>
> "sections named module" sounds confusing to me. Why are there multiple
> sections named module? (for the record: I know what you mean, I just
> don't know if it couldn't be said simpler)
> Maybe better "subsections of section `module`, one per submodule"?
> Hmm, sounds ugly too.

Good documentation is hard, so I'll work on it some more...

>
> > +Each submodule can contain the following keys.
> > +
> > +module.$name.path::
> > +     Define a path, relative to the top-level directory of the git
> > +     working tree, where the submodule is expected to be checked out.
> > +
> > +module.$name.url::
> > +     Define a url from where the submodule repository can be cloned.
>
> For .path a "Defaults to name of submodule" probably wouldn't hurt.

True. But there might be some issues with this rule, so I'll leave it
as is for now.

>
> For the sake of documentation consistency I would suggest
> module.<name>.path. You can compare the output of
> $ grep "\.<[a-z]" Documentation/*.txt
> with
> $ grep "\.\$[a-z]" Documentation/*.txt
> to see what I mean.

That was very descriptive, thanks!

>
> > +     [module 'libfoo']
> > +             path = include/foo
> > +             url = git://example1.com/git/libfoo.git
> > +
> > +     [module 'libbar']
> > +             url = git://example2.com/pub/git/libbar.git
>
> This would actually be a syntax error in a git config file
> (subsection names can be enclosed in "" but not '').

Shame on me for drinking while documenting ;-)

Thanks for the review, I'll try to send a fixed-up patch later today.

--
larsh
