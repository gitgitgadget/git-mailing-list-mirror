From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: question about: Facebook makes Mercurial faster than Git
Date: Mon, 10 Mar 2014 16:22:08 -0400
Message-ID: <CACPiFC+yjwakzC-0Z=Asuy6SJAxg=pHv4mis_AP_qKVHkpk1Ag@mail.gmail.com>
References: <531D8ED9.7040305@gmx.net> <alpine.DEB.2.02.1403100310080.25193@nftneq.ynat.uz>
 <20140310175102.GA17336@domone.podge> <alpine.DEB.2.02.1403101053120.20306@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-2?B?T25k+GVqIELtbGth?= <neleai@seznam.cz>,
	Dennis Luehring <dl.soluz@gmx.net>,
	Git Mailing List <git@vger.kernel.org>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Mon Mar 10 21:22:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN6iX-0008A6-Qh
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 21:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbaCJUW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 16:22:29 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:48194 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbaCJUW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 16:22:29 -0400
Received: by mail-ve0-f171.google.com with SMTP id cz12so7794625veb.30
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=N6Aa12zVbEUwMOXYySr47qETt6oQjj40tL5UFXMaJLM=;
        b=GJdaZV7FwZTUzzvljgewzVG3Lupy/EpYpa4ghR9lZV1jL2BT+aocA/8KvUEgaxlAkc
         9eraoCmEpPmdr/R0pxAQfkggfgnICBfU36HM6axIDn2mz0jMYPoWgNTovfP9soeRkY4S
         XGW1i3yeZcKntQ5mCPpW3RhCS9/usNkDsjKNlk1+EA+AI2gRbl4fj/9xSctPDrp1kh9S
         Fjti3nCMJND3YnBzztAGIg/3+rQpYrr7uS1PkDkIPYpZjQFIjIK8OONuYDBBQZvfUU+M
         NpLuIMhS8Oa5IT2u1H64yt3MG3+FtJ8Q/FBtqDzcckrFsps85jdg1z9KoHZOAz8lhO6+
         9k/Q==
X-Received: by 10.221.30.14 with SMTP id sa14mr94775vcb.44.1394482948205; Mon,
 10 Mar 2014 13:22:28 -0700 (PDT)
Received: by 10.220.183.138 with HTTP; Mon, 10 Mar 2014 13:22:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1403101053120.20306@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243809>

On Mon, Mar 10, 2014 at 1:56 PM, David Lang <david@lang.hm> wrote:
> there's also the issue of managed vs generated files, if you update the
> mtime all the way up the tree because a source file was compiled and a
> binary created, that will quickly defeat the value of the recursive mime.

I think this points us again to an inotify-based strategy, where git
can put an event listener daemon which registers just the watchers it
needs, and filters the events on its own conditions.

The kernel and fs have no good way of knowing about this stuff.

cheers,


m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
