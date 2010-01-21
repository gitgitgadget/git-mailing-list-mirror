From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] Allow to override mergetool.prompt with   $GIT_MERGETOOL*_PROMPT
Date: Thu, 21 Jan 2010 11:10:15 +0100
Message-ID: <4B582807.8070504@gmail.com>
References: <4B572192.2020606@gmail.com> <20100121074427.GA26973@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 11:10:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXtzs-00015n-UD
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 11:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab0AUKKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 05:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919Ab0AUKKg
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 05:10:36 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:50422 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab0AUKKf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 05:10:35 -0500
Received: by fxm20 with SMTP id 20so1115123fxm.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 02:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=t8BuR/i3T+A1Uar5SspwdiB12fG/0OubjU8WEerOs1s=;
        b=DjwqqcZ5pBAWPYtRImuq6gwNHhs6I9PM76+CvvIIpwX9GC60lJ1HPMBttaMVBiXyP3
         rReaIKcC3sAM2+3A066208ebm5SOGtu+eyq3D4LfijrUa2is8P/QvlRFLd7A+QHt3u05
         uwT3gLlOcCjNG4UbbVpU0UREzJOrK+iSpPSrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=X2TFk2G8VYzxA52Vd8oR/U5rZat58KXcw3fAV5/WSKNy7FgibGQ/UzN8ynAJyMDbC2
         yBci+ScxKxTduHs5wv3dtOLBXXHD6/bQQV9dNZGkHkI9qAmBjCMlOGYzOiJlrAqchDoJ
         Z/JZbpFh0al9BL4y+iVxI5CZ0tKlu+sLsuBrE=
Received: by 10.103.87.28 with SMTP id p28mr595486mul.83.1264068633681;
        Thu, 21 Jan 2010 02:10:33 -0800 (PST)
Received: from ?192.168.1.11? (91-67-62-42-dynip.superkabel.de [91.67.62.42])
        by mx.google.com with ESMTPS id j9sm3238832mue.36.2010.01.21.02.10.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Jan 2010 02:10:32 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20100121074427.GA26973@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137650>

On 21.01.2010 08:44, David Aguilar wrote:

> The GIT_DIFFTOOL*_PROMPT variables are implementation details
> about how git-difftool passes options to git-difftool--helper.
> We don't advertise them in the documentation so we probably
> shouldn't support them aside from what is needed for
> git-difftool.  We can drop this part.

Thanks for the explanation, I already was wondering why they don't 
appear in the docs.

> git-difftool falling back to mergetool.prompt when
> difftool.prompt is not available is good, especially
> since we advertise that feature.
>
> Once you drop the local declarations and the env. variable
> it should be good to go.  Patch v2, soon?

If I drop env. variable support, I don't see much reason to introduce 
the should_prompt_merge () at all. I'd then leave git-mergetool* as-is, 
and directly run "git config --bool mergetool.prompt" inside 
should_prompt_diff (). Would that be OK with you?

-- 
Sebastian Schuberth
