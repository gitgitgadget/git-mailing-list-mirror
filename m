From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v2] Re: add documentation for mailinfo.scissors and
	'--no-scissors'
Date: Sat, 12 Sep 2009 05:03:51 +0200
Message-ID: <20090912030351.GC18684@vidovic>
References: <33445216edc4c4e1976cdd81521922042955e6eb.1252626034.git.nicolas.s.dev@gmx.fr> <f63e8402656c02fc2ecdcce8a37cc1d60a61aa1d.1252628643.git.nicolas.s.dev@gmx.fr> <7veiqe0x05.fsf@alter.siamese.dyndns.org> <20090911134112.GA18684@vidovic> <7vws45wbxq.fsf@alter.siamese.dyndns.org> <20090911200849.GB18684@vidovic> <7v8wglw60x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 05:05:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmIv5-0004zu-E9
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 05:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbZILDEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 23:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbZILDEB
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 23:04:01 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:56198 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbZILDEA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 23:04:00 -0400
Received: by ewy2 with SMTP id 2so1607670ewy.17
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 20:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=2I+8TX9Eq9TkAYWCL63lsUSUoAeMhWj+7x781sXh2BY=;
        b=jPM0J/Y/5pRhYIXMSqhFGpJSQM+L8GZCcdXDi2Q3yNHWNuizn5ss979pcZjvCBEhvX
         RboRUaphPUkO9fIcjM7OCIAVLHJAHfct5inwVhTyEWxtfnJdMoUtAG1G81jyq3HWocJ2
         DHhIJsnd3ph9mhq2dZi8vn51dkLOI9SE3t8mE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=G0UMfEE1kGNJtNyZ8JeLsQQo7qC8K8mRE3Q66o0rbjtm6lVkWnQ2+x5SiQWco2Crxz
         uA+esrAwSq7sfAqsOjZpo5/di0b10SN9FhKe2jVSfTqGbqXbblK7BUT0pUBQiSkYGtMt
         eMszwR2C0sV3DrteJpMHCd+QozOam/2za7TVg=
Received: by 10.210.2.16 with SMTP id 16mr4077193ebb.31.1252724642710;
        Fri, 11 Sep 2009 20:04:02 -0700 (PDT)
Received: from @ (91-165-134-53.rev.libertysurf.net [91.165.134.53])
        by mx.google.com with ESMTPS id 23sm979089eya.25.2009.09.11.20.03.58
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 11 Sep 2009 20:04:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8wglw60x.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128235>

[ Thank you (again) for this very good explanation. ]

The 11/09/09, Junio C Hamano wrote:
> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> 
> > Ok. So, the fact that the usage of git-am doesn't tell about
> > --no-scissors is the expected behaviour?
> 
> You _could_ argue that we _could_ describe a long option "frotz" that
> lacks the '!' flag in OPTIONS_SPEC as "--[no-]frotz" in the output by
> changing the rev-parse --parseopt, if you really want to.
> 
> However, I think that is not done deliberately to avoid cluttering the
> output.  I Cc'ed the primary guilty party ;-) of the parse-options
> infrastructure.

Well, if it is expected to not have the "--[no-]frotz" in usage where
applicable I'll be fine with that (even if it may sounds a bit odd for a
sane user). Otherwise, I believe it could be a (small) improvement for
the UI.

> Currently, non-bool options are not marked with '!'.  Nobody sane would
> say "git am --no-directory foo", but "rev-parse --parseopt" acccepts such
> a nonsense input, and it is up to the calling script to catch it and barf.
> But "rev-parse --parseopt" will start saying "--[no-]directory=" with such
> a change, which is not good.
> 
> And --no-scissors is not that special.  We could add --no-signoff to say
> "I do not want to sign-off this one time" explicitly, and it is crazy if
> we had to add another line in OPTIONS_SPEC when we want to do so, when it
> is clear "signoff" option is a boolean.
> 
> As a long term direction, I'd rather not to see "no-" in OPTIONS_SPEC, but
> have that taken care of by "rev-parse --parseopt" to keep our sanity.  The
> only existing offender is "no-verify" in "rebase -i".  Let's solve it (if
> there is anything to solve, which I doubt) without adding new ones.

Now (with all this background in mind), I agree that the "no-" in
OPTIONS_SPEC looks ugly.

<If there were something to change>

As you say, we can't blindly rely on the "is a boolean" and "option name
begin with 'no-'" things altogether. Perhaps a new magic character
('-'?) beside the current flags of PARSEOPT could smartly do the trick?

</>

Pierre, opinion?

-- 
Nicolas Sebrecht
