From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Mon, 13 May 2013 14:38:22 -0700
Message-ID: <20130513213822.GH3657@google.com>
References: <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
 <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
 <20130511055647.GA3262@iris.ozlabs.ibm.com>
 <20130511061322.GB3394@elie>
 <20130511094119.GA6196@iris.ozlabs.ibm.com>
 <CACPiFCKkzSCaSfqExZggFHBAmcPBTYYhyauOa2h1dXiYqKZMxA@mail.gmail.com>
 <20130513185551.GB3657@google.com>
 <CAAhxitGFhVa6+8x_rgNz5dgyr6m4S11fVU2eJNnMuWimGiM8aQ@mail.gmail.com>
 <20130513193320.GC3657@google.com>
 <CALkWK0kVa-9-G8-2HtH1_cd1LY65abU8R4WKcjgkyTSh=xQamw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@laptop.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 23:38:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc0S0-0003cY-8W
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 23:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347Ab3EMVi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 17:38:28 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:50706 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308Ab3EMVi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 17:38:26 -0400
Received: by mail-da0-f53.google.com with SMTP id t11so1041513daj.40
        for <git@vger.kernel.org>; Mon, 13 May 2013 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iO+0pwnefDCrKMkOYCSZoWwIflLiIzXaL+F3eK0JBss=;
        b=UKxmhRrN7hJxLQDC+lNxE2twe4o++IMesVt057bkbZ3wGcqStberuov2vNzwPSjZx7
         mRiXNT6zwRbqofvTpgqIBfGxMt0hvoq7XNeW0zTGGdGGn7fgxZ0MnliJnTjaIUvFvQ86
         MhuGoBo/m+mpTQxTm8DEpszUPURImQGJWbveouKLuJLwhGeDef227yCtn0AelAkTwkJu
         ZCziCn1ZNz870N/kDYg/kH140tJwJayAmzTTYpzVOzebrWR3V0uuBMaRSYGy0iaEwE/2
         sfcY4wdxcNKZfCA7aasnq8R51Y2LYqqFIW4Sqkkmt9DaSS8/PMOKN4+XIRDK4DgFm6Qz
         em+g==
X-Received: by 10.68.255.36 with SMTP id an4mr30961532pbd.206.1368481106369;
        Mon, 13 May 2013 14:38:26 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bs2sm16365589pad.17.2013.05.13.14.38.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 14:38:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kVa-9-G8-2HtH1_cd1LY65abU8R4WKcjgkyTSh=xQamw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224213>

Ramkumar Ramachandra wrote:

> I still don't know exactly what -G and -S do.

If you've been following recent gitk development (or this thread)
closely, you'll know that "git log -S" finds commits adding/removing a
string, while "git log -G" finds commits changing lines matching a
regex.

Examples for inclusion in the documentation welcome, certainly
(especially if they come in patch form).

A quick web search finds some references:

 http://article.gmane.org/gmane.comp.version-control.git/187364
 http://thread.gmane.org/gmane.comp.version-control.git/154822/focus=154823
 http://gitster.livejournal.com/35628.html
 http://thread.gmane.org/gmane.comp.lang.scala.internals/14219/focus=14220
 http://thread.gmane.org/gmane.linux.kernel/1370389/focus=1370478
 http://thread.gmane.org/gmane.comp.sysutils.autoconf.general/10682/focus=5691
 http://thread.gmane.org/gmane.network.nagios.plugins.devel/6164/focus=6175
 http://thread.gmane.org/gmane.comp.python.sympy/5830/focus=5836

Thanks and hope that helps,
Jonathan
