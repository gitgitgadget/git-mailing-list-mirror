From: "Anatol Pomozov" <anatol.pomozov@gmail.com>
Subject: Re: Commit templates are not readable after 'make install'
Date: Thu, 11 Sep 2008 10:21:21 -0700
Message-ID: <3665a1a00809111021i565be775x9ad34dd99f753497@mail.gmail.com>
References: <3665a1a00809091202u295fedabl53b280aad7bedb62@mail.gmail.com>
	 <7v8wu16sbc.fsf@gitster.siamese.dyndns.org>
	 <7vprnd5b07.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johannes.sixt@telecom.at
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 19:22:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdpsF-0007Hf-Mg
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 19:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbYIKRVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 13:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbYIKRVX
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 13:21:23 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:62393 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbYIKRVX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 13:21:23 -0400
Received: by wa-out-1112.google.com with SMTP id j37so266258waf.23
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=62A2W8lhF3T1nxKTOCygedzJ2xan19tBt8Lc5fbV7p8=;
        b=feve/26qXk6Bc7qsUpwCkJE4XvYvluVbX/33uReaYr1S8rFn1yegPTXrCVDY3nS3Y0
         lNq9+hgrwaJcKon9LS4kCbYPh9jyPLHnNNr3sGid1qDf1JpAJriAhEgUuDCotkkYgjk3
         lwKY4DZ4ZiakKtaEvl21iHAE1VKKabqHSAQo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IThW+KL4DNXZiZ3JpZ9EofKFUS2LKU8kIISSnD66gAzaz/BmvSBL5OdCNsTTGX7iGb
         ae/YfNiSLYRtFR+Np1JMd7cCSfzOikmZlMfVo+RKGIJr7vsT6PW0tULDumF0c4xPSXDw
         NJMzRvVvS3ChYU4mwuDRKTLNW0fI+Q/K0e3so=
Received: by 10.114.56.1 with SMTP id e1mr2339188waa.204.1221153682193;
        Thu, 11 Sep 2008 10:21:22 -0700 (PDT)
Received: by 10.115.78.6 with HTTP; Thu, 11 Sep 2008 10:21:21 -0700 (PDT)
In-Reply-To: <7vprnd5b07.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95624>

Hi, Junio.

Thanks for the provided patch. It works fine for me and I agree that
it is better do not hardcode that only hooks are executable. So your
solution looks better for me. +1 for include this patch.


Now permissions for are

anatol:repo $ ls -l /usr/share/git-core/templates/ -R
/usr/share/git-core/templates/:
total 16
drwxr-xr-x 2 root root 4096 2008-09-11 10:13 branches
-rw-r--r-- 1 root root   58 2008-09-11 10:13 description
drwxr-xr-x 2 root root 4096 2008-09-11 10:13 hooks
drwxr-xr-x 2 root root 4096 2008-09-11 10:13 info

/usr/share/git-core/templates/branches:
total 0

/usr/share/git-core/templates/hooks:
total 44
-rwxr-xr-x 1 root root  452 2008-09-11 10:13 applypatch-msg.sample
-rwxr-xr-x 1 root root  894 2008-09-11 10:13 commit-msg.sample
-rwxr-xr-x 1 root root  160 2008-09-11 10:13 post-commit.sample
-rwxr-xr-x 1 root root  553 2008-09-11 10:13 post-receive.sample
-rwxr-xr-x 1 root root  189 2008-09-11 10:13 post-update.sample
-rwxr-xr-x 1 root root  398 2008-09-11 10:13 pre-applypatch.sample
-rwxr-xr-x 1 root root  519 2008-09-11 10:13 pre-commit.sample
-rwxr-xr-x 1 root root 1219 2008-09-11 10:13 prepare-commit-msg.sample
-rwxr-xr-x 1 root root 4942 2008-09-11 10:13 pre-rebase.sample
-rwxr-xr-x 1 root root 2892 2008-09-11 10:13 update.sample

/usr/share/git-core/templates/info:
total 4
-rw-r--r-- 1 root root 240 2008-09-11 10:13 exclude

On Tue, Sep 9, 2008 at 1:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Didn't 9907721 (templates/Makefile: don't depend on local umask setting,
>> 2008-02-28) take care of that?
>>
>>     ... goes and looks ...
>>
>> Ah, that is only to propagate the wish of the person who _built_ it.
>>
>> You probably have a tight umask and have sources checked out unreadable to
>> others, which is propagated to the installation (check the permission of
>> files in your templates/blt directory to verify this conjecture).  And the
>> build procedure is honoring your wish to make things unreadable to others.
>
> I should have said "too tight a umask", but anyway, try this patch and see
> it helps.
>
> -- >8 --
> Fix permission bits on sources checked out with an overtight umask
>
> Two patches 9907721 (templates/Makefile: don't depend on local umask
> setting, 2008-02-28) and 96cda0b (templates/Makefile: install is
> unnecessary, just use mkdir -p, 2008-08-21) tried to prevent an overtight
> umask the builder/installer might have from screwing over the installation
> procedure, but we forgot there was another source of trouble.  If the
> person who checked out the source tree had an overtight umask, it will
> leak out to the built products, which is propagated to the installation
> destination.
>
>  templates/Makefile |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git c/templates/Makefile w/templates/Makefile
> index 0722a92..a12c6e2 100644
> --- c/templates/Makefile
> +++ w/templates/Makefile
> @@ -31,9 +31,11 @@ boilerplates.made : $(bpsrc)
>                dir=`expr "$$dst" : '\(.*\)/'` && \
>                mkdir -p blt/$$dir && \
>                case "$$boilerplate" in \
> -               *--) ;; \
> -               *) cp -p $$boilerplate blt/$$dst ;; \
> -               esac || exit; \
> +               *--) continue;; \
> +               esac && \
> +               cp $$boilerplate blt/$$dst && \
> +               if test -x "blt/$$dst"; then rx=rx; else rx=r; fi && \
> +               chmod a+$$rx "blt/$$dst" || exit; \
>        done && \
>        date >$@
>
>



-- 
anatol
