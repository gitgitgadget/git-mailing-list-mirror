From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: What is 'git BRANCH'?
Date: Wed, 30 Jul 2008 00:49:00 +0200
Message-ID: <bd6139dc0807291549y66c56fbah928a854f37573680@mail.gmail.com>
References: <g6o4vi$rap$1@ger.gmane.org>
	 <7vej5cba6z.fsf@gitster.siamese.dyndns.org>
	 <7v63qob9hz.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-2?Q?Jurko_Gospodneti=E6?=" <jurko.gospodnetic@docte.hr>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 00:50:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNy18-0000XZ-Bj
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 00:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483AbYG2WtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 18:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755908AbYG2WtD
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 18:49:03 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:51686 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbYG2WtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 18:49:01 -0400
Received: by py-out-1112.google.com with SMTP id p76so75248pyb.10
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PqWjzWPGyNUcaiyoGfMi3QQvamJR7x/ITsKzBrat8VU=;
        b=WOeSLqF66js5GobCQ3hiYkk//0az7jIDkWgGhwKnoJG2iOX0Lql95bHooGj+kkiqK3
         6/a1Ka498bns4K7yjY5AECQEq8O1+CucfojkvWXbKjL92Rgu3U3u2m0x0SWeJ3jSbzwz
         rivXz3Q8/FeRSoz99/4Su9jzJPD4GlrYlr2nA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=XMxJVOypuZkKxnFiU2XsEGL4GpDXjD8ddgZ3lT6N7fW42XLsgJbXL6kH+LiHVp3X/j
         MWKexSmoEwAdTK3EEgYCuZV/nYmYOVMzstgFUSC4kEDTd5oaCkwsbojrPtBh5jcgEhwj
         lupTru0nYzEnWlx7NBo2qjDf9pjTD41/gtlXk=
Received: by 10.142.210.4 with SMTP id i4mr2367400wfg.240.1217371740325;
        Tue, 29 Jul 2008 15:49:00 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Tue, 29 Jul 2008 15:49:00 -0700 (PDT)
In-Reply-To: <7v63qob9hz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90700>

On Wed, Jul 30, 2008 at 00:39, Junio C Hamano <gitster@pobox.com> wrote:
> diff --git a/git.c b/git.c
> index 37b1d76..c99e769 100644
> --- a/git.c
> +++ b/git.c
> @@ -448,7 +448,7 @@ int main(int argc, const char **argv)
>                cmd += 4;
>                argv[0] = cmd;
>                handle_internal_command(argc, argv);
> -               die("cannot handle %s internally", cmd);
> +               help_unknown_cmd(cmd);
>        }
>
>        /* Look for flags.. */

Why does handle_internal_command not complain after the "	for (i = 0;
i < ARRAY_SIZE(commands); i++) {" that no matching commands were
found? Is that not an implicit assertion that would do well with being
asserted here?

-- 
Cheers,

Sverre Rabbelier
