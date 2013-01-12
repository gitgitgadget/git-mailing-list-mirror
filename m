From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 03/21] Export parse_pathspec() and convert some
 get_pathspec() calls
Date: Sat, 12 Jan 2013 13:00:30 +0700
Message-ID: <CACsJy8Drszo=wvd-b0WXWiYkJysrbQabAP0c3NVcbrJuO2S4tA@mail.gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
 <1357903275-16804-4-git-send-email-pclouds@gmail.com> <20130111175644.GA12359@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 07:01:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttu9l-0005oY-Bt
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 07:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104Ab3ALGBB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2013 01:01:01 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38652 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab3ALGBA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2013 01:01:00 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so2536164oag.33
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 22:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=8sQT4t/gD9DCQngS0qOlh245vGk4V0z44WnpXCSYLpA=;
        b=kJ+4QnkAAOmMP6qJ5Dt0MHmN4IaQgAeMgSwd4GKCU2A+h1nfRWPNN4HwhuSUfCcFqc
         698FLzPqUQ/i8RqHX2zLXHupEnLXqlj55rlkPaqUdiYVgHco+OemcbESATBrrd4JXk7R
         4XoXChc4QICGbCtZD0iTgZ6Hnl1CsFOjCCB/0a8dyofmWiDkpiSzwaf6fTvnMI8V9aKZ
         gJDBYHiboSztqXrlfytu/ampSNVw3xwZXVKviaaRlZFFCzHCsOpxe2s1mdWmPhTyOZ7W
         gw9Zj5+rqPDfySDDf1KjeT3BQjIt3DsB0uU534S607VS9mx3JOHOYFr+HO687911SKVL
         lZUg==
Received: by 10.60.32.44 with SMTP id f12mr48193928oei.61.1357970460390; Fri,
 11 Jan 2013 22:01:00 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Fri, 11 Jan 2013 22:00:30 -0800 (PST)
In-Reply-To: <20130111175644.GA12359@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213266>

On Sat, Jan 12, 2013 at 12:56 AM, Matt Kraai <kraai@ftbfs.org> wrote:
> On Fri, Jan 11, 2013 at 06:20:57PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> +#define PATHSPEC_FROMTOP    (1<<0)
>
> The previous commit introduces a use of this macro in get_pathspec.
> Should this be defined by that commit instead?

This macro is already defined in setup.c when parse_pathspec is
introduced. I wanted to move it from setup.c to cache.h but forgot to
remove the original definition. Will fix.


>> @@ -266,9 +266,9 @@ static int pathspec_item_cmp(const void *a_, con=
st void *b_)
>>   * Given command line arguments and a prefix, convert the input to
>>   * pathspec. die() if any magic other than ones in magic_mask.
>>   */
>> -static void parse_pathspec(struct pathspec *pathspec,
>> -                        unsigned magic_mask, unsigned flags,
>> -                        const char *prefix, const char **argv)
>> +void parse_pathspec(struct pathspec *pathspec,
>> +                 unsigned magic_mask, unsigned flags,
>
> The prototype for this function uses just "magic" instead of
> "magic_mask".  Should they be consistent?

Definitely. Will fix.
--=20
Duy
