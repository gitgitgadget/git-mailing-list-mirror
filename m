From: Baz <brian.ewins@gmail.com>
Subject: Re: why no "git fetch --dry-run" ?
Date: Fri, 21 Nov 2008 23:14:59 +0000
Message-ID: <2faad3050811211514u1f3eb3deg7ae597a0328c981c@mail.gmail.com>
References: <ee2a733e0811211341j1e49fad7o64577605951fa5c0@mail.gmail.com>
	 <20081121221826.GM21815@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Leo Razoumov" <slonik.az@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Nov 22 00:16:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3fEX-0001gt-Od
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 00:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbYKUXPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 18:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbYKUXPB
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 18:15:01 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:31013 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYKUXPA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 18:15:00 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1155852rvb.1
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 15:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=o3pawm7wwUYhHJ9bUH7HPgv41/rZ6WwDQJqpm+UYhGk=;
        b=UJlNNUCIiWsQ8MegB26j0MW9F69EKozc5yGDoGI5BX5p44S3qIxO+uIyACYgL1rt+h
         S13jqvTWl0R7CF1WlJWfwO89gs2YeFZq4btyiHWDXlEVX5m8DCBmaAtShxU/5ABFKw4B
         SXm7ZOkl7LDYncg6WuzDjETc2nnF2bK3WfyCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=l0CDuKWtpNlmlDlpPJWiMHuaAjgNRLlOpF0FEkhmVtgpYLYnWACD9YrPokud0bjUmV
         Uu5Mat4iKxDQs3075kJW20fyPNt/zOHPchtGsiyX2HRrygMvp2qBxqNJBEqcJtC0ynK7
         GP3bq5RNSgUg7+GyIoqRkiLcLS29M7R69b4Ws=
Received: by 10.141.13.16 with SMTP id q16mr545313rvi.272.1227309299587;
        Fri, 21 Nov 2008 15:14:59 -0800 (PST)
Received: by 10.140.177.7 with HTTP; Fri, 21 Nov 2008 15:14:59 -0800 (PST)
In-Reply-To: <20081121221826.GM21815@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101546>

2008/11/21 Miklos Vajna <vmiklos@frugalware.org>:
> On Fri, Nov 21, 2008 at 04:41:57PM -0500, Leo Razoumov <slonik.az@gmail.com> wrote:
>> I am curious why there is "git push --dry-run" and no "git fetch
>> --dry-run" nor "git pull --dry-run". It would make sense to keep
>> push/pull/fetch as symmetric as possible.
>> For example, I just want to see which branches, if any, changed on a
>> remote repository since my last fetch. "git fetch -v --dry-run" would
>> be handy in this case.
>
> Actually fetch - at a core level - isn't symmetric to push, the protocol
> is completely different. I haven't checked the source, but I suppose
> that the push protocol has "dry run" support, while the fetch one
> doesn't have.
>

I wrote the patch for "push --dry-run" because I was more worried
about messing up the central repository (which I can't fix) than
messing up my local repository (which I can). It just needed a few
checks added to send-pack to make it work. I guess it's not been done
for fetch yet because nobody had that itch, shouldn't be too hard to
write. Certainly, other people have asked for it.

-Baz
