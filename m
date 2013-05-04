From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Add porcelain command to revert a single staged file to its HEAD
 state while preserving its staged state
Date: Sat, 4 May 2013 11:48:57 -0700
Message-ID: <20130504184857.GC25863@elie.Belkin>
References: <CADeMBooSZA4D7YctRpRf+axjcUhkMBaJhkd89nssxZYFKph5sA@mail.gmail.com>
 <87obcryvcw.fsf@hexa.v.cablecom.net>
 <CADeMBopNestsZT4maGr3+tdOBf_Q0ukUbRCbXyucOiZZeHx6nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Dimitar Bonev <dsbonev@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 20:49:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYhWA-0003Ci-VA
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 20:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759854Ab3EDStE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 14:49:04 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62551 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759269Ab3EDStD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 14:49:03 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq8so1399345pbb.19
        for <git@vger.kernel.org>; Sat, 04 May 2013 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Rt7rn7Ss0tVlCdsw+5KDxvJ4+ldI40wVYeIW1UJmygM=;
        b=eLcn4ANMNS+cVTt868D5WyzK+wdsVMFpO8XncWpU4UNPJLmlF+sw4ad/6rPIGBm9iW
         ZuIFarv9wqz23dSWz4TeTrZxEWwqEaayXmPEIUXqQqgaFc6zpKg9EkJjKBnMi/Are7In
         xHRYHCPD4atIwZJW9P2Q/rcGC3VGPhtgX9JdPsyHX80sl5ElvjI6r6K6nxs5yVNdzn1M
         t5TtB6/uNfHBJ2mDCvRbNuCacbS1QJ9OgbZE2Lf3AfZSDTDd6GxjQl4JxTnpCJOjV4TT
         DjDU983vSx5vgKH+L+i4nok/cSnBBZ3xo+kAcgk6HovqEzsreK9Xqo6YYxmTTEOSFDMd
         eNAg==
X-Received: by 10.66.248.228 with SMTP id yp4mr19871207pac.158.1367693343235;
        Sat, 04 May 2013 11:49:03 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id k2sm18178355pat.7.2013.05.04.11.49.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 04 May 2013 11:49:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADeMBopNestsZT4maGr3+tdOBf_Q0ukUbRCbXyucOiZZeHx6nQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223370>

Dimitar Bonev wrote:

> @ThomasRast: 'git show HEAD:targetfile > targetfile' was proposed in
> the both links that I provided in the email that your replied to, but
> this introduces external dependency to the command interpreter to
> output the file unmodified but not every interpreter does this.
> PowerShell in particular modifies the encoding of the file

That would suggest that "git show" (along with similar commands like
"git diff") should learn an --output= option to avoid its output being
corrupted.  It doesn't leave me very happy.

Is there no way to convince PowerShell to treat the output of a
command as binary data with no particular encoding?
