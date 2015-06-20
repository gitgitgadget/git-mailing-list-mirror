From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 12/12] refs: move the remaining ref module declarations to refs.h
Date: Fri, 19 Jun 2015 20:30:35 -0700
Message-ID: <xmqq381n5a5g.fsf@gitster.dls.corp.google.com>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
	<79947baebd702f8e9fe9b667e2eeb69afa73094b.1434206062.git.mhagger@alum.mit.edu>
	<xmqqfv5salh9.fsf@gitster.dls.corp.google.com>
	<20150615183504.GB4041@peff.net> <5584C789.7020209@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Jun 20 05:30:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z69UW-0004af-J0
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 05:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbbFTDaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 23:30:39 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34824 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687AbbFTDai (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 23:30:38 -0400
Received: by igblr2 with SMTP id lr2so4394796igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 20:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ECr1FccQK5UIUCkQBwontBMig7FJ0R2Ihc3Oj8SsMSE=;
        b=JCrm0dOmXfPUAUaNt7vFv1KYJh2GGUp1Z6MaWkM2DNFfLUyN6lRuQY5l6WLPXCNydT
         GuUhsNLoHKdE8g+/Qj3wriZRBgGf2jLx82DZf+G8H8A9Yz5KiXaGI8uh6kNg28BXiLOB
         kj4Mji2lBjFfBkHvy3NM0HK8XScaaIM2i5nsEb9t3+oKuOwFfxiquwkShZF0dT/RaYJS
         BXz1+Po1TDPUmjgM/aPKlkz17cEm+0ObhWjOjlQlXS+50Z7s97duxTvwMcmO0wHTfUPl
         4U75puSGvN1oiJuRFBu0us5uSY8WPc2RZJCHxBAFFvfjtdxhq+OHBPXqn+jZKY6pBExj
         GA0Q==
X-Received: by 10.50.141.164 with SMTP id rp4mr8669047igb.2.1434771037368;
        Fri, 19 Jun 2015 20:30:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id w4sm3046681igl.22.2015.06.19.20.30.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 20:30:36 -0700 (PDT)
In-Reply-To: <5584C789.7020209@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 20 Jun 2015 03:53:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272223>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Finally, when I'm inventing new functions (which I admit isn't the case
> here), I usually write the declaration first and then copy-paste it to
> the C file as the first step in writing the definition. If I name the
> parameters in the declaration then (a) I don't have to go back and edit
> them at the definition and (b) if parameter names are needed later at
> the declaration (e.g., for a docstring), I don't have to edit the
> declaration again, cross-referencing back to the C file to make sure I
> name them consistently.

That cuts both ways, though.  After somebody decides to rename
parameters that used to be "ref" after adding tons of other
functions and names parameters to these new functions "refname", you
have two places to update "ref" to "refname" for existing ones, not
one.

> I will split the "add names in declarations" changes into a separate
> patch.

Yeah, please do so.  I do not mind "add docstring and add names in
declarations so that docstring can refer to them" patch at all, but
that is a step separate from the "move the remaining declarations".
