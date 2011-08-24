From: =?UTF-8?B?QWRhbSBLxYJvYnVrb3dza2k=?= <adamklobukowski@gmail.com>
Subject: Re: Problem with S_IFGITLINK
Date: Wed, 24 Aug 2011 17:30:12 +0200
Message-ID: <4E551904.303@gmail.com>
References: <4E54F364.7000503@gmail.com> <4E550E03.3080104@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 17:30:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwFPK-00036G-Dj
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 17:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103Ab1HXPaR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Aug 2011 11:30:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59887 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab1HXPaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 11:30:16 -0400
Received: by fxh19 with SMTP id 19so1055459fxh.19
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 08:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GLgyb4BNOoxKO1bK2CfUMmd6v3ZnPkHz5oD9+JAX0Us=;
        b=YkSPi7kONXrafc4/uXoipwJbHtdbSOF0G8F1yyKXlY7vCy03zJyZ60rz9oewDOGOmN
         rNrApInk5gbNc3+pgfKej6yYOHYePZ/LIsnCTenC2Quoi+CqcZrdBjG9brd122aDSRG9
         OMXq2YTBZryKbTWSjabV6saXB936/xku9m5tE=
Received: by 10.223.52.66 with SMTP id h2mr7478118fag.92.1314199815073;
        Wed, 24 Aug 2011 08:30:15 -0700 (PDT)
Received: from [192.168.0.102] (89-72-179-1.dynamic.chello.pl [89.72.179.1])
        by mx.google.com with ESMTPS id 14sm924243faf.8.2011.08.24.08.30.13
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Aug 2011 08:30:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
In-Reply-To: <4E550E03.3080104@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180009>

W dniu 24.08.2011 16:43, Michael J Gruber pisze:
> Adam K=C5=82obukowski venit, vidit, dixit 24.08.2011 14:49:
>> Hello
>>
>> I'm trying to compile git on some very exotic u*ix flavor (FreeMiNT
>> anyone? :)) and I encountered problem with S_IFGITLINK.
>>
>> Unfortunately, on my system S_IFGITLINK =3D S_IFLNK, and it breaks b=
uild
>> in entry.c write_entry.
>>
>> Should I report a bug? (where?, I could not find any reference to
>> bugtracker on git pages)
>
> Yes. Here.
>
> A short log of the build break would be nice.
>
>> Can I fix it somehow? Can I change value of S_IFGITLINK to something=
 else?
>
>  From git's cache.h:
>
> /*
>   * A "directory link" is a link to another git directory.
>   *
>   * The value 0160000 is not normally a valid mode, and
>   * also just happens to be S_IFDIR + S_IFLNK
>   *
>   * NOTE! We *really* shouldn't depend on the S_IFxxx macros
>   * always having the same values everywhere. We should use
>   * our internal git values for these things, and then we can
>   * translate that to the OS-specific value. It just so
>   * happens that everybody shares the same bit representation
>   * in the UNIX world (and apparently wider too..)
>   */
>
> Time to implement that translation :|

I may try to implement it, but I my knowledge of Git internals is equal=
=20
to zero. If someone can point me what has to be done - I'll be grateful=
l.

AdamK
