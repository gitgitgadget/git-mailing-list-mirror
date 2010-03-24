From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: Question about .git/objects/info/alternates
Date: Wed, 24 Mar 2010 13:16:05 -0700
Message-ID: <780e0a6b1003241316i4bbd4489w63ba0308706e4d20@mail.gmail.com>
References: <a038bef51003221026i379ee16ej6e0e6defcf0048dd@mail.gmail.com> 
	<20100323024223.GA12257@progeny.tock> <a038bef51003241153g33445607qb3ab750e08b0584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 21:16:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuX06-00051c-K1
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200Ab0CXUQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 16:16:21 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44861 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933Ab0CXUQU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 16:16:20 -0400
Received: by pwi5 with SMTP id 5so4273299pwi.19
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HI+b6aeOW7GPemT0IVH4W0S3nalX4pp7iDQ76ctkkoA=;
        b=t1r7L6V7zU8Gp/pOzdDUCz50oHVLDolk//5bjPhfepo6gbI0xAtsovTlJRuTghuTUD
         4lDpGH/o6IkEetmfVfOQSsAZDIg9V+WF4dZkR0/aaeOU/g9zdQHGbcuujg74hijbj6ff
         x88uAMogBVZPF9FXo7ZGuMQl9Wn77qo/h84tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lBpm9cK5o7eWKAB2sO380UNrPqNXY0Yxy9gYN14LuncmYw8LoOETEUcxvKsSfYzUxN
         /3kkVCmZiqvb4TmYcxBvr/IrSPQiKuIasjalXnKzCkV8kRqcOn7iOlRZ8j3j2hdvr9AX
         txXXUN+/IgAtnkoQse+VpWaeQDSUgV3q0ILAU=
Received: by 10.143.85.8 with SMTP id n8mr3774809wfl.276.1269461780093; Wed, 
	24 Mar 2010 13:16:20 -0700 (PDT)
In-Reply-To: <a038bef51003241153g33445607qb3ab750e08b0584@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143115>

On Wed, Mar 24, 2010 at 11:53 AM, Chris Packham <judge.packham@gmail.co=
m> wrote:
>
> +USAGE=3D'[-r|--recursive] [-a|--add <dir>] [-f|--force -d|--delete <=
dir>]'
[...]
> +case $oper in
> + =C2=A0 =C2=A0add) add_alternate ;;
> + =C2=A0 =C2=A0del) del_alternate ;;
> + =C2=A0 =C2=A0*) =C2=A0 show_alternates ;;
> +esac

=46rom a very high-level this should probably be more like git remote
and git notes. 'add' and 'delete' would be subcommands instead of
options. Plus you might have an explicit subcommand for show (or
list?). Something like

git alternates [show]  [-r|--recursive]
git alternates add <dir>
git alternates delete  [-f|--force] <dir>
