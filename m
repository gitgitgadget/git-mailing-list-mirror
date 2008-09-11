From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: Re: PATCH: git-p4 optional handling of RCS keywords
Date: Thu, 11 Sep 2008 08:33:57 +0200
Message-ID: <1a6be5fa0809102333j3218ada0xb905e3766c7697cd@mail.gmail.com>
References: <880457.35643.qm@web95006.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Simon Hausmann" <simon@lst.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"GIT SCM" <git@vger.kernel.org>,
	"Jing Xue" <jingxue@digizenstudio.com>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 08:35:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdfll-0002AQ-HZ
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 08:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbYIKGeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 02:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbYIKGeA
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 02:34:00 -0400
Received: from gv-out-0910.google.com ([216.239.58.186]:32924 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbYIKGd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 02:33:59 -0400
Received: by gv-out-0910.google.com with SMTP id e6so141841gvc.37
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QjYp5k2dAJ84CFZZ67L3agyolwokgDxAz6kM7i88d2k=;
        b=C3zpeJ2e1lQ3+VqEdEigaSXqeXTNifQYNXZDI0YudkhYei6N+cx7YOpT6jf7TzvZwF
         QHAKHnfGEf7gisNNb1wToYCl5lVUf9ZcOhYvMyBuC7gTjYAnN3k/jsKZONi+TuFKIdSo
         /khZwpo8MoIs3R151W/n/DwLDrj8QM94ofGZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eFpSB6cW9uV8js/Tug4yMHjV6S8hv9UkAiIeu6YqKO0rn5aSyTNTri+ygQewMwhVsG
         2pNtCFryWnL2tYWq8l/6N0dQBUvYzWKPubWD5KLf6wJU7tI6rBpUEMKoma+I08agtPtf
         uGmdlCRlR9MJKAP/LrtqD2EFFe0k6IHnlth58=
Received: by 10.86.73.3 with SMTP id v3mr1718828fga.28.1221114837994;
        Wed, 10 Sep 2008 23:33:57 -0700 (PDT)
Received: by 10.86.79.9 with HTTP; Wed, 10 Sep 2008 23:33:57 -0700 (PDT)
In-Reply-To: <880457.35643.qm@web95006.mail.in2.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95586>

On Thu, Sep 11, 2008 at 6:06 AM, dhruva <dhruva@ymail.com> wrote:
> Hello,
>
>
> Commit message: Modifying RCS keywords prevents submitting to p4 from git due to missing hunks. Optional shrinking of RCS keywords in git-p4. New option git-p4.kwstrip set to true or false controls the behavior..
<snip away the diff>

Me guesses that Junio (who gets loads of patches) would be happy if you do:

1) Squash these changes down to one single commit
2) Run git format-patch -1
3) Send it to the list either with git send-email, or otherwise send
the 0001-<your-commit-summary>.patch to the list directly if your
mailer supports it.

The reason is simply that the maintainer can simply use git am
<your-raw-mail-message-file> to commit it, instead of having to
manually sift through the emails.

Otherwise, this is nice work. Thanks.

-Tor Arvid-
