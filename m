From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Building git 2.4.5 on AIX 6.1 problems
Date: Thu, 09 Jul 2015 11:30:18 -0700
Message-ID: <xmqqwpy9uqth.fsf@gitster.dls.corp.google.com>
References: <516b832bd9db48e4bdb486d63b2a3977@imap.force9.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: John Norris <john@norricorp.f9.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 09 20:30:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDGaY-0001Wf-6d
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 20:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbbGISaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 14:30:22 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38212 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbbGISaV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 14:30:21 -0400
Received: by igrv9 with SMTP id v9so200070126igr.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7aC2HEHHjD06bgwMXXfzQG1p6rVtyjAJLKvebpfuhjU=;
        b=MwKH9xDrdzfKIMes1O+qfUyMiCGkSXcq4aSJdBR3MAO6mzb2IXpzFPxpOj5xETxwzz
         NPxEOR/iCjnMmw2s27vuYbpWz7fOt8Gl3Z2K2dH524O4ydOYOzDUBf/M/iOkwHZfVUQz
         KM+nKlB3qvziIi4GRqph3xwaJLCWNG8jnGjf/Giloy+klQOYZCGcDUipey/YpDuLsHh+
         xotsEAIN/wODXabu1bDlAEj2ZSN2KPZYRkr11KVm3byvsTO8F9RY9MLwyqMTdDTWw2Tn
         zD6AmvBfF11zX+wyZIdfKp3cx0atEdTX3H/tCAU4ngNrDIqKiblFTPoBdIV6G+1Rcqim
         iw5w==
X-Received: by 10.50.117.66 with SMTP id kc2mr74010172igb.31.1436466620781;
        Thu, 09 Jul 2015 11:30:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id b9sm3730023ioj.6.2015.07.09.11.30.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 11:30:19 -0700 (PDT)
In-Reply-To: <516b832bd9db48e4bdb486d63b2a3977@imap.force9.net> (John Norris's
	message of "Thu, 09 Jul 2015 18:06:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273769>

John Norris <john@norricorp.f9.co.uk> writes:

> I am trying to compile git 2.4.5 which I downloaded as a tar file on
> AIX 6.1. The machine has gcc installed.
> Having read through the INSTALL file, there appear to be several ways,
> either using configure, make, make install or just make, make install
> with prefix of where to install.
> Anyway whichever approach I try I end up with the same error.
>     LINK git-credential-store
> ld: 0711-224 WARNING: Duplicate symbol: .bcopy
> ...
> But really need help as this is very frustrating and googling has not
> found anything that quite matches it.

As "ld: 0711-224 WARNING: Duplicate symbol: .bcopy" seems to hit
many similar issues across different piece of software, I have a
suspicion that AIX folks (as opposed to Git folks) may have a lot
better insight to the peculiarity of the platform.

Running "make" with "V=1" may show the exact command line that is
invoked (it would begin with "gcc ...", I think), which may help
diagnosing the issue further.
