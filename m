From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] branch: colour upstream branches
Date: Mon, 15 Apr 2013 08:31:23 +1000
Message-ID: <CACsJy8DdBkPDXORxv08cFi+i5Q4WiBjjbNf9GyB4hv+t-K=wRQ@mail.gmail.com>
References: <1365903985-24920-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 00:31:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URVSo-0004m1-IU
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 00:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266Ab3DNWby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 18:31:54 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33368 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab3DNWby (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 18:31:54 -0400
Received: by mail-ob0-f170.google.com with SMTP id x4so1440897obh.1
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 15:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6I5kvs3HQzQRONWYjOD7mah5y8G++3A9D0Kfo9/jxmA=;
        b=ReoSoGGLur+Y4Ez2FuKYNAbPPN2j/xm6xkTUxfiYzd4HHcDujTEoJiYSecE6j+go49
         q7Fyg7IG60GHanEqBph2CjREoHQWzhyRQ72JJH7cY6+IkdK/PTQaVeTiF0Mp67W0wEfi
         qcVK5BaI1H0GnoI8e2mN4Qg8hbM0kDwGldX+dhBmsvsHpP3bgXGUYBBEbS/FybQAy113
         99bqqa/CqIAkR/wSpdQay74YsKb2w+h2/PKBbxkRCeGjBLPauEm+lpFzlWovm/4Khv1E
         vZNPxcIJrn3E/0Nq7Zdj8AoUAyYkuNBaYET1pxqP7hFjDl2PYob86SUL54YgJQ3sSZ2g
         XGiw==
X-Received: by 10.60.142.230 with SMTP id rz6mr6897110oeb.22.1365978713710;
 Sun, 14 Apr 2013 15:31:53 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Sun, 14 Apr 2013 15:31:23 -0700 (PDT)
In-Reply-To: <1365903985-24920-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221163>

On Sun, Apr 14, 2013 at 11:46 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> +       char fancy[80];
>
> -       if (show_upstream_ref)
> +       if (show_upstream_ref) {
>                 ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
> +               if (want_color(branch_use_color))
> +                       snprintf(fancy, sizeof(fancy), "%s%s%s",
> +                                       GIT_COLOR_BLUE, ref, GIT_COLOR_RESET);
> +               else
> +                       strncpy(fancy, ref, sizeof(fancy));
> +       }
> +

Please use strbuf for "fancy". I also agree with Thomas that the color
should not be hard coded.
--
Duy
