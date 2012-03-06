From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: Not add stripped contents for translation
Date: Tue, 6 Mar 2012 14:47:40 +0800
Message-ID: <CANYiYbFXP_rB82-_ObnPE7NkKpv8NsA7=yu1VY7nRwkRPY5X_A@mail.gmail.com>
References: <1330910494-17216-1-git-send-email-worldhello.net@gmail.com>
	<7v7gyz7pei.fsf@alter.siamese.dyndns.org>
	<CANYiYbGdJ0yFmPnsK_JdABwmFraVdNi08QgFKRmGzJt-DA9tBw@mail.gmail.com>
	<7vobsb67dn.fsf@alter.siamese.dyndns.org>
	<CANYiYbHGAG5ijeL3yW5SKYAfMNwtme5ELPeGNPhNyKBPGTONMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 07:47:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4oBW-0005fh-5N
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 07:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab2CFGrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 01:47:41 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37710 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab2CFGrl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 01:47:41 -0500
Received: by gghe5 with SMTP id e5so1303234ggh.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 22:47:40 -0800 (PST)
Received-SPF: pass (google.com: domain of worldhello.net@gmail.com designates 10.236.186.1 as permitted sender) client-ip=10.236.186.1;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of worldhello.net@gmail.com designates 10.236.186.1 as permitted sender) smtp.mail=worldhello.net@gmail.com; dkim=pass header.i=worldhello.net@gmail.com
Received: from mr.google.com ([10.236.186.1])
        by 10.236.186.1 with SMTP id v1mr31944376yhm.4.1331016460570 (num_hops = 1);
        Mon, 05 Mar 2012 22:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jnK1t5MAslmub+uDkwdtYydkA3EOZ3Nr5Ss1K3riFIc=;
        b=GG8pRPX/o7SRdo3tNlY82GYNzYkUtgHn5k3SaneYWRA+8x61YCmbwKMm2gKSm3cRWN
         icmrO5IBcTDH2AUaZkcQ+wyAbABQnHTgWdWYflFd5YGnduzjZh8MwcnYjLrfaxJGIhdA
         cxXcrrmfxoi4RkJPM6N4EKMyjNmzNVwjHbL87OO6l+vzv2na1PSSMEx+rSguGHLFtdIL
         vJkeLCuRVX3AyrfZxo8P2KGOW3Y1JdEqebYlTnKqyfeQ8zChIDHhDv9S6ri9qXnIp62B
         iOp3taZZic9boZ3N6GId/wXS0tEZpym4xIsh1Y8SGuu3Y2LLbDQt4xAaYzmbjDyCfwvG
         5twg==
Received: by 10.236.186.1 with SMTP id v1mr25208587yhm.4.1331016460446; Mon,
 05 Mar 2012 22:47:40 -0800 (PST)
Received: by 10.236.182.5 with HTTP; Mon, 5 Mar 2012 22:47:40 -0800 (PST)
In-Reply-To: <CANYiYbHGAG5ijeL3yW5SKYAfMNwtme5ELPeGNPhNyKBPGTONMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192303>

=D4=DA 2012=C4=EA3=D4=C26=C8=D5 =CF=C2=CE=E712:16=A3=ACJiang Xin <world=
hello.net@gmail.com> =D0=B4=B5=C0=A3=BA
>
> /*
>  * Make list of items easy for l10n translation.
>  *
>  *   1. Input list of items one by one through the 2nd argument,
>  *      but leave the 1st argument as NULL.
>  *
>  *   2. Append the output joint string to strbuf from the 1st argumen=
t.
>  *
>  * According to the number of items input. The joint string maybe:
>  *
>  *   a
>  *   a and b
>  *   a, b and c
>  *   a, b, c and d
>  *
>  */

-#define MAX_L10N_LIST_ITEMS_COUNT  128
+#define MAX_L10N_LIST_ITEMS_COUNT      8

> void append_l10n_list_items(struct strbuf *ret, const char *item)
> {
>    static const char **itemlist =3D NULL;
>    static int  count =3D 0;
>    int i =3D 0;
>
>    if (itemlist =3D=3D NULL)
>        itemlist =3D xmalloc(MAX_L10N_LIST_ITEMS_COUNT * sizeof(char*)=
);

+    else if (count >=3D MAX_L10N_LIST_ITEMS_COUNT)
+        itemlist =3D xrealloc(itemlist, (count +
MAX_L10N_LIST_ITEMS_COUNT) * sizeof(char*));

-    if(item !=3D NULL && count < MAX_L10N_LIST_ITEMS_COUNT )
+    if (item !=3D NULL)

>        itemlist[count++] =3D item;
>
>    if (ret !=3D NULL) {
>        if (count =3D=3D 1) {
>            strbuf_addstr(ret, itemlist[0]);
>        }
>        else if (count =3D=3D 2) {
>            strbuf_addf(ret, _("%s and %s"), itemlist[0], itemlist[1])=
;
>        }
>        else if (count > 2) {
>            strbuf_addf(ret, _("%s, "), itemlist[0]);
>            for (i=3D1; i<count-2; i++) {

-                 strbuf_addstr(ret, itemlist[i]);
-                 strbuf_addstr(ret, _(", "));
+                 strbuf_addf(ret, _("%s, %s"), itemlist[i], "");

>            }
>            strbuf_addf(ret, _("%s and %s"), itemlist[count-2],
> itemlist[count-1]);
>        }
>        free(itemlist);
>        itemlist =3D NULL;
>        count =3D 0;
>    }
> }
>
>
> ...
>       strbuf_addstr(&extra, " ("))
>       if (a)
>               append_l10n_list_items(NULL, _("msg a"));
>       if (b)
>               append_l10n_list_items(NULL, _("msg b"));
>       if (c)
>               append_l10n_list_items(NULL, _("msg c"));
>
>       append_l10n_list_items(&extra, NULL);
> ...
