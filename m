From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Set Makefile variables from configure
Date: Wed, 4 Nov 2009 14:16:58 -0600
Message-ID: <20091104201657.GA30073@progeny.tock>
References: <20091103222123.GA17097@progeny.tock>
 <1257357960-12763-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7v7hu6gjzz.fsf@alter.siamese.dyndns.org>
 <1257363937-sup-5123@ntdws12.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:13:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5mEs-0004Hz-1l
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 21:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758123AbZKDUNn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 15:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758111AbZKDUNn
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 15:13:43 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:47074 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757240AbZKDUNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 15:13:42 -0500
Received: by bwz27 with SMTP id 27so9289923bwz.21
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 12:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=aUfY687SDXnRAaMqikiI17zv+o/GmkSppsJaOlcU4qg=;
        b=CGcD/eJM8evXB1ov89YCBM4WWqn2I/Wk+VBFcgUNRfL7p4yotOdcLy+9A0Z5AM5HJS
         O75k/Z4S+7q88I37c34FbMvrHp6Wmw9RxjjXtt08Pg2jMiOVC8MUQDMRrCMXdRHZrieT
         xLjSZA6kc4yFxrA34J0EdDAWyCK2g9zGpr+x0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=JPITre5NG/9wzBYrwvzpdbdpk814knssrPjLeLrcBdDgAlfLLtvZ4z+blBAUBiVxZx
         MXYuGjsvsQ4GpZYJ3ezR3Hdtrno2H7PQO4dvCzaz1y3jJV5AelQP5jeQPR9nas2R/zq0
         u1eb4nZ9bWeOjGBhbXm+as61NLa5lfif1AuiI=
Received: by 10.204.148.78 with SMTP id o14mr1994036bkv.83.1257365234757;
        Wed, 04 Nov 2009 12:07:14 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm501779bwz.5.2009.11.04.12.07.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 12:07:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1257363937-sup-5123@ntdws12.chass.utoronto.ca>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132138>

Ben Walton wrote:
> Excerpts from Junio C Hamano's message of Wed Nov 04 14:36:32 -0500 2=
009:
>=20
>> I am a bit puzzled about the "warning" logic.  Is this because you e=
xpect
>> variables we typically give YesPlease/NoThanks as their values will =
not be
>> handled with this new PARSE_WITH_SET_MAKE_VAR() macro?
>=20
> No, this is because it's perfectly acceptable, in my opinion for a
> user to say:
>=20
> --with-pager=3Dno
> or
> --with-editor=3Dyes

More to the point, that=E2=80=99s what autoconf gives for "--without-pa=
ger" or
plain "--with-editor".  It seems strange to silently use PAGER=3Dno or
EDITOR=3Dyes in that case.

Maybe the options should just be --pager=3Dfoo and --editor=3Dbar, whic=
h
would be less misleading and avoid this problem.  But this is not my
itch (I find it cleaner to use the Makefile directly), so I have no
strong opinion.  Unfortunately, my autoconf-fu is too weak for a demo.

Jonathan
