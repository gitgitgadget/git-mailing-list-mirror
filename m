From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [RFC] git reset --recover
Date: Mon, 3 Mar 2008 16:13:06 +0100
Message-ID: <8aa486160803030713r7bdcf825sf994cbb20f096ccd@mail.gmail.com>
References: <46dff0320803030659j2fa0325lf9c88b915ddb70da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 16:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWCMP-0004pS-JT
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 16:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbYCCPNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 10:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753943AbYCCPNL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 10:13:11 -0500
Received: from ti-out-0910.google.com ([209.85.142.186]:8780 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbYCCPNK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 10:13:10 -0500
Received: by ti-out-0910.google.com with SMTP id 28so87331tif.23
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 07:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QT2CglPMy/aY2dfXzx/y1bEfKumTE4BYbi3S+cjOXr8=;
        b=oUJr1vERfNWTRgOyEIR+FRb6P2hj9uzhZQTiH2NAcLSK6TUvNHYG3VaMssXojxXTa6QpIsEd2odvjbf+M03Nv0n3epLv098MZkhOaPITVbPaLB6bC8xdoMNGQaQqFcDPJy1h00p2obZ1mZI9rYzPJ1eOZNy+vmEvAtTw8IH5OIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zzio2uIpRMrlUqLn01VB9ZpxUFAfTOAefDMN2aN7uwEpNCzCmfSf+x3ZSUGEVXgloFoyRAdaUdHm/f9N6myMQSidJkTca06zW8fPgYOGsNnqUUz3cATeME4o7PWQiZHIIMbgXPyg5xxKeguVrIY09MsIP94RoOv7prZhy1/GBnA=
Received: by 10.151.150.13 with SMTP id c13mr4776ybo.168.1204557186679;
        Mon, 03 Mar 2008 07:13:06 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Mon, 3 Mar 2008 07:13:06 -0800 (PST)
In-Reply-To: <46dff0320803030659j2fa0325lf9c88b915ddb70da@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75934>

On Mon, Mar 3, 2008 at 3:59 PM, Ping Yin <pkufranky@gmail.com> wrote:
> Today i use git reset carelessly and lose all my changes!
>
>  To remind other people not do the same wrong thing, i share my
>  experience and propose a new option to avoid this happens again.
>  ------------------------------------
>  foo
>    .git
>     bar
>         file1
>         file2
>  ------------------------------------
>
>  In the direcotry structure above, i want to make bar as a repository
>  (which hasn't yet been tracked by foo repository). I should have done
>  this as follows
>
>  -------------------------------------------
>  cd bar
>  git init
>  git add
>  ------------------------------------------
>
>  but i fogot to type "git init" which results that file1 and file2 are
>  added to index of foo repository. I tried to revert the operation
>  using "git reset". And the tragedy happened at that time because i
>  made so fatal  a mistake that i typed "git reset --hard". And i lost
>  all my files in bar dir!

"git reset" was sufficient.

>
>  So, can we introduce a --recover option for "git reset" to save the
>  foolish or careless people like me?

Another possibility would be to not delete a file that is absent in
both the old and new HEAD, even if it was in the index.

Santi
