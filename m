From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] ls-remote: print URL when no repo is specified
Date: Fri, 14 May 2010 11:17:44 -0500
Message-ID: <20100514161743.GA1957@progeny.tock>
References: <1273416140-5044-1-git-send-email-rctay89@gmail.com>
 <1273598423-3156-1-git-send-email-rctay89@gmail.com>
 <7veihh8y8b.fsf@alter.siamese.dyndns.org>
 <AANLkTinxm8hwX53LE9_7rDPoKs9UnGAyFFfVcoh-WGxE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 18:17:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCxaD-0004QY-IG
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 18:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab0ENQRs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 May 2010 12:17:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42100 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab0ENQRr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 12:17:47 -0400
Received: by vws9 with SMTP id 9so217254vws.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jnI4K5HwaaT5pDpq5236lPFq9m6L/H82CbT1WAnhCLU=;
        b=DDTpjoWPiYDNWhJNElGLqB3xwUE3B9HtuYEMBT7V2bvoX3O7qWcEZj0esA1AZX96Q4
         XoVcfWc1eshqBdo14LkXATiI6XVt1pElcslELyBJ3c98MsaEnedHOct9iJkUJL+Vpqt1
         hiWkwnQD8dZ6c6QUjsIh5KSHRGho7NTxsTMhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZhPvXmxlBTlt26q4R0Kq3TGqslk2dqIc2Xn7rxbPy8ismJonKSQjwPHGLZhIPpSszG
         ++Ah06JJBvUIClq2HtPrwRnevaH4SlJPK2KJTG2acfDMMk65hAwrfRGKK4Dox+hsEA9j
         1pYwy/tBmCss/ohfPQHqf8yB34D4onIZUhSYI=
Received: by 10.229.214.10 with SMTP id gy10mr387423qcb.195.1273853865957;
        Fri, 14 May 2010 09:17:45 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id i10sm541801qcb.11.2010.05.14.09.17.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 09:17:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinxm8hwX53LE9_7rDPoKs9UnGAyFFfVcoh-WGxE@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147099>

Tay Ray Chuan wrote:
> On Wed, May 12, 2010 at 1:50 PM, Junio C Hamano <gitster@pobox.com> w=
rote:

>> I cannot convince myself that this is a good change, as I've always
>> thought "ls-remote" output as something people want to let their scr=
ipts
>> read and parse. =A09c00de5 may have given an enhancement to these sc=
ripts in
>> the sense that they can now respond to an empty input from the end u=
ser,
>> but this patch forces them to change the way they parse the output f=
rom
>> the command.

Would 9c00de5 be so useful for scripts?  I suspect the typical script
does

  git ls-remote "$remote"

so to use the new default it would need adjusting.

Run by hand, 'ls-remote | grep heads' can be quite useful.

> in this patch, the remote url is printed to stderr, instead of stdout=
,
> so existing scripts should be safe.
>
>> I also think this patch is solving a wrong problem.
>>
>> When an end user does not know which remote ls-remote would be talki=
ng to
>> by default, what else does he *not* know? =A0Probably which remote "=
pull"
>> would be fetching from
[...]

I think I see what you are saying, and for scripts, that really would
be the most useful thing.  Then the script could use something like

  if test -z "$remote"
  then
	remote=3D$(git branch --get-remote --current)
  fi
  git ls-remote "$remote"

which would be much better than

  git ls-remote ${remote:+"$remote"} 2>/dev/null

because it does not suppress error messages.

=46or manual use of ls-remote, on the other hand, I can see the use of
the reminder.

Jonathan
