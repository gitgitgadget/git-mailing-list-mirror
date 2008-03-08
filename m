From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Can git be stopped from inserting conflict markers during a merge?
Date: Sun, 9 Mar 2008 11:24:21 +1300
Message-ID: <46a038f90803081424s1a0091c6r4d9e24c62ef2bdd1@mail.gmail.com>
References: <loom.20080308T174918-559@post.gmane.org>
	 <alpine.LFD.1.00.0803081242040.5896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "William Tanksley" <wtanksleyjr+git@gmail.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 23:25:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY7TQ-0004r0-H9
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 23:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbYCHWYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 17:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbYCHWYX
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 17:24:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:18812 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYCHWYW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 17:24:22 -0500
Received: by ug-out-1314.google.com with SMTP id z38so4641656ugc.16
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 14:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4MRDh7y8ezYRhgKK/u90sWO6MyuGi5YD2K6fVQw0oAg=;
        b=Z+VBxKE4QCtjpsEKCC3rJB7s9MsdZbHS9LFXkPT2cQED/kMrtClbJXKxMklT1fipwnnOg/inSQ+tdvF/ZRmSmeo0bd0Tqe/rzJC+mTmCcqNmyHOFkEOrWSA1Gm6EwAt+m0jqQIDhI+8agF7WpGFH3uIMmkJghWZkXeenhdf5/Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZsQqaI/PFWX0A1RImtGMqdGcKz5K1x7XwG2fTQImAefE4bzBUtZvaQ1Fp3MvcrD9oO1pEg6KlsaH3DNdu9umey1NHiGE2lS/+lSWRrmo0rJIhT1hv8S8xzGKneB1hJOU/FiTC3BTqIepI6EQMqpHyaw/Y9MrxUxKz4grrVKfIrs=
Received: by 10.66.234.13 with SMTP id g13mr2594701ugh.26.1205015061462;
        Sat, 08 Mar 2008 14:24:21 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Sat, 8 Mar 2008 14:24:21 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0803081242040.5896@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76595>

On Sun, Mar 9, 2008 at 9:51 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>  Do you want to just have both (with the base version, all three?) versions
>  of the file in your directory?

If that's what he is after, git-mergetool will do it - normally as a
preparation to call xxdiff or something similar. William, perhaps
git-mergetool is what you are after? You can look at the source --
it's shell -- if you want to tweak it.

But I think that what mercurial does is similar to Arch and Bazaar
behaviour: it will update the file following "one side" of the merge,
and then generate a .rej file with the unapplied hunks coming from the
'other side'.  This selection is arbitrary, and doesn't work on
octopus merges, so I end up not quite liking it. OTOH, if you open the
.rej file with emacs in diff mode, it's bloody useful for fixing up
patches so that they apply.

cheers,




m
