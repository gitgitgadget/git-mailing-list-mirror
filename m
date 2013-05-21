From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/2] Fix invalid revision error messages for 1.8.3
Date: Tue, 21 May 2013 23:20:48 +0530
Message-ID: <CALkWK0nXbncV4bjHLSQCu21w36vQP5E9irNhBbyXoEZ4-oqfcQ@mail.gmail.com>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com> <7vy5b8p9wm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 19:51:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueqj1-0006a2-Mh
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 19:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429Ab3EURvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 13:51:44 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64641 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046Ab3EURva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 13:51:30 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so2500685ied.19
        for <git@vger.kernel.org>; Tue, 21 May 2013 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DWx+4RmNwNTy3N63FHsRGJY4lbivYUQfBTPc9C68NF4=;
        b=va5DDWtTdSiVfwHTIaTwu0QEBpDrkzpf3zUUnemVUfiI8iuiD98yNL+5GYIUjMT27d
         jrvgU4NFDh0LpBA5QsOrWLo+ZI2n8js1weeJ1TIDznH5TKOB5T1lo6DqtIc1Ej+oZsd3
         OYJ+l0wnzHCs/QbLUtxxkPayW0DVovVAb3POcm5hxNALnZTyoVkQVoZNpSzCtCawuY52
         zDetP3xFZKrK0RPdRAoqDRUHDxez0tGOTBdmQuE1MD00UC3mXIvjLuG5enmNa/M57wyi
         VTQ84QwwzpL5qTwFKDXBlN7vYlSpKlIhNM+kbkcvEqS+122XNFvlKEMhAda1z05YmYu5
         Aigw==
X-Received: by 10.50.33.19 with SMTP id n19mr8908408igi.44.1369158690338; Tue,
 21 May 2013 10:51:30 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 21 May 2013 10:50:48 -0700 (PDT)
In-Reply-To: <7vy5b8p9wm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225051>

Junio C Hamano wrote:
> Fixes to something that are broken the same way between 'master' and
> older release versions are the same as enhancements (which you can
> view as "fix to lack of feature").  They are not regression fixes
> and not for 1.8.3 at this point in the cycle, deep into -rc.

If we view them as enhancements, well and good.  Let's polish them
until we're really happy with them: they're written with the "minimal,
but correct" philosophy, because the -rc3 window is too small for a
review.

Just to share opinion, they looked like "bugs" to me, because it's not
about "improving" the error messages; it's about correcting a defect.
The author could not have possibly intended two "error: " lines in the
first one, or an empty string in the second one.  At some point in the
past, the behavior must have been different (a "feature" must have
introduced these problems: like implicit HEAD for @{<N>}): the
"regression" was introduced in the version after that.  So, is it
because that version was too long ago that we don't consider it a
regression (do we backport fixes)?
