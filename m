From: Jesse Hopkins <jesse.hops@gmail.com>
Subject: determine name of tag used for checkout when multiple tags exist?
Date: Thu, 3 Sep 2015 20:53:16 -0600
Message-ID: <CAL3By-8odLE53iBiNATgiCcnK4Ef5uBeH7E6EMB1K7P-oX0oAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 04:53:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXh7x-0002CJ-Rw
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 04:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbbIDCxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 22:53:18 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35446 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbbIDCxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 22:53:17 -0400
Received: by obuk4 with SMTP id k4so6952077obu.2
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 19:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=vTt70Zobvs0wSlkNQZGaCwNvLMyxZPMxmLTc+JUw7SU=;
        b=YzdLdwkERJaBFzR7RaPhI463nnqN5XeyB1IIhFMWa2cbmsEcEK07GSBP15MhQ1+TYb
         towGIurlbVspUzgy3OvJV9E/ACfw3NdpSv/ygRyBoO2XwUEOTBqU1JXqMlfUvLp1eQX9
         53zOi9iynmm/4TojjJGQ74uog6uKe1tI1Kh8HD1yfr7z1HEycmGyGj/X3YlSjcnhEhbH
         uovXThSoInO+eXmj7DxeXEmA9YbJAglj22oTGLAiDTtAvoNB2rKN7LRFKspWMfjyv23c
         gKaErMcaLoXtSlQuCosNkHzUto9V++33ZEIX36REwbpyLJXoaADlAsnMWB2gJFxi0ERN
         1E3g==
X-Received: by 10.60.155.42 with SMTP id vt10mr984193oeb.58.1441335196486;
 Thu, 03 Sep 2015 19:53:16 -0700 (PDT)
Received: by 10.202.1.199 with HTTP; Thu, 3 Sep 2015 19:53:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277283>

Hello all,

Looking for suggestions on how to determine the tag that was used to
checkout a git repo to its associated commit, particularly in the case
where multiple tags might point to the same commit.

I've had a look at git-name-rev and git-describe, and both seem useful so
long as there's only one tag pointing to the commit of interest.  However,
I'm still coming up to speed on their behavior in the multiple tag case
(mainly by experimentation).

It seems to me that when checking out to a tag, Git does not record the
*name* of the tag anywhere, but rather sets HEAD to the de-referenced
commit SHA-1.  As far as I can tell, it is not possible to recover the
original name of the tag in the case of multiple tags on the same commit.
Is my conclusion correct?

The reason I ask is that we have a build environment where it is likely
that multiple tags will get set by various groups in our main 'truth' Git
repo.  We are using some scripting that would like to know the *name* of
the tag used for checkout (this has been working well for us so far as long
as we checkout against branches).

Is there perhaps some other means of doing a checkout to tag that DOES
record the name of the tag?  If not, I imagine we might need some external
means to record the checked out tag, which is not out of the question.

Regards,
Jesse
