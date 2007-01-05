From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [BUG] stgit: unexpected "unknown user details" on refresh
Date: Fri, 5 Jan 2007 09:07:51 +0000
Message-ID: <b0943d9e0701050107s21ec8527ud89425df4772998@mail.gmail.com>
References: <20070104232224.GA12756@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 05 10:08:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2l3M-0005TH-Mx
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 10:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbXAEJHx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 04:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbXAEJHx
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 04:07:53 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:63775 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030369AbXAEJHv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 04:07:51 -0500
Received: by nz-out-0506.google.com with SMTP id s1so3252121nze
        for <git@vger.kernel.org>; Fri, 05 Jan 2007 01:07:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GF/jBQao0rJhP5rtjalu7PsjFj/5nmBNk5Rn5kEKjWmbX7eKFWd3QlbKA0gBuDF+X9x9KC6/H/59OLVkr0cPZeVHon6wbrKzsZ7HdCat+54HnS6OxYRb34SGBsujwLxx5QaOe70DNr04QBmxoGuLNk0fFPSa4qfGPEJuxZqU5ZE=
Received: by 10.64.243.10 with SMTP id q10mr851226qbh.1167988071123;
        Fri, 05 Jan 2007 01:07:51 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Fri, 5 Jan 2007 01:07:51 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070104232224.GA12756@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35982>

On 04/01/07, Yann Dirson <ydirson@altern.org> wrote:
> Here is an error I just got when refreshing.  The refresh did occur, but
> the error is annoying and may hide something:
>
> dwitch@gandelf:/export/work/yann/git/stgit$ ./stg ref contrib/stg-whatchanged
> Checking for changes in the working directory... done
> Refreshing patch "whatchanged"...stg ref: unknown user details

I changed StGIT to use the same configuration file as GIT and it
cannot find the user information. To remove the error:

  git repo-config --global user.name Yann Dirson
  git repo-config --global user.email ydirson@altern.org

It probably tries to set the author information for the patch and
GIT_AUTH* or GIT_COMMIT* aren't set but it would be probably useful to
get the full backtrace of this error (at the end of the stgit/main.py
file, just add a "raise" before sys.exit(2)).

-- 
Catalin
