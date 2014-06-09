From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH/RFC v1 2/5] add strbuf_set operations documentation
Date: Mon, 9 Jun 2014 14:49:58 -0700
Message-ID: <20140609214958.GA18783@hudson.localdomain>
References: <cover.1402301815.git.jmmahler@gmail.com>
 <ce477667323a531b4b3c39724160e66360061816.1402301816.git.jmmahler@gmail.com>
 <CAPig+cSB78YZiqWm7oTn3oFXE2yZZFbKmD6R5oHmEJMc9CtwvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 23:50:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7SC-0003nA-Qc
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 23:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbaFIVuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 17:50:05 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:32802 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaFIVuD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 17:50:03 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so5446333pbc.2
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SKZEIyhNxRLuXDkiQ80My6UN7Uc6kCGbUb8DZAn9PeY=;
        b=rxwYUYk6z4k+bbjJZt2IVEqfgZM7zBq4fGotC966hF+4RBJouDkuPcqlN+QOylRNo7
         5mVSHPosov0JLoosSGk0WXYzpi96q75LpfJlmixXMfOUb4RYk96t6Fk30jGKc6b5zJTy
         9b2BXZCZUr91r8AOqDcr0a7ZzNVByI+JAa0+qFf76E6ZNkK1Zt9lJmKIVUFerAaU0rxW
         SyOh6lZPdfzpMXFHvELII81ZhPZhhADr8CBD21+nOd13yMoMNNhMhEzl7ZDIWuwkq4nr
         DjHS7A1aX/02WvogIHzBnmDpnxfCjG16C5MU9gPo2y81bEf/3l52JCtknm2UEhwj10fp
         3sbg==
X-Received: by 10.69.19.139 with SMTP id gu11mr7278227pbd.36.1402350602592;
        Mon, 09 Jun 2014 14:50:02 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id io8sm65668353pbc.96.2014.06.09.14.49.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 14:50:01 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:49:58 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAPig+cSB78YZiqWm7oTn3oFXE2yZZFbKmD6R5oHmEJMc9CtwvQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251104>

Eric,

On Mon, Jun 09, 2014 at 05:53:49AM -0400, Eric Sunshine wrote:
> On Mon, Jun 9, 2014 at 4:36 AM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> > Add documentation of the strbuf_set operations to
> > technical/api-strbuf.txt.
> 
> Since this patch is concise and so closely related to patch 1/5, it
> probably should be squashed into that one.
> 
Fixed.

> More below.
> 
> > Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> > ---
> >  Documentation/technical/api-strbuf.txt | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
> > index 077a709..ab430d9 100644
> > --- a/Documentation/technical/api-strbuf.txt
> > +++ b/Documentation/technical/api-strbuf.txt
> > @@ -149,6 +149,24 @@ Functions
> >         than zero if the first buffer is found, respectively, to be less than,
> >         to match, or be greater than the second buffer.
> >
> > +* Setting the buffer
> > +
> > +`strbuf_set`::
> > +
> > +    Set the buffer to some data up to a given length.
> 
> I personally find this slightly ambiguous. Upon reading it, the first
> question that pops into my mind is whether or not the existing strbuf
> content is replaced (even though "set" should imply that it is). I
> wonder if it would make sense to rewrite as:
> 
>     Set the buffer to [...], replacing the old content
>     of the buffer.
> 
> Alternately:
> 
>     Replace the buffer content with [...].
> 
On a second reading, I agree that it is ambigous.  'Replace' is much
more clear.  Great suggestion.

> Ditto for the others.
> 
> > +`strbuf_setstr`::
> > +
> > +       Set the buffer to a NUL-terminated string.
> > +
> > +`strbuf_setf`::
> > +
> > +       Set the buffer to a formatted string.
> > +
> > +`strbuf_setbuf`::
> > +
> > +       Set the current buffer to the contents of some other buffer.
> > +
> >  * Adding data to the buffer
> >
> >  NOTE: All of the functions in this section will grow the buffer as necessary.
> > --

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
