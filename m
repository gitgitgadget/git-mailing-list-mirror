From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Wed, 25 Aug 2010 08:47:31 +1000
Message-ID: <AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 00:48:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo2Hv-0006GT-8m
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284Ab0HXWre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:47:34 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50209 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab0HXWrc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 18:47:32 -0400
Received: by ewy23 with SMTP id 23so3844886ewy.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XP00MXJnZLR3D0HHdBh6fo5lGf3bue1EQl2Oue0opzU=;
        b=QGH69IRk5y89fOGjrQXce7WStwEo/FAcy8h2uL5YxbNgKHy9nhI8XaVFHaHp+9EIg1
         S5rK7cDjGyMAlApQ4TokFwAy26+4fODnspkDhjR9PI0EIhIDeTB2Ya2YeK1RVNbCTHvb
         GxlXWQchibdfbT6+nqYUqqDC7UNptsEjbcpgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BTH145E/PGr0XUDxLDUF3dxCEd5A0Zi7oa2mWkQB/F3cftYIq4aq76imKY8O7ESvuk
         wZ5+qubB0oSrPhZ2scks9NCmsQWRrNexDjwvec8yX/kRgiSUQYph/Fzukd1SJL/biKu/
         izT26F2SPemsxXaKk+N3VEOQqmnt/URY9+vys=
Received: by 10.216.74.75 with SMTP id w53mr6577639wed.86.1282690051074; Tue,
 24 Aug 2010 15:47:31 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 24 Aug 2010 15:47:31 -0700 (PDT)
In-Reply-To: <20100824223741.GB2376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154379>

On Wed, Aug 25, 2010 at 8:37 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> Patches 26..30
>> =C2=A0 Add upload-narrow-base command
>> =C2=A0 rev-list: traverse some more trees to make upload-narrow-base=
 happy
>> =C2=A0 narrow-tree: add oldest_narrow_base()
>> =C2=A0 Add command fetch-narrow-base
>> =C2=A0 merge: support merging when narrow bases are different
>>
>> Remote merge part.
>>
>> Split a merge operation into two parts, the real merge will be done
>> within narrow tree. Conflicts can happen and be resolved in the narr=
ow
>> index, locally.
>>
>> Everything outside narrow tree will be merged (trivially) by
>> server. Then server sends the base tree back, so join_narrow_tree() =
in
>> patch 20 can be used to create proper commit.
>>
>> Server can disable this remote merge feature, which means users are
>> forced to do rebase/fast-forward. Not too bad.
>
> Yikes. =C2=A0Na=C3=AFve question (please forgive my laziness): is it =
possible to
> merge without remote contact in the boring case, when no changes have
> occured outside the narrow tree?

That's possible (and is implemented in my series). But I guess as soon
as you do "git pull", the boring case is likely not applicable
anymore.
--=20
Duy
