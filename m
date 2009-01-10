From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH] format-patch: avoid generation of empty patches
Date: Sat, 10 Jan 2009 19:17:22 +0300
Message-ID: <20090110161722.GA18859@myhost>
References: <1231536787-20685-1-git-send-email-nathan.panike@gmail.com> <7vmye0yohu.fsf@gitster.siamese.dyndns.org> <20090110113642.GA25723@myhost> <20090110113903.GB25723@myhost> <d77df1110901100801s463bb43bt701a95df14f167d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 17:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLgXz-0001Ef-2o
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 17:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbZAJQRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 11:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752409AbZAJQRX
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 11:17:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:61359 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbZAJQRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 11:17:21 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3639143fgg.17
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 08:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=WFL9RtJT9kYZPqARuz/Dxxn1eK7v73wWU+lHlkVpzvg=;
        b=d8RdOA25MXEJLheYFns4/KioTqdwvLABO6EMn8ktJzkrvEw2lpQ+lsB2FhOj2KolC8
         6e3fYLZXTwll+0VT63UID0OBmMhuCpU5Hyhc8RTdl9A6mlDh6KLPmh5cLdT5FgrXAza8
         MVV7TIpxqkWlPTGNRLUxjemF8hFvvFV4jP3VE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=J0ZewQeK/hu1dZjtFGYcowj+GSTvflCT7STU1abBNExi6f2q/GordZAxDTAXKc3Srz
         YRjjupJWPY0fUxc044byFGLfxMTvZga+DXVijOKjz/vVdIqPCYR+xPcoDQUsXWwHHtM2
         G7Rifrr0xxcPjMtzjNx8G8NjEdN31eLz16VLs=
Received: by 10.86.79.19 with SMTP id c19mr15477218fgb.66.1231604239744;
        Sat, 10 Jan 2009 08:17:19 -0800 (PST)
Received: from smtp.gmail.com (ppp83-237-189-185.pppoe.mtu-net.ru [83.237.189.185])
        by mx.google.com with ESMTPS id 4sm20791328fgg.14.2009.01.10.08.17.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jan 2009 08:17:19 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Sat, 10 Jan 2009 19:17:22 +0300
Content-Disposition: inline
In-Reply-To: <d77df1110901100801s463bb43bt701a95df14f167d8@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105125>

On 10:01 Sat 10 Jan     , Nathan W. Panike wrote:
> Hi:
> 
> On Sat, Jan 10, 2009 at 5:39 AM, Alexander Potashev
> <aspotashev@gmail.com> wrote:
> ...
> >
> > +               if (!commit->parents && !rev.show_root_diff)
> > +                       break;
> 
> Do you really want to stop getting commits?  It seems like the break
> statement here should be a continue.

AFAIU get_revision stops revision iteration when it appears to stay at
the root commit. So, if we will replace 'break' with 'continue', the
'while' loop will finish right after that 'continue'.

However, I might be wrong... please, correct me then.

> 
> Nathan Panike
