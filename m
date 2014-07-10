From: Luke Diamand <luke@diamand.org>
Subject: Re: git p4 diff-tree ambiguous argument error
Date: Thu, 10 Jul 2014 19:07:57 +0100
Message-ID: <53BED67D.8080006@diamand.org>
References: <1405013428825-7614774.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Door <duanemurphy@mac.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 20:08:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5IlO-0007mg-Ju
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 20:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbaGJSIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 14:08:06 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:62786 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbaGJSIE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 14:08:04 -0400
Received: by mail-wg0-f51.google.com with SMTP id y10so4655233wgg.22
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4EoS7tJW6i17lIdCK26njQTPOxWMMxkHWul60C7jeec=;
        b=Dd1/ebTBz/FVIXmv5lnrKMOvRp0S5z5FkbNVIFUcORuUYCmE9maUhc1GLIQFE27qT7
         OZAlBf4ctEP3Ci/siBdpfzBF+vJl82s6q5bTmZn91IoMvM0ea+5RdPPMcaZ42bRSiBmJ
         Z42OfTal26TUvfLV7JMFrGvLAudTH4xiHVdVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4EoS7tJW6i17lIdCK26njQTPOxWMMxkHWul60C7jeec=;
        b=EKdRGDpnqjCAnKQwIg27pMvLjC2U67iDGTOwRl/N5C6l1nlL/sLaDaoqm1oDjbdg3x
         svbsFqJWe7wrxA1ewjMt1H3Yk7kJdkSeg+jnDMlxE7NQ0Ob/55f/JWCTQd5JNzCXRsrC
         xrDC5NLIW3PhXHdllM3eEDv83WWUTeccPBZGiz7K0Y2HA4tv37FcoLFU+1cHjgtQjnI2
         yxas7S5mwWyxRSwgWuWuje1Q56OndXTs9IFmtDDgCMrZovTI67aGs6C8NTOw7mf7b7MD
         Tbvu2NSCbYp4+RwQYeBC/36zSQUO+6+Rshsz359M8qFAHV5BFNv2O8USISkVRgT8tJ8c
         K+yA==
X-Gm-Message-State: ALoCoQk7g7KtS+0OgYvnocOxKLNuM+fI32XoykIL7f26+5TZi3dUOIBPj8IopRNQO3QTud9c0V0H
X-Received: by 10.180.109.101 with SMTP id hr5mr21575357wib.25.1405015680287;
        Thu, 10 Jul 2014 11:08:00 -0700 (PDT)
Received: from [86.14.230.179] (cpc14-cmbg17-2-0-cust690.5-4.cable.virginm.net. [86.14.230.179])
        by mx.google.com with ESMTPSA id ey16sm34364931wid.14.2014.07.10.11.07.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jul 2014 11:07:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1405013428825-7614774.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253197>

Is this using NFS, or local storage?



On 10/07/14 18:30, Bill Door wrote:
> $ git p4 sync --detect-branches --import-labels //main@all
> ... Lots of useful information elided
> fatal: ambiguous argument 'git-p4-tmp/8031': unknown revision or path not in
> the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> Command failed: ['git', 'diff-tree',
> '6b3ef26a3e2635a5ff0170e15fdadb386672f8b9', 'git-p4-tmp/8031']
>
> If I re-run the command, it works the second time. Of course there are
> 73000+ commits. This is gonna take a while.
>
> I've done some debugging. It appears there is a timing problem between
> git-p4 and git.
>
> The failure occurs in P4Sync.searchParent(). Even though a checkpoint is
> sent to git (for fast-import) just prior to the call to searchParent() in
> importChanges(), the file does not yet exist. I used pdb, paused the program
> just before the call to diff-tree and the file was missing. After the
> program exits due to the error the file exists (i.e. the OS flushed the
> file). This is why re-running continues to work, there is an "old" file with
> basically the same information laying around (dangerous).
>
> How can I get git (fast-import) to flush the file at the right time?
>
> $ git --version
> git version 1.7.12.4
> $ python --version
> Python 2.6.6
> OS: GNU/Linux 2.6.32-431.el6.x86_64
>
>
>
>
> --
> View this message in context: http://git.661346.n2.nabble.com/git-p4-diff-tree-ambiguous-argument-error-tp7614774.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
