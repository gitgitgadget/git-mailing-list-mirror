From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] branch: only print upstream relationship with -v -v
Date: Thu, 18 Mar 2010 07:06:41 +0700
Message-ID: <fcaeb9bf1003171706s31870438kc69606389495876d@mail.gmail.com>
References: <1268838344-8581-1-git-send-email-pclouds@gmail.com>
	 <7vwrxavqig.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 01:06:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns3GG-0004M6-42
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 01:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab0CRAGq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 20:06:46 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:44379 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab0CRAGp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 20:06:45 -0400
Received: by yxe37 with SMTP id 37so788265yxe.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FGlLd5zAtp4Rtrt7EJvXo4rIvqmzD2YDjPMxKHD0r6M=;
        b=C9HorKp1b5IY7owd0MnqDxhyvW/A+vE5jMgfLn+jUOTO+xDj7L7SB4Z8GqSj1HhOxk
         bhottE4WLwlJ2CgVRLZ91k5SE3lOhPWHuS3i8nIdW+jxl+3iZ2/7tZwhkNwrQD60o11Q
         ZH7ofSu95qTNEY9JIe/1SfZGYuACJUhYJRGBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bxZv83IOAlicWjewyiSBHWA2Rf+p3pr3iSBPsVEIFN8USurbMPEple/8kOoAy5nHRe
         lIODjV/fv/QFgcRsb8wZUvDtq9qUN/CBgEIHxin/SxWH1EfrK0qGwY9UWHW9h3QXWqCF
         pc3SrkxzfIrUQF0dcnlUp+plGp9kHleHttUMY=
Received: by 10.101.132.10 with SMTP id j10mr2437302ann.145.1268870802011; 
	Wed, 17 Mar 2010 17:06:42 -0700 (PDT)
In-Reply-To: <7vwrxavqig.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142443>

On 3/17/10, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>  > "git branch -v" is unusable for me because it's too slow.
>
> > ...
>
> > This is on a repository with ~30 branches, some are hundreds of
>  > patches behind upstream.
>
>
> Perhaps you have an overeager branch.autosetupmerge configuration?

No. Never heard of it.

>  I dunno.  I seem to have a lot more branches than you do (currently
>  56), but most of them are topics that, once they forked from a
>  particular commit, never merge other random commits, only because th=
ey
>  have new commits that are unrelated to the objective of the topic, s=
o
>  most of my branches do not have "upstream" in that sense.

I did sysprof and it seems half the time was spent inside
merge_bases_many(). Being a complete ignorant about merging stuff, I
put "return NULL;" at the beginning of that function, "git branch -v"
now goes down to 2 seconds. Don't know if that could tell anything.
--=20
Duy
