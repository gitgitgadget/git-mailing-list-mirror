From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/5] command-list.txt: prepare with [commands] header
Date: Fri, 15 May 2015 13:26:24 -0700
Message-ID: <xmqqr3qhfuz3.fsf@gitster.dls.corp.google.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431714904-16599-2-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: =?utf-8?Q?S=C3=A9bastien?= Guimmara <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 22:26:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtMBj-00010O-Di
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 22:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934763AbbEOU01 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 16:26:27 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36823 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934443AbbEOU00 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 16:26:26 -0400
Received: by igbpi8 with SMTP id pi8so4903151igb.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=skl9HZ+KbSSS+Itff/LrzUxqLMmVzHuBw+uzoMTLutQ=;
        b=lDOgat/gYxehSJmpBST1hA33Uu+ipo6Dp8yTEQ4JSwz5X3MVm17aFK/EkR/S07VGkz
         8XDCF+yVtGUbDVHL20TPBz1mOQd9VLlKZkHYvuNIuoFfPAd+nT5lFXMRNXW0Vt+cXap0
         6F/TC8eTPciA1SlNyb8j4fUV9A2OCDs+rsv8R47p3kYW42KEOiyP2pqxs5Pq/XeEeITZ
         4yrB4+Lq71Ea3qUNDTObM47+nkZuemPxhJl0AsnRvZSaMLE6gGlturgoJcKG6e+222PM
         HJuMufNKAS9cx9ABt9OCREGJ9nV8SqqxRQnWc2fbpNHJV6fNJiQogpRVvJMfFAraY+fJ
         NdIw==
X-Received: by 10.50.29.40 with SMTP id g8mr472177igh.41.1431721585891;
        Fri, 15 May 2015 13:26:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id j4sm2340409igo.0.2015.05.15.13.26.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 13:26:25 -0700 (PDT)
In-Reply-To: <1431714904-16599-2-git-send-email-sebastien.guimmara@gmail.com>
	(=?utf-8?Q?=22S=C3=A9bastien?= Guimmara"'s message of "Fri, 15 May 2015
 20:35:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269177>

S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index 25a453b..0cb2045 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2454,7 +2454,7 @@ check-docs::
>  		esac ; \
>  		test -f "Documentation/$$v.txt" || \
>  		echo "no doc: $$v"; \
> -		sed -e '/^#/d' command-list.txt | \
> +		sed -e '1,/^\[commands\]/d' -e '/^#/d' <command-list.txt | \
>  		grep -q "^$$v[ 	]" || \
>  		case "$$v" in \
>  		git) ;; \
> @@ -2463,6 +2463,7 @@ check-docs::
>  	done; \
>  	( \
>  		sed -e '/^#/d' \
> +		    -e '1,/^\[commands\]/d' \
>  		    -e 's/[ 	].*//' \
>  		    -e 's/^/listed /' command-list.txt; \
>  		$(MAKE) -C Documentation print-man1 | \
> diff --git a/command-list.txt b/command-list.txt
> index 54d8d21..caed872 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,5 +1,6 @@
>  # List of known git commands.
>  # command name                          category [deprecated] [commo=
n]
> +[commands]
>  git-add                                 mainporcelain common
>  git-am                                  mainporcelain
>  git-annotate                            ancillaryinterrogators

This is largely just a "taste" thing, but with all these backslashes
in the supporting infrastructure you had to add in Makefiles and
scripts, don't you think the choice of the way you designed the
format to use '[commands]' was a rather poor one?  After all, all
you need is a clear separator line for a block of commands and
another block of groups, and there wasn't a reason why you needed to
use square brackets for that, and the sed scripts are suffering from
that poor choice.

You could for example have used the existing "# List of known git
commands" as such a signal to tell that all the no comment lines
below are commands.
