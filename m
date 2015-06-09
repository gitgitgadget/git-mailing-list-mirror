From: Stefan Beller <sbeller@google.com>
Subject: Re: git lock files (Was: GIT for Microsoft Access projects)
Date: Tue, 9 Jun 2015 12:08:17 -0700
Message-ID: <CAGZ79kbc5UuHz=MZogX2kQ8XS_CbvgW=_7hPw2LF6Gur_pKQow@mail.gmail.com>
References: <1433870383-7631-1-git-send-email-sbeller@google.com>
	<20150609132144.ANWJW.73271.root@txifep04>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, kostix+git@007spb.ru,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Deaf Smith <hackerp@suddenlink.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:08:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Oss-0008L1-9q
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 21:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbbFITIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 15:08:22 -0400
Received: from mail-yh0-f54.google.com ([209.85.213.54]:36759 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007AbbFITIS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 15:08:18 -0400
Received: by yhan67 with SMTP id n67so11057312yha.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cnqY+CsJ53lBvxb/Zv5eQTz9K6WD+5P0kNhAAXAeaLQ=;
        b=bZbq52WBSl0tXKBQXmbwyrk8SdYMfKpdCbsrI/Ie53XNn/o3j+hiIj5Ciy9aLRIXT/
         wOrgseiqwP4bv3h3sWTIhuVzS0PaiWrTpMpEr1sdjeD40/7Pye4SKPN6Hw3ii+K6oYQF
         1JvnmFGPWZpnlyf4dsw2uXB+0dzksD09qRsU/ERmwIKrfpldxrxKP15ZTh7BZV/V6XS2
         a6LxmXUs2TTEmdPsU6CJFEhBArCy1Qig5r+ahOGAi2rBVGpgWvnInSQbkd9/zdZH6HTY
         Ka5PcFSM4rJkJ52hOekHJikSMjqNZ1YWA8bU3OjHwVJnqlTchREoGgOrdBtSUC/jZzGh
         8ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cnqY+CsJ53lBvxb/Zv5eQTz9K6WD+5P0kNhAAXAeaLQ=;
        b=j0EKNc0da7cCVre8rWRmj4nJe5wZxjyCC9n9eQ54CzhxcL2DxHdMMZaWV+JL4Am33t
         4EcaNBv2Xm853BXqKmtoFlhgHV47kUqPxP/VDn4yZXyV+Yt//zMnQ4uZXHzvLb4/WQvI
         aLHp58i713YJ9QCfiu5cQYSUud3r9gUUNWhOGSisezmamYvUFAaCPr4Ff7UIagH0G4ik
         Nb1tv4Yr9HW+SVsGqKZkbfJZEoelElt/t8Z55c52XYzugUHYl6E0WR7+41weKaaKM3I0
         TVFicvRwYRTOn8hNqrRJRbC7ZGlJpCSp6jxRenU4HaueRB2DiDKckaKi89MvR6AzdXRK
         rHHg==
X-Gm-Message-State: ALoCoQl3KYTg1aQuPI/6SNYBwTI7JUzmpAQfpk7tneD8mMy30kz/QSSi2hjT0WJUtJ6RvNHpx9Ka
X-Received: by 10.129.46.213 with SMTP id u204mr24325339ywu.1.1433876898093;
 Tue, 09 Jun 2015 12:08:18 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Tue, 9 Jun 2015 12:08:17 -0700 (PDT)
In-Reply-To: <20150609132144.ANWJW.73271.root@txifep04>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271233>

On Tue, Jun 9, 2015 at 11:21 AM,  <hackerp@suddenlink.net> wrote:
> Thanks folks, I am digesting all you have said.

I did not intend to answer your original question, but to start a
discussion on the
feasibility of a dedicated "git lock" command.

There are lots of things which are checked in alongside the code
(The code is which is why you want to use Git in the first place),
such as Graphics, CAD, design documents (maybe in binary format such as ODF,
MS Excel).

All I did was proposing a new command and laying out its behavior.
By being careful at what to use as the porcelain command line and what to use
as a stable plumbing command, other programs could rely on that.
(Some proprietary CAD tools such as Altium have a subversion
integration [1], maybe Git wants to offer an easy interface to allow
for Git integration as easily?)

>
> Now the command line I can do (I'm a programmer) but the secretary here I doubt.
>
> So is there at GUI interface for this? Does it work on Windows systems?

As all I was saying is dreaming out new concepts, there is currently no code.

>
> Thanks,
>
> Paul


[1] http://techdocs.altium.com/display/ADOH/Version+Control+and+Altium+Designer
