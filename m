From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Update t3508 status
Date: Tue, 29 Jun 2010 11:50:32 -0500
Message-ID: <20100629165032.GA7699@burratino>
References: <1277775091-13313-1-git-send-email-newren@gmail.com>
 <7v4oglbxn6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: newren@gmail.com, git@vger.kernel.org, chriscool@tuxfamily.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 18:51:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTe1i-0005Nl-Rh
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 18:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165Ab0F2QvE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 12:51:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49726 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab0F2QvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 12:51:01 -0400
Received: by fxm14 with SMTP id 14so1553590fxm.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=E8UZrqpqIhPP+HvHUXiVOTl8cMIn/hTOzZYu5e1+vpA=;
        b=OuZ/KSIaiffj3vijM66kGC58EIWPZe0ZzxGAYCxhfOIXqWVqtrTsq1Qi8iyiRR1srD
         vzuLiVjs3Qb8KQeFwL0aILC498S141B/qHRUYK/nt8obSsltu+zOZrFCXBnc5eSK9pBA
         B5wmiKwSf2lEQcat6BP+MJHg3Ua9JRE7nKTkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=LsDhhVe3WyhLl7/OyjT946bwp1Dxrl0BbE88rQ7AbWl8Dfcs4Q4XHMDPofhK6lFYkH
         atlzeJGv+eW+Z+0oPn2GS5co1ehJqCivcEjQi10kjJNmSM/0uqRHQxDJLf0CSzzABbZD
         DMjHzYHgQ0vF8/p8Gj8aZFeX/onp0fECX1Th8=
Received: by 10.223.103.202 with SMTP id l10mr5931236fao.33.1277830258354;
        Tue, 29 Jun 2010 09:50:58 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f15sm1097490faa.46.2010.06.29.09.50.55
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 29 Jun 2010 09:50:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4oglbxn6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149919>

Junio C Hamano wrote:
> newren@gmail.com writes:

>> Test #8 of t3508-cherry-pick-many-commits.sh
[...]
> Curious.
>=20
> This test is broken in the second parent of 3af0bba8b (i.e. the tip o=
f
> cc/cherry-pick-stdin), but in 3af0bba8b, i.e. the merge result, it do=
es
> seem to be fine.
>=20
> What am I missing???

The fix is in commit v1.7.2-rc0~6^2 (DWIM 'git show -5' to 'git show
--do-walk -5', 2010-06-01):

 disable --no-walk in this case so =E2=80=98git show=E2=80=99 and futur=
e =E2=80=98git
 cherry-pick=E2=80=99 can behave as expected.

Jonathan
