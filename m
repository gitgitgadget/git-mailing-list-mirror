From: David Deller <david@horizon-nigh.org>
Subject: Re: [BUG] git pull does not understand --strategy-option
Date: Wed, 27 Apr 2011 14:27:57 -0400
Message-ID: <BANLkTiniVvLe7Wb9-OsKNb8nY23jxo-vQw@mail.gmail.com>
References: <BANLkTinFcob1RrOxEDDG+B6UAZGYg-smtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 20:28:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF9T2-00046O-F3
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 20:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480Ab1D0S17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 14:27:59 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35108 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303Ab1D0S16 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 14:27:58 -0400
Received: by vws1 with SMTP id 1so1526796vws.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=+Cqre4twBlve0TVzWOLnebqES9QzvT4Ubr4NxI0Jx2s=;
        b=EVmQB4KuVJM0QJna09vNrNxcKesZZF7Pj2quBP/RbM2KzhReifKgd+UXi/XuoQTTEZ
         H9cua8AzmW9rRjSYos8yDns1wbgaSyU6QaSwBJP7aRdI2LW9wxPXopqJaqnewYxdaPOu
         DeVijDOn4A3CR7sFrYOMv/XSGlOLzHENeD1Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        b=Em7/AnAsTrWlGF65DmIeSbW/OAgJG09E8XQhqwYzm8/zZaveUsgDRTw1VUbI6QCByQ
         T06+DZ3bQzlbT3DzgnPQyryXT+iMty1wx7Qtm3JC+2N4PFVaHOMzERb7tcH8tRv1Da+u
         HgisrjSFeaVNSGkTmHtd9Q3mv9rvaFGoeqpXE=
Received: by 10.52.184.5 with SMTP id eq5mr206016vdc.219.1303928877288; Wed,
 27 Apr 2011 11:27:57 -0700 (PDT)
Received: by 10.220.72.75 with HTTP; Wed, 27 Apr 2011 11:27:57 -0700 (PDT)
In-Reply-To: <BANLkTinFcob1RrOxEDDG+B6UAZGYg-smtg@mail.gmail.com>
X-Google-Sender-Auth: gFu2uqmClrU7HQ6aCYjLY6-CNDU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172256>

> $ git pull --strategy=recursive --strategy-option=theirs origin master
> error: unknown option `strategy-option=theirs'
> usage: git fetch [<options>] [<repository> [<refspec>...]]

I was able to confirm that the bug still exists in the latest version
of Git, 1.7.5. The docs say the option should work.

This affects Phing's[1] Git Pull task[2], which always outputs the
long form whenever the corresponding option is used.

David

[1] PHP build tool
[2] http://www.phing.info/docs/guide/stable/chapters/appendixes/AppendixC-OptionalTasks.html#GitPullTask
