From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Wed, 10 Jun 2015 09:38:25 -0700
Message-ID: <xmqq7frbmsce.fsf@gitster.dls.corp.google.com>
References: <5575F948.4060400@web.de>
	<xmqqioavob7n.fsf@gitster.dls.corp.google.com>
	<loom.20150610T170737-586@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 18:38:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2j1P-0006uN-9P
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 18:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966194AbbFJQic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 12:38:32 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:32866 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965309AbbFJQi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 12:38:29 -0400
Received: by iebgx4 with SMTP id gx4so38215790ieb.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mSgJWTa1zrvl5onE674bS00QIrE/Tm+xG/XOKX67tIk=;
        b=oTYg7A563QSoB0avo4iuKOubD9A1wfxbLfEudrKO6Mu2cbsgoACPg/rBnwKGRtc+y5
         AnZGQpCcM0T59N8DHjEcNl6FCKWk526P3DAhBKnX5v3Ibfekn/pxRfkuqs0cpERYZdYj
         gdfrW1zufr+vJ9CByKDi6x9qu8lLRVUGuVq4Uzzt8ktWeSlXrO/v4Xy5b1Hv14HyOHDs
         TlLlQHNA3pCmS9lpYVcbAwPNPmxdVVQ8+WsSV0Nznhho5RnuLiuww95cnaxYyHYTwBh/
         q3Oj7lnRfCVzOff75Ic2Rk7k4bYrvzRdQ37B0LVDATNonnjpK4oSYJgFsXrs8s96tmxN
         LJlA==
X-Received: by 10.43.171.70 with SMTP id nt6mr5665083icc.73.1433954308512;
        Wed, 10 Jun 2015 09:38:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id f126sm6324185ioe.21.2015.06.10.09.38.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 09:38:27 -0700 (PDT)
In-Reply-To: <loom.20150610T170737-586@post.gmane.org> (Ed Avis's message of
	"Wed, 10 Jun 2015 15:11:57 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271327>

Ed Avis <eda@waniasset.com> writes:

> 'restore' may be more consistent with git's internal terminology.
> But from an outsider's perspective, 'revert' rather than 'restore' is in my
> view much clearer and more consistent with other version control systems:
> for example 'svn revert' is what you use to revert files in the working copy.

The reason why I said "restore" is because it does *not* have any
"internal terminology" connotation.

On the other hand, "revert" that means "create a counter-effect
commit" is not "internal".  "git revert" is a part of end-user
facing command.

The only people that will be helped by using "revert" there will be
the ones who haven't learned "git revert".  And it will make it
harder for them to learn "git revert".  It is unfortunate that other
systems use the word "revert" in a different way, and that is why we
should avoid using that word when describing "checkout".

> The original issue was that I naively expected that 'git checkout PATH' would
> indeed just 'restore' some files, that is, create them when they are missing.
> ...
> If 'revert' is not a suitable verb because of the existing git-revert, then
> I suggest that 'overwrite' or 'replace' might better convey the idea of what
> the command does.

Git is about "contents", not "files".  You modify a file, and
restore its contents to its pristine state.  It is not "restore the
file", as Git is not about "files".

I think "overwrite is better" is primarily coming from not thinking
in terms of "Git tracks contents, not files".
