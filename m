From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git rebase -i slow for a reason ?
Date: Thu, 15 Apr 2010 10:20:09 +0530
Message-ID: <w2jf3271551004142150yc0323559x7dd66da56f473d22@mail.gmail.com>
References: <20100413100435.GA7441@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Apr 15 06:50:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2H2C-0004I9-OB
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 06:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192Ab0DOEub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 00:50:31 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36014 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab0DOEua (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 00:50:30 -0400
Received: by gyg13 with SMTP id 13so537629gyg.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 21:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=yK0PqLYFNEvwsDJLcrcFghTrDcsK09cJLdJyEm++zik=;
        b=lHt7HF2+hDe0M9GGeR5PC4WkzVGFNA09xoACLm2SiWCYwoGrSR/9eRf2BomBynVXZZ
         tIiesZEeb7+dv0k3fml4OeXWXmaUTjdoio2H956FCfkDUQFBamxJfrfBFdRVk7Ur5xjs
         y1lwZILtMJFm7InEdnM1gXT/obatMqTEx6Yjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fO3HVoKMlvc2E3h6/o0QMOQxiC3OyeXI1lbBZmMlopEt5RZgPwlEz/iXEIIhgOix/s
         QEn709AJvKs9hrhSeFaAE1aFnZ/cF2k1lkbSIJ6jGFri8E3aqcaFWzv1WPAy1P+UJIAL
         qcGlOFhpL82ki0DLJfHUG3PvhSublhJgeGjOk=
Received: by 10.90.69.14 with HTTP; Wed, 14 Apr 2010 21:50:09 -0700 (PDT)
In-Reply-To: <20100413100435.GA7441@glandium.org>
Received: by 10.91.59.6 with SMTP id m6mr4020216agk.4.1271307029200; Wed, 14 
	Apr 2010 21:50:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144948>

Hi,

> Most of the time, I run git rebase with -i, so while it is slow, I
> always assumed there was somehow a reason.

Technically, the interactive counterpart is simply a shell script that
calls the git-rebase binary along with a bunch of other things. See
git-rebase--interactive in the the source tree. Your observations
about speed mainly have to do with how the interactive counterpart
recursively cherry-picks and rebases.

-- Ram
