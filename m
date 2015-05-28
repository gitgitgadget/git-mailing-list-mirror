From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] send-email: allow multiple emails using --cc --to and --bcc
Date: Thu, 28 May 2015 11:26:06 -0400
Message-ID: <CAPig+cRb0GstQThkprzBA=VwHSFxUeX6KDdSA7Xjdb_B2mH6Uw@mail.gmail.com>
References: <1432809733-4321-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 17:26:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxzhJ-00016h-3V
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 17:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbbE1P0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 11:26:09 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33486 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbbE1P0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 11:26:06 -0400
Received: by igbpi8 with SMTP id pi8so116651258igb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QsUq2QrOrdX0lkU+ct2bxJ1+7BhH2qumYXQt5B2zo+Y=;
        b=FhiYsbp3g/99mYANxaK+RgDBqnO3wxG8ZYRIP3ypXgsC2ykXjA0aL/u/3SJEvYqg9h
         T8s1L4efIivuylk5uAPeX6HAXZ1lKtH8EV8mjp7+Zpr6wFTwSPuiLqXZ84I8oDfpyg8j
         j6fdThwo0Cf+coz+OZwlJ3q9nnQvqySCdKYkvW5164IODwFn9wk29/y4yZIBJ4nfCfmp
         7S+iZAdTSbig7JIVMFU9T25yLPKhDH0MeExsc84S88QzE8jLXgIp/FAdO+7R7WV5lILE
         sG5h+bw52gbw8mfZfWba8RYnRPRJeE1f2WiZ/D4bFx8gVIHjlkWDpfMY4DWjF9l70G09
         WoYg==
X-Received: by 10.50.79.202 with SMTP id l10mr12010155igx.7.1432826766183;
 Thu, 28 May 2015 08:26:06 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 28 May 2015 08:26:06 -0700 (PDT)
In-Reply-To: <1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: F49XbufDeIRXU2DU2zmdXDS_SwE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270153>

On Thu, May 28, 2015 at 6:42 AM, Remi Lespinet
<remi.lespinet@ensimag.grenoble-inp.fr> wrote:
> Add the possibility to use a list of emails separated by commas
> in flags --cc --to and --bcc instead of having to use one flag

s/--cc --to/--cc, --to/

Ditto in subject.

> per email address.
>
> The use-case is to copy-paste a list of addresses from an email.
> This change makes it so that we no longer need to cut the list.
>
> The format of email list handled is basic for now:
>         $ git send-email --to='Foo <foo@example.com>, bar@example.com'
> We thought it would be nice to have a "first-step" version which works
> before handling more complex ones such as names with commas:
>         $ git send-email --to='Foo, Bar <foobar@example.com>'
>
> This artificial limitation is imposed by 79ee555b (Check and document
> the options to prevent mistakes, 2006-06-21).
>
> Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
> Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Contributions-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>

Helped-by: may be more appropriate than Contributions-by: on this
project. Also, move it above the sign-offs.

> ---
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 043f345..0aeddcb 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -49,17 +49,21 @@ Composing
>         of 'sendemail.annotate'. See the CONFIGURATION section for
>         'sendemail.multiEdit'.
>
> ---bcc=<address>::
> +--bcc="[<address>,...]"::

Adding square brackets indicates that the addresses following '=' are
optional, which is incorrect. It should be sufficient merely to add
the comma and ellipsis. Also, the need to quote strings containing
whitespace is a shell issue not specifically related to this option.
That is, people have to understand quoting issues in general, so it
doesn't make sense to mention them literally here. Thus:

    --bcc=<address>,...::

should be sufficient.

>         Specify a "Bcc:" value for each email. Default is the value of
>         'sendemail.bcc'.
> -+
> -The --bcc option must be repeated for each user you want on the bcc list.

I think it's harmful to remove this line. Although the "must" is no
longer true following this change, it's still important for people to
know that they can use --bcc multiple times. So, perhaps just reword
it:

    This option may be specified multiple times.

> +       The format supported for email list is the following:
> +       "Foo <foo@example.com>, bar@example.com".
> +       Please notice that the email list does not handle commas in
> +       email names such as "Foo, Bar <foobar@example.com>".

A few issues:

In order for this to format correctly in Asciidoc, the text needs to
be left-justified (just as was the line which you removed).

The sentence "The format supported..." seems superfluous. It's merely
repeating what is already clearly indicated by "--bcc=<address>,...",
thus it could easily be dropped without harm.

Mention that commas in names are not currently handled is indeed a
good idea, however, "please" tends to be an overused and wasted word
in documentation. More tersely:

    Note: Addresses containing commas ("Foo, Bar" <...>)
    are not currently supported.

The above comments also apply to --cc and --to.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index ffea500..409ff45 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1052,7 +1038,8 @@ sub sanitize_address {
>  }
>
>  sub sanitize_address_list {
> -       return (map { sanitize_address($_) } @_);
> +       my @addr_list = split_address_list(@_);
> +       return (map { sanitize_address($_) } @addr_list);
>  }

Although, it was convenient from an implementation perspective to plop
the split_address_list() invocation into sanitize_address_list(), it
pollutes sanitize_address_list() by making it do something unrelated
to its purpose.

If you examine places where sanitize_address_list() is called, you will see:

    validate_address_list(sanitize_address_list(@xx))

which clearly shows that sanitation and validation are distinct
operations (and each function does only what its name implies). To
continue this idea, the splitting of addresses should be performed
distinctly from the other operations, in this order:

   split -> sanitize -> validate

or:

    validate_address_list(sanitize_address_list(
        split_address_list(@xx))

That's pretty verbose, so introducing a new function to encapsulates
that behavior might be reasonable.

>  # Returns the local Fully Qualified Domain Name (FQDN) if available.
> @@ -1193,6 +1180,10 @@ sub file_name_is_absolute {
>         return File::Spec::Functions::file_name_is_absolute($path);
>  }
>
> +sub split_address_list {
> +       return (map { split /\s*,\s*/, $_ } @_);
> +}

This is somewhat misnamed. It's not splitting the address list in the
sense that sanitize_address_list() and validate_address_list() operate
on the list of addresses. The name implies that it's somehow
partitioning the list of addresses, but in fact it's iterating over
the incoming list and (possibly) splitting each item into multiple
pieces. Perhaps a better name would be split_address_list_items() or
something.

>  # Returns 1 if the message was sent, and 0 otherwise.
>  # In actuality, the whole program dies when there
>  # is an error sending a message.
