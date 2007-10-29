From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit restrictions on patch names
Date: Mon, 29 Oct 2007 16:14:34 +0000
Message-ID: <b0943d9e0710290914p4163ffabt5767fdb2ab8d91d4@mail.gmail.com>
References: <20071025194808.GV26436@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"GIT list" <git@vger.kernel.org>
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 17:15:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImXGN-0007ru-21
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 17:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbXJ2QOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 12:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755300AbXJ2QOi
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 12:14:38 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:27745 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbXJ2QOh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 12:14:37 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1608210rvb
        for <git@vger.kernel.org>; Mon, 29 Oct 2007 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Yh8A9rERSPQsYZrfNTwKz3GChV1i0VYbEHHeso3KaDw=;
        b=DnyxdEwt7Cie0XI0SUuPjhO+kjSjn9naI0GGT429l1lWWJpMRib4UfP3KbcPabSkpMJPcnfOan0e3d4f+gQSudBpcqSBJp3Lc/o4SFO3XUX8e/ZYvwFAOZ1yErTSw4yladk2A27UCiCn7BfwGjFMFKFqwkf/zdum+zt2Vsoxujg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XxAybwxFRN7kRDliK66JhQbxQexNRqnaduFx5XHc2z9Dyw6W1QsiOhicP935l6+SaBfphbBGwXCakNZAy2fM/x5MMaecW6YNfyVZ8qeQMXtK/e6p4Ft3sul0Uo7pCQtjP7AARZACLwg3HAM4RgQAIzFaN9y0Y8tQkNQbgpwgvpM=
Received: by 10.140.199.19 with SMTP id w19mr2848357rvf.1193674474352;
        Mon, 29 Oct 2007 09:14:34 -0700 (PDT)
Received: by 10.140.158.1 with HTTP; Mon, 29 Oct 2007 09:14:34 -0700 (PDT)
In-Reply-To: <20071025194808.GV26436@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62621>

On 25/10/2007, Yann Dirson <ydirson@altern.org> wrote:
> Looks like stgit is now more picky on patch names than in used to be:

It's not that we explicitly disallows "+" but I think I tried to avoid
some wrong patch names but was too lazy to create a better regexp.

As a quick fix, we could re-generate a patch name if it is invalid.

> => the result of the cloning operation is a partial clone.  Do we want to:
>
> - implement a mechanism for checking beforehand that the operation
> will not fail ?  Seems awkward to duplicate checks already found
> elsewhere.
>
> - wait for proper transactions so we can rollback on error ?
>
> - on clone error, delete the newly-created stack ?  I'd vote for this
> one, until the previous one gets done.

I think the last one is the simplest to implement, while the second is
nicer, I've never found the time to investigate it properly.

-- 
Catalin
