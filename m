From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC v1 2/5] add strbuf_set operations documentation
Date: Mon, 9 Jun 2014 05:53:49 -0400
Message-ID: <CAPig+cSB78YZiqWm7oTn3oFXE2yZZFbKmD6R5oHmEJMc9CtwvQ@mail.gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
	<ce477667323a531b4b3c39724160e66360061816.1402301816.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 11:53:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtwH5-0002g4-3z
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 11:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbaFIJxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 05:53:51 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:51570 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932348AbaFIJxu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 05:53:50 -0400
Received: by mail-yk0-f170.google.com with SMTP id q9so7534ykb.15
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 02:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WRka4qQDNafKQuTzhg4qKxB2H4uO2n61Xj4UCTG3y78=;
        b=AMbc9X/RJr0q9nbjROQCaL/CdDaKDTA+ZF5NgVcQF/i4y5Qe3TomNSjA7asdbruq7t
         68C8Ob7odpkgrMASv8FUzQXDejokHRtYccjqwlI8+aRpDMdz5vmQ+ZjTW+fVzJ4Qo/Dy
         Noa6DJimwyQtSKPdd6mHhimKNp6QHtAxjS4kuvOAAZxwjMkMIZ2otmSlJTROqr+ORJsa
         K7b5zm7NPqabdKlrhHswIN9Ihs7YrWketp65iL6OvPtOP8Af9B6/KBBIU0LnJJz5wcn5
         UECWv31yFVeGcam2DGYkTvmyav2bafIVAOo8hkxWTOn6VFx9bOP3YoNNUzfScG6MBbcP
         MUmA==
X-Received: by 10.236.117.80 with SMTP id i56mr14295777yhh.15.1402307629506;
 Mon, 09 Jun 2014 02:53:49 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Mon, 9 Jun 2014 02:53:49 -0700 (PDT)
In-Reply-To: <ce477667323a531b4b3c39724160e66360061816.1402301816.git.jmmahler@gmail.com>
X-Google-Sender-Auth: ttn-AHoO6Xq_5zPJFgFgda1ujpc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251065>

On Mon, Jun 9, 2014 at 4:36 AM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> Add documentation of the strbuf_set operations to
> technical/api-strbuf.txt.

Since this patch is concise and so closely related to patch 1/5, it
probably should be squashed into that one.

More below.

> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  Documentation/technical/api-strbuf.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
> index 077a709..ab430d9 100644
> --- a/Documentation/technical/api-strbuf.txt
> +++ b/Documentation/technical/api-strbuf.txt
> @@ -149,6 +149,24 @@ Functions
>         than zero if the first buffer is found, respectively, to be less than,
>         to match, or be greater than the second buffer.
>
> +* Setting the buffer
> +
> +`strbuf_set`::
> +
> +    Set the buffer to some data up to a given length.

I personally find this slightly ambiguous. Upon reading it, the first
question that pops into my mind is whether or not the existing strbuf
content is replaced (even though "set" should imply that it is). I
wonder if it would make sense to rewrite as:

    Set the buffer to [...], replacing the old content
    of the buffer.

Alternately:

    Replace the buffer content with [...].

Ditto for the others.

> +`strbuf_setstr`::
> +
> +       Set the buffer to a NUL-terminated string.
> +
> +`strbuf_setf`::
> +
> +       Set the buffer to a formatted string.
> +
> +`strbuf_setbuf`::
> +
> +       Set the current buffer to the contents of some other buffer.
> +
>  * Adding data to the buffer
>
>  NOTE: All of the functions in this section will grow the buffer as necessary.
> --
> 2.0.0.573.ged771ce.dirty
