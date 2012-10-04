From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Bug report
Date: Thu, 4 Oct 2012 10:19:02 -0400
Message-ID: <CABURp0rhHTSqQFiXEb12iKLAAjMW3+Jn-ubMy-9jNWc5068toA@mail.gmail.com>
References: <506D122E.2050404@emsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: John Whitney <jjw@emsoftware.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:22:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtZO-0001w8-0S
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889Ab2JDOTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 10:19:25 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38912 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964793Ab2JDOTY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 10:19:24 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so410581lbo.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 07:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YpQIMB+rhq4yyDGrYIQEpjGujaI6mkF04XUi9YpdwAg=;
        b=E9oEWjdVSIl/smm/K7uzypS3wihpCxPaxcZZt77QETVvxaK7j7TLK/EJQ3A3KW84PY
         sZpfp4TiPS88jgti4o52altPtLEFwtCTvrkL/VuA9b0s/xVCFnzJ6L/2IVChw6ACkAHG
         Qp1Gd8Qs6vBSCv4Uj/yhoSrVO+2AdOaXKKNTa97C5WPJ6+4ah9IQ/c9jYEBkeaZsEe8b
         MkSyois5L1PQ/PjxRNwBdhT3mI08xMm3o9Anj7vjl56Hl14Qv5qqtf6QGtAR7nyfc5di
         JgB25z/sNJNJHmppnxuPTDCfV+WzJVcNXx7jLMuDugy5vilAl5zUCQaaguSLm1fZuUh4
         J2yQ==
Received: by 10.152.110.229 with SMTP id id5mr4264449lab.36.1349360362785;
 Thu, 04 Oct 2012 07:19:22 -0700 (PDT)
Received: by 10.114.17.225 with HTTP; Thu, 4 Oct 2012 07:19:02 -0700 (PDT)
In-Reply-To: <506D122E.2050404@emsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206992>

On Thu, Oct 4, 2012 at 12:35 AM, John Whitney <jjw@emsoftware.com> wrote:
> I just ran into a problem that I'm pretty sure is a bug in git. Just read
> and run this (fairly trivial) shell script to replicate.

When you added "* text=auto" in the .gitattributes file, you changed
what git considers to be the checked-in file content state for
test.txt.  The file contents in your working directory do not match
what git expects to check in.  Therefore, the file appears to be
different.  If you commit the file "changes" the problem goes away.

This is more of a workaround than an a satisfying explanation.  If you
then checkout the original HEAD commit (but with .gitattributes
present) you will see the problem appear again.  But in a sense,
adding .gitattributes this way is an act of foot-shooting.   The best
way forward may be to normalize your repository by removing all CR's
from files in history.  If you do not have this freedom, your best bet
may be to normalize the repo in the current commit and move on.

Others with more intimate insight into the CRLF journey in git's past
may have better advice.

Phil
