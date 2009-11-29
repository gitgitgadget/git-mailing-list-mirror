From: Peter Weseloh <peter.weseloh@googlemail.com>
Subject: Re: Fwd: What is the best way to backport a feature?
Date: Sun, 29 Nov 2009 20:03:28 +0100
Message-ID: <4db3b0200911291103x6430e563rb86330284a4c2c7b@mail.gmail.com>
References: <loom.20091129T164518-669@post.gmane.org>
	 <4db3b0200911290941j42c5a0aaq2c6a9836b38066b2@mail.gmail.com>
	 <4db3b0200911290945r34a73346w148ee42e59868876@mail.gmail.com>
	 <200911291933.54301.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Nov 29 20:03:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEp3b-0007JT-FX
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 20:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbZK2TDX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 14:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbZK2TDX
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 14:03:23 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:62219 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbZK2TDW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Nov 2009 14:03:22 -0500
Received: by ywh12 with SMTP id 12so3224851ywh.21
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 11:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+SJv+3Iogv0hAiC2FdMasHzLPbvodhsLuzJvCIqe6pM=;
        b=LAgCYgyTPoANrDRQekzlbbrePCii1PhuhzKjWzIFOQ8ZLdmCttdSIJG2h1csMoLePN
         eFXf3051gJ5qq6L/uIKTrf6/Nu+4yaf1/vHsnk6U8LcpBKtBGERL0RJtNj58Mr/fvGq1
         yaQ+ApOHQH5IlgcZnRVze17H1SrHRfCJjgn5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g/zq75IT0X0imr9VsK3KJK38ndzwgBgMnUQDy7YFNhQJsm16jZwFS8Cv+dP3+yfPbu
         wsQarKqvRzKNw7kh4vgTAOr/+OQjILNFWZZuHQnSIWN57M1mtz1mPeTZ6W/f99bUYNrs
         vWSwqhIXf7rHVDCAw3RgHd4YWlbM1jEiR7Exo=
Received: by 10.101.200.29 with SMTP id c29mr1231049anq.101.1259521408642; 
	Sun, 29 Nov 2009 11:03:28 -0800 (PST)
In-Reply-To: <200911291933.54301.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134033>

2009/11/29 Johannes Sixt <j6t@kdbg.org>:
> [please keep the Cc list]
Sorry!
>
> http://gitster.livejournal.com/42247.html
>
> Basically, as soon as you merge Mainline into Feature_A, you change t=
he topic
> of Feature_A from "Feature for Release_1.0" to "Feature for this Main=
line".
> Clearly, this topic is not suitable for Release_1.0 anymore.
>
> There is a way around this that doesn't sacrifice the topic-oriented =
nature of
> the branch: You keep developing Feature_A as planned for Release_1.0 =
and when
> you notice that merging this feature to Mainline will become increasi=
ngly
> complex, you fork off a new branch Feature_A_for_Release_2.0 from Mai=
nline
> and merge Feature_A into this new branch:
>
> =A0 o--o--o =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Release_1.0
> =A0/ =A0 =A0\ =A0\
> =A0o-o-o--o--o-o-o-o-X-o---o--o Mainline
> =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 F1 =A0 =A0 =A0 =A0 =A0 =A0o--o =A0 =A0 Feature_A_for_Rele=
ase_2.0
> =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 / =A0/
> =A0 =A0 =A0 =A0 F2--------F3-F4 =A0 =A0 =A0Feature_A
>
> The fork point X must be in Release_2.0.

That makes perfect sense. I will discuss your suggestion with my
colleagues and will send them the link you mentioned. It's just that
branching and especially merging with CVS is so painful that they
might get scared :-). With git that's completly different, of course.

Thanks a lot,
Peter
