From: Victor Engmark <victor.engmark@gmail.com>
Subject: Re: git svn fetch loses data
Date: Sat, 14 Nov 2009 20:29:22 +0100
Message-ID: <7d4f41f50911141129n967374ap7d92296c5723e31e@mail.gmail.com>
References: <7d4f41f50911140907n285d72dcp7bbe802900f8bae5@mail.gmail.com>
	 <fabb9a1e0911140925r3f7b7806s65da03c046bf5ab4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 20:29:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9OJN-00005E-Qx
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 20:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbZKNT3T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Nov 2009 14:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbZKNT3T
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 14:29:19 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44992 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbZKNT3S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2009 14:29:18 -0500
Received: by bwz27 with SMTP id 27so4500986bwz.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 11:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YGmBnLm7NjiGUl3BuuwfmNIMLGylWghTKxdYYAyD9vY=;
        b=s6aBxRuHbXFAr5/PYUQL/HB6GKwPe9vXH2LXqOQiSpWIzUwl/H/seJniIXjuP9U8MX
         TRW1u2fO84lfX/zENsRWmwArWfG6gIhaE6rnqIHZl4rwvHSxqVy9vVc+UI5CLnhzJTqb
         ET1ey1TzAo31Hyqw0E8Q5f5FcQumQ5Xkpfzpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uvT48Asv0laosUXqWPG2uaJb3dS3CgrA4cF8tjabo08xbzx3PpTO2J6qyq9LdVUme8
         mltnY3/MQ/FuvKy72a6WjL7l6+HiIZEQ41SZkMsCGNhO6UQ9/o/yaLAA4VyaI47qgPAr
         g/Y2z6VYSdzQxzLHnEePkCTlIe0bKfC2aeKNc=
Received: by 10.216.88.143 with SMTP id a15mr1827359wef.206.1258226962891; 
	Sat, 14 Nov 2009 11:29:22 -0800 (PST)
In-Reply-To: <fabb9a1e0911140925r3f7b7806s65da03c046bf5ab4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132882>

On Sat, Nov 14, 2009 at 6:25 PM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> On Sat, Nov 14, 2009 at 18:07, Victor Engmark <victor.engmark@gmail.c=
om> wrote:
>> but at the end about half of the
>> root directories are missing.
>
> Can you be more specific, what is the layout of your repository and
> which directories are missing?
>
> / -- trunk
> =C2=A0-- branches
> =C2=A0-- tags
> =C2=A0-- thirdparty
> =C2=A0-- private

> If your repository looks like that, and 'thirdparty' and 'private' ar=
e
> missing, that's because git svn assumes that you're only interested i=
n
> trunk, branches and tags by default.

I'm not entirely sure which directories you mean - I've got none of
those, neither in the repository nor the working copy. One of the
directories missing in the top-level directory of the working copy is
"Linux", which contains my .bashrc and tens of other config files.
Which is really odd, because here are the last few lines of "git svn
fetch --revision 993:1879":
r1878 =3D 3fcec05426b59b0bad43b02cc3c367525d2c0b93 (git-svn)
	M	Linux/etc/cups/printers.conf
r1879 =3D 7ab92e8f4bb1a277621d67ba7373f56a694466c1 (git-svn)

After checking this output a bit closer, it turns out only the
directories and files that were retrieved by "git svn clone" (the
first revision only) remain. Where did the files from the "git svn
fetch" go? Do I need to run something after fetch to see them?

--=20
Victor Engmark
