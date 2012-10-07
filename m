From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Fw: [git-users] How do I git-push to an FTP server?
Date: Sun, 7 Oct 2012 20:58:26 +0530
Message-ID: <CALkWK0kXH-U0mTeFtiMq7tqCOpNJT1A7Z==GxOphe-sGdmxRRg@mail.gmail.com>
References: <20121005173833.e96c4fcfed0cce5b78911b0b@domain007.com>
 <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
 <CAEcj5uW4aw19MgNi8vJk5TWoL6SEad=s2jthS-h1jLTtuPq7AQ@mail.gmail.com> <7vwqz4si87.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org, git-users@googlegroups.com,
	August Karlstrom <fusionfile@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 17:29:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKsmt-0007yu-KP
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 17:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348Ab2JGP2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 11:28:50 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:60573 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318Ab2JGP2s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 11:28:48 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so1392728qaa.19
        for <git@vger.kernel.org>; Sun, 07 Oct 2012 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GlOA7lvrj7djg4lXYtGDA+b6r0g6EVZM6ogYCIEZLTk=;
        b=0zGt8HtwN1ndoOBcV/2nP0gDIWBJM1MPwqdbGPe9tCv4DR0IYvYNAmgR8xnuLXMafO
         v+WKLVqLpxUaAfR7cKcZoGeYpfr0SfWwZjBf42ycWoIOrCkoKkVIPG/2i+03NFAP1r9X
         PVVyT/1KMwsrMESFsbRLVoh2kXFti+u7NlAeHHSvIrTsKzHbtDdfj1nHxkjkZFJ6hgfT
         cwamjZmYnWJN2p2e172G/Qkh9J4gdYE5i+5WtILfBWp6/SoBL7KRaKgbIBr8fRE3jKAJ
         FbPXrSsFGYKQrkvYgjqFpSh2lnI0sMH6D/mzwKynRr2oHazjZEp6f4+wF4bIYNxA5pvW
         VIDg==
Received: by 10.49.14.193 with SMTP id r1mr37212671qec.50.1349623728188; Sun,
 07 Oct 2012 08:28:48 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Sun, 7 Oct 2012 08:28:26 -0700 (PDT)
In-Reply-To: <7vwqz4si87.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207182>

Junio C Hamano wrote:
> Thomas Ferris Nicolaisen <tfnico@gmail.com> writes:
>
>> On Fri, Oct 5, 2012 at 3:46 PM, Philippe Vaucher
>> <philippe.vaucher@gmail.com> wrote:
>>>
>>> > On the git-users mailing list we're trying someone to help with
>>> > running `git push` over FTP.  That person is runnig Git 1.7.9.5
>>> > on Ubuntu 12.04.
>>>
>>> I don't think vanilla git supports pushing over ftp.
>>>
>>
>> At least according to the documentation[1], "Git natively supports [...] ftp".
>>
>> This could need some clarification if pushing over ftp is not supported.
>
> The commit 5ce4f4e (Documentation/urls: Rewrite to accomodate
> <transport>::<address>, 2010-04-06) that came from
>
>   http://thread.gmane.org/gmane.comp.version-control.git/145196/focus=145205
>
> was supposed to be just a clarification of the document, but it
> added ftp to the list without justification.

Hm, my bad.  Would this fix the problem?

-- 8< --
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Sun, 7 Oct 2012 20:57:15 +0530
Subject: [PATCH] Documentation/urls: git does not natively support ftp

5ce4f4e (Documentation/urls: Rewrite to accomodate
<transport>::<address>, 2010-04-06) added ftp[s] to the list of
supported protocols without justification.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/urls.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 2890194..a65e894 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -6,13 +6,12 @@ address of the remote server, and the path to the repository.
 Depending on the transport protocol, some of this information may be
 absent.

-Git natively supports ssh, git, http, https, ftp, ftps, and rsync
-protocols. The following syntaxes may be used with them:
+Git natively supports ssh, git, http, https, and rsync protocols. The
+following syntaxes may be used with them:

 - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
 - git://host.xz{startsb}:port{endsb}/path/to/repo.git/
 - http{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- ftp{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
 - rsync://host.xz/path/to/repo.git/

 An alternative scp-like syntax may also be used with the ssh protocol:
-- 
1.7.12.1.428.g652398a.dirty
