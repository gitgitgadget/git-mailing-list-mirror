From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 02/21] Add parse_pathspec() that converts cmdline args to
 struct pathspec
Date: Fri, 11 Jan 2013 09:33:48 +0700
Message-ID: <CACsJy8DOPZD_zd1cTtrCcvVUU6d7LA7_UNJse4xTcDp4ttP9jQ@mail.gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
 <1357453268-12543-3-git-send-email-pclouds@gmail.com> <CANiSa6iUqZ7E9NWgMfR3bUxZoyhjO2Jz+Z=yjs9vkfmbit7SOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 03:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtUS8-0000II-H5
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 03:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398Ab3AKCeU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 21:34:20 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:58354 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab3AKCeU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2013 21:34:20 -0500
Received: by mail-oa0-f41.google.com with SMTP id k14so1336269oag.28
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 18:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HsHpdy5X/6OINTVki0sYehpw0NR3r3LLxapolTLy3Js=;
        b=A5xtnLrV5bMewPQFrGK/8YYPMh9Rov3sm9NjvqdewuyDJ/b5xNdcmp5h4lf94ywJmp
         GyIyiBaNMZ/R3L9AdsV5br5wcV2k9KmbPUkq8Jpjt+JSWzBW1fIIGcJEUAclaTJZ+4xx
         6o0joAdXqeg7UNiludEy3aCfDIiySddsbmNqX95V7H7aLVGtWd2GGbsytfPkdHPhkt6n
         t5W7rGSzxheuM8ULxXSc72PNuHOX3PO8AGpILNPO+S/JD+VPzupylE+VByJCZb8miJij
         FaYG3Azq8Xbho1u3Ogpvs+GAaDM/Q18BP0k3Pu8np+yzEy6hCbVSRaQiUtE2iRdkerrq
         HN6g==
Received: by 10.60.8.131 with SMTP id r3mr42730661oea.14.1357871659705; Thu,
 10 Jan 2013 18:34:19 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Thu, 10 Jan 2013 18:33:48 -0800 (PST)
In-Reply-To: <CANiSa6iUqZ7E9NWgMfR3bUxZoyhjO2Jz+Z=yjs9vkfmbit7SOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213165>

On Fri, Jan 11, 2013 at 6:26 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> On Sat, Jan 5, 2013 at 10:20 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> +
>> +       /* No arguments, no prefix -> no pathspec */
>> +       if (!entry && !prefix)
>> +               return;
>>
>> +       /* No arguments with prefix -> prefix pathspec */
>
> When working with the old get_pathspec(), I remember wondering if a
> flag switching between "no argument -> prefix pathspec" and "no
> argument -> no pathspec" would be worthwhile. I think e.g. 'add' and
> 'clean' would use the former , while 'reset' and 'commit' would use
> the latter. Since you're now changing all the callers of
> get_pathspec(), it seems like the perfect time to ask this question.
> What do you think?

Yes that'll simplify the call sites. Will do.
--=20
Duy
