From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 22:35:10 +0200
Message-ID: <81b0412b0910201335j3b3340cydf3cbaf3c938190@mail.gmail.com>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
	 <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
	 <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
	 <200910202222.37563.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:35:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LQO-0000Vr-KN
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbZJTUfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 16:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbZJTUfI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:35:08 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:61799 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbZJTUfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 16:35:07 -0400
Received: by fxm18 with SMTP id 18so6892327fxm.37
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 13:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=eiX75etGvesionF8W1Bi4jwZ9dDu+JBpX7gKC5ctoZE=;
        b=urI6zW9Md9YFYGREZDcT8CTUTEja2vaO6HH9XLSAv4+aHggKg3H0h3pRyNk99s+/5w
         6RT5gWjNYRSDaoiM7ieWzaNuTvtBcf5awdTniMd3fy/2A4+iqoV93+vDWv+b5R44DLup
         Komwczh1EbuQPp8v6T3D5BeN2d1orh0idvFnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vZbErs8Hzfx6Ny0pzERJedRBA/aLwAxZnHojB7nVoqCaVOUG1xH6UMKWRLwebwEFO1
         PwrAl37vhn0FfXBD405HHCP1gEuyXnDHAufGHDEKct4T4cPtkj7eDaZOlw250N/G0lV6
         WZIE5QGRrxVg+ocVh86dScrfx832+LxpRHbcw=
Received: by 10.204.3.211 with SMTP id 19mr6914264bko.36.1256070910933; Tue, 
	20 Oct 2009 13:35:10 -0700 (PDT)
In-Reply-To: <200910202222.37563.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130838>

On Tue, Oct 20, 2009 at 22:22, Johannes Sixt <j6t@kdbg.org> wrote:
> On Dienstag, 20. Oktober 2009, Alex Riesen wrote:
>> What's so hard with storing the SHA-1 of the *commit*, anyway?
>
> The hard part is that you get a cycle: commit SHA1 depends on contents depends
> on commit SHA1.

Don't store it in the repo. Store it in the output.
