From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: git and peer review
Date: Sat, 3 May 2008 14:54:12 +0100
Message-ID: <18071eea0805030654j42c21212wd1ccf4df42662000@mail.gmail.com>
References: <46dff0320805021802i1a29becflcae901315035a77d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 15:55:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsICw-0005Uk-FO
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 15:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285AbYECNyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 09:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755286AbYECNyQ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 09:54:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:63907 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755238AbYECNyO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 09:54:14 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1317512fgg.17
        for <git@vger.kernel.org>; Sat, 03 May 2008 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GzCE23+4EYvvfO6PfOVmOgkku5AUw+Z+u34cYGP7syY=;
        b=U2B3XapHWfTI6vUQTQqG5nU13EGmF2VDxnmSr7z8gnhMyhsWG+ZcWNCRIjKdhuKgOl6eME+RvdaE6FVQPqciinpjKGEitChvfRn9T5I5uKuft1Cdv3JpVeCnueoyXxNQRhm6wgrUeMojD/1sfOUDZQMb7bFOGl4idworZHdscE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N2qEaA8C7FEmOLIlGXIqu2WDpu/ixgRR8JtAzwkSwr3Hb8B+xGqNS5Cq63s6IJklEW7I1TrqVVU8fgD0M1+UX0mhmRkYoi9spGBnmS/YddAbCMNfCjDW0iISKRzIT14xHgG0KZRWLaL+HCeYq26oXB2E9W5oBh9Bn9i9gFI22Xg=
Received: by 10.82.116.15 with SMTP id o15mr18595buc.75.1209822852693;
        Sat, 03 May 2008 06:54:12 -0700 (PDT)
Received: by 10.82.170.5 with HTTP; Sat, 3 May 2008 06:54:12 -0700 (PDT)
In-Reply-To: <46dff0320805021802i1a29becflcae901315035a77d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81082>

On 03/05/2008, Ping Yin <pkufranky@gmail.com> wrote:
>  I am in a company environment and i want to enforce a policy that
>  every commit must be reviewed before pushed to central repository. I
>  think i can use hooks to enforce such kind of policy.

This sounds likely, yes.

>  One way i want to try is to check in the hook whether every pushed
>  commit has a "Reviewed-by " line .  Any suggestion?

Assuming this is enforced either through a template (see:
commit.template in git-config(1)), or as part of being added by the
committer, then in GIT 1.5.4 onwards there's a commit-msg hook which
will do this for you.  Something like:

test "" = "$(grep '^Reviewed-by: ')" || {
    echo >&2 "Message must have a Reviewed-by line present."
    exit
}

>  And one question, how to add a "Reviewed-by" line automatically?

There's an example of that by way of a SOB in the commit-msg hook.

-- Thomas Adam
