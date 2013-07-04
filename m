From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: git gui replaces amend message when prepare-commit-msg hook is
 used
Date: Thu, 4 Jul 2013 12:21:04 +0200
Message-ID: <20130704102104.GE17597@paksenarrion.iveqy.com>
References: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
 <20130704100112.GD17597@paksenarrion.iveqy.com>
 <CAGHpTBJqVazwuNxe1m8ggcCPh9d+9Dkuv32aCqU15AZoamGwag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 12:21:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uugf1-0002Rc-5p
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 12:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660Ab3GDKUw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 06:20:52 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55167 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab3GDKUv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 06:20:51 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so1074989lbi.19
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J/URuyfxL14qnwn7c8OYCpG9ABQ3Q0tGgNCKuy3ljno=;
        b=BT5vXW64n7NsBCEQG7IZLmRD4l2cCUXTlef/I6/bEPMEoqJzzHRTlPtfzrA1xpuJXB
         SJv8VBOnb5Ue92Cs/8idf8lWJEi+MeUqoEjN8FFocFZphqG7b7eYvGqb5QAjYxp9EFbq
         HE17995zlJOamLpsadR7kfel165ylHhsfmLd7tNovH5nlt4Txz/2lHcDIXWIySXbCzry
         8h3bSS0Gv0OKP9wJZW7ApfQKuvTORI6csMQunfwMTXBPgePT/T8Npvr+NcT5JIxPE2UQ
         FgzA7xSNYdnAR0suvAk20I/3zHYhdW5RzLRZFXrzB2h3XwmCFkKaWcey+aVFh4xVVG7s
         sr1A==
X-Received: by 10.152.20.40 with SMTP id k8mr2618606lae.25.1372933248560;
        Thu, 04 Jul 2013 03:20:48 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id m14sm1015454lbl.1.2013.07.04.03.20.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 03:20:48 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Uugeu-0002ms-Hk; Thu, 04 Jul 2013 12:21:04 +0200
Content-Disposition: inline
In-Reply-To: <CAGHpTBJqVazwuNxe1m8ggcCPh9d+9Dkuv32aCqU15AZoamGwag@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229568>

On Thu, Jul 04, 2013 at 01:03:31PM +0300, Orgad Shaneh wrote:
> On Thu, Jul 4, 2013 at 1:01 PM, Fredrik Gustafsson <iveqy@iveqy.com> =
wrote:
> > On Thu, Jul 04, 2013 at 12:47:28PM +0300, Orgad Shaneh wrote:
> >> If a prepare-commit-msg hook is used, git gui executes it for "New=
 Commit".
> >>
> >> If the "New Commit" is selected, and then immediately "Amend" (bef=
ore
> >> the hook returns), when the hook returns the message is replaced w=
ith
> >> the one produced by the hook.
> >
> > I don't get it. The message from the hook is replaced with the mess=
age
> > from the hook?
> >
> > What I don't get is how you can amend to a commit that doesn't yet
> > exists. How is that possible?
>=20
> Did I say anything about a commit that doesn't exist? I have a commit
> which I want to amend. If I click the Amend button before the hook is
> done, this commit's message is replaced (in the editor, not the actua=
l
> commit) with the hook's result.

When you click on amend the prepare-commit-msg hook is runned. But you
say that you click amend before "the hook is done". Which hook are you
talking about in this case? Are you clicking twice on amend?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
