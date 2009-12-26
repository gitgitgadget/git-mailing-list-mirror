From: Tarmigan <tarmigan+git@gmail.com>
Subject: Does smart-http need git-daemon-export-ok?
Date: Sat, 26 Dec 2009 11:21:23 -0500
Message-ID: <905315640912260821k2fb149b3je69dbea5463afaa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, "J.H." <warthog9@kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 26 17:21:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOZOs-00007m-Fq
	for gcvg-git-2@lo.gmane.org; Sat, 26 Dec 2009 17:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbZLZQVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2009 11:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbZLZQVo
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 11:21:44 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:43323 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbZLZQVo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 11:21:44 -0500
Received: by pwj9 with SMTP id 9so5675497pwj.21
        for <git@vger.kernel.org>; Sat, 26 Dec 2009 08:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=W+qZAe0wp791E1H+tMmkLqAZiwtRVE7EjdCeJ/P7/wk=;
        b=I+bhCaJSf7yt7vzUjp+JdqXzgjQ5dVmgxq7el1/uW7NmiUXgPpkRU0EbSLQekpsn8F
         ccYTaOk9xqTgcIIV/yVBYNqKiCbUAdbC2w9oWajOPAOaAt2utaPLMeIldNxSF47HCyM/
         0aDOROHtidvvWkC6p8t9Ax9MNes4T9La9rNAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        b=AdMaj4QrgHRZA5NCqtKWZIcAuhwA3XROWjI89awpQbk/DOoTXwsEz8cUuYmnKyiYPa
         0+Gt+CyBEvFD484divARrsOEuZfPmvjPlVlNxXIxU1ftTiN89bFL+FnBGIYP3BkgEuLa
         IIF2zx21P/vU52ekmTm1GSW9aaN59/SvNyR/w=
Received: by 10.142.3.13 with SMTP id 13mr9122873wfc.302.1261844503128; Sat, 
	26 Dec 2009 08:21:43 -0800 (PST)
X-Google-Sender-Auth: ab93aed994164e77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135689>

Hi all,

Should the git-http-backend check something like git-daemon-export-ok
before serving a repository?  It would have been better to discuss
this a month or two ago, but it's probably not too late since
smart-http is still so new in released versions.

I think it's very similar to git-daemon which requires that to be set,
and I think the same arguments could be made for the same kind of
check.  There are already parallels for the upload-pack and
receive-pack services between the two.

Just as git-daemon may be invoked with --export-all, for
git-http-backend we could have an environmental variable to export all
repositories.

Thoughts?

Thanks,
Tarmigan
