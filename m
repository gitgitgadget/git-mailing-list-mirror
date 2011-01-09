From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: manual http authorization (no netrc)
Date: Mon, 10 Jan 2011 00:35:16 +0800
Message-ID: <AANLkTik2QjOOoOcx0E7NeYEbs3YnLFPbG3x5J2RUFmRU@mail.gmail.com>
References: <auto-000024252997@sci.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tfogal@sci.utah.edu
X-From: git-owner@vger.kernel.org Sun Jan 09 17:35:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbyEo-000507-2S
	for gcvg-git-2@lo.gmane.org; Sun, 09 Jan 2011 17:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185Ab1AIQfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jan 2011 11:35:20 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35533 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab1AIQfT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jan 2011 11:35:19 -0500
Received: by fxm20 with SMTP id 20so18195135fxm.19
        for <git@vger.kernel.org>; Sun, 09 Jan 2011 08:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1Lc5tnKSZuy8QfKdp7JIvoqmPQ2Jp/x3rQ+tWppzMfc=;
        b=eIpSI5FxVTV0m0jouBVC9e12BEAQF4xboGkELTA0wcWxefF5N3beTmrYCPZbfPVWjh
         1KynJY/cH9yFMCPzWnmDXQGnr8uJ2mkB4+aQ5V2S0dKG/pgh04hvoHyssWDTvGIX1gnI
         1DyLsc/VG2irV7CGDvWfL4arkVxotDOuN3BS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vHY3HF95JlpLPo6LJihgVLpJtPLBhjbf4LxJDvC/qKWWfX7h6ljdfntHxaAXxGBWun
         Z9MmkRG/avJiVgvE8Uy5L3Mdi6uJITW2YkDKlpTocx1ycwDocPNovzQcx2cwVpkB6ziX
         vXyF5tpaVOP/xFDo1/1jhXmaQ5BeF47SGUSbo=
Received: by 10.223.113.131 with SMTP id a3mr10448875faq.135.1294590916785;
 Sun, 09 Jan 2011 08:35:16 -0800 (PST)
Received: by 10.223.115.82 with HTTP; Sun, 9 Jan 2011 08:35:16 -0800 (PST)
In-Reply-To: <auto-000024252997@sci.utah.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164852>

On Fri, Jan 7, 2011 at 1:20 AM, tom fogal <tfogal@sci.utah.edu> wrote:
> I'm getting authorization errors when I lack a .netrc for an http-bas=
ed
> server. =A0Specifically:
>
> =A0tf@shigeru tmp $ git clone http://myhost:port/git/io.git
> =A0Cloning into io...
> =A0Username:
> =A0Password:
> =A0error: The requested URL returned error: 401 (curl_result =3D 22, =
http_code =3D
> =A0401, sha1 =3D 9c201da4d64e2fd178935b9ebbd6e110a97578d4)
> =A0error: Unable to find 9c201da4d64e2fd178935b9ebbd6e110a97578d4 und=
er
> =A0http://shigeru.sci.utah.edu:1234/git/io.git
> =A0Cannot obtain needed blob 9c201da4d64e2fd178935b9ebbd6e110a97578d4
> =A0while processing commit b1853d6f6a54cf22e259a75f77770eef53b8cb38.
> =A0error: Fetch failed.
>
> I did try multiple times; the username/password combo is correct :)

hmm, can you try passing username and password in this manner

  http://<user>:<pwd>@server:port/

?

Also, does your username/password contain special, non-alphanumeric
characters? I remember there was a change to how we handled those some
time ago.

--=20
Cheers,
Ray Chuan
