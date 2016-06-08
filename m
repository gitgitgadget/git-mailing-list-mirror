From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 3/4] dir: introduce file_size() to check the size of file
Date: Wed, 8 Jun 2016 13:27:56 +0530
Message-ID: <CAFZEwPPWMdOahMP4f0=Lm_n+ZmEtGHg=zHaZAyQjSf9oL8X2ew@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-3-pranit.bauva@gmail.com> <CAPig+cTgnp3tm_S7ybDBiGfesw9mh3J4_OtEV7timnsgL0AGjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 09:58:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAYNG-0003pi-9d
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 09:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbcFHH56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 03:57:58 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34371 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcFHH55 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 03:57:57 -0400
Received: by mail-yw0-f180.google.com with SMTP id c72so375327ywb.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 00:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5XgDImB6gVLFB0wa6PRToJ5dclWi9Od5bfkSNOjn3Go=;
        b=yBTAkBnvSw+ix6yZZkUPV0y55ugtFNXKErEtJMwM0pUT5Sc+8iW3lyO4P+hELJXOvo
         XOIN8kJ7KbaQ1F446cVzHkdrBV9TUoPHTL8GXzL9eenNfmp4O3nxJ29iLjGx1p25EN11
         ahlu02A71hNkAHpH8vhggmpX7yYFC22mfqam1tUeq8hOdywIdj2nZJUq+EaS4hvWziCQ
         9NIchThoIMpNKwro/djG+Wsl05iMow8cvelR74hz9k+rhTbCPwg0srBcGKH8pfCIOotn
         lAqy7Ipu8FIuPaZc/syTaL1Jm8diHtkhIsgH3WiZbFAS26Ye80hDULZ6u/435MugnxPm
         f3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5XgDImB6gVLFB0wa6PRToJ5dclWi9Od5bfkSNOjn3Go=;
        b=GvF0+TcmQfRQmS+3okthZh4uB+A4o3suCPBo5aXYP3l05OgdTb65IwIFlfHNfdiDzb
         5RCLCB11Ez3l93S+sAUgAcNJ3O8cZDpsZ2GqIMdQ6t6G51559QHfP7Ag4NoQdZA6hUxn
         yE/F9jhM/HgNARM51XZrEfk9jnMuphh5UaAUtOIPZCBu3wHvEjhdM+OW8JU3Z2FiV2o1
         S1uXy1Sai2eoMxJyx8lQx7QDVSMxftaUdpfxRza6GigJ7aTPQsVmMl2NbD2dT5+89sFQ
         X2hQxkiBNaDCI5WA3r/Y5DLldIE0OReulV7xXXvcQRIMm9yzKOEGCC2EBIMM+Nc+u4V4
         8fQQ==
X-Gm-Message-State: ALyK8tLfATqeeIhAFydQ8EKWiatBITCkiejBzr7QzbN5+svvo66uZ6evd9x5bYbNCdQYz2KGTXReuFx/hhRimA==
X-Received: by 10.37.198.142 with SMTP id k136mr1844414ybf.53.1465372676873;
 Wed, 08 Jun 2016 00:57:56 -0700 (PDT)
Received: by 10.129.124.132 with HTTP; Wed, 8 Jun 2016 00:57:56 -0700 (PDT)
In-Reply-To: <CAPig+cTgnp3tm_S7ybDBiGfesw9mh3J4_OtEV7timnsgL0AGjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296762>

Hey Eric,

On Wed, Jun 8, 2016 at 1:07 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> dir: introduce file_size() to check the size of file
>>
>> At times we require to see if the file is empty and get the size of the
>> file. By using stat we can get the file size without actually having to
>> open the file to check for its contents.
>
> The sole caller of this function in patch 4/4 does so only to check if
> the file exists; it doesn't even care about the file's size, thus
> neither this function nor this patch seem justified and probably ought
> to be dropped unless some better and stronger justification can be
> shown.

Umm, actually there is a subtle difference between file_exists() and
file_size(). file_exists() *only* checks whether the file exists or
not while file_size() can also be used to check whether the file is
empty or not also see the implementation of both of them which shows
the difference. In fact it doesn't care at all about the file size.
Now there are a lot of instances in shell scripts where there are
quite some differences with -f and -s and some places *do care* about
this subtle difference. For eg. in bisect_reset() we test whether the
file .git/BISECT_START has some contents in it. But I guess I can add
some more justification in the commit message. What do you think?

>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/dir.c b/dir.c
>> @@ -2036,6 +2036,14 @@ int file_exists(const char *f)
>> +ssize_t file_size(const char *filename)
>> +{
>> +       struct stat st;
>> +       if (stat(filename, &st) < 0)
>> +               return -1;
>> +       return xsize_t(st.st_size);
>> +}
>> +
>> diff --git a/dir.h b/dir.h
>> @@ -248,6 +248,13 @@ extern void clear_exclude_list(struct exclude_list *el);
>> +/*
>> + * Return the size of the file `filename`. It returns -1 if error
>> + * occurred, 0 if file is empty and a positive number denoting the size
>> + * of the file.
>> + */
>> +extern ssize_t file_size(const char *);

Regards,
Pranit Bauva
