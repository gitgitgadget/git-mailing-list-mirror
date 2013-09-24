From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 00:49:21 -0500
Message-ID: <CAMP44s1-AXKRz4pqQsyCMLZgnxmxTaoeBGt8aNDFM0ttDTmBRQ@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<20130924045325.GD2766@sigill.intra.peff.net>
	<CAMP44s1tirA5w91L2YomaduZVkqL3=n1j79eoueB6XeGuyY3Mw@mail.gmail.com>
	<20130924053712.GA6114@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:49:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOLV1-0004AZ-LW
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793Ab3IXFtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:49:23 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:42986 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab3IXFtX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:49:23 -0400
Received: by mail-lb0-f172.google.com with SMTP id x18so3417558lbi.17
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 22:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jAtafSfja9TINQ+aZs1fVMIks+StDUH01gtcexGKfcs=;
        b=UnGH126vn9Zq6JsZXHJ+L49P5OK8x7rp/aO7TRciR9gS4KQ79G02ni964H3TdyX4/1
         HNKpCuIdQamqTrH0vpFcOOzDgkzH1YzXcy67v5CeIHvndQny+V1TXibp1Qj0lWolSv21
         bSDAwsPJig4bUiPIKHU1kgJv+mMFcv2KemgFGJxjGrcVH27hkY7b0n1h3BppUsenc5n2
         THxxYaIZmeJ9Xj3S36A/EmExuhg+DvEuzWLn8FHL9e+z/3XWykImdgH9DSDXLl5n/jzw
         dKjIjWKdJEvRoEJQA/IOn7HdV1fVzwYwQZIskrkyljQ8biMF0Iyei9GFlBQgCQ+wzrr0
         KNZA==
X-Received: by 10.112.29.147 with SMTP id k19mr23111150lbh.9.1380001761756;
 Mon, 23 Sep 2013 22:49:21 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 23 Sep 2013 22:49:21 -0700 (PDT)
In-Reply-To: <20130924053712.GA6114@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235269>

On Tue, Sep 24, 2013 at 12:37 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 24, 2013 at 12:32:46AM -0500, Felipe Contreras wrote:
>
>> > You are making things more consistent for people who already define
>> > those aliases in the same way (they are available everywhere, even if
>> > they have not moved their config to a new installation), but less so for
>> > people who define them differently. Rather than get an obvious:
>> >
>> >   git: 'co' is not a git command. See 'git --help'.
>> >
>> > the result will be subtly different (especially so in the case of
>> > "commit" versus "commit -a").
>>
>> Before:
>>
>> # machine A: git ci
>> git: 'ca' is not a git command. See 'git --help'.
>>
>> # machine B: git ci
>> commits
>>
>> After:
>>
>> # machine A: git ci
>> no changes added to commit (use "git add" and/or "git commit -a")
>>
>> # machine B: git ci
>> commits
>
> That is the output if there are no files to commit. What about while
> resolving a merge, or after using "git add" on a path? In that case we
> create a commit, but it is subtly different than what the user intended.

It might be different, but it might not.

Anyway, if you are so worried about this hypothetical user not
noticing that 'git ci' didn't commit all the files, we could ma ci to
'git commit -v' so we are being straightforward to the user as to what
is being committed.

-- 
Felipe Contreras
