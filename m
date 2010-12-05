From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sat, 4 Dec 2010 20:18:38 -0600
Message-ID: <20101205021837.GA24614@burratino>
References: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 03:22:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PP4Ex-0005Zj-Bj
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 03:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab0LECS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 21:18:58 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65037 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117Ab0LECS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 21:18:57 -0500
Received: by ywl5 with SMTP id 5so5433993ywl.19
        for <git@vger.kernel.org>; Sat, 04 Dec 2010 18:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7YfEGZZndyP6QbeBouDI8cDcIKchUNr6ib7eSLzvFIk=;
        b=UvmX994EzEhwIgE3Ff5qixtRZtSgYHQ5NGK0vUzZVDrdBnOzIN1W4B/zrTjKKmIzB2
         UkZDGmOW5CvrY6KHKX2xiMLvJmkjXNckFW5vnVe2PocabwJ7EyYw2vSnWAgoUYuOyOs0
         uZKA7NKKwxwKsXhh2uGJtliUC/qjiNMROpGac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hWLE2p3OvOHLWzusipZ/UFwz0xLluhzLY0A9FFj7bg53dCECzDNIjBJtE/hhnZefcC
         XsGngBkP8emKRt/b25JGC/rjE6xUt8i01BToQYaPnHujjqnNI2Kyslx28FukyYVFbLKd
         4IWpXsifRsPoCHsM1z49SBjqnZLBsehuLVJ0A=
Received: by 10.150.145.4 with SMTP id s4mr5964357ybd.10.1291515536946;
        Sat, 04 Dec 2010 18:18:56 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id v18sm2162747yhg.15.2010.12.04.18.18.55
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Dec 2010 18:18:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162926>

Thiago Farina wrote:

> Signed-off-by: Thiago Farina <tfransosi@gmail.com>

I know that the context is part of an effort to make the commit_list
functions into something more of a self-contained API, but the
reader does not know that.  Perhaps you could say some words about
that in the change description: what's wrong with the current
situation, what context does this change come from, and what positive
effect would it have?

Beyond that, I must say I do not think this goes far enough to seem
useful.  If I wondered what reduce_heads did, wouldn't
commit_list_reduce_heads be even more confusing? (ignoring the typo)

Perhaps a more natural way to proceed would be as follows:

 . first, collect the functions to be treated as a module and
   list them in Documentation/technical (in this case, perhaps
   api-revision-walking or a new api-commit-list)

 . next, describe their current meaning.  If this requires
   apologizing for the name, that's a good hint that a name
   change might be worthwhile

 . finally, tweak signatures (names and arguments) based on the
   results from step 2 and update the documentation at the same
   time.

That way, people used to the current functions would at least have
some documentation to help them adjust.  What do you think?
