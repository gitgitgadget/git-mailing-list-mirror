From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Sat, 13 Mar 2010 01:33:19 -0800 (PST)
Message-ID: <m38w9wlg7i.fsf@localhost.localdomain>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com>
	<7vr5nqrpyg.fsf@alter.siamese.dyndns.org>
	<55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com>
	<7v8w9whd3g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erick Mattos <erick.mattos@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 10:33:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqNj4-0000wA-91
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 10:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934102Ab0CMJdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 04:33:24 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:38747 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933950Ab0CMJdV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 04:33:21 -0500
Received: by fxm19 with SMTP id 19so1890191fxm.21
        for <git@vger.kernel.org>; Sat, 13 Mar 2010 01:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=rnEog1nqAFuNsuDsRn2O8TH38Zvk7UqSblqKMVJlk9s=;
        b=kWgDcgbPZonpM3d2pDlfyDsBgD92hBLarI5IUFDVmK5aHPHRYQjR2QcKdwuDbUFyQA
         bZ3utSNYvW45urdnR26PB3UsF3YQ0SI9HyWz1MMVBEOZxdNJyUnRB7pX5s6UtkUPaugj
         /fJrFzjJq43BVLwMpFGAPL+SSNxpfi/M0+VJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=XgNaHtyCjRSxx7D/YfhUgROCzvoz9NuvSf4fDLbcF6/EEggmpdBQCP+luOyng1S8fs
         6iQBluEm1s+7eG7FgNh9wGVm1QfbpmRUoO8tfzsiHZWyqfZfwzRzia+cIawK5xkzXXQH
         yVoOzvqsp3QvOj48RJqyKVZoeeY8xkwtAKFOo=
Received: by 10.223.164.165 with SMTP id e37mr2628784fay.43.1268472799943;
        Sat, 13 Mar 2010 01:33:19 -0800 (PST)
Received: from localhost.localdomain (abwm212.neoplus.adsl.tpnet.pl [83.8.236.212])
        by mx.google.com with ESMTPS id 13sm1641489fxm.10.2010.03.13.01.33.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Mar 2010 01:33:19 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2D9WpDp005110;
	Sat, 13 Mar 2010 10:32:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2D9WXXg005099;
	Sat, 13 Mar 2010 10:32:33 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v8w9whd3g.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142094>

Junio C Hamano <gitster@pobox.com> writes:

>     Side note: The other two "disjoint" merges we have are also this kind
>     of "no common paths" merge.  Nobody who was involved in the branches
>     that resulted in them prepared his branch with --orphan, by the way.
>     They started out in independent repositories, because they were by
>     definition independent projects and these were "cross project merges",
>     as Linus put it.

Note that beside "disjoint" merges ("cross project merges"), of gitk,
git-gui, gitweb and (very early in git history) git mail tools, there
are also three "disjoint"/"unparented" branches: 'html', 'man' and
'todo'.

While 'todo' is totally unrelated, and if instead of starting in
separate repository it would be created using proposed feature, it
would be created with "no common paths" case.

BUT in the case of 'html' and 'man' branches I could see why current
implementation of _removing index and not removing files_ might be
advantageous.  Remove index, create HTML and manpage version of
documentation, and add HTML (in 'html' branch) or manpages (in 'man'
branch)... probably shifting root, so it is not all in single
Documentation directory.

Just my 2 eurocents.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
