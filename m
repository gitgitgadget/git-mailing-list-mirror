From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Recovering Committed Changes in a Detached Head?
Date: Sun, 9 Oct 2011 16:52:11 +1100
Message-ID: <CACsJy8CsMCju7joj2B2xbBSTF1vHjyuFeSZyPhTJisO2sU-Fqg@mail.gmail.com>
References: <1318107488.5865.46.camel@R0b0ty> <20111008213741.GA24409@goldbirke>
 <ab706826-75df-4410-941e-6b40ec92713c@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Daly Gutierrez <daly.gutierrez@gmail.com>, git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Sun Oct 09 07:52:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCmJb-0005s2-T6
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 07:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008Ab1JIFwn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Oct 2011 01:52:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42588 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab1JIFwm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Oct 2011 01:52:42 -0400
Received: by bkbzt4 with SMTP id zt4so6848377bkb.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 22:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yKBre9RQA/9SfMN/PBYkPrV6K7f/Qq+uknL7qwL3nyc=;
        b=lQn1E+4alsIeFoLrr1GDUcsR8AxRaN7Isc49YLxqM5/inoL1z6pgYsU9CzTufsI448
         26Csqxr4BWFFK2tAUUMtfS7f4ndeoccJtOydkeo8U4HJJ85jolmqDsNN/dMWWvRL7Dz+
         4gVEoC0jX1/gLYHOogB20IPaT7e7Lfzy7bjW8=
Received: by 10.204.128.78 with SMTP id j14mr2572279bks.42.1318139561161; Sat,
 08 Oct 2011 22:52:41 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Sat, 8 Oct 2011 22:52:11 -0700 (PDT)
In-Reply-To: <ab706826-75df-4410-941e-6b40ec92713c@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183186>

On Sun, Oct 9, 2011 at 9:00 AM, Martin Fick <mfick@codeaurora.org> wrot=
e:
>>git reflog to the rescue. =C2=A0For your example above it will output
>>something like this:
>>
>>deadbeef HEAD@{0}: checkout: moving from
>>92aa5381b9f7229523dba42aa94735c30f173451 to New_Branch
>> =C2=A092aa5381 HEAD@{1}: commit: Committing this in the Detached Hea=
d
>>3a5bb38a HEAD@{2}: checkout: moving from master to
>>3a5bb38a83c00f7acab573f0ec836577143200aa
>> =C2=A0deafbabe HEAD@{3}: ...
>> =C2=A0...
>>
>>There you see the first line of the commit message from your "lost"
>>commit, and you can do
>>
>> =C2=A0git checkout -b lost_detached_head 92aa5381
>>
>>and you get a branch pointing to that commit you made while on
>>detached head, and you can work with it as usual.
>
> While rflog is cool, I can't help but think that git could be even mo=
re helpful for these scenarios.
>
> First, maybe git could create refs for these automatically, perhaps w=
ith a name like orphans/1? =C2=A0Maybe these refs would only be visible=
 via git branch --orphans.

If I remember correctly, we don't have private ref namespace, any refs
created automatically this way could be pushed out by accident.
--=20
Duy
