From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 12/41] builtin/update-index.c: use error_errno()
Date: Mon, 2 May 2016 15:47:47 +0700
Message-ID: <CACsJy8CZ_AH30oa=wB4OVPW2kpykmc---R2f461hK0CJnAVMWw@mail.gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462101297-8610-13-git-send-email-pclouds@gmail.com> <CAPig+cQmjXcsDsCO0A7dgeDg2ho_eFFf9wCouz528kBk_W=b9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 02 10:48:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax9Wg-0006Ge-QC
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 10:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbcEBIsU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 04:48:20 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32944 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbcEBIsS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 04:48:18 -0400
Received: by mail-lf0-f66.google.com with SMTP id p64so26548201lfg.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XvtV0iLD2zNbFGnRyESb81moAhBtosqXDYERMQDCQOY=;
        b=J3CBsgkV+vXHBv2gGgFp7W+fZz0oky8hrfw1okvnmnMS3u2bNMhgSEotG/B4HOTuLp
         ZWejlrx750eotFNlzNUGB9XtsgZepyENEd1b3EQntR6/2/YSaH3JhKVRzPcpakbx6xhT
         uivgNhhe0BxfH8berfbg5t/qPXhNQdf3t272l1cht4LEewv+FQdq4UWhqItR8njqUEVc
         26EngayZoTDencAhkYLaKZgbMb7CBmWNFMM4SU49+woCep4h8/E5qBX1sJpocel+GXR7
         n5gKtQWRAhFcLjfrcO3hHWN3dzi/iGqpr1kOgHebOmiX0X6gXk2+Cx9SyJzd50460WtE
         nfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XvtV0iLD2zNbFGnRyESb81moAhBtosqXDYERMQDCQOY=;
        b=mdelET4NELYTQOeZ/nC0dwmaUWNHQHiW7/K/P2sRryf0zF9tVT3g4f77A8X9vUELM9
         XkIAWOUc+dmYksCKz8NV2m5atKm66+HtRgvWzNdw7WOy1S+4qwBoCfyrHGTZC7Zrhgeq
         sUeD9HRO+RWQLbUj1G0ugdB14WuJhAlsFrXYbaoCgB1hDeitd+C+JpRV3CTKiKlJf10I
         ksPQK4+5ltKwcZ/U7vwVCfFhlwEZIPu/3xBwyU6+E55kcHtMBcmbiqMka8mThm8ltL7k
         ZbNOOpDGwaaHoKPlGNNkfik6El2m/hG9N4TQIC+oGxoq9rc3ZTHJAlsNutLP3qkgkG72
         HGSw==
X-Gm-Message-State: AOPr4FWVXfoIIgO3cJw/5T6fZ1wY+UbjRTwDrcWHcbGfCYZtBW0s9owMjU7BQvpHirBM1Z9d/ypQa/2WCYZbmg==
X-Received: by 10.112.181.72 with SMTP id du8mr3231677lbc.137.1462178896923;
 Mon, 02 May 2016 01:48:16 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 2 May 2016 01:47:47 -0700 (PDT)
In-Reply-To: <CAPig+cQmjXcsDsCO0A7dgeDg2ho_eFFf9wCouz528kBk_W=b9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293232>

On Mon, May 2, 2016 at 1:40 AM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Sun, May 1, 2016 at 7:14 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> "err" is deleted because it just causes confusion when "errno" is al=
so
>> used directly in process_lstat_error().
>
> Despite the function name which may imply that it is consulting errno=
,
> this change makes me feel slightly uncomfortable since it increases
> coupling. Whereas consulting of errno had been explicit, with this
> change, it becomes implicit, and someone changing the code needs to b=
e
> extra careful about ensuring that errno does not get clobbered.
>
> Not a big objection, but a nagging doubt...

We could s/errno/err/ in this function and not convert to
error_errno(). Or we could delete this function and move the code back
to its only call site in process_path()?

>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> @@ -251,11 +251,11 @@ static int remove_one_path(const char *path)
>> -static int process_lstat_error(const char *path, int err)
>> +static int process_lstat_error(const char *path)
>>  {
>> -       if (err =3D=3D ENOENT || err =3D=3D ENOTDIR)
>> +       if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR)
>>                 return remove_one_path(path);
>> -       return error("lstat(\"%s\"): %s", path, strerror(errno));
>> +       return error_errno("lstat(\"%s\")", path);
>>  }
>>
>>  static int add_one_path(const struct cache_entry *old, const char *=
path, int len, struct stat *st)
>> @@ -382,7 +382,7 @@ static int process_path(const char *path)
>>          * what to do about the pathname!
>>          */
>>         if (lstat(path, &st) < 0)
>> -               return process_lstat_error(path, errno);
>> +               return process_lstat_error(path);
>>
>>         if (S_ISDIR(st.st_mode))
>>                 return process_directory(path, len, &st);
--=20
Duy
