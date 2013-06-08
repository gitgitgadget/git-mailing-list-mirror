From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 09:35:37 +0700
Message-ID: <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com> <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 04:36:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul90p-0001vw-3S
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 04:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249Ab3FHCgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 22:36:10 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:51613 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab3FHCgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 22:36:09 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so4077357lab.38
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 19:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MQ5YbXiCA6CM82D6sgbKZGBr9OPgEpaQvBxHNxqKIi4=;
        b=cTsOqVFLsyyFv1NyE/DMf1/MM5yl09kAZmnyKl+Gzkf4wAcWVQREf/kbRQmLv7KniC
         HIPeeoh1oOfuT/ZujB875EGZf0pVNN1p6z4bGdP0Bq81WIB0nMp44bCQvaGbq2Dh347T
         N1zd7Xx4VvBMNacr3a+mOXBgCkI+fqtmoBU+wXeRaJRFw9Owpa0ubm+5ylYSypvb6RgO
         uU5PnL+cYeGTsmqbsE1ar1IbcalO5gFR2Kee5zLY3CZSuO9leQt8dY4wWRtwIJpfD8Hm
         CQ7lFbhFMFUmlYac+Mg0R+kt5Y2xzmDxw54tHqizYFOAeaL0sjOLswmJnQE+q1bUGeLl
         Y7Qw==
X-Received: by 10.112.159.202 with SMTP id xe10mr2324839lbb.52.1370658967672;
 Fri, 07 Jun 2013 19:36:07 -0700 (PDT)
Received: by 10.114.24.234 with HTTP; Fri, 7 Jun 2013 19:35:37 -0700 (PDT)
In-Reply-To: <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226780>

On Sat, Jun 8, 2013 at 5:16 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This code is only useful for cherry-pick and revert built-ins, nothing
> else, so let's make it a builtin object, but make sure 'git-sequencer'
> is not generated.

As you can see, the convention is builtin/foo.c corresponds to git-foo
(and maybe more). Why make an exception for sequencer? What do we gain
from this? A lot of code in libgit.a is only used by builtin commands,
e.g. fetch-pack.c, should we move it to? I ask because I moved
fetch-pack from builtin out because of linking issues and I don't want
the same happen to sequencer.c.
-- 
Duy
