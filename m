From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] git-p4: map a P4 user to Git author name and email address
Date: Wed, 2 Mar 2016 10:25:25 +0100
Message-ID: <61210CAD-D3D2-40AC-88F9-02169619F5F6@gmail.com>
References: <1456829396-38659-1-git-send-email-larsxschneider@gmail.com> <CAPig+cRwEKjGaDA-jy8KJSAhTheJYDmxtPq8SdVs0LA2f9-9Yw@mail.gmail.com> <CAE5ih7_EAjMtdNQ6ab2wrN4LMSBBZ=T7w-fPKLtdRqfvFUhzFQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 10:25:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab32M-0008KO-8j
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 10:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbcCBJZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 04:25:32 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33079 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbcCBJZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Mar 2016 04:25:29 -0500
Received: by mail-wm0-f41.google.com with SMTP id l68so71061759wml.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 01:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z8SdhBQlfC5xkoGqBAsTwpDVNFRCK8u28UsT6VS0+vM=;
        b=NsCB9GZvGIMmHN1QxOBNxSFAxE6sZgGnT2E+mcApHbhv93qg8x3tIplsP7nti7Pgb7
         26Nn2ancXVHS2mYlmD9QblRf81c7bu7JTfkQ/xm8HbYTv9xB2eNr7B5NwAizbn6mRrgg
         U+jO5/L5iKGLfYRo755pGRT+pYJVX5xBIDnUBh9j8uyBlYte7ucXIGE25JyfWx86UNZ/
         goLY+iyzoKyJg0u8RHtiC8uci40ONp50TxiZGnm9Ki5SqQfg4LUNBk4mFr3R9CZDbuc+
         oCwg3AO7lsj9taZwNK2WLESRFRxU8D8Ogy6nxPdgW6asYuu5PNhNMWqWt/Y7TRlxNaWL
         aTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Z8SdhBQlfC5xkoGqBAsTwpDVNFRCK8u28UsT6VS0+vM=;
        b=XCFrjPqoIji5HedBPNnojgnpP0kIponY0uGUnybBJbDJUnchBUZg29Gt5omfELJWqr
         vcgKEHUErB1S96GZmfJi7nfvCBDaMP3L/WupTi3ld41FfErwyeeNZyE09Zn5AQaeIvtE
         PUnJM/dnGpBweUr6E5n7yLU1f6Kyh1K+CUVaxMDtFzd9U0INqhMElJLbwBsrryDzyNhZ
         F0yIGVWRbs6SkJS9qLWMqIgDjr0QhFcLVJzvkVeOvQZQ/x/cZMqr2MIU9yLf4Q6pxxg8
         L0gt8VNkdYa4E3M0UA/yLZDSEbRXmyxQDaWt8sIGT5lVbAd+s3z1fBVDXfFKwnFCMFAW
         GuCg==
X-Gm-Message-State: AD7BkJJr5Lfmkp2KrxPt+FmTvyJ7gO8gvrb9plcCTf6qO9vz5zjTUd8uw+mKbq1Q5nufjA==
X-Received: by 10.194.87.161 with SMTP id az1mr24670231wjb.163.1456910728509;
        Wed, 02 Mar 2016 01:25:28 -0800 (PST)
Received: from [10.32.249.45] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id u136sm3149630wmu.20.2016.03.02.01.25.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Mar 2016 01:25:27 -0800 (PST)
In-Reply-To: <CAE5ih7_EAjMtdNQ6ab2wrN4LMSBBZ=T7w-fPKLtdRqfvFUhzFQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288117>


> On 02 Mar 2016, at 06:06, Luke Diamand <luke@diamand.org> wrote:
> 
> On 1 March 2016 at 19:15, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Mar 1, 2016 at 5:49 AM,  <larsxschneider@gmail.com> wrote:
>>> Map a P4 user to a specific name and email address in Git with the
>>> "git-p4.mapUser" config. The config value must be a string adhering
>>> to the format "p4user = First Lastname <email@address.com>".
>>> 
>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>> ---
>>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>>> +git-p4.mapUser::
>>> +       Map a P4 user to a name and email address in Git. Use a string
>>> +       with the following format to create a mapping:
>>> ++
>>> +-------------
>>> +git config --add git-p4.mapUser "p4user = First Last <mail@address.com>"
>>> +-------------
>>> ++
>>> +A mapping will override any user information from P4. Mappings for
>>> +multiple P4 user can be defined.
>> 
>> Sorry for not paying closer attention the first time, but this needs
>> to be repeated for each P4 user you want to map, right? One can
>> imagine this quickly becoming painful if you have a lot of users to
>> map. Have you considered modeling this after git-svn where you can set
>> an "authors" file (and name the corresponding option --authors-file)?
> 
> For most authors it should just use the existing Perforce user
> information. This is (I assume) just for the occasional exception
> where Perforce has the wrong email address.
I agree this is an occasional exception. I use it for users that have been deleted on the Perforce server.

@Eric: If a user wants to they could create a custom gitconfig and then use the config "include" mechanism to achieve a "authors" file kind of approach.

Cheers,
Lars