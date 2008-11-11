From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: importing mercurial patch
Date: Wed, 12 Nov 2008 00:36:19 +0100
Message-ID: <85b5c3130811111536q774ad33fk76da59cf90c264df@mail.gmail.com>
References: <85b5c3130811110258h53d389co97a3c33e10667ae8@mail.gmail.com>
	 <alpine.DEB.1.00.0811111258260.30769@pacific.mpi-cbg.de>
	 <85b5c3130811110418l11be8084sf0f47a1095755747@mail.gmail.com>
	 <alpine.DEB.1.00.0811111454330.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 00:37:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L02ni-0002d9-LJ
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 00:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbYKKXgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 18:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbYKKXgX
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 18:36:23 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:7687 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbYKKXgV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 18:36:21 -0500
Received: by ey-out-2122.google.com with SMTP id 6so64453eyi.37
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 15:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=kIcKB4WaTcLS+80jn6f4teo/uapW0tESHHhs66kit90=;
        b=h2LDyAjVRMyjbZPJlHq8Y79CJVhoPV59ruDCLnqKORXrPoQ8xKioUUZmXJVvr3/RQs
         q98wg9o447avYTwoKCVxB6O3ZAY1o/Zbrd9X6DJ6g4KdToTXVY2t6wUAwQalos5WB2D/
         O7rZwej0YHM9EK4/O6BObpWdOzTIgGJfrRLIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=WnZuLxo6580XyWlf/lK3jWKFRi583QJhtee6DPA59exbTg0Z/oNkzQLoE3vBQIU0SY
         9bEgODTk6VARMMRaJXWqHmTXn8lNkJ+liHey2JM3LdHZE6s6NjvemN7XestbYCIAJ1bI
         Z1bp6GuSs9A6iddQdlx1XAtydYkJMPyPjBDVU=
Received: by 10.103.106.1 with SMTP id i1mr2415343mum.47.1226446579723;
        Tue, 11 Nov 2008 15:36:19 -0800 (PST)
Received: by 10.103.6.11 with HTTP; Tue, 11 Nov 2008 15:36:19 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811111454330.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
X-Google-Sender-Auth: 9721c31cc9902528
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100694>

Hi Johannes!

On Tue, Nov 11, 2008 at 3:41 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 11 Nov 2008, Ondrej Certik wrote:
>
>> But imho if git supported mercurial patches, life would be a lot easier.
>
> Mine would not be.

Because you don't use Mercurial, or is there also some other reason?

> BTW I had to be online (which is not always the case when I read email) to
> access the pastebin, which made it more of a hassle to look at it than I
> deem necessary.  Besides, it is bad because in 3 days, that pastie will be
> gone.  Not nice.

You are right, sorry about that.

>
> So here is it, for the pleasure of others:
>
>        # HG changeset patch
>        # User Vinzent Steinberg <vinzent.steinberg@gmail.com>
>        # Date 1226338168 -3600
>        # Node ID 23efeaf89f7089d94307526ec0536eb6f4382213
>        # Parent  dab6435e04fd083d66bbfa897cbe15ab9660b9e6
>        <commit subject>
>
>        <commit body>
>
>        diff -r <commit name> -r <commit name> <filename>
>        --- a/<filename> <date>
>        --- b/<filename> <date>
>        @@ <line range pair> @@
>        ...
>
> So what I suggest is that you familiarize yourself with
> builtin-mailsplit.c.  Basically you'd need to enhance the is_from_line()
> function to check this:
>
>        const char *hg_patch_preamble = "# HG changeset patch\n";
>
>        if (len >= strlen(hg_patch_preamble) && !memcmp(line,
>                        hg_patch_preamble, strlen(hg_patch_preamble))
>                return 1;
>
> Then you need to familiarize yourself with builtin-mailinfo.c.  In
> function mailinfo(), you'd need to work on this:
>
>        /* process the email header */
>        while (read_one_header_line(&line, fin))
>                check_header(&line, p_hdr_data, 1);
>
> I'd suggest to make the function read_one_header_line() into a
> handle_one_header_line(), and replace the while loop with this:
>
>        if (!strbuf_getline(&line, fin)) {
>                if (!strcmp(line.buf, "# HG changeset patch\n"))
>                        while (handle_one_hg_header_line(&line,
>                                        p_hdr_data, fin))
>                                strbuf_getline(&line, fin);
>                else
>                        while (handle_one_header_line(&line, fin)) {
>                                check_header(&line, p_hdr_data, 1);
>                                strbuf_getline(&line, fin);
>                        }
>        }
>
> Implementing handle_one_hg_header_line() should be a breeze:
>
>        static int handle_one_hg_header_line(struct strbuf *line,
>                        struct strbuf *hdr_data[], FILE *in)
>        {
>                if (line.buf[0] != '#') {
>                        strbuf_addbuf(hdr_data[1], line);
>                        return 0; /* no more headers */
>                }
>
>                if (!prefixcmp(line.buf, "# User "))
>                        strbuf_addstr(hdr_data[0], line.buf + 7);
>                else if (!prefixcmp(line.buf, "# Date "))
>                        strbuf_addstr(hdr_data[2], line.buf + 7);
>                return 1;
>        }
>
> Okay, this is all utterly untested, and you probably need to trim the
> newlines from the lines first, and maybe you need to replace the
> hdr_data[] entries instead of adding to them, but now you have a starting
> point.

Thanks a lot for the detailed help, I'll give it a shot and report
back in couple days, hopefully with a working patch. :)

Ondrej
