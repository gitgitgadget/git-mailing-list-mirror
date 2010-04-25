From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 'commit -a' safety
Date: Sun, 25 Apr 2010 10:01:06 +0200
Message-ID: <201004251001.08979.jnareb@gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> <20100424164247.GM3563@machine.or.cz> <7voch8mj04.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, Wincent Colaiuta <win@wincent.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 10:01:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5wmZ-0004wp-Dk
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281Ab0DYIBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 04:01:21 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57159 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab0DYIBU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:01:20 -0400
Received: by bwz19 with SMTP id 19so494248bwz.21
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 01:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5v7ToJrSYw77Qs6vcFtq0QVJB/G8cRaRHtBr+Qlzc4U=;
        b=qmf8xm1FTLmy9zxtT6Ka96jkxIwrrAGHnYekvSWss663uTwqlf0Da/5cEyCVdzOECq
         iEMol3naPYpyQVjk2dhSHqTypdZeCrUQJYZT+a6h32mIAhMHOgn4Mkrh7ehqlw+5GKk0
         bJ6EgU1LFVUreYa+7oRKmIpeJE3rbOl+V2PTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dTwL7xoyoGfnJbarOi0b8tyinD30qlilRkQPg8cd/zRhej82U6M5t6eS5HQrebK8t+
         7zF4K40JDsqVd7koWRGcvYkyIp9sNksDBFrz2M51YnyGQLzf87/HX0gXx6rUZR7MOTyh
         2pXSzSKtlmbXa8bDCafnO8rqkEJ0kDj4qkdfs=
Received: by 10.204.5.130 with SMTP id 2mr1453112bkv.189.1272182478318;
        Sun, 25 Apr 2010 01:01:18 -0700 (PDT)
Received: from [192.168.1.13] (abvs189.neoplus.adsl.tpnet.pl [83.8.216.189])
        by mx.google.com with ESMTPS id 16sm1070519bwz.9.2010.04.25.01.01.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 01:01:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7voch8mj04.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145720>

Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
>> On Sat, Apr 24, 2010 at 01:10:24PM +0200, Wincent Colaiuta wrote:
>>> El 24/04/2010, a las 11:40, Jakub Narebski escribi=C3=B3:
>>>>
>>>> I'd like for 'git commit -a' to *fail* if there are staged changes=
 for
>>>> tracked files, excluding added, removed and renamed files.
>>
>> Thanks for this suggestion, this is exactly what I wanted to propose=
!
>=20
> I am somewhat torn.
>=20
> I have made mistake of running "commit -a" after I spent time sifting=
 my
> changes in the work tree.  I can see that I would have been helped by=
 it
> if the safety were there.
>=20
> But at the same time, I also know that my development is often a cycl=
e of
> change then diff then add (to mark the part I am happy with), and whe=
n I
> am happy with the output from diff, I conclude it with "commit -a" to
> conclude the whole thing.  I can see that I would be irritated to if =
that
> final step failed.
>=20
> But I suspect the irritation would be relatively mild: "ah, these day=
s I
> shouldn't use 'commig -a' to conclude these incremental change-review=
-add
> cycle; instead, I should say 'add -u' then 'commit'".

Or, 'git commit -f -a' (which means 'git commit --force --all').

--=20
Jakub Narebski
Poland
