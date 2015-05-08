From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Please consider extending .gitignore to support setting of a
 file size limit
Date: Fri, 8 May 2015 09:09:06 +0200
Message-ID: <20150508070906.GC8248@paksenarrion.iveqy.com>
References: <CAC+AdWRpJnt2PN1YcB7VoHcKsO86_DhE1mOB5Ls9bWaEd_XKXQ@mail.gmail.com>
 <xmqqy4l0m5wf.fsf@gitster.dls.corp.google.com>
 <20150508065459.GB31516@vps892.directvps.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Roger Mendes <sproger1@gmail.com>, git@vger.kernel.org
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Fri May 08 09:09:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqcPK-0005xd-Vv
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 09:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbbEHHJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 03:09:10 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33816 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbbEHHJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 03:09:09 -0400
Received: by lbcga7 with SMTP id ga7so47140638lbc.1
        for <git@vger.kernel.org>; Fri, 08 May 2015 00:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nUg9OeKO/JYvnu7oXdSc53X7/W0iVbaCJhQQnPBrpXU=;
        b=A/gQZpPDPrI5nZhINF/wOKzg9jUCnrAybF64OR7ZUJPNff3xp6lTRcUYtV4Fh2CGPo
         uBV3sXHMvPaf+Icf/1SHhYT7DegfHiij1MdOKWci+hqW9CdNRAODeIdLv7oJ5JUyfI2E
         DvDaW60SfBMJ8soBsPpadVMiRDC2fbVB7R+P79Fk8ZJ0Q8qW42ref52CdKrSWid4BHY6
         t6VWd3dSDDyp5mvVyyTGvD8YCWbhKrzQH02BC9DysIRFLgq3dqfGihFCQOS8u36Tiyge
         IggWMr/8Ux/2yf5A6JspwxcCh22CIGOltpfybXbsfwLQY1xZ1zHjGp8ye20C93rBvzuT
         ARQg==
X-Received: by 10.112.139.36 with SMTP id qv4mr1802991lbb.24.1431068947507;
        Fri, 08 May 2015 00:09:07 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-17-125.bredband.comhem.se. [83.249.17.125])
        by mx.google.com with ESMTPSA id xx2sm955753lbb.13.2015.05.08.00.09.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 00:09:06 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1YqcPC-0000Wn-4C; Fri, 08 May 2015 09:09:06 +0200
Content-Disposition: inline
In-Reply-To: <20150508065459.GB31516@vps892.directvps.nl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268604>

On Fri, May 08, 2015 at 08:54:59AM +0200, Kevin Daudt wrote:
> My experience in #git is that people want to prevent other people
> accidentelly adding large files, resulting in all sorts of problems,
> which takes a lot of effort to fix if you're not an experienced user.

I second this. In #git@freenode we often get people trying to reduce
repo size since they or a collegue accidental added a huge binary file.

They do a filter branch and remove that file. However then they need to
do a forced push. And the person (the collegue) that didn't had enough
git experience to understand why it was a mistake to add a big file, now
ends up with having to sync with a rewritten remote.

So I can really see that there's a demand for such a feature. However, I
wonder if this shouldn't just be a pre-recieve hook?

If we want to inform the user, we might just add a pre-commit hook for
this.

The problem with pre-commit hooks is distribution of them. As it is with
making this a configuration option. There's really no good way to share
configuration and hooks between git repos today as I know of. (Yes, I'm
aware of this beeing a hard problem due to security concerns).

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
