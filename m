From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Fri, 1 Jun 2007 16:45:06 +0200
Message-ID: <8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
References: <1180385483418-git-send-email-hjemli@gmail.com>
	 <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
	 <20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
	 <20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Fri Jun 01 16:45:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu8Na-0006Zr-7A
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 16:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759597AbXFAOpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 10:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759560AbXFAOpJ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 10:45:09 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:45990 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759597AbXFAOpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 10:45:07 -0400
Received: by wa-out-1112.google.com with SMTP id j4so500856wah
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 07:45:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cJ5lZDXRxeWm/u0lqZufg8wftZAMqvVFfMhIZuzwNO8UQV+5K2kXKus9Vq5sFUUGz5mXSNkS/RCJJlFkZdId8CLta58z/tzVLzM7HdERD8sRXutjbe8WtTKn6O0OBF9rWjuD8qc62BVIa6lIVSMIYqnChyXNgBBS3BqWlHfAmyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qPSB55GCx3klic6N3HCM2rAOcdJ9b75Xtq1BclXZtwiNzSPGqk47P3kmSz60jrqjnaobchwxm/f9mcs9qUF3J6mHyi/j1CgyOwObWy3xI6xZOt6S1zOSwGwBGQWb0Wx+QnsIItaFOj+jXeEArFyu+kphDpL2Ki2Ce7OrMYSGIlU=
Received: by 10.114.103.1 with SMTP id a1mr1868117wac.1180709106887;
        Fri, 01 Jun 2007 07:45:06 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Fri, 1 Jun 2007 07:45:06 -0700 (PDT)
In-Reply-To: <20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48867>

On 6/1/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Fri, Jun 01, 2007 at 11:25:42AM +0200, Lars Hjemli wrote:
> > On 6/1/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> > >Could you please document the proposed .gitmodules first?
> >
> > The man-page for git-submodule found in 'next' mentions how it uses
> > .gitmodules, but there isn't (yet) a separate man-page for
> > .gitmodules(5).
>
> That's what I'd like to see first.
> .gitmodules(5) will hopefully not change in an incompatible
> way after it is accepted, while there is no such constraint
> for git-submodule.

True

>
> > [path '$path']
> >  submodule=modulename
> >  url=/some/url
>
> Wouldn't it make more sense to have
>
> [path '$path']
>         submodule=modulename
>
> and
>
> [submodule '$modulename']
>         url=/some/url
>
> in case the same module appears in more than one path?

Yes, that would be a properly normalized model.

Hmm.... Maybe we could allow both variations, with your suggestion
overriding mine if both are present? (I think there would be many
cases where the extra level of [submodule...] wouldn't be needed.
Also, the url in .gitmodules will only function as the initially
suggested url stored in the 'superprojects' .git/config)

--
larsh
