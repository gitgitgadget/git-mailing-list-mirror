From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 2/3] tests: use __gitcompadd to simplify completion tests
Date: Tue, 16 Oct 2012 02:24:54 +0200
Message-ID: <CAMP44s2ej4oz4E4tYk7hNjBXe-pvK-v2kQDuz9pg42stBtL61w@mail.gmail.com>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
	<1350229971-9343-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	SZEDER Gabor <szeder@ira.uka.de>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 02:25:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNuy2-0002pV-GM
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 02:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116Ab2JPAY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 20:24:56 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44069 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab2JPAYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 20:24:55 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so5636412oag.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 17:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XvjcFtSVkaksF+vF8KmjUQXnOfuHqAVk/oC+ftVobBY=;
        b=JW8NtK76AQKV1f9V4XeLbld+2vxwFxWolcHdrT8VWehrce5eeHGt66koZyciJG34Pa
         tuY17TxNhKM74tj8TFrNt0JeIFS/et/eGqtvncv3RBTMNZU5IN0KNoAqew0x2DCwc6Zt
         T1LqhqzsJMfM222jpd8sC0AyUimhwuj4iNAtIOR1KmwV4AYqnH7yWUJo+jLP9wFNpJaM
         71pfJUOGaXNsSIT6I6WauKcp6XoIvfT+++x4xdtuVIen1Yfy3cycNGC/QNFsIcu93bpC
         5ruYhu7QosdXs7yU2JoFsVH4KwTfpiBeCLffPEirkQ5jLji835LkvWDt+mS2QlTvtW0O
         rtOQ==
Received: by 10.60.27.71 with SMTP id r7mr11161795oeg.96.1350347094952; Mon,
 15 Oct 2012 17:24:54 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Mon, 15 Oct 2012 17:24:54 -0700 (PDT)
In-Reply-To: <1350229971-9343-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207791>

On Sun, Oct 14, 2012 at 5:52 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> -print_comp ()
> +__gitcompadd ()
>  {
> -       local IFS=$'\n'
> -       echo "${COMPREPLY[*]}" > out
> +       compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}" > out

Rather:

compgen -W "$1" -P "$2" -S "$4" -- "$3" > out

-- 
Felipe Contreras
