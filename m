From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/2] sh-setup: Write a new require_clean_work_tree
 function
Date: Fri, 1 Oct 2010 00:37:21 -0500
Message-ID: <20101001053721.GB6184@burratino>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
 <1285877017-8060-2-git-send-email-artagnon@gmail.com>
 <7v4od7hsqt.fsf@alter.siamese.dyndns.org>
 <20101001045713.GE20098@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 07:40:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1YMI-0000TZ-BU
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 07:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995Ab0JAFkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 01:40:33 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52039 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab0JAFkb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 01:40:31 -0400
Received: by yxp4 with SMTP id 4so1031757yxp.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 22:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7touTN7yx/WKHu7aXZz4OtOEhEBpUaqZEiOBbSuepo8=;
        b=l9XRSlkKKEUyJbfs5BYrrY1iUkAbFEXn5zfvGmSnTNUS0pBw+Cf3vt9PhP4SIFaE3d
         mw7POllM/xbroacnP9dtO7E4cjsWX6wRsc0l0gT16iCAUFDsVjBu0Lbycwzc1sXOVoUy
         3sC9PgoIKL67T28+uyATaCb6WbKUpVQsPTHtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RYtlfqeEx0AjdwEEoo6poDrA/h8dsp08tk9IXXdUJS8xyzs+iX5HdqfE+0rm48Y3y1
         EmhWtF/GdBqIR1LF/SXAO1lqhHQaBf+uKXOJn5AoOdpyG2bQS6sGqk9ix+9R1rjD11CZ
         CcwkTVO7aIL0Yfm8nQ6LFXR1uxFsLi8P+MHsU=
Received: by 10.151.1.41 with SMTP id d41mr429046ybi.215.1285911630622;
        Thu, 30 Sep 2010 22:40:30 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id l19sm472603ybn.12.2010.09.30.22.40.25
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 22:40:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101001045713.GE20098@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157733>

Ramkumar Ramachandra wrote:
> Junio C Hamano writes:

>> Please don't do this in-body "Cc:"; it is meaningless.
>
> Oh. What I intended to say was that Matthieu reviewed my previous
> iteration- should I just put that information in the cover letter or
> is there some other notation I should use? I can't use "Reviewed-by"
> either because he only reviewed the previous iteration- not this one.

Some noise about Cc and Reviewed-by tags:

 - I have been using Cc lines in patches to say "I consider this
   person something of a maintainer of the subsystem in question
   and would be particularly interested in his or her opinion."
   The idea is that if the patch does not get acked and a Cc line
   remains, people can tell that from the log.  The benefits:

    1) I remember to cc them
    2) later it is easy to find who looks like a maintainer
    3) the lack of ack is more obvious

   Checking Linux's Documentation/SubmittingPatches, I find that
   that is a misuse on my part (sorry).  A person passing on a patch
   to Linus is rather supposed to _add_ a Cc line in the rare event
   that they want to explain that a certain person had an opportunity
   to comment but did not comment (so Linus can know about their
   indifference to the patch, I guess).

   Neither use is as important for git, where many people read the
   list so it is not as important to cc people to get proper review.

 - I also used to abuse Cc lines to fit in contact information for a
   person who helped me, until I learned to use Helped-by and similar
   neologisms for that.  Sorry.

 - Again from Documentation/SubmittingPatches, I learned a while ago
   that Reviewed-by, unlike Acked-by, can only be offered by the
   reviewer and means that she is satisfied that the patch is ready
   for application.

If you just want to credit Matthieu, I suppose it would make sense to
say "Thanks to Matthieu Moy for such-and-such" somewhere.
