From: James Pickens <jepicken@gmail.com>
Subject: Re: Disallow amending published commits?
Date: Sat, 21 Mar 2009 15:49:46 -0700
Message-ID: <885649360903211549h751c19e6sbaa0e07a14413d19@mail.gmail.com>
References: <885649360903211056u38ff6cabxbe1a17d57faaa0c4@mail.gmail.com>
	 <eaa105840903211146s4ff398e3qa8b570a8d29a83f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Sat Mar 21 23:51:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlA2B-0000KU-GC
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbZCUWtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbZCUWtu
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:49:50 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:26266 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbZCUWtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:49:49 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2095301wff.4
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 15:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ETshWUyg+iGxuZbNrOaSkY6rdK/Xq30+jQL1r5TTI4k=;
        b=EpbJrWP/xRY2Fs5EgFCmEKOfkhdO1TegEjUkrXJtcl/ocTV5T7cJVSfg754ZzAcxku
         X2OPPWWuPdkSPVx1byjGKxasLKdqNYKw1Q7tO4R4vY/6eWmdJWtedb9KXg/IkYt3qqA4
         HnIAyoMbjHNPox/eV8gLF2iimVj2wZjOudphs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WsAfBgoJYP0L/3m90nqzD9UBikw83nqDAbeW67h4D5PYb4e1gM8cotq3l3nAWuuq6g
         8nJKaFbTyuUneBRiri+V9sJ8gmQJfZuRfmtR1EDPKTiFOzwqGEifXgAHwRR+WR6KaNHD
         YO3QAxuZWbeR5QPUmCQXXfG/HXNfUOMiThF3s=
Received: by 10.114.73.14 with SMTP id v14mr3574159waa.104.1237675786960; Sat, 
	21 Mar 2009 15:49:46 -0700 (PDT)
In-Reply-To: <eaa105840903211146s4ff398e3qa8b570a8d29a83f4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114090>

[Resend since I forgot to cc the list]

On Sat, Mar 21, 2009, Peter Harris <git@peter.is-a-geek.org> wrote:
> An amended commit will have a new SHA1, and therefore git will treat
> it as an entirely different commit. Trying to push an amended history
> is 'non fast forward' in git terminology, since it involves a rewind
> of existing history.
>
> Set receive.denyNonFastForwards if you don't want people to be able to
> amend (or otherwise rewind) published history.

Thanks, but unfortunately that won't work in our workflow.  Users never
push their changes; instead, they do a turnin to a continuous integration
server.  The server clones the central repo, pulls their changes into the
clone, builds and tests it, then pushes to the central repo if it passes
the tests.  So integration happens via 'pull' instead of 'push'.

We can't force the pulls to be fast forward only, because we need to allow
turnins from multiple users to be built and tested in parallel, without
requiring users to pull from each other or otherwise coordinate their
turnins.

James
