From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Tabs and spaces
Date: Thu, 21 Apr 2011 01:51:01 +0000
Message-ID: <1235e29d-6cbb-445b-9b6f-4e174c03ba8f-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
            <20110420064318.GF28597@sigill.intra.peff.net>
            <d74e95d4-ef16-42fb-ae8f-b1d7a8b9d91e-mfwitten@gmail.com>
            <20110421000701.GA10987@elie>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 04:06:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCjI4-00069S-Sk
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 04:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652Ab1DUCGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 22:06:39 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61543 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab1DUCGh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 22:06:37 -0400
Received: by vws1 with SMTP id 1so988666vws.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 19:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=vPetfbZNQWZnXtkZJ6zqBmLFyedlQEcJtb0YSQqKrNQ=;
        b=npFSZR/H462v7FH0VKxTybae7Vyrr6N+c9Ocn7X7niRdv/2QlBEA368+LWCj6sAc85
         ve6RSvTfiApLrrbPDQqK9GQkdtwZiOOBlYOl1WskVkTYDVUyRYsKn6Xc08diVR+rsiEC
         iTZrPPVDtRxAEFcpUBk09x7mw/2Bedf2tvqtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        b=avx/1ZKZUnRdm/TcH478rptsTz6MnB4Xbyjfdv/k8YlGnyg53uS2sNaiMbfqiSm+pj
         33P6Fqli3pr6+B4onsSS1PqnKuLrxk985G+VTVRgPtShTrGKFG9xF59gihKdXwRMBnXT
         LigmGDhB5PjP1u/beHqViNL1hTvV4wP7aAcqY=
Received: by 10.52.74.74 with SMTP id r10mr740681vdv.212.1303351596823;
        Wed, 20 Apr 2011 19:06:36 -0700 (PDT)
Received: from gmail.com (saito.countshockula.com [65.183.151.13])
        by mx.google.com with ESMTPS id ej3sm296690vdb.7.2011.04.20.19.06.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 19:06:36 -0700 (PDT)
In-Reply-To: <20110421000701.GA10987@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171887>

On Wed, 20 Apr 2011 19:07:01 -0500, Jonathan Nieder wrote:

>> However - and this is the key point - if you are going to be mixing
>> tabs and spaces ANYWAY, then you might as well do it in a way that
>> maintains alignment within a tab level regardless of the current
>> setting for the tabwidth:
>
> In principle, I generally agree.  But as mentioned in the thread you
> reference, most text editors don't make that very easy.

You just need an editor that can insert into a newly created line the
same leading whitespace characters that were on the previous line (of
course, it's nice if lines with only whitespace are automatically
converted to empty lines); if your text editor can't do that, then any
style of indentation/alignment is going to be painful.

> I personally use a tabwidth of 6 when I really want to concentrate on
> reading.  When coding in a rush for other people, that leads to using
> tabstop of 8 and only aligning text that is much shorter than one tab:
>
> 	if (foo && bar && baz &&
> 	    qux && quux) {
> 		...
> 	} else if (quuux(quuuux, quuuuux,
> 				long_expresion_comes_here(quuuuuux))) {
> 		...
> 	}
>
> As you can see, this is following the "put continuation lines near the
> right margin" convention advocated in linux-2.6's
> Documentation/CodingStyle.

It's not hard to see why "near the right margin" is an important remark;
with a tabstop of 8, your code is rendered like this:

        if (foo && bar && baz &&
            qux && quux) {
                ...
        } else if (quuux(quuuux, quuuuux,
                                long_expresion_comes_here(quuuuuux))) {
                ...
        }

However, with a tabstop of 2, it looks like this:

  if (foo && bar && baz &&
      qux && quux) {
    ...
  } else if (quuux(quuuux, quuuuux,
        long_expresion_comes_here(quuuuuux))) {
    ...
  }

Notice that your `qux && quux' line (which follows the method we both like)
remained nicely aligned, but your `long_expression_comes_here' line has
moved back so much that it doesn't even satisfy the `right margin' rule
anymore.

> Two advantages:
>
>  - looks sensible with any tabstop

As we have seen, the sensibility of using tabs for *alignment* is precarious;
on the contrary, using spaces for alignment [across lines of the same level of
tabular indentation] remains *exactly* as sensible as intended by the original
author, regardless of the tabstop setting.

The problem is that there are really two issues that are being conflated"

	* Indentation : This can be implemented with tabs
	* Alignment   : This should be implemented with only spaces

> - no need to cascade changes on following lines when the width of a
>   function name changes

That is indeed the best reason to avoid alignment (after all, by its
very nature, alignment implies a coupling between lines), and I find
myself in constant intellectual conflict over that very issue. However,
if the number of lines to be aligned is rather small or alignment
obviously helps readability, then it's a rather minor risk.

Now, your example of a changing function name is a good one; for instance,
consider one of the functions that my patch series introduces:

	int parse_date_mode_config_internal(const char *var_date,
	                                     const char *var_time_zone,
	                                     const char *var,
	                                     const char *value,
	                                     struct date_mode *d,
	                                     int *ret);

I just noticed that the parameters are misaligned by one space; it should
be the following:

	int parse_date_mode_config_internal(const char *var_date,
	                                    const char *var_time_zone,
	                                    const char *var,
	                                    const char *value,
	                                    struct date_mode *d,
	                                    int *ret);

I probably changed the function name by 1 character at some point and then
forgot to update the alignment of the parameters. :-(

Now, I actually hate that style of continuation, and I only used it because
that's basically what everybody else on the planet (and in the git project)
tries to do (albeit with some apalling combination of tabs and spaces).

In such a case, I would much rather treat parameters as `subelements' of
the function construct (prototype, call, etc.) by explicitly giving them
their own indentation level; this transforms the problem from one of
indentation and alignment to a problem of just indentation, thereby allowing
for nothing but tabs:

	int parse_date_mode_config_internal
	(
		const char *var_date,
		const char *var_time_zone,
		const char *var,
		const char *value,
		struct date_mode *d,
		int *ret
	);

A function call might look like this:

	parse_date_mode_config_internal
	(
		"Some value of some sort",
		"Another value of some sort",
		"dingleberry",
		d,
		ret
	);

Of course, this opens up the debate about where the opening parenthesis should
go; if the `{' of a block is routinely put on the same line as, say, an `if',
then perhaps this would look more natural:

	parse_date_mode_config_internal (
		"Some value of some sort",
		"Another value of some sort",
		"dingleberry",
		date_mode,
		return_value
	);

An `if' statement is kind of gross to mold in this way due to the fact that
there are two parts, each with its own subelements; at some point, you might
as well just make some temporary variables with reasonably short names in
order to hold the condition value, thereby obviating this nightmare in the
first place.

However, if you must write every expression explicitly in place, then your
example could be written thusly:

	if (
 		foo && bar &&
 		baz && qux &&
		quux
	){
 		...
	} else if (
		quuux (
			quuuux,
			quuuuux,
			long_expresion_comes_here (
				quuuuuux
			)
		)
	){
		...
	}

or more drawn out:

	if
	(
 		foo &&
 		bar &&
 		baz &&
		qux &&
		quux
	)
	{
 		...
	}
	else if
	(
		quuux
		(
			quuuux,
			quuuuux,
			long_expresion_comes_here
			(
				quuuuuux
			)
		)
	)
	{
		...
	}

Again, it should be recognized that there are 2 issues:

	* Indentation : This can be implemented with tabs
	* Alignment   : This should be implemented with only spaces

and it should also be recognized that treating tabs as a primitive
means of space-saving compression by having it always represent
some constant number of spaces (8) is just as flaky as expecting
people to properly use spaces for alignment; thus you might as
well go for the latter in order to get the best of both worlds,
because somebody is going to mess it up either way.

Sincerely,
	Michael
		Witten
