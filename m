From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v7 01/9] Add column layout skeleton and git-column
Date: Wed, 14 Mar 2012 18:17:59 +0700
Message-ID: <CACsJy8D8U7L4P+z9DT6hq0Rze=p2M6UZKMCqia1kN-QGJFE_zg@mail.gmail.com>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <cover.1331638663.git.pclouds@gmail.com> <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com>
 <7vaa3kt9zf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 12:18:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7mE1-0005dw-R8
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 12:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab2CNLSc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 07:18:32 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:47452 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab2CNLSb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2012 07:18:31 -0400
Received: by wibhq7 with SMTP id hq7so2398047wib.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 04:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=U175kgL6rnJm46hQS3HwQnKi3sQz+F5i/TC8WDWI0hY=;
        b=rcwgI691Qr9QSNeUfK5PNi+1A10PqKS2kjLlMFkEcl8n94bYiRRcfABdvoCGxlO9GC
         XGpdVyYv/zrnI1GCTaNhR0DGC/2ukrVFaKPmF3w3mjV6jjVFR2vVdRlTCtNV4LKe2jY4
         VT+AMAYBt8HrQQDQZyBQD0K5I/kGRKtQTO6ys/ITMTYTx4YPv+qvUc/Ura6mHAPsk5jS
         61z978sJbDd5yHjucHgz6oJRWK7ACREbdQPRhcF/knqsFF8lHzqeAeIwG+Rh+B3wm9df
         lpIH8+BzgVhJ8qLArzKNy1RE/PPiy+ovumfzLoYSbhLO9QIkbrdSWaWHCfwZbRNvwOKY
         ryUQ==
Received: by 10.180.106.9 with SMTP id gq9mr5339369wib.17.1331723910012; Wed,
 14 Mar 2012 04:18:30 -0700 (PDT)
Received: by 10.223.13.5 with HTTP; Wed, 14 Mar 2012 04:17:59 -0700 (PDT)
In-Reply-To: <7vaa3kt9zf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193094>

2012/3/14 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> +#define COL_ENABLE(c) ((c) & COL_ENABLE_MASK)
>
> That is a misleading name for a boolean macro. =C2=A0It looked as if =
this
>
>> + =C2=A0 =C2=A0 assert(COL_ENABLE(colopts) !=3D COL_AUTO);
>
> was asking the helper to *enable* the column machinery with the given=
 set
> of option in colopts, and expecting the helper to answer how it enabl=
ed
> ("I took the 'automatic' decision path"). =C2=A0But that is not what =
is
> happening.
>
> Unfortunately, COL_ENABLED?(c) is not an option, but this seriously n=
eeds
> a better name to avoid reader confusion.

I'm running out of names. Suggestions are welcome.

> I haven't formed an opinion on your "grouping" mode yet. =C2=A0The ha=
rdcoded
> slash hierarchy delimiter somewhat bothers me, but I haven't thought =
it
> deeply enough to judge if it is worth making it more generic. My gut
> feeling is that '/' probably is OK.

The column user should be able to decide how to display the group
line. I rely a lot on coloring, and I was already thinking about
giving group line a highlight color, which must be configurable
because different column user uses different base colors.
--=20
Duy
