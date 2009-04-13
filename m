From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: help with git query
Date: Mon, 13 Apr 2009 15:31:49 -0500
Message-ID: <d77df1110904131331p24f52220o74c401c97fbb904d@mail.gmail.com>
References: <3a69fa7c0904131151p35945ed3y58cba069bd801337@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 22:33:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtSqL-0002wd-4x
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 22:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbZDMUbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 16:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbZDMUbv
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 16:31:51 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:46179 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbZDMUbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 16:31:51 -0400
Received: by gxk4 with SMTP id 4so4845547gxk.13
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DBOfYVbfxhUPQ03IhxlplWdX/2U9PAhclRcmFp8R3yE=;
        b=EHnmvUU58KDL0wNh+erfp46IbNEfQ/CvbUsIKz+rnq8on8p/Hqwsn/2jOeNvmxREhc
         729C0BZTwnuDvbJjfP++nlxTVQbGm7eSRTM/8eARKLPV8HBTbkPqQJdiV2FytKnKq4aI
         J9EeKAg8nSK4U1zpd8+M1G9s92QIOAYF+Mrtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xVV4ezIC6cE+wmRL+KutkVvftRe4lUrINPdg/3IFTktxEii05M1UhxmaEwIChBYXbp
         yropJsmez5Yb2fF7AX/FUsneolJR3ivoHL5h4+GaRK21CXIZ0v3/cMTyEBYtipKca8V9
         +J3PPb78Ud3C01x9DU6bx/h9N6Sce+vUgJC9Q=
Received: by 10.231.35.75 with SMTP id o11mr801445ibd.45.1239654709451; Mon, 
	13 Apr 2009 13:31:49 -0700 (PDT)
In-Reply-To: <3a69fa7c0904131151p35945ed3y58cba069bd801337@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116481>

On Mon, Apr 13, 2009 at 1:51 PM, E R <pc88mxer@gmail.com> wrote:
> Hi,
>
> I'd like to generate the following report from git:
>
> for each branch:
>  - info about the latest commit on that branch (date and time, message, etc.)

Depending on what you want to do---from a bash shell, you could do:

for i in $(git branch -a | cut -b3-); do echo $i; git show -s $i; echo; done

>  - info about the last time it was merged into master

for i in $(git branch -a | cut -b3-); do echo $i; git show -s $(git
merge-base $i master); echo; done
>
> What commands can I run to figure this out? I think I can figure out
> the first one - it's the second one I'm having trouble with.
>
> And if it would easier to do it from the C API (or something like the
> perl Git::PurePerl module) I'd be interested in knowing that, too.
>
> Thanks,
> ER
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
