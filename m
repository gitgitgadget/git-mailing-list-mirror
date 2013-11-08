From: Thomas Manson <dev.mansonthomas@gmail.com>
Subject: Re: Selectively commit/publish files to GIT
Date: Fri, 8 Nov 2013 23:51:55 +0100
Message-ID: <CA+PenvG7CnkvN-XZE-uYBh42Yyqq23G5fOFRNhCU83m3V5f8sQ@mail.gmail.com>
References: <CA+PenvEDY6mc+DyjXy4ebZKdK4R=ucM28MDXGC42XKxvJ=a-pQ@mail.gmail.com>
 <20131108141329.GA26790@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?TWFnbnVzIELDpGNr?= <baeck@google.com>
X-From: git-owner@vger.kernel.org Fri Nov 08 23:52:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Veuub-0002Hc-Mz
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 23:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758221Ab3KHWwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Nov 2013 17:52:18 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35200 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757570Ab3KHWwR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Nov 2013 17:52:17 -0500
Received: by mail-wg0-f48.google.com with SMTP id b13so2576099wgh.15
        for <git@vger.kernel.org>; Fri, 08 Nov 2013 14:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=r3692/Wc4B7IuSi05NUo6n3GeIAV1uQv2BLDSA4uwmE=;
        b=JwzS2NNp94de+XIjO2QAbvf+g9bUxBTgdTF+RsCSq4gwNqoXKUFv2FXac8LvpwWO4N
         m4cVg40TV9WYWYEKR5EYKIqRG6U6yPrcGTInORp62ij+Jg+7vkEColAW9HceeU2XYNr4
         TGy+GCZ3iy2YOBVbGI4bpzFSWxwfMEo20wh1MlFspB4hCw3nDZqiLQxZnP53JpgnJMXX
         ZR7lgnLzqDzHJ/ix/AMzgz8LGZegjj6xwkPNPJibptpkk78q8zEcluvtNZMBlSsFINFi
         mkLtwLHIjpqOaForLDHKv07FSXYOba0IYfCKHc3VZHtPbZMwse3lmDQPBN7Zvz9eVbPV
         4ZBg==
X-Received: by 10.180.84.101 with SMTP id x5mr4096636wiy.58.1383951135881;
 Fri, 08 Nov 2013 14:52:15 -0800 (PST)
Received: by 10.180.21.162 with HTTP; Fri, 8 Nov 2013 14:51:55 -0800 (PST)
In-Reply-To: <20131108141329.GA26790@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237471>

Hi Magnus,

 thanks for pointing that out. I must have overlooked the webpage,
when I saw that I thought it was some kind of alias that designated
files greater than a specific files (server side configurated as the
100MB limit)

  I'll try again ;)

Thomas.

On Fri, Nov 8, 2013 at 3:13 PM, Magnus B=C3=A4ck <baeck@google.com> wro=
te:
> On Friday, November 08, 2013 at 05:52 EST,
>      Thomas Manson <dev.mansonthomas@gmail.com> wrote:
>
> [...]
>
>>   How can I search git history for big files and remove them, or mar=
k
>> them to be not published ?
>>
>> I've tryed this solution found on the link in the error:
>>
>> git filter-branch --force --index-filter   'git rm --cached
>> --ignore-unmatch giant_file'   --prune-empty --tag-name-filter cat -=
-
>> --all
>> git commit --amend -CHEAD
>
> [...]
>
>> here is the error I have using the GitHub application on Mac :
>> (after that I intend to use Eclipse)
>>
>> File Ressources/dwr/dwr-3.0.0.110.dev-src.zip is 67.69 MB; this is
>> larger than GitHub's recommended maximum file size of 50 MB
>> GH001: Large files detected.
>> Trace: 8f0259b29260f0c4d7ae4d4ae70e0306
>> See http://git.io/iEPt8g for more information.
>> File .bzr/repository/packs/a7bcd6ba235114ab88c80fe8a97adcfa.pack is
>> 178.76 MB; this exceeds GitHub's file size limit of 100 MB
>
> Did you actually replace the 'giant_file' placeholder with the path t=
o
> *your* giant file? The error message indicates that you didn't, or th=
at
> something else went wrong during the filtering.
>
> You can use 'git log' to look for commits touching particular pathnam=
es,
> making it easy to verify that a file has been eradicated.
>
> git log --all -- path/to/big-honking-file.zip
>
> --
> Magnus B=C3=A4ck
> baeck@google.com
