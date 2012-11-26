From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] fast-export: Allow pruned-references in mark file
Date: Mon, 26 Nov 2012 15:14:15 +0100
Message-ID: <CALWbr2ympYDTpJ4wSSc8ThYKtE5gvcf1OM-ztj5cry_TDsJr9w@mail.gmail.com>
References: <1353750432-17373-1-git-send-email-apelisse@gmail.com>
	<7vd2z1xb6c.fsf@alter.siamese.dyndns.org>
	<CAMP44s0iSkqcOW0YsD=Jm_=x1tuoRbFQ+EbVvkROa_yY2-WFcA@mail.gmail.com>
	<CALWbr2yZpAT=eSahGcGKw5weoz1MjTzbb16pdQndKDFcn_3VJg@mail.gmail.com>
	<CAMP44s3Xo2ko6X1-SO3hLiTYHA3+i912jTGOQCUihixxcbEuRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 15:14:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TczSD-0007K5-OH
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 15:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab2KZOOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 09:14:18 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60162 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab2KZOOR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 09:14:17 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so4489978eek.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 06:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GKDXCGPScq5Za8vbtfMznowQDkQbDE17MiVhaOpbwS0=;
        b=fO2zt7DoxxwDBOPAViPiSuJYWqQX7YfTzDSVrw6xJJDiOjAHoa4PeXlyCOQ0FjUJPG
         NB41uD48lT7D7Xi1c27VjaraCC5syX9ZBoImIiuetmVBPiAmw7Gbi6P0t0W02EXHYJMO
         u9p+l2JlE5PhB90bcjrXM/uZM7FIon4Wxqj37Q+JCe85s/ILFj9SrDQH3fTtxDW9yXJz
         TQJp3SVEvb+vs7F4Rvhz0aho9d5SxQ0jcCFbY0KDvURgUyY8uGqv9O5pAF3Bemnyfv3y
         rXwq9kOmUP74VlfEgoHbuBCOA5m/1L1ZtVUhtRwJacX6Xf32Uo01bUYgo4uvYvJxIfT3
         oLGA==
Received: by 10.14.199.134 with SMTP id x6mr46134691een.31.1353939255786; Mon,
 26 Nov 2012 06:14:15 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Mon, 26 Nov 2012 06:14:15 -0800 (PST)
In-Reply-To: <CAMP44s3Xo2ko6X1-SO3hLiTYHA3+i912jTGOQCUihixxcbEuRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210450>

> If that's the case, I don't think it should throw a warning even just skip them.

Removing the warning seems fine to me.

> Then, in the actual export if some of these objects are referenced the
> export would fail anyway (but they won't).

Of course it will fail to export anything that requires the missing object.
As they are unreachable, it will be hard to provide a ref that needs
it anyway.

On the other hand, I'm afraid that your file
'.git/hg/<remote>/marks-hg' needs consistent references to mark.
If a mark is removed, and then replaced by another object, can it
break somehow git-remote-hg ? If not, I can provide a simpler patch.
If it does, it will be more complicated.

Cheers,
Antoine
