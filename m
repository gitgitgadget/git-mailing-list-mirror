From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Submodules with feature branches
Date: Thu, 5 Jun 2014 13:31:39 -0500
Message-ID: <CAHd499CBAQHG4rdojb8pdjymUCaZNYSnKb-ksmsLesq73OWTyA@mail.gmail.com>
References: <CAHd499Bn7CCVy=vhFzpLYXCssxR0oGxm3Vdgou_Yk5zSt1gfmA@mail.gmail.com>
	<20140605151549.GQ21803@odin.tremily.us>
	<CAHd499Dc7_fob2-X1KZ77sdx20r+erQ_9JbDc7y4G0RUxG65eg@mail.gmail.com>
	<20140605162333.GR21803@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jun 05 20:31:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WscS2-0008Dk-0y
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 20:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbaFESbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 14:31:40 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:62674 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbaFESbk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 14:31:40 -0400
Received: by mail-vc0-f181.google.com with SMTP id hq11so1611032vcb.26
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Idfg8ePAMir5Fbj+Ivr0sGsMS7XWlRMkdcWv295JEnQ=;
        b=msXwkfXvQY6cwwPvjpvLlraUbY8oMPZZIyPls33wPQQMrNzlN97J2MeuBTy2tKKrPP
         y5uZWL3BlCw8cUkZjShuG8Ky5C52SJB/2cFBYm6G6KTXHdMI9admv8aIHZeqPzgvRRdj
         LqQjGffVQKXmEw80H2PkebtDAum4MjsZbMzhP7ReIgC85QSStMNMKoxWDumZGRMroFbN
         IfxREGznbTr0D/LDwbrEEHfv4wIjY6ptGNHkL2nXjSP4pSdvNQdWGcATt3ps2jgi29EZ
         M50qj45NfFuvPWCJpXPeV8VoGdWJ7VVGg0NMscxT2W6acpTEB7LOeLq1iooDJSWA0f+F
         wcnA==
X-Received: by 10.52.147.9 with SMTP id tg9mr9907250vdb.76.1401993099321; Thu,
 05 Jun 2014 11:31:39 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.204 with HTTP; Thu, 5 Jun 2014 11:31:39 -0700 (PDT)
In-Reply-To: <20140605162333.GR21803@odin.tremily.us>
X-Google-Sender-Auth: ScmKWQa3KGiMAWluEVQ538xRQqU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250854>

On Thu, Jun 5, 2014 at 11:23 AM, W. Trevor King <wking@tremily.us> wrote:
> 3rd party libraries sound loosely-coupled to me ;).  In one of my more
> mature projects I did a similar thing, and just used relative URLs [1]
> and sibling mirrors/forks [2,3,4].
>
> Cheers,
> Trevor
>
> [1]: https://github.com/wking/pygrader/blob/master/.gitmodules
> [2]: https://github.com/wking/pgp-mime
> [3]: https://github.com/wking/pyassuan
> [4]: https://github.com/wking/jinja2

I guess I'm still confused on how relative URLs help here. Won't the
capping commits (A and C in your first email) still be needed? Or is
there a way I can modify the local "../third-party.git" submodule repo
instead? Can you explain?

Unfortunately, the reason why I feel third party in a submodule
creates tight coupling is because:

* You can't make changes to third party libs for your feature branch
without breaking the trunk
* Merge conflicts are insane to resolve and involve two clones if
trunk maintainers modify third party binaries and you do as well.
* Feature branching requires those capping / meta commits to simply
setup your branch to be a feature branch.

Instead of just creating my branch and starting to make commits, I now
have to setup my submodule branch first. Also pull requests won't show
the changes to the third party libraries unless I do a second pull
request for the third party repo.

It just seems like a mess :-(
