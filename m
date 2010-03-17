From: Jonathan Nieder <jrnieder@gmail.com>
Subject: cc/cherry-pick-ff (Re: What's cooking in git.git (Mar 2010, #04;
 Tue, 16))
Date: Wed, 17 Mar 2010 04:52:18 -0500
Message-ID: <20100317095218.GA6961@progeny.tock>
References: <7vhbof4fof.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 10:52:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrpv4-0007m7-3N
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 10:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab0CQJv7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 05:51:59 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54263 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab0CQJv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 05:51:57 -0400
Received: by pwi1 with SMTP id 1so598638pwi.19
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 02:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qOSpA9Y3JZLLt7cs37DesKM0vR3Y4756wsaqglTlSnM=;
        b=YexcyHy6FIuKqsBlRwA30aPYL2BVEEWheqLMDFwC+viqcfSccjyNzhxsjzW7VS4KPq
         MBHWQ/yRekG6wuqwa0upuuHiM+KZCY19O92Io9I4tNF7KCxb8I7whqtoEnY13rwWQS4h
         ZE13LPrORuj+D+pVNC2yDbt7V79GWgioeDAwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FwiC3ZHjeIfcLKEppSj+PI0zeJOZJ+1W9V2rK95pVYXpj/KcVxPJ8Ro+R6YVZaMleq
         LHOGOinLUUy232X1l8YRA8BlJ/0O2rTtScGQBniq7xNRg3LSaMHGYiXLmNx5l7oEM7AS
         M8l/aQKZ8ALaEEv88elGp5d5XOzyZeyLz9Xgg=
Received: by 10.114.162.40 with SMTP id k40mr438531wae.99.1268819517029;
        Wed, 17 Mar 2010 02:51:57 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm6173588iwn.11.2010.03.17.02.51.56
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 02:51:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhbof4fof.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142372>

Junio C Hamano wrote:

> * cc/cherry-pick-ff (2010-03-06) 7 commits
>   (merged to 'next' on 2010-03-07 at 5589b26)
>  + rebase -i: use new --ff cherry-pick option
>  + cherry-pick: add a no-op --no-ff option to future proof scripts
>  + Documentation: describe new cherry-pick --ff option
>  + cherry-pick: add tests for new --ff option
>  + revert: add --ff option to allow fast forward when cherry-picking
>  + builtin/merge: make checkout_fast_forward() non static
>  + parse-options: add parse_options_concat() to concat options
>=20
> I think this is ready for 'master'; comments?

=46or what it=E2=80=99s worth, I am not convinced about the --no-ff opt=
ion.  I do
not think --ff ever will be the default: for an operation that amounts
to applying a patch and making a new commit, it just feels wrong.

On the other hand, I have no objection to --no-ff as an undocumented
feature, to allow scripts using the flag to be backwards compatible.  I=
f
--ff will become the default some day, we could start advertising the
--no-ff option as soon as we know that.  Why worry script authors and
use up space in the manual before then?

Just my two cents,
Jonathan
