From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] t4010: match_pathspec_depth() and trailing slash
 after submodule
Date: Fri, 24 Jan 2014 12:48:54 +0700
Message-ID: <CACsJy8Cw3bkOuw8Xbw4hvcNGtZ0w6gqEkFCmfR2mfju3xHvNOA@mail.gmail.com>
References: <2550653.GHkhBQDSTk@localhost.localdomain> <1390483326-32258-1-git-send-email-pclouds@gmail.com>
 <1390483326-32258-2-git-send-email-pclouds@gmail.com> <xmqqa9emtngr.fsf@gitster.dls.corp.google.com>
 <52E188D4.20904@web.de> <xmqqwqhqs7j0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>, pawel.sikora@agmk.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 06:49:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Zdy-000668-Qo
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 06:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbaAXFt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 00:49:26 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:39328 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbaAXFtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 00:49:25 -0500
Received: by mail-qa0-f46.google.com with SMTP id ii20so3313899qab.5
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 21:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZgpyWhR9cHqIc7hujv7GHUCyKTo/NDCKD9yKd6WDqTU=;
        b=OUHEpa4Pe1/haiUvLVeDctGbPfvKnmoFDwF/3LPRCJ/xh3o2GktqK66eGLWRpjtDjt
         seREBs4h6lElWJSPXDO9ZJVagA0GxTmWB1CpNtWnEhGPEeylXyhW2W10JktASC8g/SQs
         Yboy0Ec6W0Wsmb8KEcZbVwkQ7NGtC1H9IwPenAA1nMBouhcphhuq0eSY/Yl5hc/e40NW
         qZ/LcPZBa6bwHO+I1zIKqqpOQI9R7tCw3lzNaYht6gTVO8C0wCnQXY1+hbA9r5a0nk6i
         bl/2gaT5K0xgz0o4aWcijybDyeyJNdD9Y8wYHTAbTwzsuB1taOIL1Q2k3DOK4WoWUEuO
         PTEg==
X-Received: by 10.224.123.14 with SMTP id n14mr17518137qar.78.1390542564853;
 Thu, 23 Jan 2014 21:49:24 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Thu, 23 Jan 2014 21:48:54 -0800 (PST)
In-Reply-To: <xmqqwqhqs7j0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240996>

On Fri, Jan 24, 2014 at 4:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> ... But a single
>> trailing '/' does mark "submod" as a directory, which I think is
>> ok for a submodule. And it makes life easier for the user if we
>> accept that, as shell completion will add it there automatically.
>
> OK, that would be annoying.
>
> Perhaps the completion is what is broken here, then?  I dunno, and
> haven't thought things through.

My reasoning is more simple minded: if "git diff HEAD HEAD^ submod/"
works, the user would expect "git diff HEAD submod/" to work too. I
think I've got something working with a bit refactoring. Will send out
soon.
-- 
Duy
