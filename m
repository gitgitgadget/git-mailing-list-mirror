From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 14:44:09 +0530
Message-ID: <CALkWK0nO-K1BOOxNG0--Gx8AP-HOfLEjrn_UrkkccwuL6A449Q@mail.gmail.com>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de> <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408083712.GE20159@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 00:05:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPKAb-0002Am-UO
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 00:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934589Ab3DHJOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 05:14:51 -0400
Received: from mail-bk0-f45.google.com ([209.85.214.45]:42146 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759123Ab3DHJOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 05:14:51 -0400
Received: by mail-bk0-f45.google.com with SMTP id j10so2900090bkw.4
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 02:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=0CpLyz3Sq3jsjJpy8TUy5lU7fQyDM8GstA+SJ7mSG3A=;
        b=noMUpfCrcqY2FO8aYnMeglUcKKb0EIdpMb+YFzpYTtF9t+RRdFtOmYcQRVdp4+voQ7
         ltpONSKq8odrdMlUZ/nzXE8XdbD0NuYB57qfgy9RXfZF4y3fTO51aQOvzY8FNt2IL7pF
         +7LYAfPtkeqyDL1D8pL9jAFVprU4AHsj+rLfy+qq3w/QVSThCEiycw8iJEjX1OxbKn8e
         N6x9UAxcqcsam6OWyHhgZTMl6gVl4oDV8YfSKHoxQcmRjjza3GL6vCie0E9RHHq2FZZ9
         62RRt794aJlfY0AUF+NtyiMzjXBDpiYYRWN9yY+rtSQgxSMwLJuXjAnB1EIxm8AqUjbS
         UpBg==
X-Received: by 10.205.47.202 with SMTP id ut10mr10524190bkb.2.1365412489557;
 Mon, 08 Apr 2013 02:14:49 -0700 (PDT)
Received: by 10.204.37.69 with HTTP; Mon, 8 Apr 2013 02:14:09 -0700 (PDT)
In-Reply-To: <20130408083712.GE20159@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220411>

Jonathan Nieder wrote:
>         git grep -l -F -e oldhost.example.com |
>         xargs sed -i -e s/oldhost.example.com/newhost.example.com/g

Yes, I've had to do this too: in a proxied environment I had to
s/git:\/\//https:\/\//.  So yes, we will have features to operate on
multiple links at the same time.  I'm thinking something fine-grained
that allows you to pick which links to operate on.  It's currently a
vague thought, and I'm not sure what the implementation will look
like.
