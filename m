From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: diffstat witdth with one changed file
Date: Tue, 22 May 2012 19:50:59 +0700
Message-ID: <CACsJy8D1eMhyPm8b5D6vSuMDvebfX1hB2GUz82E8LeVhnWsqCQ@mail.gmail.com>
References: <CACsJy8BrqaLbtVp5uF3q2Jo63DPwtFACYw3_rPy8eyNK7VSWMw@mail.gmail.com>
 <4FBB2B4B.6030402@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue May 22 14:51:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWoYr-0003Zw-Gz
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 14:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758587Ab2EVMvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 08:51:32 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:58584 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757820Ab2EVMvb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 08:51:31 -0400
Received: by weyu7 with SMTP id u7so3859573wey.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Y08RnY2FVlhi2E9LYHbJDxDG2/5s5GdEkdHNAnQRB78=;
        b=GloLJor4/nGqrB9IwBxXFsU4YXi8gid1hbmgcLEEfcD8zJlheOmOs+LyCVuSQhYOdM
         cKgSFSRiXZTk6j3mMbDzffTSnoIoLHZrkMjwkoB0aLkJ9rdcwixozg0qFc+P+JAr2wHs
         s2YR98BjkXoG97DvCA5R8PSf/npdDEl97w2X2yBy5u27zpJNy3tr+SXxYg9lQSjoYChc
         XgHNIBXLj0SwfV1/wKcvzptTmI0NEVuZ6WtDBsGKLvkAXW7K1v4yTZivUrk9Age9dTI0
         l8QWt1hrqUxqSnpBMjQjVUvyPkKZ2Uv9aqaiD+6JaoPuEo4sn+mwn23zdTQ0VyefDMmV
         +36g==
Received: by 10.180.97.3 with SMTP id dw3mr34692339wib.19.1337691090113; Tue,
 22 May 2012 05:51:30 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Tue, 22 May 2012 05:50:59 -0700 (PDT)
In-Reply-To: <4FBB2B4B.6030402@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198196>

On Tue, May 22, 2012 at 12:59 PM, Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
> On 05/21/2012 05:52 PM, Nguyen Thai Ngoc Duy wrote:
>> Hi,
>>
>> With recent git, "git log --stat 90e6ef5", the first commit's diffst=
at
>> uses full terminal width while the next one uses less than 80 chars.
>> Both changes one file. Is it intentional? I tend to think it's a bug
>> because with one-file changes, diffstat width is not important as we
>> have no other files to compare with.
> Hi,
> 90e6ef5 makes 502 additions/deletions, so it scales the +- part to th=
e
> whole available terminal width. 90e6ef5^ does only 41 additions, so i=
t
> can display the +- part unscaled without even filling the terminal wi=
dth.
>
> Since we don't coordinate the diffstat width between different commit=
s
> in the same git-log invocation, there's no way to make the diffstats =
use
> the same scale. Anyway, diffstat is only supposed to give a rough
> overview, and it does that here.

Yeah, others have explained it. And it makes sense.

> What output would you expect?

It just looks weird that while most of the commits fill half of my
screen (200 char width), some diffstats strike a line through the
right edge. And I did not see the reason for that in the beginning
because I thought long lines only makes sense when compare to other
lines.
--=20
Duy
