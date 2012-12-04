From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v7 p1 07/13] remote-testgit: remove irrelevant test
Date: Tue, 4 Dec 2012 08:03:17 -0600
Message-ID: <CAMP44s3C=Q3VLc=5PS-oBBib6eiew3Ou4-ZBHL91NfuKusCdSw@mail.gmail.com>
References: <1354140669-23533-1-git-send-email-felipe.contreras@gmail.com>
	<1354140669-23533-8-git-send-email-felipe.contreras@gmail.com>
	<20121203231321.GA5098@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 15:03:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tft61-0004vb-0P
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 15:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608Ab2LDODU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2012 09:03:20 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35009 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab2LDODT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 09:03:19 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3900743oag.19
        for <git@vger.kernel.org>; Tue, 04 Dec 2012 06:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iWGaWzduZk1O1h37+ffkDtrzXwXtXK/USLlA3YhSaNY=;
        b=P97slPOikmDM59lNT2ju07mctPtp6lEcvFelENVh4JXsHmA395CBOEUpl0ZDxdLYqk
         22CkUZIX3KS7DmR0ILOmhtzcna3acMmq1XuCaXuMTsTbTLXG4xzEajvlRNdHrBpNJwY6
         mG8XxG8O6O1/fqg874tDRMNjFOk+jmTKERuBzhA3WzfPWVUALdKCuemy5NIa3jXAUvEb
         26NQRygqIgtmE5N1zXetanfWPhlfYlhyW+icxXcjGQSTa/oUjcPwvhcZkyFYxFAxIc1k
         ehxd+Se1BKCcNLPRmgI9wDuhgTjkl0FnUP5ht9y9VisVlKWzqeHkNpRBGo6S+D6hHVxk
         KQtA==
Received: by 10.60.30.70 with SMTP id q6mr11168795oeh.103.1354629798083; Tue,
 04 Dec 2012 06:03:18 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 4 Dec 2012 06:03:17 -0800 (PST)
In-Reply-To: <20121203231321.GA5098@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211082>

On Mon, Dec 3, 2012 at 5:13 PM, Pete Wyckoff <pw@padd.com> wrote:

>> --- a/t/t5801-remote-helpers.sh
>> +++ b/t/t5801-remote-helpers.sh
>> @@ -53,19 +53,6 @@ test_expect_success 'pushing to local repo' '
>>       compare_refs localclone HEAD server HEAD
>>  '
>>
>> -# Generally, skip this test.  It demonstrates a now-fixed race in
>> -# git-remote-testgit, but is too slow to leave in for general use.
>> -: test_expect_success 'racily pushing to local repo' '
>> -     test_when_finished "rm -rf server2 localclone2" &&
>> -     cp -R server server2 &&
>> -     git clone "testgit::${PWD}/server2" localclone2 &&
>> -     (cd localclone2 &&
>> -     echo content >>file &&
>> -     git commit -a -m three &&
>> -     GIT_REMOTE_TESTGIT_SLEEPY=2 git push) &&
>> -     compare_refs localclone2 HEAD server2 HEAD
>> -'
>> -
>
> Why does this cause problems?

It doesn't.

> If you're going to rip it out, please finish the job, and take
> out the other two hunks that are needed to trigger this test.  See
> 7fb8e16 (git-remote-testgit: fix race when spawning fast-import,
> 2012-04-22).

That commit has absolutely nothing to do with the new remote-testgit,
the old remote-testgit is called now remote-testpy, and its test has
this chunk still there.

For the new remote-testgit this is irrelevant.

-- 
Felipe Contreras
