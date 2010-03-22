From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Improve documentation for git-remote-helpers
Date: Mon, 22 Mar 2010 16:40:04 +0100
Message-ID: <fabb9a1e1003220840q5b9b791ft83c8fd4793b83be2@mail.gmail.com>
References: <f3271551003211026m376b86d6ga915f85a623eddfd@mail.gmail.com> 
	<f3271551003211121o48f502fp954b649ff4ca8f8b@mail.gmail.com> 
	<alpine.LNX.2.00.1003211907390.14365@iabervon.org> <fabb9a1e1003211635w27f0b22em73c7c6431c3998af@mail.gmail.com> 
	<alpine.LNX.2.00.1003211951360.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 16:40:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntjk1-0005ZI-HQ
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 16:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291Ab0CVPk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 11:40:26 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:47465 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475Ab0CVPk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 11:40:26 -0400
Received: by bwz1 with SMTP id 1so2025866bwz.21
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=I+R3qn3uTInoxlyr6HLZU1A85cTDiXUqf/9pjA8UEWw=;
        b=UrlQNQkf1OUpzHeKpuQS7qDJ26mljE+El03fn2iOGfD6xGZSqI2jtsO8DYEjtCkjJf
         I40faXfcV693w2LKbguOdZTElo+5LIkI74jFnnCy7fbbSrREkGBPHJjMUDEZ0GrzWhkJ
         xGftZ+1lbeygsFijvoFYUdf0nGR2/f7VxndP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qbIveJw3f+Z+DvVCUB3cyUJ8f4+POgujamNdmIyW5yvcy/zOIMP7xSZy9NCuTyEC8A
         sXiQnmf2eCEYxnUQjDlDO+oBY27v6iaDikGGut+u0fpXvNet6gLqSij77njdnm9+B3Cd
         ia9AphBryi+cq+V9/+iUHKdpKaDph44iJCoOg=
Received: by 10.204.131.82 with SMTP id w18mr2788255bks.29.1269272424244; Mon, 
	22 Mar 2010 08:40:24 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1003211951360.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142939>

Heya,

On Mon, Mar 22, 2010 at 01:06, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Looks generally right, but I think you need to do
> "finish_command(&exporter);" first, and actually get some feedback from
> the helper. I think the right thing is actually to put the output of the
> helper into fast-import again, and have that give one of three
> conclusions:

I'm not sure that makes sense (at least to me). I think you are right
in that we need to collect output from the helper, but I don't see any
added value in feeding that into fast-import. I think we should rather
read from the helper after we finish exporting to figure out what
happened. The different cases you described are I think indeed what we
should look for.

-- 
Cheers,

Sverre Rabbelier
