From: Lee Griffiths <poddster@gmail.com>
Subject: Re: Checking for fast-forward
Date: Wed, 8 Jul 2009 18:36:30 +0100
Message-ID: <ca4f67be0907081036j38724491n6c4c0e9aa995ee51@mail.gmail.com>
References: <ca4f67be0907060936v7bf7c44y4395717fff854fd4@mail.gmail.com> 
	<20090706232614.32602ccc@schatten> <4A530594.20100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Florian Mickler <florian@mickler.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 19:37:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOb4x-0001bx-0f
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 19:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896AbZGHRgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 13:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754477AbZGHRgw
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 13:36:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:33002 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817AbZGHRgv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 13:36:51 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1748715fga.17
        for <git@vger.kernel.org>; Wed, 08 Jul 2009 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=sp6NyL8n+a7C2nV0H+nfdNoPixbtMOD1hKjiM7hQUUk=;
        b=YFvs+ETpJRmcMsRBsRgJhK6vgR/B5gtFIpTIvXeABp7VIF1R5AWzFHM8AYu5ysZGZi
         VK34Vmiq7lasEA1vgmb2k2kH6x9bD4b5KTKvh/8jw7DWPyHeXIy1s/Shxd3oJJxcHFeo
         yl8R1BddY+dhoDnqhAMrHjL93v4syApgqMxRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rK/OWrpJ2eLBBHXc5NTzRXvrEKdbRohKAUD0JeVIdr4fzpqokN3VXQe2/69e2u1Ubs
         AbBKhBIPa8gfL1tGPjsYXgV5Hk2GnAhv8famxqs1N8t144s+ht/goUmc0gtHn5fOJH1R
         xLgbSmnhXxNhz/69T+g0kGvuBKAqsnGz9AU/4=
Received: by 10.86.1.1 with SMTP id 1mr2857688fga.42.1247074610186; Wed, 08 
	Jul 2009 10:36:50 -0700 (PDT)
In-Reply-To: <4A530594.20100@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122908>

Thanks for the answers :)

After seeing that git push skips the packing (and potentially other
things) when doing a dry run, and given that:
	git push --dry-run
takes 1.5s on average and that:
	git fetch
	git rev-list master..remotes/origin/master
OR
	git ls-remote origin refs/remotes/origin/master

take 4s on average, I think I'll stick with the dry-run & checking for
exception method.

Thanks though :)

2009/7/7 Michael J Gruber <git@drmicha.warpmail.net>:
> If $(git rev-list bar..remotes/origin/foo) is empty then the branch foo
> in the remote repo can be fast-forwarded to bar.
