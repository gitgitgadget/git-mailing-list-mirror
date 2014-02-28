From: =?UTF-8?B?572X5Li55bKz?= <dirkdyluo@gmail.com>
Subject: Re: [PATCH] parse-options.c:parse_options_check() change
 OPTION_NUMBER to OPTION_CMDMODE
Date: Fri, 28 Feb 2014 18:49:30 +0800
Message-ID: <CAFvDSgJZ_Ku9EoBO8UoG5iugf-0dLNwfMFqRz=z-KeJD4Tsa3g@mail.gmail.com>
References: <1393578442-2822-1-git-send-email-sunheehnus@gmail.com>
	<531061D1.2060206@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 11:49:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJL0b-0005rL-FR
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 11:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbaB1Ktd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 05:49:33 -0500
Received: from mail-wg0-f65.google.com ([74.125.82.65]:33816 "EHLO
	mail-wg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaB1Ktc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 05:49:32 -0500
Received: by mail-wg0-f65.google.com with SMTP id l18so157244wgh.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 02:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=xD4n7noc+7+v8R00J8Jy7kotvnUkV6JgGXPU/hvq8G8=;
        b=vFNdC6TAegAmmtQctYSGhVhg/sO4dq9v+iETNyEF3B9FCpj/b9HIS0FGbk8/yn/mGK
         3+qJOlIWMzeNMo8U7rL/kkndq0sRj6zEVTyftF92+P+zYBG5b6qNHu/hD2YjOX1/+oe3
         S7CaENg0sLYiYeNX9+2mS0sDy7OClCzeYPK+q+oAeHbNtUdsZnC0/KqH2XZsfR0uNvVF
         Xbiovqntq6Yxm3lU20ulL4jrO6xFAvfOIaJACR/nIBdIpbmO4vwgGHVzO4nUy8IFrDkb
         IXitVR0r1nMwwC9u918teLTvMr4nS8EljW5+KWpassdVXfFe3epXDR64htOQ+TlFlef/
         umMA==
X-Received: by 10.194.85.168 with SMTP id i8mr1073754wjz.81.1393584570794;
 Fri, 28 Feb 2014 02:49:30 -0800 (PST)
Received: by 10.216.238.197 with HTTP; Fri, 28 Feb 2014 02:49:30 -0800 (PST)
In-Reply-To: <531061D1.2060206@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242939>

On Fri, Feb 28, 2014 at 6:15 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> On 02/28/2014 10:07 AM, Sun He wrote:
> > Signed-off-by: Sun He <sunheehnus@gmail.com>
> > ---
> >  parse-options.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/parse-options.c b/parse-options.c
> > index 7b8d3fa..59a52b0 100644
> > --- a/parse-options.c
> > +++ b/parse-options.c
> > @@ -371,7 +371,7 @@ static void parse_options_check(const struct option *opts)
> >               case OPTION_NEGBIT:
> >               case OPTION_SET_INT:
> >               case OPTION_SET_PTR:
> > -             case OPTION_NUMBER:
> > +             case OPTION_CMDMODE:
> >                       if ((opts->flags & PARSE_OPT_OPTARG) ||
> >                           !(opts->flags & PARSE_OPT_NOARG))
> >                               err |= optbug(opts, "should not accept an argument");
> >
> > --
> > 1.9.0.138.g2de3478.dirty
> >
> > Hi,
> > When I was reading code yesterday, I came across this protential bug.
> > parse-options.h says that OPTION_CMDMODE is an option with no arguments and OPTION_NUMBER is special type option.
> >
> > According to the information the program says (Should not accept an argument), I think you should take this patch into consideration.
> > Thanks.
> >
> > He Sun
>
> Please resubmit this change in the proper format (as described by Eric
> Sunshine WRT another one of your patches).  Also please remember to
> distinguish between information that should go in the commit log
> message, which will be stored permanently to the repository and help
> future developers understand your change, vs. side notes meant only for
> the mailing list.  For example, for the log message, stuff like:
>
>     OPTION_CMDMODE should be used when ... So change the mode to
>     OPTION_CMDMODE so that ...
>
> vs. for the mailing list discussion:
>
>     When I was reading code yesterday ...
>
> The former goes above the "---" line and the latter goes directly below it.
>
> BTW, none of my comments should be taken to indicate whether the commit
> itself makes sense or not.  I haven't checked that far.
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


>.<
