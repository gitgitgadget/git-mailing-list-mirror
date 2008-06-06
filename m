From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 3/5] Create a git.Branch class as ancestor of stack.Stack
Date: Fri, 6 Jun 2008 09:44:37 +0100
Message-ID: <b0943d9e0806060144x48176566m277ba2969087b91e@mail.gmail.com>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
	 <20080604211334.32531.74258.stgit@localhost.localdomain>
	 <20080605070126.GC23209@diana.vm.bytemark.co.uk>
	 <b0943d9e0806050503x40191104ye332d6a8435811a5@mail.gmail.com>
	 <20080605130415.GB28995@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 10:46:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Xa6-0000a3-CS
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 10:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbYFFIor convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jun 2008 04:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764823AbYFFIor
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 04:44:47 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:39778 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764708AbYFFIon convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 04:44:43 -0400
Received: by wa-out-1112.google.com with SMTP id j37so689031waf.23
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 01:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hup6VbkqKgyD8+xgPYRnWNDtEWI/9U+/HcNRAnRdIjk=;
        b=eKFgXRVFRBpvuVSYFxfCsmRn7YmkDt9Sa7G0pLeKBejfT/jGS4LRs6zOk8SXjEC+Y5
         UKKeKf8/QQ7Cw+8SjZLSDRhbylP3pFfMza1Xay0rEFNC8PrSMXiWFRacLtQarbNwcbiS
         2aCfWjRGbiOwqW2pxvywT0CFyu7jhkOHLT8wA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=odM4jdUj2xfju6y5A8LIsnQQhpFZle9cXHRYTfCoK202Mh3NQhr5jLUe/R4+JGKnhY
         N7iLMxFliMgEoaiB3gh3Nein57fgpqBowcb4BrF5usXfFp5nfdZZaVEbqyzM9h5rVb9c
         Qa112Nq+yzq8otKGv67agqovtsjfx11rZyTb4=
Received: by 10.115.46.9 with SMTP id y9mr2712282waj.23.1212741877449;
        Fri, 06 Jun 2008 01:44:37 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Fri, 6 Jun 2008 01:44:37 -0700 (PDT)
In-Reply-To: <20080605130415.GB28995@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84040>

2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-05 13:03:55 +0100, Catalin Marinas wrote:
>> 2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
>> The same goes for the "create" function, the repository shouldn't
>> need to know the directory or files structure that a Stack or Branch
>> are using. I think we get a clearer separation this way.
>
> Yes, you're right. Knowledge of internals belong in the class itself.
>
> We'll have to be watchful against attempts to create objects other
> than via the officially designated factories, though. Python doesn't
> really have any mechanisms that help us here.

Doesn't need to be enforced. The Stack and Branch objects can be
initialised by themselves provided that the repository is passed as
argument at construction. The factory is more for convenience, passing
the repository to the newly created object.

If you really want enforcing this, it can probably be done by hacking
__new__ and __init__.

--=20
Catalin
