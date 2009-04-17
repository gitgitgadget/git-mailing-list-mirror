From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: renaming remote branches
Date: Fri, 17 Apr 2009 20:20:52 +0400
Message-ID: <37fcd2780904170920m5a0c6c24se345275b0944e59d@mail.gmail.com>
References: <buo3ac9jn18.fsf@dhlpc061.dev.necel.com>
	 <20090416065934.GA20071@coredump.intra.peff.net>
	 <76718490904160609s1ef9c1e0m6f19ff169666fa3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 18:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luqpj-0000Yb-C9
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 18:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998AbZDQQU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 12:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754542AbZDQQUz
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 12:20:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:31183 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbZDQQUy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 12:20:54 -0400
Received: by fg-out-1718.google.com with SMTP id 16so129850fgg.17
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 09:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=T6X/PYDdBauk3v9KeI/ThieE0vwGs+DLjy8B7kgdfzo=;
        b=vTNFOjfycfZ+KY1at9c9AckAJa8UGYZgdxnkniAGr6LOBEBhAsiRKsh2JVzRhdQ3bN
         D6klqp2fTietsomIzwGYxfH52mk2MUWNvSRUVWjLSZ9mzrc3dnj75DRtklfVAozM0XnG
         PRjLltvSyftulHp1DTBH+a4ZI3rtbVOU1vc0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rlRrdHudA83Sg/Q0tbx0QsJn9OoB5kupEREkiQiSrhGAJyzTccRpFxFkK5PfFiF+0Y
         9Y24xYwr1UmG5XvS5m1uwYM44TLQHfoksjrZMIKml6CfSUpqspTHGH5uyVARO1a0ILAW
         haIBLo4oCUHBtVVHPnVWlbRxBzW8DDse87aCw=
Received: by 10.86.82.6 with SMTP id f6mr2121412fgb.77.1239985252238; Fri, 17 
	Apr 2009 09:20:52 -0700 (PDT)
In-Reply-To: <76718490904160609s1ef9c1e0m6f19ff169666fa3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116754>

On Thu, Apr 16, 2009 at 5:09 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
>
> I wonder whether we should:
>
> a) teach git remote a rename-branch sub-command
> b) add support on the remote side for properly preserving the config and reflog
>
> Thoughts?

Besides a race condition in creating new and deleting old branch, which
Jeff already mentioned, it could be some other problems. For instance,
how this new feature is going to interact with the update hook that many
users already have? It seems to me there is no way to make it backward
compatible with existing update hooks, so it will require to add a new
hook, and by default (unless this rename hook is explicitly allowed),
renaming should not be allowed, otherwise it can be used to circumvent
restrictions built inside 'update' hook.

Dmitry
