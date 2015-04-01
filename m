From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Clone from shallow bundle bug
Date: Wed, 1 Apr 2015 20:09:55 +0700
Message-ID: <CACsJy8C4G01LOhg13=rhkCTMGTq-NTHgG-k-kaoT9jALnd7CZw@mail.gmail.com>
References: <551B0D37.5070407@ubuntu.com> <CACsJy8C0wMFiPw1thSWN-dPVW+9N=JXDsy_HFCj=Oyu2rf40eg@mail.gmail.com>
 <551BEA4A.9050708@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 15:10:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdIPf-0001XS-5z
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 15:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbbDANK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 09:10:27 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35143 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbbDANK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 09:10:26 -0400
Received: by ierf6 with SMTP id f6so42017985ier.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=f0cY0lfVGRtYck8H3+GGHTA/2LLoEhAYRbdjIRZ55OM=;
        b=Uywh7dwscsPvWH68o3j+qHuq9FRQb1JUev8DvdgdmAQrePGLFYVusytjU/f6kI82kh
         v/1d+8X0tsLFSmhcESVNmQicYT4CktYyNhGcv8jZeQXiOVcdsED7fs3CgXw8FP5v09qU
         SS70DLFqCgThUyUeNj8SaYpne53aMtMLBN5vKupaYwjEwUrA8P6GVmMmU9EpBoN6+dPU
         2e0F/cHe9Wzfx5MmlnFsxPO+jG3eTL3aee4fTyHnSPawRtN7sOLUni1YnGRXx7DzeVet
         CKqaroV46LKKlLZjuLbx6V1pguSPyutvRg2vGyw0Ehkhvyeljgb71YQNs41qbhfn5l5p
         yizQ==
X-Received: by 10.50.66.141 with SMTP id f13mr11824820igt.47.1427893825778;
 Wed, 01 Apr 2015 06:10:25 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Wed, 1 Apr 2015 06:09:55 -0700 (PDT)
In-Reply-To: <551BEA4A.9050708@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266606>

On Wed, Apr 1, 2015 at 7:53 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 4/1/2015 5:55 AM, Duy Nguyen wrote:
>> On Wed, Apr 1, 2015 at 4:10 AM, Phillip Susi <psusi@ubuntu.com>
>> wrote:
>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>
>>> I made a shallow clone of my repo, then used git bundle create to
>>> pack it all into a bundle file, then cloned from that bundle.
>>> The initial shallow clone has a .git/shallow file that identifies
>>> it as a shallow clone ( and I guess keeps things from complaining
>>> about the missing history ), but the the repo cloned from the
>>> bundle does not,
>>
>> You made me worry a bit. We have checks in clone and fetch to make
>> sure the result is "good" (i.e. gitk should not complain,
>> clone/fetch should report it instead). Unfortunately I tested and
>> it seemed to work as expected (i.e. clone fails)
>>
>> $ LANG=C ./git clone ./shallow.bundle  shallow2 Cloning into
>> 'shallow2'... Receiving objects: 100% (2813/2813), 5.33 MiB | 0
>> bytes/s, done. Resolving deltas: 100% (250/250), done. Checking
>> connectivity... error: Could not read
>> 50a3ba22454e2989424d5de489de9c0f68fed5ec fatal: Failed to traverse
>> parents of commit c73a8a63134734ddf7077d09355a10a0077ed2ca fatal:
>> remote did not send all necessary objects
>
> Strange; it works fine for me using git 1.9.4.msysgit.1, and then I
> just get the complaints from gitk.  I created the bundle with no
> prereq argument, i.e. "git bundle create shallow.bundle".  Did you use
> a prereq argument?

No, just your command plus a branch name. I tried v1.9.4.msysgit.1
(but on linux, not windows), clone rejected too.
-- 
Duy
