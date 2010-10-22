From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git merge --abort? [was: Re: [PATCHv4 00/21] git notes merge]
Date: Fri, 22 Oct 2010 10:20:59 -0500
Message-ID: <AANLkTimzryq2Qa5sZNmXVY5Z1epg5Zxe3TMk9CX_+VX8@mail.gmail.com>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <201010221611.15425.johan@herland.net> <20101022145553.GA9224@burratino> <201010221712.06059.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, bebarino@gmail.com,
	avarab@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 17:21:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9JQq-0006gQ-R0
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 17:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878Ab0JVPVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 11:21:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62923 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab0JVPVV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 11:21:21 -0400
Received: by gyg4 with SMTP id 4so702552gyg.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=U1dpg6tO9huOKiUcIRPk5uAnyfZrKRlaEgqdOjnP8Vc=;
        b=ofJNbuDiBl1jxZ1HG8fGjD3aUzUJ4wRuA3yv8H+j8Wf7raqZFEeciVdRr5AhFq5LKo
         p91MKG+7iABGOSyb+3ouY7ddNIEdNJpkxHfXjO22H5lVE66L9IsJ2jnj8dBLLsQnV7hD
         1Wus4mvx5ooikcnH36ycBHEVIWyHqhylbFO4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=A6esDAn7loqs6joyVWsfCUc2XehxysH+6cJSXTMMJ+4kMsBepAMmCcEbd+pOJFO67F
         /XCbW8Kdlfdx8Q/AvGbkS+EN86x723as1SQ631gEbuWKXst3ESdtezTKPwpCQu/tyuny
         eVDKsyWecRMQ9L8b/IPCVlIO4es+yX87Vo+W0=
Received: by 10.150.177.7 with SMTP id z7mr6224755ybe.433.1287760879797; Fri,
 22 Oct 2010 08:21:19 -0700 (PDT)
Received: by 10.151.45.12 with HTTP; Fri, 22 Oct 2010 08:20:59 -0700 (PDT)
In-Reply-To: <201010221712.06059.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159700>

Heya,

On Fri, Oct 22, 2010 at 10:12, Johan Herland <johan@herland.net> wrote:
> Yes, that makes sense to me, especially if we make a 'git merge --abort'
> synonym. Alternatively, we can make 'git merge --abort' check for
> MERGE_HEAD, and then defer to 'git reset --merge', while leaving 'git
> reset --merge' as-is.

ACK to that. I think people using 'git reset --merge' know what
they're doing, and should be able to clobber their changes (viz. `git
reset --hard`), while 'git merge --abort' should do more handholding
and make sure you don't lose any data. (If I had more time I'd
implement that 'core.nodataloss' flag...)

-- 
Cheers,

Sverre Rabbelier
