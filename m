From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] Add "ls", which is basically ls-files with 
	user-friendly settings
Date: Fri, 8 Jan 2010 01:09:32 +0700
Message-ID: <fcaeb9bf1001071009m11a7adfehdad485a4baeeb958@mail.gmail.com>
References: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
	 <1262884076-12293-4-git-send-email-pclouds@gmail.com>
	 <7vfx6h4ww3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 19:09:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSwni-0000dB-6l
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 19:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110Ab0AGSJd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 13:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101Ab0AGSJd
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 13:09:33 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:43577 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab0AGSJd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 13:09:33 -0500
Received: by pxi4 with SMTP id 4so1438341pxi.33
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 10:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ry0C8K0qDiR5qMuOYMxMDy3zYK94jFqw7C9FZMMog9U=;
        b=txkVKdNkoX8OiMMZ2Lfzk6ohfKa9Tg/FsInCf/GW/+cD0hXIUiuKqNbNNoXhH/ElRw
         56QU6ouEKXBamMUGXxE9FtFmGDsXl6pFl3xh0FMjStm5ONwqK2AB7h57vUfYTxy/wY/j
         f+zQBPmjfNv17Y6qRBrn5VIWZ280Ng+JWx4O4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Uyr01VEuSSIQpy/nal4PYrA+W3GaLTdfPSHQ8spiq40E1oPFJgrbk6tuLwrv/Lx03K
         qCOrMgxSvZFpCFN+k5ySgj4otVAEs/vWBizs+URKFGmFARmASJNR9tWHcLAbH3aIkWNq
         lnBcq3yzi7zBqdLQWaVWjEBp/U0WvVeHO9QNw=
Received: by 10.114.69.17 with SMTP id r17mr5414244waa.42.1262887772582; Thu, 
	07 Jan 2010 10:09:32 -0800 (PST)
In-Reply-To: <7vfx6h4ww3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136374>

On 1/8/10, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>  > +
>  > +     if (show_colums) {
>  > +             const char *argv[] =3D { "column", NULL };
>  > +
>  > +             memset(&cp, 0, sizeof(cp));
>  > +             cp.in =3D -1;
>  > +             cp.out =3D dup(1);
>  > +             cp.argv =3D argv;
>  > +             start_command(&cp);
>  > +             close(1);
>  > +             dup2(cp.in, 1);
>  > +             close(cp.in);
>  > +     }
>
>
> I think the code for columnar output used in producing "git help -a"
>  output should be reusable (if not, should be made reusable and reuse=
d
>  here).

I saw that and even exported term_columns() but was too lazy to make
pretty_print_string_list() something reusable. Will think of it again
when I see this command is worth pushing forward.
--=20
Duy
