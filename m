From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git clone algorithm
Date: Wed, 10 Oct 2012 06:43:43 +0530
Message-ID: <CAMK1S_hziqqMiSrO--_=6rX4k9gj16KGjtdXQ-0QEgeCMWU8oQ@mail.gmail.com>
References: <loom.20121009T192043-666@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bogdan Cristea <cristeab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 03:13:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLkrz-00043G-Gu
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 03:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757258Ab2JJBNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 21:13:46 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45136 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519Ab2JJBNo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 21:13:44 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so49670lbo.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 18:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mpz0nH/NR9KiI5h99t3DaP52Ifq0zqIwyks5DXkGj7k=;
        b=FGnP67o834wstAVjNGEYRJmxoNYI5RZ57a5P86pyYRBUcpp9924pA/xYrab4ucqcuW
         /WxjeeVqmUQDc0wMY6Kef/LPpABYXhUhLr3oCDL5OFpVN0Rck9xEGH0tY/oOg+g+VlSD
         eES0bH3NNG9bCJA8RoGbBUKWTfuWlcvlE1Mkx4AbxeVRiO/DuJylnK/fxpUQe0n1VzmW
         4rdeg/whqrxMNWe6rLRVJxPLafyU+TVhX6yd4iK8n/ScFR9UnwY2ht76IFGbpYn7dvKs
         iEDQDYVtUKZGXE7e8+7PgQUtNOWXlpxLRU8XEp6xedBM/bVwaGljdCd485PqTyfEcCAp
         rhWQ==
Received: by 10.152.144.67 with SMTP id sk3mr18359821lab.19.1349831623137;
 Tue, 09 Oct 2012 18:13:43 -0700 (PDT)
Received: by 10.112.84.97 with HTTP; Tue, 9 Oct 2012 18:13:43 -0700 (PDT)
In-Reply-To: <loom.20121009T192043-666@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207358>

On Tue, Oct 9, 2012 at 10:53 PM, Bogdan Cristea <cristeab@gmail.com> wrote:
> I have already posted this message on git-users@googlegroups.com but I have been
> advised to rather use this list. I know that there is a related thread
> (http://thread.gmane.org/gmane.comp.version-control.git/207257), but I don't
> think that this provides an answer to my question (me too I am on a slow 3G
> connection :))
>
> I am wondering what algorithm is used by git clone command ?
> When cloning from remote repositories, if there is a link failure and
> the same command is issued again, the process should be smart enough
> to figure out what objects have been already transferred locally and
> restart the cloning process from the point it has been interrupted.
> As far as I can tell this is not the case, each time I have restarted
> the cloning process everything started from the beginning. This is
> extremely annoying with slow, unreliable connections. Are there any
> ways to cope with this situation or any future plans ?

This is not an answer to your question in the general case, sorry...

Admins who are managing a site using gitolite can set it up to
automatically create and maintain "bundle" files, and allow them to be
downloaded using rsync (which, as everyone knows, is resumable), using
the same authentication and access rules as gitolite itself.  Once you
add a couple of lines to the gitolite.conf, it's all pretty much
self-maintaining.
