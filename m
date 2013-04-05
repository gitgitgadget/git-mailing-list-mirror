From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Fri, 05 Apr 2013 02:26:25 -0600
Message-ID: <515e8ab11a679_3cb6f57e181657@nysa.mail>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
 <20130402200948.GF2222@serenity.lan>
 <2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
 <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
 <CALWbr2w2jjBmO9pTrw12UGKGC94MQqg6mZynLACLT7B3eoz8VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 10:30:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UO22j-0007FJ-FE
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 10:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161663Ab3DEIaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 04:30:10 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:54854 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161244Ab3DEIaH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 04:30:07 -0400
Received: by mail-ob0-f175.google.com with SMTP id va7so3411033obc.6
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=1dTTEfUE0ThlJwG3Seoov8u/aWFD8aV9fk/gvvXXsWU=;
        b=p2t8Ex1lVaz4aPAKN2XOdK6ASr5UE9riAaAonQ0OiSwAM9Rwm+7hy73uaJWawyQquK
         MSZyuHMOAT0zpvu6vHBmOSObxrVaT6kBWfIN/lfyCVtSSCfncIfFxmiHyXRBgJlj4LLo
         DY+dpHVWTNnM//F3D6lSjedstdMkoANmYsTsLBtX5QLSxqY7LBWXpbjyBOGnqQKzLsA0
         bHg/ytzw6dB5cjRmcs0K0Bf7UxyYXalzVVFGhG4btHByrDhI3uJUIrLW3Pt4cmLsK49w
         VQ5StU5Z6v0FP/ZLhCU+bieZw5v+9VAx3iJxACx5/0XWNC4VZ0XaGzYIVvefD1TSZ12c
         Aj2w==
X-Received: by 10.182.212.6 with SMTP id ng6mr7158276obc.26.1365150606541;
        Fri, 05 Apr 2013 01:30:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id d10sm11487287oeh.7.2013.04.05.01.30.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 01:30:05 -0700 (PDT)
In-Reply-To: <CALWbr2w2jjBmO9pTrw12UGKGC94MQqg6mZynLACLT7B3eoz8VQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220158>

Antoine Pelisse wrote:
> >> * internally, the marks are using the hg sha1s instead of the hg rev ids. The latter are not necessarily invariant, and using the sha1s makes it much easier to recover from semi-broken states.
> >
> > I doubt this makes any difference (except for more wasted space).
> 
> I think this is definitely wrong. If you happen to strip a changeset
> from the mercurial repository, and redo a completely different commit
> on top of it, the new commit will never be seen on git end (because it
> will have the same rev id and will thus be identified as identical
> from git point of view).

That is true. I've written the code to use SHA-1 nodeids inststead andd this
particular scenario works correctly, I just need to figure a way to discard the
old ones.

Cheers.

-- 
Felipe Contreras
