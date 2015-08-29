From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 03/13] utf8: add function to align a string into given strbuf
Date: Sat, 29 Aug 2015 23:03:04 +0530
Message-ID: <CAOLa=ZRq4aJMYcRBaaLV9XFJ0LkeO27cZwaaJUmRMvCnHD1SAQ@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-4-git-send-email-Karthik.188@gmail.com> <55E1E778.4030400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 29 19:33:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVk0n-0000c0-G7
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 19:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbbH2Rde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Aug 2015 13:33:34 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36635 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbbH2Rde convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Aug 2015 13:33:34 -0400
Received: by oibi18 with SMTP id i18so40231981oib.3
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=egMyDvAD/zGxkr9JDJ1QDYxiEj8e8tGOHXH8LKpctjk=;
        b=W9fOMmyT9rKry52R31Ae8lFcmfnaYruKP3PACaaLhOoQ44q0tTRaLlXyovap6Ecyta
         o7gyR8rG/pHwcX+qjVOY0nRWg8+SK1BxDU8DqlolFeH0NOMZayIWlihr0F+tKutseSN0
         ObXZA4qw5dPT6cuYT1a8Uy2QNLdmqgPgNoTwAomenhec1FwNG7cVhswdBKDAzwAnaZtx
         R6FOBSNlzCUS676BOPeOB1uXdYi7cmh0BdzxUH8RrE2JJMtl+qRpRNXmD6QuEFy3CHi/
         pjy8ooFeIU1Ca8nK7TDdZAPyfeWg0pA4xsIXxozcNRtUoTWUSdEPDmRS+ImMzu5ccFAH
         py0g==
X-Received: by 10.202.200.146 with SMTP id y140mr3382299oif.111.1440869613416;
 Sat, 29 Aug 2015 10:33:33 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sat, 29 Aug 2015 10:33:04 -0700 (PDT)
In-Reply-To: <55E1E778.4030400@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276793>

On Sat, Aug 29, 2015 at 10:40 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 29.08.15 16:12, Karthik Nayak wrote:
>> diff --git a/utf8.h b/utf8.h
>> index 5a9e94b..7930b44 100644
>> --- a/utf8.h
>> +++ b/utf8.h
>> @@ -55,4 +55,19 @@ int mbs_chrlen(const char **text, size_t *remaind=
er_p, const char *encoding);
>>   */
>>  int is_hfs_dotgit(const char *path);
>>
>> +typedef enum {
>> +     ALIGN_LEFT,
>> +     ALIGN_MIDDLE,
>> +     ALIGN_RIGHT
>> +} align_type;
> should this be called strbuf_align_type ?
>

align_type seemed descriptive and unique enough.

> And is there a reason why the is in utf.c and not in stbuf.c ?
>
> (I know that there is a lot of strbuf in utf8.c, but I hadn't managed=
 to send a patch
> to move everything into strbuf.c and make utf8.c un-aware of all strb=
ub-business)
>

This was based on Eric's suggestions.
http://article.gmane.org/gmane.comp.version-control.git/275456

It makes sense also, since rather than acting on a strbuf, this is more=
 of just
utilizing an strbuf to provide the result. whereas the real work is of
alignment.




--=20
Regards,
Karthik Nayak
