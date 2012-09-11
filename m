From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git an case-insensitive Mac OS X filesystem
Date: Tue, 11 Sep 2012 12:06:04 +0200
Message-ID: <CABPQNSYv1hd8RFHfcQ1XTB94nu6xo+tjj4CvWur29152z2dk6A@mail.gmail.com>
References: <CAPLaKK71O3RzavOqY2uVC1tUsbs+W6WxJRWuLBDFUvTwojAN-g@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@entel.upc.edu>
X-From: git-owner@vger.kernel.org Tue Sep 11 12:06:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBNMs-0004VY-Jx
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 12:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340Ab2IKKGr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Sep 2012 06:06:47 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:62952 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572Ab2IKKGq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 06:06:46 -0400
Received: by vbbff1 with SMTP id ff1so357543vbb.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2012 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=y0kEAPJZhQQmxcuk0ymr/77iSxLDxBbIcpZFKT3Q5cI=;
        b=UyXtgtdLq8h66yWSycXkvr4RYSKKW75k8ZTSzFKZyY1nHvIY/s2YtM/sdk17W9WPOn
         kSNdsk8dZcfQHmQWtlzmAc4Nj6sjbAQ18NLhGPERGsI9a9AnrC9xxtQPC+WPxtmpJZR7
         72Aqt8UY+VenEs2/c4SKsV3tQ6B2nqC89nK8PVLmY9YG/ULuR2BZb/u1JyCP9HTbtc75
         3Ed09hqXrfI5r5v40ybVKqLPxBMHCMBe4l2wByscu/I0VRaskjCRtX/d3x0b8zmIoOqV
         US0s6vWTlfRDO/zpEdfobsJDU5rrrhLFgktbnAUQj8Ps3GQeliREFKIa6yx9zaI5o7Ed
         nB/w==
Received: by 10.52.88.200 with SMTP id bi8mr4727543vdb.12.1347358005283; Tue,
 11 Sep 2012 03:06:45 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Tue, 11 Sep 2012 03:06:04 -0700 (PDT)
In-Reply-To: <CAPLaKK71O3RzavOqY2uVC1tUsbs+W6WxJRWuLBDFUvTwojAN-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205214>

On Tue, Sep 11, 2012 at 11:21 AM, Roger Pau Monn=E9
<roger.pau@entel.upc.edu> wrote:
> Hello,
>
> I'm using git for all my projects, and I usually work under Mac OS X
> with the default filesystem (that's case-insensitive, but
> case-preserving). I'm currently working on a project that has several
> branches, and two of them are called origin/DHCPCD and origin/dhcpcd
> respectively, that's unfortunate, but I cannot do anything about it.
> This completely breaks the git repository, because
> .git/refs/remotes/origin/DHCPD and .git/refs/remotes/origin/dhcpd are
> actually the same file, so when I try to update my repository
> performing a git pull I get the following error:
>
> error: Ref refs/remotes/origin/dhcpcd is at
> 6b371783de2def2d6e3ec2680ba731f7086067ee but expected
> 79f701ce599a27043eed8343f76406014963278a
>
> So I was wondering if anyone has stumbled upon this issue, and what's
> the best approach to fix it.
>

I have stumbled upon a similar issue on Windows (which also has a
case-preserving filesystem), and I seem to remember the solution being
something to do with packed refs.

Perhaps we could change Git to detect name-collisions and
automatically pack the refs in such cases?
