From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v13 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Thu, 21 Aug 2014 05:39:43 +0200
Message-ID: <CAP8UFD3hi6rRS=Z9dvbpvW75_K5mN5mPaxQdx3ATYOwXbuw3Pw@mail.gmail.com>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org>
	<20140816160622.18221.71416.chriscool@tuxfamily.org>
	<53F51B98.2060903@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 05:40:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKJE4-0006ys-N1
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 05:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbaHUDjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 23:39:44 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53590 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaHUDjo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 23:39:44 -0400
Received: by mail-ie0-f174.google.com with SMTP id rp18so4049972iec.19
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 20:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9RvlT1IZKO4jFVzq/6AND/RD4wC5QjyAxBDe1mhebmY=;
        b=iAgPC7gZ2tEDb5GFi2FaU2U7h+F9Pqy8H/a7oVGWYEKyjHcIQ2FofuMVxnit6XFZUg
         BJn2P7MYTQKj1a6URAi7mCYb+MOl1kugLzU55AyhjegOpgGP7JWeKLy0VV41Y7pck+/M
         VveiV03TwXedkdg337QbVPIApDLF3WHtH+WJmjf9cHo0CDfks1VrffEHICQhEJ6/YRLg
         ptgjIDilHaMtFrakADR1+Q3dDgaLd3nK6in7hszRXnAnrtIoGDkV3PQs4I1xBME6g6jy
         pNKnPMrVfg0C32vw3sO76usPccV7ZnuTzgthT4JUfldG/MkuMyRzxw0IhtQckWFhqFfo
         4ZWw==
X-Received: by 10.42.68.1 with SMTP id v1mr1190141ici.49.1408592383063; Wed,
 20 Aug 2014 20:39:43 -0700 (PDT)
Received: by 10.50.212.3 with HTTP; Wed, 20 Aug 2014 20:39:43 -0700 (PDT)
In-Reply-To: <53F51B98.2060903@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255596>

On Thu, Aug 21, 2014 at 12:05 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> On 14-08-16 12:06 PM, Christian Couder wrote:
>
>> +The trailers are recognized in the input message using the following
>> +rules:
>> +
>> +* by default only lines that contains a ':' (colon) are considered
>
> s/contains/contain/

Ok.

>> +  trailers,
>> +
>> +* the trailer lines must all be next to each other,
>> +
>> +* after them it's only possible to have some lines that contain only
>> +  spaces, and then a patch; the patch part is recognized using the
>> +  fact that its first line starts with '---' (three minus signs),
>
> Is that "starts with" or "consists solely of"?

It is starts with. (The starts_with() function is used.)

>> +
>> +* before them there must be at least one line with only spaces.
>
> I had little bit of trouble parsing those three points, and it seems like a
> lot of text to describe something simple.  How about a single paragraph:
>
> Existing trailers are extracted from the input message by looking for a group
> of one or more lines that contain a colon (by default), where the group is
> preceded by one or more empty (or whitespace-only) lines.  The group must
> either be at the end of the message or be the last non-whitespace lines
> before a line that starts with '---' (three minus signs).

Ok, I will use something like that, thanks.

> Also, will a trailer be recognized if there is whitespace before and/or after
> the separator?

Yes.

> Can there be whitespace before the token?

Yes.

>  In the token?

Yes.

> (I don't feel strongly about the answers to these questions, they just came to
> mind as I read the documentation.)

Ok, I will add something.

>> +Note that 'trailers' do not follow and are not intended to follow many
>> +rules for RFC 822 headers. For example they do not follow the line
>> +folding rules, the encoding rules and probably many other rules.
>> +
>> +OPTIONS
>> +-------
>> +--trim-empty::
>> +     If the <value> part of any trailer contains only whitespace,
>> +     the whole trailer will be removed from the resulting message.
>> +     This apply to existing trailers as well as new trailers.
>> +
>> +--trailer <token>[(=|:)<value>]::
>> +     Specify a (<token>, <value>) pair that should be applied as a
>> +     trailer to the input messages. See the description of this
>> +     command.
>> +
>> +CONFIGURATION VARIABLES
>> +-----------------------
>> +
>> +trailer.separators::
>> +     This option tells which characters are recognized as trailer
>> +     separators. By default only ':' is recognized as a trailer
>> +     separator, except that '=' is always accepted on the command
>> +     line for compatibility with other git commands.
>> ++
>> +The first character given by this option will be the default character
>> +used when another separator is not specified in the config for this
>> +trailer.
>> ++
>> +For example, if the value for this option is "%=$", then only lines
>> +using the format '<token><sep><value>' with <sep> containing '%', '='
>> +or '$' and then spaces will be considered trailers. And '%' will be
>> +the default separator used, so by default trailers will appear like:
>> +'<token>% <value>' (one percent sign and one space will appear between
>> +the token and the value).
>> +
>> +trailer.where::
>> +     This option tells where a new trailer will be added.
>> ++
>> +This can be `end`, which is the default, `start`, `after` or `before`.
>> ++
>> +If it is `end`, then each new trailer will appear at the end of the
>> +existing trailers.
>> ++
>> +If it is `start`, then each new trailer will appear at the start,
>> +instead of the end, of the existing trailers.
>> ++
>> +If it is `after`, then each new trailer will appear just after the
>> +last trailer with the same <token>.
>> ++
>> +If it is `before`, then each new trailer will appear just before the
>> +last trailer with the same <token>.
>
> It seems to me that it would be more sensible to make the new trailer appear
> before the *first* trailer with the same token.

Yeah, it is a copy-paste mistake that I will fix.

Thanks for the careful review,
Christian.
