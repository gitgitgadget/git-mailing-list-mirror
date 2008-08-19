From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Tue, 19 Aug 2008 15:53:05 +0100
Message-ID: <e5bfff550808190753t4f99ddb6q83886dbca27dbf03@mail.gmail.com>
References: <20080808211318.GA4396@efreet.light.src>
	 <e5bfff550808170846y522cc6a8w59b696be39df311b@mail.gmail.com>
	 <20080817195839.GB4542@efreet.light.src>
	 <e5bfff550808171330w28dda6a2m32b0e51b1ef73cdc@mail.gmail.com>
	 <20080818180048.GA15520@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Aug 19 16:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVSb7-0001Pg-QI
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 16:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbYHSOxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 10:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbYHSOxJ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 10:53:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:53667 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbYHSOxH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 10:53:07 -0400
Received: by wx-out-0506.google.com with SMTP id h29so2764516wxd.4
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jw7Qo6ErhesuYns0qQnHdfevLzN1E1+e54JcTfZ/Pao=;
        b=fnrAMu/MNqrG4rgbRGvGmK0CfFaACGyrQfWcGSuRk2CQxHv4XMfoGFTliKrzA7PDka
         RL+rAz8cejmG3NlqOaFZhzaiP54BmhlfL7Ah2G1IJ+Qlk3seNKyXag07Asnvip+Ea4bx
         RnELM4HETz0BOHg2CpWT4iNeK9oX/x6o/rZ2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TACtFN+81KccD9oYkvj3dE+CWQNrVqmbutJLkdyr3aGykxk+Y/s2B08Bom9QuOIVTr
         oyJmlCnssRCP5KPQr9zc2fz5/UShrNlLawa9PO9gl5wKc28NEZxq0T1IgqA3rYEuVuGz
         HXJfQnjLUbTeI0E8l/hMCtN0TGkO+DN61n8zI=
Received: by 10.114.36.4 with SMTP id j4mr6649623waj.156.1219157585779;
        Tue, 19 Aug 2008 07:53:05 -0700 (PDT)
Received: by 10.114.174.5 with HTTP; Tue, 19 Aug 2008 07:53:05 -0700 (PDT)
In-Reply-To: <20080818180048.GA15520@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92870>

On Mon, Aug 18, 2008 at 7:00 PM, Jan Hudec <bulb@ucw.cz> wrote:
> On Sun, Aug 17, 2008 at 21:30:46 +0100, Marco Costalba wrote:
>> On Sun, Aug 17, 2008 at 8:58 PM, Jan Hudec <bulb@ucw.cz> wrote:
>> >
>> > But as I said, I only have basic infrastructure and am currently looking at
>> > what to write tests for and how exactly that test should work. The detection
>> > of git vs. stgit branch (does not work for me)
>>
>> This sounds as a bug. Could you elaborate on that please ?
>>
>>
>> BTW the test for a StGit repo is:
>>
>> isStGIT = run("stg branch", &stgCurBranch); // slow command
>>
>> in function Git::getRefs() , file git_startup.cpp
>
> Yes, I've seen that command. But it returns true for me even when it's not
> a stg branch :-(. I am not sure what the problem there is.
>

That's interesting !

The command just runs "stg branch", in my StGit setup this returns an
error (some stuff written to stderr) if the directory where it is run
is not a StGit stack.

run() just detects the error and returns false.

Could you try to run it from a console and see if you have stuff on stderr ?

Thanks
Marco
