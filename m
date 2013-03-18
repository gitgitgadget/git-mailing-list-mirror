From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git: how the pack-objects.c find the object's delta
Date: Mon, 18 Mar 2013 07:54:34 +0700
Message-ID: <CACsJy8C6pVTUYvU9xkNchfKBXNzT8nMuM+ggD_FQXtGwNU59wA@mail.gmail.com>
References: <tencent_0A91BD9B7F2294EF42EFC942@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?5pa55qCL?= <fangdong@pipul.org>
X-From: git-owner@vger.kernel.org Mon Mar 18 01:55:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHOMQ-0007UN-5k
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 01:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089Ab3CRAzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 20:55:07 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:53766 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3CRAzG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 20:55:06 -0400
Received: by mail-oa0-f47.google.com with SMTP id o17so5018790oag.20
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 17:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=2MvX9iwnJ81Lt3vg2+k2wlCpava4ivB6zczrLtsTFtA=;
        b=I8A7n2IL61cp1EMdenKb0EqdLyopXWhDc6w+TWqp9Bj4InaHWbamMWMn3sfGYAbTBB
         +nKi0cdszJsckZorHW5Wqs6xq+Rt7K+dB9ot4czti0akjCodEtMce70x9Ww+egHDRO50
         Pox3oHvsfuJ97M2X/LCKhtzljaH9DHPEZ8horTm5AQLULYJGaZciuszuOQUoVnSeVurK
         +MK58aJVNqgSNoJHv0GKJYydAZeSjrRC6kScA7+6iCs8FhsSAEhS7Xxui7XUPRJOykpI
         5NufY8w6yu7F1B3/IocFJ1qo7lcW32xdD8EcxBg5sfhZYcE1/2ZxX0E/MIqbeETaTfeu
         jFIQ==
X-Received: by 10.60.30.231 with SMTP id v7mr6156603oeh.118.1363568105028;
 Sun, 17 Mar 2013 17:55:05 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Sun, 17 Mar 2013 17:54:34 -0700 (PDT)
In-Reply-To: <tencent_0A91BD9B7F2294EF42EFC942@qq.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218386>

Hi,

I can't say from a first glance. Maybe git@vger can help?

On Sun, Mar 17, 2013 at 10:08 PM, =E6=96=B9=E6=A0=8B <fangdong@pipul.or=
g> wrote:
> hello
>
> i don't understand this:
> src in builtin/pack-objects.c  find_deltas() function, line 1800:
>
>
> static void find_deltas(struct object_entry **list, unsigned *list_si=
ze,
>             int window, int depth, unsigned *processed)
> {
>         ......
>
>         /*
>          * Move the best delta base up in the window, after the
>          * currently deltified object, to keep it longer.  It will
>          * be the first base object to be attempted next.
>          */
>         if (entry->delta) {
>             struct unpacked swap =3D array[best_base];
>             int dist =3D (window + idx - best_base) % window;
>             int dst =3D best_base;
>             while (dist--) {
>                 int src =3D (dst + 1) % window;
>                 array[dst] =3D array[src];
>                 dst =3D src;
>             }
>             array[dst] =3D swap;
>         }
>         ......
> }
>
> what this code block use for?
>
> thx
>
>
>
>
> ------------------
> =E7=A5=9D=E5=A5=BD
> --=E6=96=B9=EF=BC=88tyut=EF=BC=89
>



--=20
Duy
