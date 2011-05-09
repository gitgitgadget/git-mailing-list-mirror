From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 (for maint)] git-completion: fix zsh support
Date: Mon, 9 May 2011 17:53:07 -0500
Message-ID: <20110509225307.GG22908@elie>
References: <BANLkTikkhryMa69DSx4EAYjw+aar4icKcQ@mail.gmail.com>
 <1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 00:53:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJZKI-000051-Gc
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab1EIWxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:53:13 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:37412 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699Ab1EIWxM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:53:12 -0400
Received: by yia27 with SMTP id 27so1972861yia.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 15:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WjTg/F8JvUF8jixFySa8/JWBsE5wlkDDQCJhNQTPri4=;
        b=lzvzCQ4fDWJ21uYiHGUz9GY+T2zDi6zSVhHEmE3tCrPl+N2Zma6y83AgQJoetG8Req
         OxGgFA+IZntburYaEyarn3I1PVmTkzXnm2H0bn/8U6d70+KNnXT/+uLexYYA00lV3WRg
         4MU9D+gIqv5VUrEpSOdRlYHInOLOjz1nfkkNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oBjX8NLgvMBskCm+1CRWIq9nAV4070EK/GdLelm5PN8gc0KBozsqUldkOJLaNjLyQH
         D+tFzWbkZxcTM1E87ePPdydbwL7yo1A+PIzuqfhogfAB/lt5rKqlJACLuImKZ2JE8nge
         9wVObOBq5bSXr+mDi3vvtz6m/OKrQjztGOJK4=
Received: by 10.236.156.132 with SMTP id m4mr8713820yhk.107.1304981592290;
        Mon, 09 May 2011 15:53:12 -0700 (PDT)
Received: from elie (adsl-68-255-107-251.dsl.chcgil.sbcglobal.net [68.255.107.251])
        by mx.google.com with ESMTPS id l49sm2838950yhn.33.2011.05.09.15.53.10
        (version=SSLv3 cipher=OTHER);
        Mon, 09 May 2011 15:53:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304979299-6496-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173281>

Felipe Contreras wrote:

> v4: more commit message improvements

Thanks.  You seem to have ignored most of my review; I'll try to find
time to clarify the commit message if the consensus is that this
approach is a good idea.

An alternative possibility if we need this fixed in the v1.7.5.x
series (do we?) would be cherry-picking the fix from
sg/completion-updates on top of maint.

To clarify the trade-offs:

 - in terms of lines of code, the fix itself in sg/completion-updates
   and this fix are about the same size.  But the sg/completion-updates
   version relies on a code cleanup.

 - the fix in sg/completion-updates is less likely to be broken by
   future changes in the bashcompinit library.

 - this fix is conceptually simpler.  In a way, the fix in
   sg/completion-updates only works by accident.
