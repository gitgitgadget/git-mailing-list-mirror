From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Segfault in "git remote show <remote-name>"
Date: Tue, 26 May 2009 20:54:16 +0200
Message-ID: <40aa078e0905261154o7f8901e4k8526c787e0e9d3ac@mail.gmail.com>
References: <40aa078e0905250910v268faa66p29a0183db26cb0df@mail.gmail.com>
	 <20090525190121.GA3979@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue May 26 20:54:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M91n8-0005N4-Ou
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 20:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154AbZEZSyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 14:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756027AbZEZSyQ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 14:54:16 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:63114 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548AbZEZSyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 14:54:16 -0400
Received: by bwz22 with SMTP id 22so4037146bwz.37
        for <git@vger.kernel.org>; Tue, 26 May 2009 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4WnhoRJFmy/T957sUspNmPPMsXfbeShafRip6lN7lE8=;
        b=Fo/vg1eKkFrkodUXCzNrLGY3Ae/cJU9ZySPySiB4bWsUWHRhj0oMuH4fvTd7qH9Ww3
         zxfOgff2MK2tV7tbp50RAcv6xp7gQcq0OIg2BsgJcwe83U1QEYsfy48flRg89gaNKKh9
         8JqjXxVUt1dbVFe9IpfEBMj4JJ9Xz4f0KsBMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I/z+chAlTzqolmYYA+S2HJocLGiE6eGN87eF7/2esQ4WZWqHdW80d72F5iLldcWslB
         XzaRd0jq0W0o5THeZyFyk3BxNwiMuU7M1V6yvAxgX6JUjtF1GxXmOc+YKPlEq2HB1RVl
         t994ejFrv+iOx6M+vOvdf2VfbBKW+S7iZoYCc=
Received: by 10.239.163.69 with SMTP id o5mr631022hbd.40.1243364056366; Tue, 
	26 May 2009 11:54:16 -0700 (PDT)
In-Reply-To: <20090525190121.GA3979@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120008>

On Mon, May 25, 2009 at 9:01 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> Subject: [PATCH] fix segfault showing an empty remote
>
> In case of an empty list, the search for its tail caused a
> NULL-pointer dereference.
>
> Reported-by: Erik Faye-Lund <kusmabite@googlemail.com>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

Tested-by: Erik Faye-Lund <kusmabite@googlemail.com>

> ---
>
> On Mon, May 25, 2009 at 06:10:12PM +0200, Erik Faye-Lund wrote:
>> I've been messing around a bit, trying to set up a gitosis repo to
>> mirror one of my projects. Now, I added the remote to my project, but
>> when running "git remote show <remote-name>", I'm getting a segfault
>> in builtin-remote.c at line 303 ("while (ref->next)"), because ref
>> itself is NULL.
>
> This should fix it.

Thanks a lot for looking into and fixing this. I have verified that
the patch indeed fixes the issue for me.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
