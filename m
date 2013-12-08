From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [PATCH] i18n: move the trailing space out of translatable strings
Date: Sat, 07 Dec 2013 21:56:30 -0600
Message-ID: <87vbz0f11t.fsf@gmail.com>
References: <1386468704-18339-1-git-send-email-pclouds@gmail.com>
	<CACsJy8CBC3qk7NQPR3UWhUdA+o+hXPLPXV+8fz4ctCSV1J2hcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 08 04:56:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpVUE-0003du-Cd
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 04:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671Ab3LHD4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Dec 2013 22:56:35 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:48339 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab3LHD4e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Dec 2013 22:56:34 -0500
Received: by mail-ob0-f180.google.com with SMTP id wo20so2413718obc.39
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 19:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:newsgroups:to:cc:subject:references:date:message-id:user-agent
         :cancel-lock:in-reply-to:mime-version:content-type
         :content-transfer-encoding:posted-to;
        bh=2dHaGchvUzZ/XHxA2EiSWj5a6WV7YHXleopcCLVGGME=;
        b=eA2GKLRr0+IQo2FGU93iEvRtG/AxikqCijWvMtwKvw+hGV1DAWhDKfwTDpvIH8mbt+
         jJhQTDMkfwMMmAGuVEGtPM3r8Zsb7qPtBw2gKZEIX4jz+olw26h09AlRp/cdhiB+iS1h
         K8OiewiQPKpzJ8b6kdeEF8j5fVtojWe7XU/n9D6VF4lN2uxOXkDzy/x9PDgoi6T4qptN
         42lLN+8Hjs37lrkHLyckYNsZ/CuM+SPZVoD6y6BiohnW4f08DXnDmjZkPETLkmpvpOGV
         bR76O8Tzx4Lk0caHRRmQoKH1q6zRNl9+xvQqHdIvlk3Y5oS8AE0h3f2XDU17yTyL3uUy
         C9xA==
X-Received: by 10.182.24.69 with SMTP id s5mr8457859obf.35.1386474994004;
        Sat, 07 Dec 2013 19:56:34 -0800 (PST)
Received: from localhost (cpe-72-179-6-119.austin.res.rr.com. [72.179.6.119])
        by mx.google.com with ESMTPSA id r6sm7640789obi.14.2013.12.07.19.56.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 19:56:32 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:nltui0EV8/OBmzFL5NpxXM5FWmc=
In-Reply-To: <CACsJy8CBC3qk7NQPR3UWhUdA+o+hXPLPXV+8fz4ctCSV1J2hcA@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 8 Dec 2013 09:15:25 +0700")
Posted-To: gmane.comp.version-control.git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239033>

The following message is a courtesy copy of an article
that has been posted to gmane.comp.version-control.git as well.

Duy Nguyen <pclouds@gmail.com> writes:
> On Sun, Dec 8, 2013 at 9:11 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> I could fix vi.po alone, but it'd be better to avoid similar mistake=
s
>> for all translations by moving the trailing space out of all
>> translatable strings (*). This is inline with how we handle newlines
>> (e.g. *printf_ln wrappers) but it's not widespread enough to make ne=
w
>> *printf_space wrappers.
>
> And I just realized spaces are more common in languages using latin
> alphabet but are not a rule. CJK languages do not have/need spaces so
> this might be a wrong move..

There are already other issues as well.  The strings also seem to be
assuming certain word orders.  For example:

> -					on_what =3D _("HEAD detached at ");
> +					on_what =3D _("HEAD detached at");

Both versions of this assume that the location at which HEAD was
detached should come at the end of the sentence, whereas in
rightward-headed languages such as Japanese it would be more natural to
put the location at the middle or beginning of the sentence (while it i=
s
possible to rewrite the text a bit to force the location to come at the
end).

I think the best practice is to just have one long string per "message"
the program is supposed to display, and only display that string with %=
s
substituted for data, rather than printing that string and then printin=
g
the data, or printing the data and then printing the string, or
whatever.  With printf() in C, the %s can even be reordered wrt to the
calling order with a special syntax, "%m$", if necessary, as I just
learned from `man 3 printf`...

-Keshav
