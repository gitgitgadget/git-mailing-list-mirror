From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH] fast-import docs: LT is valid in email, GT is not
Date: Sat, 24 Apr 2010 12:59:01 -0400
Message-ID: <i2hca433831004240959s227a96as2caf523da94dff51@mail.gmail.com>
References: <1272069944-20626-1-git-send-email-lodatom@gmail.com> 
	<20100424161236.GB14690@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 18:59:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5ihU-0002yV-Bn
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 18:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab0DXQ7X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 12:59:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:49981 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab0DXQ7X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Apr 2010 12:59:23 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1453274fga.1
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LosiH5P8lhBsiM5wIJ2TX+UBT6cq1lV2t14nFVjO9i4=;
        b=apJXe+qgkCJo/auNVoV16vUdNo3H+QRYGrQ/+HJZ+UqLrSqmPE8JyVb9oK/RAKCNoy
         sFOyDpz4/9P6j56i2Cn2GWQg2gCEqw1XKG9l4IyxPd8xzjBKhCjvnabLXp+0vH5KNe6G
         Ycwed+DcDT74MU2BLtwEpwurDLv3NjbNWGRN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=S9IBY7/fxSQviP9JiTfgb9PelDJ8L2Bj9++Y4GokhVxmQKPY1nyn2Hxf2emA7SFLw3
         PSwIbPDVpUE/nAcRtve23Z+zJXvqA3fCR/zui+WLhLHPEo5ZqFunaXpWfAvNMfUvJIuF
         Ic4DyHmYiD3vMY96AYkAmiBMqwAAn6ZDSitkY=
Received: by 10.239.159.208 with SMTP id z16mr133026hbc.125.1272128361090; 
	Sat, 24 Apr 2010 09:59:21 -0700 (PDT)
Received: by 10.239.179.20 with HTTP; Sat, 24 Apr 2010 09:59:01 -0700 (PDT)
In-Reply-To: <20100424161236.GB14690@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145690>

On Sat, Apr 24, 2010 at 12:12 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Mark Lodato wrote:
>> +++ b/Documentation/git-fast-import.txt
>> @@ -394,7 +394,7 @@ Here `<name>` is the person's display name (for =
example
>> =C2=A0and greater-than (\x3e) symbols. =C2=A0These are required to d=
elimit
>> =C2=A0the email address from the other fields in the line. =C2=A0Not=
e that
>> =C2=A0`<name>` is free-form and may contain any sequence of bytes, e=
xcept
>> -`LT` and `LF`. =C2=A0It is typically UTF-8 encoded.
>> +`GT` and `LF`. =C2=A0It is typically UTF-8 encoded.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Here <name> is the person=E2=80=99s displa=
y name (for example
> =C2=A0 =C2=A0 =C2=A0 =C2=A0=E2=80=9CCom M Itter=E2=80=9D)
>
> So the original text is correct --- a <name> cannot contain LT becaus=
e
> a less-than sign marks the boundary between a name and email address.

Ah, you're right, sorry.  I thought it was <email>, not <name>.

> Maybe you were wondering what characters are valid in an e-mail addre=
ss?
> The comments in fast-import.c and code in ident.c are consistent abou=
t
> this: the forbidden characters are <, >, and LF, though no one seems =
to
> check (see also my other reply). =C2=A0A patch to explain this (inclu=
ding a
> reference to git-commit-tree(1), I guess) might be useful.
>
> git won=E2=80=99t understand an email with embedded > or LF. =C2=A0I=E2=
=80=99m not sure a <
> would cause problems, but I don=E2=80=99t mind that it is disallowed.

It seems like it would be good to disallow <, >, and LF in both name
and email.  With your other patch, > is allowed in the name.

Thanks for the clarification,
Mark
