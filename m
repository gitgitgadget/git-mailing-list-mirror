From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] send-email: If the ca path is not specified, use the defaults
Date: Sun, 26 Jan 2014 12:17:14 -0500
Message-ID: <CALkWK0ky2KCJuo==XRiNu+eb2+hHpgv+FAyZTd85=TYQxgSCbQ@mail.gmail.com>
References: <1389807071-26746-1-git-send-email-i.gnatenko.brain@gmail.com>
 <xmqqa9ex2gi6.fsf@gitster.dls.corp.google.com> <7AD1C6ED-6177-415D-B342-D1FEA9F810B4@rubenkerkhof.com>
 <xmqqob3d0w7g.fsf@gitster.dls.corp.google.com> <20140115215024.GM18964@google.com>
 <xmqqppnry0p9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ruben Kerkhof <ruben@rubenkerkhof.com>,
	Igor Gnatenko <i.gnatenko.brain@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 26 18:18:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7TLl-0001tQ-GG
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 18:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbaAZRR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 12:17:56 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:48801 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbaAZRRz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 12:17:55 -0500
Received: by mail-ig0-f170.google.com with SMTP id m12so9295417iga.1
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 09:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YKHFoUGd2iEs+OfUCqX3PagjcrdfiWWqtO7WzHaUexw=;
        b=UhFLtmztw3RxRQO1G0juRzwWwoOk0QspxsheOXTHZwFr/5+UlY+IvtYxfDvXZgxd7V
         ce75SbRXhdlTOYsnA+hbASy7/OawlNwPqUDn2BuEFq7v0z1bUx2dPB9bP9nEukuajJSF
         E/KIvCO0tCiDVBV9WIaNzFew8PWIDKZxw9XwaBanuVlEaIvdkWNdGvRM4W6QMEFS02PT
         G5Fl+3bH0Uha9lzcPNiS6vL3rFejGF4/U6h86dE50nKmcPPzTQUDKattSAWIeSwkuv/N
         /pWkQx9VIKIga1VQJzVamlct+3HYGJLmW1KsY4EtVxsa/u2OcZs3UpGRW8RoaIlh9XKP
         wU3w==
X-Received: by 10.50.36.67 with SMTP id o3mr13561414igj.47.1390756674867; Sun,
 26 Jan 2014 09:17:54 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Sun, 26 Jan 2014 09:17:14 -0800 (PST)
In-Reply-To: <xmqqppnry0p9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241091>

Junio C Hamano wrote:
> This change could introduce a regression for people on a platform
> whose certificate directory is /etc/ssl/certs but its IO::Socket:SSL
> somehow fails to use it as SSL_ca_path without being told.

I can confirm that my git-send-email doesn't regress to the
pre-35035bbf state; my certificate directory is /etc/ssl/certs. I'm
somewhat surprised that IO::Socket::SSL picks the right file/
directory on every platform without being told explicitly. This change
definitely looks like the right fix.

Thanks.
