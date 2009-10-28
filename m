From: Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured mergetool 
	option
Date: Wed, 28 Oct 2009 08:37:06 -0700
Message-ID: <d411cc4a0910280837h52596089je9ab4d03383d43cc@mail.gmail.com>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
	 <20091027230043.GA11607@hashpling.org>
	 <20091028090022.GA90780@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles Bailey <charles@hashpling.org>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 16:37:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3AaM-0005sc-C6
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 16:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbZJ1PhE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 11:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754600AbZJ1PhD
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 11:37:03 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:46908 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbZJ1PhB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 11:37:01 -0400
Received: by yxe17 with SMTP id 17so755042yxe.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bpF1Lg4aqCQ9PgkS4ykgCdGnI6jZilytED5KS8ZW1gg=;
        b=C6oiL+bAJ/tnqO9jVzZN658IgorucpN8/Wy2ymQcjOSw8cT5rig42tSafOcFpUfGPA
         cuV+0i76cI5rXoISBT9Ge5G6/yoWQWSPmOkMWUqdnujGNYrFXBRobzMLxF3oKdRBW0Ft
         lZpnCFqzohvRXqtjueBYhZ9j6nKy5iiXFDM+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vL2SZiB8drRH5h09YckY+g6+78tUNkS6TyvGSGjX6TjAbBAC95z/dm4dRLQ/FW941Y
         TlPpTdEdGGDR323lSN4j+XXu/bF7M8lH63n0xYM+gHms7SjHnHFL+4Q1p4B0ArUn0snc
         CPd/ZQxtd8CtrmM9LEfCmdLpfgXDM/27QU9Bs=
Received: by 10.101.18.20 with SMTP id v20mr310925ani.2.1256744226160; Wed, 28 
	Oct 2009 08:37:06 -0700 (PDT)
In-Reply-To: <20091028090022.GA90780@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131474>

Hey,

On Wed, Oct 28, 2009 at 2:00 AM, David Aguilar <davvid@gmail.com> wrote=
:
>> I'm just wondering, does this work well with unixes and Mac OS X? I
>> think it's recommended install practice to symlink p4v as p4merge on
>> *nix, but Mac OS X needs some sort of 'launchp4merge' to be called
>> IIRC, or is this something that users can just configure with
>> mergetool.p4diff.path?
>
> I just tested this on Mac OS X with the latest version of
> p4merge. =C2=A0It worked great.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git config difftool.p4merge.path \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/Applications/p4merge.app/Contents/=
MacOS/p4merge
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git difftool -t p4merge HEAD^
>

This is how I have it setup as well and both diff and merge work for
me.  I had to do a weird thing with passing it $LOCAL twice if there
was no merge base since otherwise it does a diff tool instead of a
merge tool - the difference is based on the number of arguments, but
it seems to work pretty well.  I can try it on Linux a bit later, but
I'm not sure why launchp4merge would be needed instead of setting the
path like this on a Mac - if there is no serious objection, I can
resend this with my Signed-Off-By (sorry, I forgot).

Thanks,
Scott
