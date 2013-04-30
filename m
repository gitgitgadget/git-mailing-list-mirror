From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Wed, 1 May 2013 02:07:32 +0530
Message-ID: <CALkWK0k9Gix4_x-VKry2a-hZL-j0ROGGLiiYV9NyE+1A-VxQOA@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
 <7vppxcdjd1.fsf@alter.siamese.dyndns.org> <7vhaindcuk.fsf@alter.siamese.dyndns.org>
 <CALkWK0kUOEygRE8uMJbW=fOV6iGPAap+mbS7mysTHT3Ri+9eGg@mail.gmail.com> <7v4nendbry.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 22:38:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXHJa-0001Ny-BW
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 22:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933393Ab3D3UiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 16:38:15 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:62692 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933034Ab3D3UiN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 16:38:13 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so1181303iee.6
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+Rxxpz+DcgP+ilp5nv760jrYRtmDVvfCeRYVUPsrQh4=;
        b=jDliJr9WY9y9odoWkG7ZbPgnocpx7PZ4ZMeCU+NfMhZl/Dcs8w8XCaH5FBTjRtDei1
         khF+SKH9/I6bquGPGV/NliM+cWjx961zzCVjC41R0weCpfp6twIT62VVSqvytOHN0+zs
         48YydMuv2rGWr5lRdXobnsN0F6Qq3r31+OL+X32cpe4rWyK4DYxvJyjYKEdmr30E/njD
         PcOiZ/fZRyiGyUdth8vPqYOX/QxPQqjK2IfFPAMcfh5FuYpZXRu5ZGBiCgs/x5DDRU3Q
         pYLK3PCRedCJsyPTuRADospZSJB25+qk8SQ4fzCplA8esbfd6wX0bb6ewiQFeNEIhAdt
         0CJw==
X-Received: by 10.50.66.197 with SMTP id h5mr11046019igt.63.1367354293115;
 Tue, 30 Apr 2013 13:38:13 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 13:37:32 -0700 (PDT)
In-Reply-To: <7v4nendbry.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223007>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> In other words: the sequence "@" is short for "HEAD".
>
> That is saying a very different thing.  master@{4.days} is not short
> for masterHEAD{4.days}.

I meant after ^, ~, @{} have been peeled off.  Just before resolving
what's left.

> As design and semantics look still fuzzy (the primary one I am not
> sure about is if @ is a ref or just a revision), even though the
> desire to have _something_ seem to be popular, I am not particulary
> interested in looking at an alternative patch. I want to see the
> right semantics first.

I wanted to explain it through an implementation, but okay.  In your
proposal, @ is a special ref: it behaves like a ref in a rev spec, but
cannot be update-ref'ed or symbolic-ref'ed.  This is probably the best
we can do, unless we want to emulate a full ref (I'm not sure how
useful the .git/@ override will even be).
