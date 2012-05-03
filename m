From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Thu, 3 May 2012 22:36:07 +0200
Message-ID: <CALgYhfOLGFK92833nZp5ny25+uoRnsygkH2M4yYRzU4JBE3Evw@mail.gmail.com>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
	<87ehr15dnh.fsf@an-dro.info.enstb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ronan Keryell <Ronan.Keryell@hpc-project.com>
X-From: git-owner@vger.kernel.org Thu May 03 22:36:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ2l5-00043a-GS
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 22:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623Ab2ECUgK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 16:36:10 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53697 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753205Ab2ECUgI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 May 2012 16:36:08 -0400
Received: by lahj13 with SMTP id j13so1550648lah.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Uj+M2fdaFS5abwcOCxPmUkE37Hpr9IVIaNAkztP1H9w=;
        b=lXGB562E0Pw85oDLVH98Cnjf8NPSEFFIV9MO5azXnr6BkjICKfBxhkHzcLUQSGyBUp
         AiHYkR5r8ngzTIXmy6lQDU6ECASz1UAfqfmooqnjWi4FDPdK6cdyiqtR0ORP/em34GHN
         OlxO4ssmaCJC/j8D2xR6EQTJvGo3tAkQ80ea5VEKKGVekOxFcsHqN+dEF84HxjVx8ipU
         vy08wDfCU4SezdAR2OAckD/iZj9Oex8sRQoM9bKcL6eadIe0VZPSbcHTg0ZIAoZwoc8w
         6oqyLnZY7SHrGHKczTApIFFhIJQ1kKha1u/j7yPtV10BU0A4CkSKpO8lfRBP9k/VmBWj
         CLlw==
Received: by 10.112.48.6 with SMTP id h6mr1651337lbn.94.1336077367479; Thu, 03
 May 2012 13:36:07 -0700 (PDT)
Received: by 10.152.37.201 with HTTP; Thu, 3 May 2012 13:36:07 -0700 (PDT)
In-Reply-To: <87ehr15dnh.fsf@an-dro.info.enstb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196956>

On Thu, May 3, 2012 at 8:21 PM, Ronan Keryell
<Ronan.Keryell@hpc-project.com> wrote:
>>>>>> On Thu, 3 May 2012 19:25:12 +0200, Thomas Gummerer <t.gummerer@g=
mail.com> said:
>
> =A0 =A0Thomas> I have been drafting the Version 5 of the index format=
 over
> =A0 =A0Thomas> the past few days with the help of Thomas Rast, Michae=
l
> =A0 =A0Thomas> Haggerty, cmn and barrbrain on IRC. It will save with =
prefix
> =A0 =A0Thomas> compression on the path, and using a crc32 over the st=
at
> =A0 =A0Thomas> data, instead of the full data, since it is only used =
for
> =A0 =A0Thomas> checking if the file is changed. (Thanks Michael Hagge=
rty
> =A0 =A0Thomas> for this hint. Unless we are missing something this wi=
ll
> =A0 =A0Thomas> save another ~4 MB on the Webkit index.
>
> Great!
>
> But I wonder whether it may not worth to investigate a 64-bit version=
 for
> the offsets and so on, just in case...

64-bit versions of the offsets were taken into consideration, but curre=
ntly
the Webkit index (the largest I know) has a size of 26 Mb, which is
reduced to about 15 MB or less with the v5 format. With 32-bit we can
address 4GB, which is about 266 times the Webkit index. Therefore there
probably is no use for 64-bit offsets in the years to come.
