From: "James Youngman" <jay@gnu.org>
Subject: Re: Clarifying "invalid tag signature file" error message from git filter-branch (and others)
Date: Thu, 11 Dec 2008 22:34:53 +0000
Message-ID: <c5df85930812111434m879f1faq80c64286714c3a1f@mail.gmail.com>
References: <c5df85930812110214k2e12d926m60856fb630d45e80@mail.gmail.com>
	 <P7E-5meNX4tXFurN9mnRguFHdJG1jaZYTn6WxFFpECSJ68KyYT3wqQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Dec 11 23:36:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAu8j-0006Zu-P1
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 23:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757139AbYLKWe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 17:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757133AbYLKWe4
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 17:34:56 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:29821 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757113AbYLKWez (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 17:34:55 -0500
Received: by yx-out-2324.google.com with SMTP id 8so581898yxm.1
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 14:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=islA9fWZc2/cbRnX8R6eopvTKBG2dCWbgJHA17HP5EM=;
        b=YyXNv7bO8FKMP9vfnWy6OXyCw451uGSsVUf9dGUKpjOOy8ryOI4XtPRfMEN3KZ25Ad
         abMOlAPNYIkfBSPM5NFKaDsW77A/y8nqBJhUw+v1hoefmxmlFYuPCbTen83cEGfams0X
         1t5wMcHD2mXoxxWdngk2ipRTaTicFcTpmgrp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=k8c4ObGbB4+Ga8paTmJHtcK1B3xmXNlLaztouhb2ICGdUWapcCYTf3Ztk9UCaK0D7W
         ouTn1WCWA1ZGueEBNyibkmLYKOSJMuyv2auzl/h4A7JRHGJg0W8aV+xnrGws4LilL2pB
         SVsmkjCC5d0FzzOuus+UdTBO4G/OOqPr4ecpM=
Received: by 10.142.207.8 with SMTP id e8mr1020326wfg.30.1229034893604;
        Thu, 11 Dec 2008 14:34:53 -0800 (PST)
Received: by 10.143.168.8 with HTTP; Thu, 11 Dec 2008 14:34:53 -0800 (PST)
In-Reply-To: <P7E-5meNX4tXFurN9mnRguFHdJG1jaZYTn6WxFFpECSJ68KyYT3wqQ@cipher.nrlssc.navy.mil>
Content-Disposition: inline
X-Google-Sender-Auth: cc4b5753f158eacc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102833>

On Thu, Dec 11, 2008 at 9:06 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> James Youngman wrote:
>> What do the errors "error: char88: malformed tagger field" and "fatal:
>> invalid tag signature file" and "Could not create new tag object for
>> FINDUTILS-4_1-10" signify in the session below?
>
> It means the tagger field in the tag does not follow the correct form.
> Specifically the testing in git-mktag (called by filter-branch) does:
>
>         * Check for correct form for name and email
>         * i.e. " <" followed by "> " on _this_ line
>         * No angle brackets within the name or email address fields.
>         * No spaces within the email address field.
>
> What does 'git cat-file tag FINDUTILS-4_1-10' show you?

Before conversion:
$ git cat-file tag FINDUTILS-4_1-10
object ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
type commit
tag FINDUTILS-4_1-10
tagger Kevin Dalley

The conversion:

After conversion:
$ git cat-file tag FINDUTILS-4_1-10
object ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
type commit
tag FINDUTILS-4_1-10
tagger Kevin Dalley

This is in the repo at
http://git.savannah.gnu.org/gitweb/?p=findutils.git;a=commit;h=ce25eb352de8dc53a9a7805ba9efc1c9215d28c2

>> Are any of those errors correctable (I can re-run the tree rewrite
>> script as many times as needed, I'm just using it on a test repository
>> for now).
>
> If there are only a few, then you can manually retag with a corrected
> tagger field, and then run your script.
>
> Of course, depending on the output of the cat-file call above, the
> testing in git-mktag may need to be relaxed.
>
> -brandon
>
