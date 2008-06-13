From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH v2 1/3] filter-branch: add new --blob-filter option.
Date: Fri, 13 Jun 2008 12:10:16 -0400
Message-ID: <32541b130806130910w1975e092y192785fbab5c908@mail.gmail.com>
References: <1213318344-26013-1-git-send-email-apenwarr@gmail.com>
	 <20080613062546.GD26768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 18:12:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Brt-0000oU-85
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 18:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009AbYFMQKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 12:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757012AbYFMQKT
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 12:10:19 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:23009 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757004AbYFMQKS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 12:10:18 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2132934fkq.5
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7de0bjwXjmiaHK0H3IuU0+zAUmb0H6SzM3lf2c6Niq8=;
        b=HuFOwmVyi9euZs5yrOaCPF4jxHw8Dm7b0FGlO+oQiBYXHDX28C3aOhTaQtIEX8Zsom
         jh9MlkZSUlZv67LNIW9SiEp3lxqXAEmJypyGaE+u5t1jJSsX+ubJK9M0rWo0yUp0guvx
         DC1FWCnU0Y3PEO3uSQqw0GzTbv1QOVzKB9Mwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bYRqV1JSIuE1HdOTJ3Boj2MKVBrL3bAmWn5hhC6CrjSXoN2jD+aaZBzHui+oJSSTYw
         Wo2HyNA1qY4ge8h7c4sAt6lLUdpsbOdD5zBXBeZqLZWbxMzRwiCb27YU3cksiSkX4klm
         Wy41YSQE+R8HQPCD3Cx3SeJHPAttMsbjfpLsE=
Received: by 10.82.107.15 with SMTP id f15mr179405buc.86.1213373416400;
        Fri, 13 Jun 2008 09:10:16 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Fri, 13 Jun 2008 09:10:16 -0700 (PDT)
In-Reply-To: <20080613062546.GD26768@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84895>

On 6/13/08, Jeff King <peff@peff.net> wrote:
>   1. We're supposed to be in rc freeze, so this is not a great time to
>      publish a new feature. ;)

I thought that was what branches were for :)  Anyway, I only rarely
get the chance to work on this stuff lately, so I guess I got excited.

>   2. When bringing back an old patch, please please please give at least
>      a little bit of cover letter context. "Here is what happened last
>      time, here are the reasons this patch was not accepted before, and
>      here is {why I think it that decision was wrong, what I have done
>      to improve the patch, etc}.

Will do next time.

>  IIRC, the situation last time had two issues:
>
>   1. it was a one-off "we're not sure if this is really useful" patch
>
>   2. it was unclear whether paths should be available, and if they were,
>      there was an issue of encountering the same hash at two different
>      paths.
>
>  I assume your answer to '1' is "I have been using this and it is
>  useful". And for '2', it looks like you have extended the cache
>  mechanism to take into account the sha1 and the path, which I think is
>  the right solution (and I am pleased to see it looks like the final test
>  covers the exact situation I was concerned about).

Yes, for #1 it is indeed useful.  I'm using git-svn on Windows with an
IDE that auto-generates files with CRLF in them, and the translation
of that is something roughly like "ARRGH!"  I have to re-fix the
newlines on various different branches at various times and this is
the best way I've found.  (Although I can also imagine using it for
whitespace fixes, etc.)

You are correct about #2.  I believe I've covered all the complaints
that were brought up at the time.

>  (for 1/3):
>  Signed-off-by: Jeff King <peff@peff.net>
>
>  (for the others (and for 1/3, do I get to ack my own patch?)):
>  Acked-by: Jeff King <peff@peff.net>

Thanks!

Avery
