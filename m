From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 21/25] fetch: define shallow boundary with --shallow-exclude
Date: Mon, 15 Feb 2016 00:52:26 -0500
Message-ID: <CAPig+cR01WCgyJQuDcq-j5Z6u3S-LO5kUVuT+g-jdu-hoH-5yw@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-22-git-send-email-pclouds@gmail.com>
	<CAPig+cQA6yV369b7hM_Q8aPuAwF8tR1xT=jr1r2PH1KsCtHWtQ@mail.gmail.com>
	<CACsJy8B=p0frmU8ahc9bnk-uoDPNUT_6UB0MVRPiLc9DqNz3vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:52:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVC5Q-0002xC-66
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 06:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbcBOFw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 00:52:28 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34077 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbcBOFw1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 00:52:27 -0500
Received: by mail-vk0-f66.google.com with SMTP id e6so7422757vkh.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 21:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=CZLVL3dgv16BEJlxf65189xSUHRdpflCZGr6jI96WKc=;
        b=xxN08rOLsKe4elapio0kCXnUZ+W2vlMmgqLlse/Mi8/2m8/XZcZJQyM+5U9uYUoReJ
         R7XLnhXdIBl5DCpOeKZfsWDVSyX6BhNefK0HInIdtu9LLE+2Ias6lVcY6axc+UHvmW+4
         zCmKWQQO7mM9Tgl0c/NPF9CONcVXyX7eI9ezy5R5Yo+pbv/rNMuTWZC4m+JDEOkAnoRi
         UedcpVNdh1qhbBRd3bEsm+RnNS3+CKP2pC8UkcpAq+FvT5ey6LkWEzLT4Eqi7aKrIz2e
         tkVwLibrsHGunBwXFyLyYGMMTOLiZvh3rp0MJNSLhazg22gkyTeeyTf7vMyeI/hCT7pk
         PJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CZLVL3dgv16BEJlxf65189xSUHRdpflCZGr6jI96WKc=;
        b=IZx4p2UqeIh65993YuuIiFSffjnyO9Rkcqt/gKJ/k8H7imxlNGiA1I5A4jDG8S7M8l
         7wAp4VjrYRwIcF6EePnz2HjhMj/iAlNe0RBEwKcKKz/AZbdm8fCKEB/H3m0UbGJXFrT0
         Xypxopg52ihSOnyr+9zU9gbYzTUCI6/lV/1zvRo7gfaNGXxj0HZ4UE2RC8ZTWdGUun+z
         cqO+oZBvLld4ktJjbTgcupWvmayPZdZRkh8tgYX/wuZJ/g7m5GVHqLvdZ5PHFHcwJE7Y
         b3NK5kEZ5rcbGdnnPPE9J3vqt9AqcbKdgVrsFkHdKCtemcI69+1aCbJvCuT227rNXJow
         mWhw==
X-Gm-Message-State: AG10YOSVsba8Tu7+AFec4CFyprA8PcMbrRBlvws4jJ/g0ypTbVo9RiWLeIPzWKD4wjNGSjn7rk96Sa09563tLA==
X-Received: by 10.31.164.78 with SMTP id n75mr12487013vke.14.1455515546665;
 Sun, 14 Feb 2016 21:52:26 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 14 Feb 2016 21:52:26 -0800 (PST)
In-Reply-To: <CACsJy8B=p0frmU8ahc9bnk-uoDPNUT_6UB0MVRPiLc9DqNz3vQ@mail.gmail.com>
X-Google-Sender-Auth: sa14jgUvqX2wgesM1IAempd34p4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286174>

On Sun, Feb 14, 2016 at 10:53 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Feb 5, 2016 at 12:26 PM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>> On Thu, Feb 4, 2016 at 4:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
>>> @@ -109,6 +109,16 @@ int cmd_fetch_pack(int argc, const char **argv=
, const char *prefix)
>>> +               if (skip_prefix(arg, "--shallow-exclude=3D", &value=
)) {
>>> +                       static struct string_list *deepen_not;
>>> +                       if (!deepen_not) {
>>> +                               deepen_not =3D xmalloc(sizeof(*deep=
en_not));
>>> +                               string_list_init(deepen_not, 1);
>>> +                               args.deepen_not =3D deepen_not;
>>> +                       }
>>> +                       string_list_append(deepen_not, value);
>>> +                       continue;
>>> +               }
>>
>> Hmm, can't this be simplified to:
>>
>>     if (skip_prefix(arg, "--shallow-exclude=3D", &value)) {
>>         if (!args.deepen_not) {
>>             args.deepen_not =3D xmalloc(sizeof(*args.deepen_not));
>>             string_list_init(args.deepen_not, 1);
>>         }
>>         string_list_append(args.deepen_not, value);
>>         continue;
>>     }
>
> args.deepen_not is const, so no, the compiler will complain at
> string_list_init and string_list_append. Dropping "const" is one
> option, if you prefer.

Yes, dropping 'const' was implied. I didn't examine it too deeply, but
it did not appear as if there would be any major fallout from dropping
'const'. It feels a bit cleaner to keep it all self-contained than to
have that somewhat oddball static string_list*, but it's not such a
big deal that I'd insist upon a rewrite.

>> Or, perhaps even better, declare it as plain 'struct string_list
>> deepen_not' in struct fetch_pack_args, rather than as a pointer, and
>> then in cmd_fetch_pack():
>>
>>     memset(&args, 0, sizeof(args));
>>     args.uploadpack =3D "git-upload-pack";
>>     string_list_init(&args.deepen_not, 1);
>
> There's another place fetch_pack_args variable is declared, in
> fetch_refs_via_pack(), and we would need to string_list_copy() from
> transport->data->options.deepen_not and then free it afterward. So I
> think it's not really worth it.

Okay.

>>     if (skip_prefix(arg, "--shallow-exclude=3D", &value)) {
>>         string_list_append(args.deepen_not, value);
>>         continue;
>>     }
