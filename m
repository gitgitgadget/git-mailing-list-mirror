From: Daniele Varrazzo <daniele.varrazzo@gmail.com>
Subject: Re: Bug: git crashes on rebase reporting bogus memory corruption
Date: Fri, 27 Nov 2015 16:29:29 +0000
Message-ID: <CA+mi_8ap9676PHKyuK1kdmLm9WLKO3XTUunjF8cwFyULoL=XOw@mail.gmail.com>
References: <CA+mi_8Y5bx-RDCV2oFfFRVZz-Jjcii7QbB6k45B5YsLoed-b8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 17:29:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2LuB-0004HZ-Al
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 17:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbbK0Q3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 11:29:51 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:32773 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbbK0Q3t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 11:29:49 -0500
Received: by oixx65 with SMTP id x65so64083524oix.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2015 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=9qreqP/G47UmkDWCwdeGLs3eitL8Qn6aDlMpPrSWfxk=;
        b=xP+rGu6s0znOyz75wy/kMXk4HxE3uti0TQagKw653IxasYDQmQRrBva6HIzUl31NfI
         VCN1FXpH2eEPpQZfQKiF8tdStlkJ3N4i42IhtmPIeiR4TRlT0ndcFTNZ2UI50zZ5yNCe
         N0nlwHk5mJd96hpZ8fjhQdSB2Gevk++UFSlLLx/svbhppe7SwL8CAX0r9alL/JZfyGfP
         Ny/Nd9fyLWWghUdp5CmZ6R/4to94rnTqqdJPkwALcF6BsbHn18npjIuPiC3c+JyGbGmE
         BKViTk1YD4TUfOefzQ5REXFDglU0Z8WHv694hIG3q5kf+DZsLakDsuQP7NJBBCeS6pq/
         2UOg==
X-Received: by 10.202.83.74 with SMTP id h71mr32388551oib.32.1448641789161;
 Fri, 27 Nov 2015 08:29:49 -0800 (PST)
Received: by 10.202.90.131 with HTTP; Fri, 27 Nov 2015 08:29:29 -0800 (PST)
In-Reply-To: <CA+mi_8Y5bx-RDCV2oFfFRVZz-Jjcii7QbB6k45B5YsLoed-b8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281779>

On Fri, Nov 27, 2015 at 2:08 PM, Daniele Varrazzo
<daniele.varrazzo@gmail.com> wrote:
> Bogus corruption is bogus because I've reproduced it on different machines.
>
> I was trying to rewrite history in a small repos and replace
> indentation tabs with spaces. Steps to reproduce:

Messing up with that repo. Not sure what reportedly originally still
works. This should remain as it is:

  git clone -b gitbug https://github.com/dvarrazzo/suponoff.git
  cd suponoff/
  git config core.whitespace
trailing-space,tabwidth=4,tab-in-indent,space-before-tab
  git rebase  6af85bcde9a30c3841b754bbb60c03ba58b88a50 --whitespace=fix

-- Daniele
