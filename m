From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] userdiff: support Java try keyword
Date: Mon, 02 Jun 2014 12:25:20 -0700
Message-ID: <xmqqr4373yhr.fsf@gitster.dls.corp.google.com>
References: <1401682405-3319-1-git-send-email-ch3cooli@gmail.com>
	<1401682405-3319-2-git-send-email-ch3cooli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sup Yut Sum <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 21:25:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrXrU-0003Ab-AU
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 21:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbaFBTZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 15:25:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52371 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbaFBTZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 15:25:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D80F1DF15;
	Mon,  2 Jun 2014 15:25:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P9opshLnqnvc7CSWxkJWpNkHWvc=; b=ZlS3On
	PnKO+GtNQfT/u9Uo+i1y32bmOrXCu9nwZ04Y07o12Wyn0+ekD/IlIxlT1tCPcTj3
	dXoEAaYytuqxZcYXkd7SnoTWnBviQ02KHMyRsjld/OhmCxqm6gOoLEwx8KrXUD76
	SQLNVZncj9otFrbAst4xIj1ExilUekV8S1tNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NP1kZiQf7EiVKESIJSB4oV80OAiEhkd3
	Hxb9OZb+haeHu0wIPFUedK8HxHBegKOpB/dMkZ6aoHKdzPawkFcEOMe2Jy3WV5Wd
	WSV0FgKnPEbCHF3HZ0GH9CbAYmvdonmEUa49m/HOwDjdEpqByHXsYWQhc/PQaD3d
	WpNywlbaX0c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 34A031DF14;
	Mon,  2 Jun 2014 15:25:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7829D1DF0E;
	Mon,  2 Jun 2014 15:25:22 -0400 (EDT)
In-Reply-To: <1401682405-3319-2-git-send-email-ch3cooli@gmail.com> (Sup Yut
	Sum's message of "Mon, 2 Jun 2014 12:13:25 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A40E90C0-EA8B-11E3-89B4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250583>

Sup Yut Sum <ch3cooli@gmail.com> writes:

> try keyword is enhanced in Java 7, see try-with-resources Statement
> try (XX yy = new XX()) {
> } catch (Exception e){
> }

Sorry, but I do not see the connection between the proposed log
message and what the patch does.

The patch seems to tell me this:

    We did not know 'try' was a keyword to begin a block for java,
    whether that 'try' is a traditional 'try' or 'try' in
    'try-with-resources'.  With this patch we start recognising
    'try' as a keyword.

and nothing else, but the log message makes it sound as if the more
prevalent use of try-with-resources in Java 7 makes it for some
reason more important to recognise it as a keyword than it used to
be---or is that what you meant to say?

Puzzled...

> Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
> ---
>  userdiff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/userdiff.c b/userdiff.c
> index 96eda6c..49e898b 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -39,7 +39,7 @@ IPATTERN("fortran",
>  PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
>  	 "[^<>= \t]+"),
>  PATTERNS("java",
> -	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
> +	 "!^[ \t]*(try|catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
>  	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
>  	 /* -- */
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
