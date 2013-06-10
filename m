From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH v3 22/28] git-remote-mediawiki: Modify strings for a
 better coding-style
Date: Mon, 10 Jun 2013 19:18:39 +0200
Message-ID: <CAETqRCh2OLq=gj-fEGrO1vyQQfTJNAFp_z_Bf0sirbBgRKPrdw@mail.gmail.com>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<1370816573-3808-23-git-send-email-celestin.matte@ensimag.fr>
	<vpqk3m2qs2r.fsf@anie.imag.fr>
	<7vhah5kje8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?Q?C=C3=A9lestin_Matte?= <celestin.matte@ensimag.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 19:18:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5k1-0008Nk-0X
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 19:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251Ab3FJRSm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 13:18:42 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:53337 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab3FJRSj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jun 2013 13:18:39 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so11829200iea.25
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Oo6oHUM3idhrMzHTSYwaa3mKs9rG9dkrBIhe7IhHeEQ=;
        b=brVLdFcGYKFW28NnuQtM4b2xwWzsihy/AqyZAVnDkRMi0v11HmEd9e/BOAgetIzpbY
         g0+0IEfI0g6w8D/kHFiHfDitN4APi8NhNJum6lLfVYTryUpMnCTwA0jCjxiwcBxwzKMG
         0sspIxZqWBiyZXYU9z6b6UwDyCy5JCveu4Q6ax/ZCSSSCcFY9cLneiiLfQBdyqMZur2n
         /2DYgOWjFTYfb4OwqxGTG0Q+oNpiQR7S6/Mf4EX6mXmhk43hTVvT4mclE8Ll8XOoYaL5
         qmNUYsxKl7GCOk5LWxSibYT1ajpArHabPo4nl7XccrGciR3tNMno+ZrqFFQJiIDKjVeo
         3TzA==
X-Received: by 10.50.153.113 with SMTP id vf17mr4340991igb.101.1370884719466;
 Mon, 10 Jun 2013 10:18:39 -0700 (PDT)
Received: by 10.42.22.141 with HTTP; Mon, 10 Jun 2013 10:18:39 -0700 (PDT)
In-Reply-To: <7vhah5kje8.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: nV7z-aKqo9otF05llXB8fGIJGwI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227326>

Well, I think next step would be to replace all those calls with
Git.pm `command`, `command_oneline` and `config``which take an array
of arguments after the "command". In the preview tool we use those but
I don't know if we will find the time to clean that up too in
git-remote-mediawiki :) .

Don't know though if it's better to mix that with this serie which is
mainly based on what perlcritic returns.

On 10 June 2013 18:41, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:
>>
>>> @@ -1285,8 +1285,7 @@ sub get_mw_namespace_id {
>>>              # Look at configuration file, if the record for that n=
amespace is
>>>              # already cached. Namespaces are stored in form:
>>>              # "Name_of_namespace:Id_namespace", ex.: "File:6".
>>> -            my @temp =3D split(/\n/, run_git("config --get-all rem=
ote."
>>> -                                            . $remotename .".names=
paceCache"));
>>> +            my @temp =3D split(/\n/, run_git("config --get-all rem=
ote.${remotename}.namespaceCache"));
>>
>> I tend to prefer the former, as it avoids long lines (> 80 columns)
>
> But you split the name of a single variable across lines by doing so.
>
> You could split lines to make it a bit more readable.
>
>                 my @temp =3D split(/\n/,
>                         run_git("config --get-all remote.${remotename=
}.namespaceCache"));
>
> It still overflows the 80-column limit, but the "namespaceCache" is
> the only thing that overflows; not much harm is done.
>
> This is totally outside of the topic of "coding-style" series, but I
> would be more concerned about the use of ${remotename}, though.  Has
> it (and in general the parameters to all calls to run_git()) been
> sanitized for shell metacharacters?  If we had a variant of run_git
> that took an array of command line arguments given to git, you could
> do this
>
>                 my @temp =3D split(/\n/,
>                         run_git([qw(config --get-all),
>                                 "remote.${remotename}.namespaceCache"=
)]);
>
> which would be safer and easier to read.
>
>>> @@ -1339,8 +1338,7 @@ sub get_mw_namespace_id {
>>>
>>>      # Store explicitely requested namespaces on disk
>>>      if (!exists $cached_mw_namespace_id{$name}) {
>>> -            run_git("config --add remote.". $remotename
>>> -                    .".namespaceCache \"". $name .":". $store_id .=
"\"");
>>> +            run_git(qq(config --add remote.${remotename}.namespace=
Cache "${name}:${store_id}"));
>>
>> Same.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
