From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: simple example for git hooks
Date: Thu, 2 Sep 2010 22:49:45 +0000
Message-ID: <AANLkTimEo=sV=bKHyuQ5Md_7uQ0jAFKx+=dv4+KK+oD7@mail.gmail.com>
References: <i5p96s$u7q$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Gelonida <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 00:50:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrIbw-0004BP-8i
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 00:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555Ab0IBWts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 18:49:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45144 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538Ab0IBWtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 18:49:46 -0400
Received: by iwn5 with SMTP id 5so918475iwn.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=gY/Ehn6KTM9wPlygZEC58JESSRRl7wctE45k9gGo5y4=;
        b=H82TnvsiozNgI9Zg7Z+9ZG2nCrEMWdluGtq3m7qAwNzp0vsppvRMIzeohJ0jAKnQoK
         qKrpsLp6fElF8L5KEj6i7iGNTk7aqIqqteq37C1nVkZQL/MRpG6iHeWQqZdISUBAzs+C
         hOowbczqjyjGKfsCbfUbjUzVYwPxU5dJRUxV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YsDtMqUndAeWg5P9tRVP3Zb/8JbFeZmNy5OU9MIOU/EI4hr1csNMoIc9jVXy0axwsN
         mhTFrMHdm1oM4PGK6zc9/F3S+gA6+OWRcnaQwy845/unXwyNFGbZGbUg4OnTGqmLScoH
         qVEwk+bcSJiR0gvL/2pnf7/LPsTpv4cGFb7BE=
Received: by 10.231.19.6 with SMTP id y6mr11448010iba.16.1283467786047; Thu,
 02 Sep 2010 15:49:46 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 2 Sep 2010 15:49:45 -0700 (PDT)
In-Reply-To: <i5p96s$u7q$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155219>

On Thu, Sep 2, 2010 at 22:41, Gelonida <gelonida@gmail.com> wrote:

> Is there any clear documentation about hich git commands I'm allowed to
> use during a trigger script and which ones I can't

It's just a program that's run at a certain point, and its exit status
determines if git proceeds.

So you can use any git command, but of course what you might affect
what's about to be commited.

For a pre-commit hook (IIRC) you should find the stuff to be commited
in the index, finding a list of things that changed from a hook is
just a matter of diffing HEAD against the contents of the index then.
