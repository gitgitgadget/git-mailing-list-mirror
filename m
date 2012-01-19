From: Michael Nahas <mike.nahas@gmail.com>
Subject: Rebase and incrementing version numbers
Date: Thu, 19 Jan 2012 12:20:08 -0500
Message-ID: <CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 18:20:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnveo-0004rA-Ak
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 18:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110Ab2ASRUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 12:20:09 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60038 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab2ASRUI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 12:20:08 -0500
Received: by vbbfp1 with SMTP id fp1so118840vbb.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 09:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=tGqLzur6kiB8wsAyFAexiZCrNUnyX5tfsO1Y+DjBA+U=;
        b=H3pVjX2BTE+JBtjy0vmxG2ZVBeO88EkB+UfPTk97YPOE9HpnRjFt+1Ys7BnM9k4kFu
         pBUe1z+zBw/RSeM3A/yokGetLOVgceNra3ETeNuPqp3Tan3Xq7WtDqfryHZGQ9Xd3CiD
         btZpIAm5w7F5bOIBsEhzUe3ZDCm7DM7o4GF6o=
Received: by 10.52.90.171 with SMTP id bx11mr13340464vdb.26.1326993608202;
 Thu, 19 Jan 2012 09:20:08 -0800 (PST)
Received: by 10.52.64.231 with HTTP; Thu, 19 Jan 2012 09:20:08 -0800 (PST)
In-Reply-To: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188820>

I'm at a new job and using Git-SVN at a place that is accustomed to SVN=
=2E

The problem I'm running into is that whenever I change a file in a
directory, I have to bump up the version number in the configuration
file. =A0The larger version value in the config file causes my changes
to be loaded over the old ones.

Most of my commits are edits to a file like "foo.js" and an increment
to the version number in "config". =A0Ideally, each of my features
should live in a single commit and I should be able to make a sequence
of them, each time incrementing the version number in config.

The problem I'm running into starts with me editing version=3D100. =A0I
create new commits where I set the version to 101, 102, 103, 104.
When I go to push ("git svn dcommit"), my coworkers have incremented
the version to 103. =A0So, I rebase my changes, and get conflicts every
time because of the version number!

Is there a good way to avoid these conflicts? =A0Is there a hook I can
write? =A0Is there a change to this process that would work smoother
with Git and its distributed development? =A0It's okay if the version
number skips numbers (e.g., jumps from 100 to 104), as long as it
increases.

Thanks,

Mike
