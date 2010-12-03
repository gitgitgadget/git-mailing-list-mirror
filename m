From: Eugene Sajine <euguess@gmail.com>
Subject: Re: cannot find hash in the log output
Date: Fri, 3 Dec 2010 15:53:20 -0500
Message-ID: <AANLkTin94XN8_+q8a1EdfY3ySqJpx_j9megQYsq8a8ux@mail.gmail.com>
References: <AANLkTi=5b26aPLm_Byqg=c9=sPpg5jEPDDpf1J9WgOdY@mail.gmail.com>
	<7v8w07rje3.fsf@alter.siamese.dyndns.org>
	<AANLkTimExbMn4-E-zuAGmi+p1wNAHoetpeyr2SK6vGxk@mail.gmail.com>
	<AANLkTinAUfFge-AcfQevG2_9Gi3oOPy+-SrEZrfp4byn@mail.gmail.com>
	<20101203175212.GA8267@sigill.intra.peff.net>
	<AANLkTim59JP-fuVTeLwxV0bktbdCq04P8XzxVmbu2Qjd@mail.gmail.com>
	<20101203202923.GB15517@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 21:53:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcdT-0007e6-2K
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 21:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab0LCUxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 15:53:22 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61934 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0LCUxW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 15:53:22 -0500
Received: by bwz15 with SMTP id 15so8734713bwz.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 12:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=cw3mmnDxMeDYDveTfz8xK5gTQBwueJ4qPTGcXPhF6R8=;
        b=nqt8zfBiGUmbFondF/rvp2qbtz3zsfqzZjAX1X2eUB5gmVv6A6DBbseyOJbBTesOC2
         Ga/dKuwQawgLPiUVBpXPwRA1OQHGcAUoJOPx4stmWrxzeIbJgzRlD+oSIgC6/JtDWnVO
         3Gi4e4C+wFqQK40sXG+UbO9QAz3CYchpWaSSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Y7na5M97ocBiSQKxvW6OiAt0XvMCfIw7vghZzL9X3hyRma5zxEhutzTtXsTmFDJfuq
         1gfjIjjBo/bgjAUqyJ0EVx2w5Ep5rd9quT+PRq1hYphy7hbXrN+5mIz2NBHMYUS1Hral
         oOqWXYrlHbwmZrF3F9M9kjpM00Ias5LEgkwAU=
Received: by 10.204.64.139 with SMTP id e11mr3128205bki.212.1291409600716;
 Fri, 03 Dec 2010 12:53:20 -0800 (PST)
Received: by 10.204.80.131 with HTTP; Fri, 3 Dec 2010 12:53:20 -0800 (PST)
In-Reply-To: <20101203202923.GB15517@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162849>

On Fri, Dec 3, 2010 at 3:29 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eugene Sajine wrote:
>
>> Now as this is pretty much clear: don't you think that the information
>> about one blob content changed during the merge should be present in
>> the merge commit info?
>
> "git rev-list <revs> | git diff-tree --root -c --stdin" might give
> some joy.
>

Allright, this is much closer now;) I used

git rev-list HEAD | git diff-tree --root -c --stdin | grep <SHA1 of
blob interest>

(I need to read now about diff-tree)
That gives me the output like this:

::SourceMode1 SourceMode2 resultMode Source1-SHA1 Source2-SHA1
resultingSHA1 MM path/to/file


Now two questions:

1. a) Why this exact output is not provided in "git log --raw" or in
"git whatchanged" for the merge commits? b) Can it be provided?
2. If 1b=no Is this the ultimate final solution to check if the blob
has appeared somewhere in the history?


Thanks!
Eugene
