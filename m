From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-subtree: directory mismatch
Date: Wed, 25 Nov 2009 18:20:45 -0500
Message-ID: <32541b130911251520l7a84554bxab9cf59ff9d8fc1@mail.gmail.com>
References: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com> 
	<32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com> 
	<20091125080812.6117@nanako3.lavabit.com> <32541b130911251028h6db240d5yd171fa4941ef14ba@mail.gmail.com> 
	<7v7htexuxc.fsf@alter.siamese.dyndns.org> <32541b130911251148v70a5dc77k9936881d0b382ec2@mail.gmail.com> 
	<7vpr76uzju.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0911260013550.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Marc Fournier <marc.fournier@camptocamp.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:21:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRAd-0004k2-I5
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbZKYXVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 18:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758842AbZKYXU7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:20:59 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:63219 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757404AbZKYXU7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 18:20:59 -0500
Received: by ywh12 with SMTP id 12so239023ywh.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 15:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dDacZsYhf2gC46Cy1d2ko4FEdpyRckbEJeTyFRZjwrc=;
        b=mQ/PGm8qD0IZYA0CA9PWsi6KgwVUA68IjHVYIf8G/MmPWLx1DNmNmr6xwbZZ8rQYmS
         TMhRDbAsc7m/bma9Eh8BjLBjljuE4TudWKE/lpeL2OlIjXgV0UXDWA3sgyFESH4nubdH
         KT+JUv9Sbunc4IZV87FSim4jSuSwOllVrhxVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LmCqQDwlpq1vWAEsMu8QMaFPHMAGDKFFfmhSROjvePcBFppTGONqrAPvymRKJQBs/2
         jHSOUx14NA55VztUJquhP9aKseS2LZfNzFcjZFyockG7ZDPtNqlNr56Gq2fFmYoZUTs/
         FbrrywXg4WLOH1gzyYPwrF+PcB6eNL6ZhSY5M=
Received: by 10.150.171.14 with SMTP id t14mr14541455ybe.316.1259191265119; 
	Wed, 25 Nov 2009 15:21:05 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0911260013550.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133698>

On Wed, Nov 25, 2009 at 6:17 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 25 Nov 2009, Junio C Hamano wrote:
>> I do remember some people didn't like -X<option> syntax but I don't
>> think there was any solid counterproposal to achieve a similar goal =
to
>> satisfy the need to pass arbitrary parameters to the merge strategy
>> backends.
>
> I took exception to the awkward way to specify the option. =A0A stron=
g hint
> just how awkward -X<option> is: it is hard to implement using
> parse-options.

I read the earlier thread and I still don't quite understand this
point.  What makes it difficult?  X seems just like any other option
that takes a string parameter (which is easily supported by getopt at
least; I haven't played with parse_options but I certainly hope it's
as good as getopt).

The string parameter (say, $x) is translated directly into "--$x" and
passed as exactly one argument of the argv array to the subprogram.
Easy, right?  Plus Junio already wrote a patch to do it (which I'm in
the process of forward-porting) and it seems pretty straightforward.

Perhaps I'm missing something.

Thanks,

Avery
