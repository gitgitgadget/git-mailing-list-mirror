From: Johan Herland <johan@herland.net>
Subject: Re: Removing all notes containing a specific string
Date: Fri, 13 Sep 2013 10:12:14 +0200
Message-ID: <CALKQrgfX-tEm84h8a2qcaoZuZ0U7BCe34V0HMyuvJHCX72-y=A@mail.gmail.com>
References: <CAC9WiBi4=SVF6SE0hpccPLRdv-n8hcRUg+Pa+BbRWN1YudtXjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 10:12:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKOUN-00020N-Ju
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 10:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457Ab3IMIMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 04:12:24 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:47103 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756317Ab3IMIMV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 04:12:21 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VKOUE-0003C5-Qr
	for git@vger.kernel.org; Fri, 13 Sep 2013 10:12:18 +0200
Received: from mail-pa0-f53.google.com ([209.85.220.53])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VKOUE-000OUs-Il
	for git@vger.kernel.org; Fri, 13 Sep 2013 10:12:18 +0200
Received: by mail-pa0-f53.google.com with SMTP id lb1so2227112pab.12
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 01:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xlBKl/lFRbGO2fTMbe2IsD2RZMURrGkO5R6e89PK53M=;
        b=gNW8ZAhqHyf8HCfVPPDRk81VzY2M1aYCMTksYwVg16WhgDVUfZpsrHSAJS8a8Wdzut
         0dTzLSKQAj0AM6v4X3sV91aUCEkc3gXTJZ7s1he8nYNGYWcVzZ19zACRecRLoHkwJppk
         tLhGvHiI5LCnOwEa4MXR/cGpUnIhz2n8Y6Z3COTtHgS+SLqLK2RRMB3RhL+LNPxEdNq8
         wsLTw6u7TS9qgn5vUWCtnKWNldn5DUDFa40/dV2pQAt6CsBPRmE44ikZWh78tBUwq54k
         OJjFO33WPcv85233LQB0kkhjgx3LU2jsXM51Lo14gRzePncfe28lz0OM0kPR47itVvfa
         9Phg==
X-Received: by 10.66.186.204 with SMTP id fm12mr236076pac.189.1379059934466;
 Fri, 13 Sep 2013 01:12:14 -0700 (PDT)
Received: by 10.70.126.67 with HTTP; Fri, 13 Sep 2013 01:12:14 -0700 (PDT)
In-Reply-To: <CAC9WiBi4=SVF6SE0hpccPLRdv-n8hcRUg+Pa+BbRWN1YudtXjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234735>

On Fri, Sep 13, 2013 at 8:51 AM, Francis Moreau <francis.moro@gmail.com> wrote:
> Hello,
>
> I'd like to know if that's possible to parse all notes to detect a
> special string and if it's the case, remove the note like "git-notes
> remove" would do.

Hi,

There's no built-in command/option to do this, but the following shell
one-liner should do the job:

  git grep -l $mystring refs/notes/commits | cut -d':' -f2 | tr -d '/'
| xargs git notes remove


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
