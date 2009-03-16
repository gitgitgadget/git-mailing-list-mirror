From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 5/5] Convert "float" to the lib infrastructure
Date: Mon, 16 Mar 2009 16:36:43 +0000
Message-ID: <b0943d9e0903160936m1971fbaft928a495eaab4fa20@mail.gmail.com>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com>
	 <20090312120918.2992.82713.stgit@pc1117.cambridge.arm.com>
	 <20090313024137.GE15393@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 17:39:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjFqK-0005QM-7P
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 17:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757659AbZCPQgr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 12:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbZCPQgr
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 12:36:47 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:53724 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758075AbZCPQgq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 12:36:46 -0400
Received: by fxm24 with SMTP id 24so3563446fxm.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z1McZ5JjXXY9CpTO7wiuF/YncPQtHtOxHbdy+yKXHXE=;
        b=CTbog2xHEXf6xGd+y/sj7ftAZpm+H72fTGndOjKQPJ2iYn4sIZ76WMxia4SWgfIrFU
         ZEGei5tnDVGOIY+P/Jweu5TlaK4ilvUHCIMcdx4ALVlkzdZX5bToN1hIMI5qa26UqcgH
         hfWPW1/7IV/ihOebJDH8Q5nZ0nvJH9tJkqo/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n937fj7z5GVDXmWlCp6muSq2GOJ0Ft/bP8P7HjqJh0omDyAY/VD5ipChwshef62uFL
         1Z912ycS757GfwXcjNIoPl4Aoc2EqB8n/bGZ+1oc2YX06tY2XRjij4M9U/3mzPwBlslS
         YZQBP4sb6G8m+6NlEjsLiALz8EyyOBo8qcCIM=
Received: by 10.204.58.79 with SMTP id f15mr1676147bkh.202.1237221403201; Mon, 
	16 Mar 2009 09:36:43 -0700 (PDT)
In-Reply-To: <20090313024137.GE15393@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113342>

2009/3/13 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-03-12 12:09:18 +0000, Catalin Marinas wrote:
>> =A0options =3D [
>> =A0 =A0 =A0opt('-s', '--series', action =3D 'store_true',
>> - =A0 =A0 =A0 =A0short =3D 'Rearrange according to a series file')]
>> + =A0 =A0 =A0 =A0short =3D 'Rearrange according to a series file')
>> + =A0 =A0] + argparse.keep_option()
>
> This flag should take the filename as a parameter, both because it's
> the right thing to do and because it'll make the tab completion work
> right (as is, it'll complete on patch names after the -s flag).
>
> Something like
>
> =A0opt('-s', '--series', type =3D 'string')
>
> ought to do it.

This command was accepting series via the stdin as well (maybe for
easier use in other scripts or from stgit.el). Anyway, it doesn't seem
to make any difference with the bash completion. It still tries to
complete patches but when this fails bash lists files if the prefix
matches some.

--=20
Catalin
