From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/2] Diff patterns for POSIX shells
Date: Tue, 2 Aug 2011 20:52:58 +0200
Message-ID: <CAOxFTcy-AXtCW7-BCLgYnNTGd+unkiSaWAGPO+k+fcKr5VK-mw@mail.gmail.com>
References: <1312195069-10782-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1312195069-10782-2-git-send-email-giuseppe.bilotta@gmail.com> <7vzkjrem6b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 20:53:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoK5j-0000QS-Uv
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 20:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715Ab1HBSxU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 14:53:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40134 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878Ab1HBSxT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2011 14:53:19 -0400
Received: by iyb12 with SMTP id 12so62916iyb.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YZb6Nq5279SdU1dp9Di5G9YmZuWvs+pjCNWJxTuZkMg=;
        b=elnV2BGs7lXKl8W7hmtbWv1Gw5RikVMztAhI+n8BLe9f+RnFhg7Yawkp+KDA4DjfY5
         OHWjZvNr0AzI+i+Lp+YjABMUHKvjuvQ37Wc050/r/NHO/2AQOnJe1vPOa4jP1k7AD8l9
         bkSLDFZikmavjMccvbER4rvfhX4yuz3S35Gjk=
Received: by 10.231.16.203 with SMTP id p11mr4037490iba.151.1312311198127;
 Tue, 02 Aug 2011 11:53:18 -0700 (PDT)
Received: by 10.231.30.129 with HTTP; Tue, 2 Aug 2011 11:52:58 -0700 (PDT)
In-Reply-To: <7vzkjrem6b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178497>

On Tue, Aug 2, 2011 at 7:51 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> All diffs following a function definition will have that function na=
me
>> as chunck header, but this is the best we can do with the current
>> userdiff capabilities.
>>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>> =A0userdiff.c | =A0 =A03 +++
>> =A01 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/userdiff.c b/userdiff.c
>> index 01d3a8b..70120c3 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -107,6 +107,9 @@
>> =A0 =A0 =A0 =A0"(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
>> =A0 =A0 =A0 =A0"|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-=
)?."
>> =A0 =A0 =A0 =A0"|//=3D?|[-+*/<>%&^|=3D!]=3D|<<=3D?|>>=3D?|=3D=3D=3D|=
\\.{1,3}|::|[!=3D]~"),
>> +PATTERNS("shell", "^[ \t]*([a-zA-Z_0-9]+)[ \t]*\\(\\).*",
>> + =A0 =A0 =A0/* -- */
>> + =A0 =A0 =A0"(--|\\$)?[a-zA-Z_0-9]+|&&|\\|\\|"),
>
> Hmm, what is this "double-dash -- might be present before a name" abo=
ut?
>

Now that's a good question. I think it was a brainfart while testing
the regexp; came across a case switch where the candidate were
options, and somehow decided that it was better to include the --.
I'll prepare a patch without this stupidity.

--=20
Giuseppe "Oblomov" Bilotta
