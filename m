From: Stefan Beller <sbeller@google.com>
Subject: Re: Bug in reflog of length 0x2BFF
Date: Mon, 1 Dec 2014 17:39:02 -0800
Message-ID: <CAGZ79kaO166tzHKRPX2j6BZ=fPRy9VhLGXStGpW4waVekZFJAQ@mail.gmail.com>
References: <547C8610.8080301@cs.uni-saarland.de>
	<20141201233515.GV6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christoph Mallon <mallon@cs.uni-saarland.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 02:39:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvcQn-0007VS-Ch
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 02:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857AbaLBBjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 20:39:04 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:52960 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280AbaLBBjD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 20:39:03 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so10797136ier.0
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 17:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SCqqhjvUpeVjILAptuNVt6o50QQKqWY62Fug/09xKjE=;
        b=eXaB/GeBqmz3GozfUjtxNjHyrEVS5cxx6b0F7h+PymWekJniRCi9TUq2wr5s8x/1u0
         M7NmgPFj7Q9H7Z9qNd9IVzu8Z0YX5zjFPIg8Mhkh9A7zR9yysZ88s/Q3ViQDODrcSBEq
         r3/N/UFtmqHAi/VBy4BgrRKMBPmwcByVIY0cuxjd4xcyh9T7weoMBXsbgll/WzDmIsg8
         IsHeaqUV4dGpYx3tLla3BlIi9Ph5mULwaPevxEukQDoppy4tQXP0TwpoxYdRg2hlRO6r
         jKcIiP6yMqpoQ3sRXTrU4MSmJiaO0qvu/VTOCRHJuldV3aShtMXEUpreeVCotW45zxBe
         KgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SCqqhjvUpeVjILAptuNVt6o50QQKqWY62Fug/09xKjE=;
        b=El6SQXFQvBT7mR6wufFpwuMESdhM26HYz1E/emjsDfY6E0U56HJrg7dqWRyZ/qIxP7
         F8bsKEg3haGm+eEnSpl/eJimyOE3eT5FJ5Fb54Ahkv2P6wv6fj5ZKLlAzPV8Kdj/2cKD
         6KbhZ2pXs275iWM2T4Pqay667jl7CG+2WnA1XQzze2wM2edMDaTgKlgtHGWIDASC3slE
         jz13HJCMjxbc3+FmS/uT+IDfBDCjaKzB1FzdfY68bHNWhA3NPLmadGd/yvOT2a5DbT3/
         kLCBF/UHmQZb7KcFhksmaUNTXYUzPU4oGqprCvfKDZ2CjCme6HCcO45oKxcECAeeojt9
         Ncjg==
X-Gm-Message-State: ALoCoQmvwIygZK0WLWaqQwdUIDhm67L32/08yKD1RfSdzFD/zTyaNIGVu3P9DnK6F8ekvz2+zCsq
X-Received: by 10.50.137.65 with SMTP id qg1mr848774igb.37.1417484342351; Mon,
 01 Dec 2014 17:39:02 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Mon, 1 Dec 2014 17:39:02 -0800 (PST)
In-Reply-To: <20141201233515.GV6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260518>

Hi,

so I have installed git version 2.2.0 currently, because I was trying to
reproduce "Bug in reflog of length 0x2BFF".

Now I was using git as a normal user, rebasing some stuff
(incidentally the reflog improvements)
and an error occurred:
$ git rebase --continue
error: Ref refs/heads/todo_sb13_ref-transactions-reflog-as-file is at
c48602d0aaa11b9099440c647ac028604fde4b14 but expected
d1bbdc6f161ae7550805d565cad1d930487dad34
fatal: update_ref failed for ref
'refs/heads/todo_sb13_ref-transactions-reflog-as-file': Cannot lock
the ref 'refs/heads/todo_sb13_ref-transactions-reflog-as-file'.

So I think we definitely have a bug in the reflog code already in version 2.2.0.

Trying to reproduce the error did not yield success.

Thanks,
Stefan
