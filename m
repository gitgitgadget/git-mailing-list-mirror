From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] More readable 'Not a git repository' messages
Date: Mon, 9 Aug 2010 18:01:32 -0500
Message-ID: <20100809230132.GG4429@burratino>
References: <i3pdkj$hut$1@dough.gmane.org>
 <AANLkTinttmKi4+EbE54r-GeRbN3_2wxUHu_qJMn5Nysn@mail.gmail.com>
 <i3q0d8$m8f$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Ebert <info@ralfebert.de>
X-From: git-owner@vger.kernel.org Tue Aug 10 01:03:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OibNB-0006Nd-05
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 01:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146Ab0HIXDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 19:03:07 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39315 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0HIXDF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 19:03:05 -0400
Received: by vws3 with SMTP id 3so7139350vws.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rUwcODFY7R5p+crb1agujW81rqiHBNx7OjsEBChhiw4=;
        b=JplN9u45Nsz8Tq7ZWA/AnTaJlONWVlYrn+yVK8TedWJInbAV7b8Op/djAni6q9X5T+
         KAMlu1PrVxCvtycTO9iiqGPE9d64a0tFg2KdDGITIZsbEHLT9o0jIEaBRm4TIwV17oeT
         QJmmQ0fpffHZebX35p9qvDa+KmwYuClh++7A8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EIkzXECawj5VAChzNr3u8zRglsiRnCgoy8ot39/AGaR4N8dn265cJeGZ5qE4cbB1Rh
         nbbR8HR8FP5WtBNivNDOaX0phxyxmIfowboL+a/KHI+Cjrp3Y23AulpKdbF50tSpbLJN
         srITx9eJLTwP6v4gLp8l7ssKQ0T+9LRoHKZ+0=
Received: by 10.220.61.202 with SMTP id u10mr9045040vch.155.1281394984944;
        Mon, 09 Aug 2010 16:03:04 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id o7sm1166018vcn.29.2010.08.09.16.03.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 16:03:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <i3q0d8$m8f$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153050>

Ralf Ebert wrote:

> this code is inside a loop that goes up in the directory hierarchy.
> So cwd[offset] = '\0' does not only happen once before dying.

I hope not, since then the returned cwd value would be useless
for restoring the original cwd later.

Shameless plug: you may find the version in commit 98937be (i.e.
branch jn/maint-setup-fix in pu) more readable. :)
