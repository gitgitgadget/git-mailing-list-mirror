From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: Recovering the index after a git crash?
Date: Fri, 6 Feb 2009 14:38:48 +0100
Message-ID: <237967ef0902060538r1189573aob15c8e40512343ce@mail.gmail.com>
References: <vpqljsma99t.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Feb 06 14:40:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVQwM-0003Ep-Al
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 14:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754241AbZBFNiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 08:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753961AbZBFNiv
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 08:38:51 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:44499 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbZBFNiu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 08:38:50 -0500
Received: by ewy14 with SMTP id 14so1306317ewy.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 05:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OKQiknd6Ngxowlm/NzTbTSXS+kwH/CRAF0UmZ0xt/yw=;
        b=Lj1GAs6wfHq+ySuD6+QkRDMn2Z4OXSKbvDtK9Mtmi7NC0Ct+/O6p3IxPDG/7pYcU9B
         GkH772niIYYHkkP5J67tvRliwy/ywuhTZ9OLDpj8ACOXSoCKwLoI1ZjXsOXHFkSRmz6F
         6eHd6Rzw+cMQsWYKQvYeWtaILZo01AQslNtDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r+a/IjGWg3UrsmVBYG8af/r6dvZi2umj0KVDOGQ7z4Q1bLe3u18rZHs0WS0H8e0Bh5
         dKf2wlUy4Wusb/WtudND0rGZUPQ+6/f1EJVLR3girQiC8j/AjPKJTMjluP86yH0XnRqB
         VnQwgGyYFRlDBt1lCZVOt3Y18vtEFkfnQWhEA=
Received: by 10.210.112.1 with SMTP id k1mr1320079ebc.109.1233927528983; Fri, 
	06 Feb 2009 05:38:48 -0800 (PST)
In-Reply-To: <vpqljsma99t.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108705>

2009/2/4 Matthieu Moy <Matthieu.Moy@imag.fr>:
> Hi,
>
> I'm debugging a git assertion failure, which leaves a .git/index.lock
> in the way. After running the failed command, git refuses to do
> anything in this directory, complaining with:
>
>  fatal: unable to create '.git/index.lock': File exists
>
> What I'm doing then is just "rm .git/index.lock". Is it safe to do it?
> I guess I should just make sure there's no git process running, but is
> there anything else to check?

It should be safe, yes. Often it is even safe to remove .git/index
itself, since you can restore it from the latest commit with 'git
reset'.

-- 
Mikael Magnusson
