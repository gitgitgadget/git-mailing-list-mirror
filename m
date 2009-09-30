From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: fix mutt regex for grouped aliases
Date: Wed, 30 Sep 2009 17:50:25 +0300
Message-ID: <94a0d4530909300750y4ea5225by3acb72010c6545fb@mail.gmail.com>
References: <1254269323-16600-1-git-send-email-felipe.contreras@gmail.com>
	 <20090930112833.GA4984@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 30 16:50:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt0Vk-0002f9-2S
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 16:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbZI3OuX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Sep 2009 10:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbZI3OuX
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 10:50:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:22209 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546AbZI3OuW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Sep 2009 10:50:22 -0400
Received: by fg-out-1718.google.com with SMTP id 22so2130773fge.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PhDWgeg+a3Ohc1cJEf8JPgagLIZzxVl+Z8BTT38kgd8=;
        b=MUNhV3C6aMUocEpBMODgCXsx9DuEk49crWqOD0TRVSv5xxmGHb2sx8IvSnJWEso4ba
         FvfgJGD3IO/laSlchfEjDQTYyHOopObB0Bs/rnjA3wD8z/gGXwMFg117ng086R7Uj/L4
         tnMQpmsi/U0ZGoi9s+GlPHxo4FyZDRu81Qgsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OIBHmHH9ccKWh141DiTWMpHtklt31V38XEMfju8Pqp+vQHvYW/iVy0hQ3nkYlv1Xus
         qVM5JtnO8NgopOIYg7m9mVB9QZTmJZQHhUmCKXtelKVCtf4OB6ukcMOt25llU9X+S3Nq
         d/gvow83t4hNe4z3fuDd5NAvZQFVvAeBgY//8=
Received: by 10.86.220.9 with SMTP id s9mr42783fgg.40.1254322225917; Wed, 30 
	Sep 2009 07:50:25 -0700 (PDT)
In-Reply-To: <20090930112833.GA4984@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129345>

On Wed, Sep 30, 2009 at 2:28 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 30, 2009 at 03:08:43AM +0300, Felipe Contreras wrote:
>
>> For example:
>> alias -group friends foo Foo Bar <foo@bar.com>
>
> Hmm. If I am reading the mutt docs correctly, is it also legal to hav=
e:
>
> =C2=A0alias -group group1 -group group2 foo Foo Bar <foo@bar.com>
>
> ?
>
> Which would need just:
>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (/^\s*alias\s+(\S+)\s=
+(.*)$/) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (/^\s*alias\s+(?:-gro=
up\s+\S+\s+)?(\S+)\s+(.*)$/) {
>
> =C2=A0 (?:-group\s+\S+\s+)*
>
> I think.

Yeap, that is correct. Resent.

--=20
=46elipe Contreras
