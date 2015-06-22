From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 08/19] parse-option: rename parse_opt_with_commit()
Date: Sun, 21 Jun 2015 18:04:52 -0700
Message-ID: <CAPc5daVpqDC4K6ne=E_cdzG0NhfEYLucWdxVwKMf9WtDxzPUnA@mail.gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com> <1434919705-4884-8-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 03:05:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6qAn-0005rJ-Bx
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 03:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbbFVBFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 21:05:13 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33773 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbbFVBFM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 21:05:12 -0400
Received: by obpn3 with SMTP id n3so21071784obp.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 18:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=zFRwxLviWZkn8v/qzWMKuUMSIJWFH8mPrbjNoz58nXQ=;
        b=LbgFYwhXzuj4uJGYemAq/HWRI2d+UuB5U6+1f+B8T0kA7UYGeWQsBJi7lkvHC4NQ/E
         BoM+b4BbhuC5CtP6+x2pxi5Tz+pYqRejrnZeIB02PzyAmINEhwVmO642vH5afAV0o7xb
         KqcNthf0+lmj74QhLm8EF/SRINme2MgLAYwJd8U38FjtdvEik08ztlWKfoW6tALEc89J
         shwEJjON2mihqIQLCxo+zJa885DL8p0Yhd7RBSJiilBJOS7ITM6jzWEHeNJEWQfkkEgZ
         vJAp0ARLXcWyIgU5a5j4IWdOP0gE9Cdgwsj7zZ6BvuL27sXI7c6Raw8xzJxzjoPhruqR
         9gcQ==
X-Received: by 10.60.15.68 with SMTP id v4mr21565393oec.17.1434935111414; Sun,
 21 Jun 2015 18:05:11 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Sun, 21 Jun 2015 18:04:52 -0700 (PDT)
In-Reply-To: <1434919705-4884-8-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: _rW_f75Ub--G5Z0vFaGFUgBk4qM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272313>

On Sun, Jun 21, 2015 at 1:48 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Rename parse_opt_with_commit() to parse_opt_commit_object_name()
> to show that it can be used to obtain a list of commits and is
> not constricted to usage of '--contains' option.

I think that is a brilliant idea, but unlike the other function you
added earlier
that can do only one object and adopts "last one wins" rule, this is cumulative,
and that fact should be made clear to the developers in some way, no?
