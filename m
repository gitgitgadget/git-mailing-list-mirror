From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] test: mailmap can change author name without
 changing email
Date: Tue, 14 Feb 2012 15:50:23 -0600
Message-ID: <20120214215023.GC9651@burratino>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
 <20120214203431.GB13210@burratino>
 <20120214203519.GC13210@burratino>
 <CAMP44s3di25SbMa1T1=0_s6f-rKnniwEcA+o5HWT7xedcghSeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:50:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQGn-0005re-3V
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761249Ab2BNVug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 16:50:36 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41475 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757319Ab2BNVug (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:50:36 -0500
Received: by iacb35 with SMTP id b35so464732iac.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 13:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aNjMTfGgIg4B72SQnEV1nQmHDZca7hqdzRgIReK26Ok=;
        b=FU9tALFmueJFPxoOE0j3IlKOd5PQ90mYztOvOeMiSvTOyH/uh2HyXo1T7iW8ncqZsC
         zKCVFemBoY2DN9wwDPvG/LOwzEM+GZKtCXeb+hI2jvnCKNRwJLO5V3/39zgW/CtYUXeq
         Lbrz6+17lzKRn27AgN7L5zdUXi/fIMzI46LEo=
Received: by 10.42.19.5 with SMTP id z5mr30231222ica.51.1329256235611;
        Tue, 14 Feb 2012 13:50:35 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id en8sm15861667igc.5.2012.02.14.13.50.34
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 13:50:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s3di25SbMa1T1=0_s6f-rKnniwEcA+o5HWT7xedcghSeg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190767>

Felipe Contreras wrote:
> On Tue, Feb 14, 2012 at 10:35 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> (2) 'email@example.com'
>> becomes the canonical author email for commits with author name 'A U
>> Thor'.
>
> That's not true. I initially thought that was the case, and I think it
> might be useful to have that, but it's not the case now, and your
> patch doesn't test this.

Thanks for explaining.  I had indeed confused myself into thinking 'A
U Thor <email@example.com>' would act like 'A U Thor
<email@example.com> <email@example.com>'.

I should have said:

-- 8< --
A mailmap entry in the format 'A U Thor <email@example.com>' means
that 'A U Thor' should be the canonical author name for commits
with author address 'email@example.com', and the email address
should be left alone.

We already have tests for this format regarding the committer name,
but not in the author name, so the tests do not cover the shortlog and
blame codepaths as they should.  Fix that.
-- >8 --

[...]
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> I most definitely did not sign this off, and I didn't add any of these
> lines, nor wrote anything about this commit message.

That's why I described the changes I made, signed with my initials,
and put my own sign-off below yours.  Did I screw up somewhere?

Note that I am making these changes because, at its heart, I think
your patch is good and useful.  Otherwise I would have ignored it and
worked on something else.  If you prefer that I don't make
improvements like this, please indicate why that's a good idea;
otherwise I will probably continue to do it when I see good patches,
despite all the signals you are giving that I have done something
awful by corrupting your perfect patch in this way.

Jonathan
