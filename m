From: skillzero@gmail.com
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 16:02:13 -0700
Message-ID: <2729632a0908171602m3c05c97bx9ce31e8960df9198@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
	 <200908142223.07994.jnareb@gmail.com>
	 <7veird4yyi.fsf@alter.siamese.dyndns.org>
	 <200908160137.30384.jnareb@gmail.com>
	 <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302>
	 <7vtz06xxao.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0908171817570.4991@intel-tinevez-2-302>
	 <7vws52uvxq.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0908172347220.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 01:02:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdBDe-0006VS-6V
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 01:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758252AbZHQXCP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 19:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbZHQXCO
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 19:02:14 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:53792 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbZHQXCO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 19:02:14 -0400
Received: by qyk34 with SMTP id 34so2436127qyk.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BMCA6JxnQ3I//zzJHYJ80R/2G90st9cLQa4yn7tKEgM=;
        b=v08i3cbLeEkN0HwOLYs7GxiKyCCO43ZSLVKtWbiLqPm0klQXfhDU9K/sf1dOYho9nP
         ih80M7j36SXLrhAXedpP1sGuba0gLMbi3zC1Es4htR6r+/1wgWt6XCNaC48sqRyiVSJ+
         8N0lK8IkEn/q+v00qAHe5MTqAGsOEjCr4IkNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I668vrkWNCRp0OLGzXXZxh2YziIcfq3fPs+3t1Q32VFTyymkyCG10lWuBm4ApX7Gfc
         RDkdYybkDWofIw7b+yE9udvrdeWYkVwVA6jcdGvJ4cL2HxOWTXPzTSNCLLXm8JxPoxho
         rx4BjKNN/ukRG2NICoP+j5RoEh14BJ+N/UIj4=
Received: by 10.224.50.137 with SMTP id z9mr4857007qaf.83.1250550133706; Mon, 
	17 Aug 2009 16:02:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908172347220.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126313>

On Mon, Aug 17, 2009 at 3:02 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:

> And here comes the problem: if something is treated untracked because=
 it
> was outside of the sparse checkout, then I want it to be treated as
> untracked _even if_ I happened to broaden the checkout by editing
> .git/info/sparse. =C2=A0The file did not just magically become subjec=
t to
> overwriting just because I edited .git/info/sparse (which could be a
> simple mistake).

Maybe I'm misunderstanding what you're saying, but why would you want
a file that's become part of the checkout by editing .git/info/sparse
to still be treated as untracked?

If I have a file on that's excluded via .git/info/sparse then I edit
=2Egit/info/sparse to include it and switch to a branch that doesn't
have that file, I'd expect that file to be deleted from the working
copy if the content matches what's in the repository. If it's modified
then I'd expect the branch switch to fail (like it would without a
sparse checkout).
