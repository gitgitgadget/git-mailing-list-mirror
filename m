From: Endre Czirbesz <endre@czirbesz.hu>
Subject: Re: git to p4 conversion
Date: Fri, 4 Feb 2011 10:49:16 +0000
Message-ID: <AANLkTimrwUxNOAnfxgvReGN+-h4_0jhZ731y22TB6u1K@mail.gmail.com>
References: <AANLkTi=0TSD6p7WtsVzx=pq8=GVu+jHUdxt1bnC++CT+@mail.gmail.com>
	<4D4AF29E.7070509@vmware.com>
	<AANLkTikW_sU8oCmU9wN5q1OPPJrQbS2YZAvS0C_nBQbD@mail.gmail.com>
	<loom.20110204T004658-497@post.gmane.org>
	<AANLkTikfGapDfZtD9H10797Ted_Av78WD8M7XrACOCpW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org,
	Ian Wienand <ianw@vmware.com>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 11:49:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlJEA-0006qS-T7
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 11:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab1BDKtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 05:49:17 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54122 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab1BDKtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 05:49:16 -0500
Received: by qyk12 with SMTP id 12so1831361qyk.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 02:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=jUCUYZWeBvUvwWL+aM4QAUxyz3er6wAv+meAG3JqwP8=;
        b=uauY2B191R5pgk2SjiJn2GJ8A7hrbfJWcyrGwoF1PyIwweYI/7wVEMyE7UrrDxLR5i
         vELh3tpPNhxwvXpxu6rKnuLzm4KwakpqZ9+S4WmrZIXY6toKsGJHtvYT86yajENjgp5x
         +7OI6inywFODB2DBWFRbB6BOKT5ev9fVq5A6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=uqBX3FUPh0t95uRLkk7btnDQplVFaMVP4/rHloG5/YUcsGnjwpdm4IY9WBC9G+8xS8
         Y03L6+Wvi/dC9T5XSlwAujkrJ9hnJu0oJjpXnv90aUSEx+Qej6DXRYM1sIxX7Xcw4HhU
         mur+48bpjvuFkMjBQb7SWTiyx2sux4qqDKOC4=
Received: by 10.229.90.196 with SMTP id j4mr10005205qcm.144.1296816556039;
 Fri, 04 Feb 2011 02:49:16 -0800 (PST)
Received: by 10.229.67.26 with HTTP; Fri, 4 Feb 2011 02:49:16 -0800 (PST)
In-Reply-To: <AANLkTikfGapDfZtD9H10797Ted_Av78WD8M7XrACOCpW@mail.gmail.com>
X-Google-Sender-Auth: 4IxHjvgBkREb13KtCRwYjTUqNs0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166034>

Hi All,

Thanks for the replies.

2011/2/4 Tor Arvid Lund <torarvid@gmail.com>:
> On Fri, Feb 4, 2011 at 1:03 AM, Vitor Antunes <vitor.hda@gmail.com> wrote:
>> git remote add remotename myprojectrepo

> Endre, you should start like you already have; by git-p4 cloning your
> project from perforce. (You maybe want to have a dummy file checked in
> to your <projectdir> in perforce, so that the 'git-p4 clone' command
> produces at least one commit in your git repo)...
>
> Then, do 'git remote add tempremote <path-to-your-existing-git-repo>'
> like Vitor suggests.
>
> At this point I would do:
>
> $ git checkout -b tempbranch tempremote/master
At this point I got an error message:
fatal: git checkout: updating paths is incompatible with switching branches.

So I fetched my tempremote first:
$ git fetch tempremote
$ git checkout -b tempbranch tempremote/master
(I got a warning from fetch, that there are no common commits, but I
supposed that it is right. :) )

> $ git rebase master
It applied all my commits.

> $ git-p4 submit
  Synchronizing p4 checkout...
  ... - file(s) up-to-date.
  Applying 1##############################9 Initial commit
  error: ***: already exists in working directory
[...]
  Unfortunately applying the change failed!

It said this error for all my files. :(
But I think we are almost there. :)

Regards,

Endre
