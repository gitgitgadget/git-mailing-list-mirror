From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 12:00:38 -0700
Message-ID: <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com>
	 <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com>
	 <20080819185804.GA17943@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWSg-0001JK-7Y
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbYHSTAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754522AbYHSTAl
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:00:41 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:63679 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbYHSTAk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:00:40 -0400
Received: by wx-out-0506.google.com with SMTP id h29so97523wxd.4
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zDIqw++8dJ+850o/z7r1ydR7NgTYAtnKBrm69Rm8oGg=;
        b=hKyQX/VPXg/KTkEafM9ReuJQ1z/+JcE3ke9ZU1BJkQJJk/8Fx7PT2Lp7Z3PJnD3Pde
         gEguZg4V/DoJkZFK5Nl38rBNH37zuF0AN/eCK+zhpibH3gYC+HKIC0ZqMq1hZu6wefTs
         a9ZSIr4GLofeCga3Z/wThate08wZxIt+5DX3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=w2Ng7sDthRe2HRLtON5IIHWpUiOzxKOzljjeWHNeoMX8IlV0IzqhDsAbsYykYQZRcd
         BMVGdJ8G+g9/2KGTOCXbTTeBRsvwUWHLuaKoQGTGGR/K+ySJLWSqM68OpsDZfjmeq+U+
         6a65wCs8JKgVkUqKjrCICQWbz4qu2m0Combr4=
Received: by 10.114.127.1 with SMTP id z1mr7084905wac.94.1219172438818;
        Tue, 19 Aug 2008 12:00:38 -0700 (PDT)
Received: by 10.114.170.3 with HTTP; Tue, 19 Aug 2008 12:00:38 -0700 (PDT)
In-Reply-To: <20080819185804.GA17943@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92904>

If the patch is acceptable, I will update the githooks doc with more
information, but we would like this so that you could add a hook that
runs your automated tests before a push would go through.

Scott

On Tue, Aug 19, 2008 at 11:58 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 19, 2008 at 11:55:27AM -0700, Scott Chacon wrote:
>
>> This commit adds support for a 'pre-push' hook that can be called before
>> a `git push` command.
>>
>> It takes no arguments currently, but if the .git/hooks/pre-push script
>> exists and is executable, it will be called before the 'git push' command
>> and will stop the push process if it does not exit with a 0 status.
>>
>> This hook can be overridden by passing in the --no-verify or -n option to
>> git push.  Documentation and tests have been updated to reflect the change.
>
> Would you care to describe what this is useful for (either in
> documentation, to help potential users, or at least in the commit log,
> so we know there is a need that is not otherwise fulfilled)?
>
> -Peff
>
