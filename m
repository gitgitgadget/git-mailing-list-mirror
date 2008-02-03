From: "Alan Smith" <alanrogersmith@gmail.com>
Subject: MKCOL fails, 403 error
Date: Sun, 3 Feb 2008 08:39:04 -0500
Message-ID: <eae1aef50802030539l14287c7exa914696755e7ade4@mail.gmail.com>
References: <eae1aef50802030535u1402471fh182a230f3e0667ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: pasky@suse.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 14:39:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLf4U-0002tJ-B6
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 14:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932942AbYBCNjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 08:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932810AbYBCNjG
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 08:39:06 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:57200 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbYBCNjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 08:39:05 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1225617rvb.1
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 05:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yqzkGcYya82EXf5jB0/iU8q+fuAHulp9pKPeqX4uYsM=;
        b=Mq3Zx6f35BlPQWiD4XUXG3BHaVbB4d6stgdIvQQDDf/pUDMSxn5WjIMu8wirHPuoMsH5RgPC4zQUDIWxhBqn4LXVfXWWo9qyPzAAiwVUprUl5od7LKRaqKue2ooN0mk5JWJ7r6uXkXHDMp2s3b0mi0EffgNJDAI16BARtMja4Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qr/pGcGot3RUELpRVXqrfog7W2/D3YHAWydaTdFEcGUsM+38m45Ss4aaLBgYw25MyPqywNbshsGd5Dm/+cZj25hZqQ2/M0tIwEbJe+N1gApzfZa9JP05DT0pbE79/A6mqBZc+kPSYDjJuQDvmEDGo3VcG3KyXU46cGb1lWWkDpE=
Received: by 10.140.125.21 with SMTP id x21mr3898823rvc.234.1202045944052;
        Sun, 03 Feb 2008 05:39:04 -0800 (PST)
Received: by 10.141.114.12 with HTTP; Sun, 3 Feb 2008 05:39:04 -0800 (PST)
In-Reply-To: <eae1aef50802030535u1402471fh182a230f3e0667ea@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72354>

Hello everyone,

I am assisting the admin of dsource.org to get git working on their
server. I have had problems but those were resolved by my upgrading to
the most recent version of git (who'd have thought Ubuntu would not
have a version newer than 1.5.2.5?) Let me give you the terminal
output, the best explanation I have of my problem:

$ git push upload --force --all -v
Pushing to http://git.dsource.org/projects/pineapple/
Getting pack list
Fetching remote heads...
  refs/
  refs/heads/
   refs/tags/
updating 'refs/heads/master'
  from 0000000000000000000000000000000000000000
  to   aae4714c3d1150974612a9de2f86223dd6882b3c
    sending 11 objects
    done
MKCOL 65f829e3b46d363c07ff4e534bb1a39a6660fa48 failed, aborting (22/403)
     sent ce937eb2f7092823f0a491fdf0ab449440eb5365
Updating remote server info
    sent 367d34569b5d5223db05770d093e23bcc1c0ba89
    sent c431db074337adc100edbe4be861f599b0d889ad
    sent 65016e7e3c0d7654d6745b7de6d6a0840dd39150

In spite of the obvious problem, the 403 error, the user which I used
to push to the remote server is in the apache group on that server.
The apache group is both the owner and group of all of the files and
directories in the git repository. Thus, I see no reason why it is
getting a 403 error.

I am pretty sure the MKCOL has something to do with the fact that
there is a directory in my local git repository which it doesn't seem
to be able to create in the remote repository.

I was told to run git-fsck but it doesn't complain when I do run it.

Does anyone have any ideas?

Peace, Alan

-- 
My blog: lifelover.blogetery.com
My old blog: cocoalatte.info

// Things I've said -------------------------
"Maturity resides in the mind."
 "Silence is the Universe's greatest gift."
"When the World realizes that personal beliefs are not something to
argue or fight over, it shall evolve."
