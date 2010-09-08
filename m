From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Wed, 8 Sep 2010 20:06:34 +0530
Message-ID: <AANLkTinPb+3rwUg5mwUN+HBkuj2SzLpiG=hCp+WOfu0S@mail.gmail.com>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<AANLkTikGiekZGNffaraHK-waBt7wH84jujM_uh3cw46y@mail.gmail.com>
	<AANLkTinTFWHWU1vCnDa-c3p5g+y7wnH9A8fieowQHU5z@mail.gmail.com>
	<201009061049.38546.jnareb@gmail.com>
	<EC704F6E-3075-459C-9210-10C234523D80@gmail.com>
	<20100906145606.GM32601@spearce.org>
	<AANLkTikmU9_Vg2+=73yjPyaaDSqk73Bvs1HyNjFDWqNY@mail.gmail.com>
	<20100906181921.GN32601@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Juran <jjuran@gmail.com>, Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 08 16:36:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtLlU-0004WE-Mw
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 16:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190Ab0IHOgh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 10:36:37 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59696 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab0IHOgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 10:36:35 -0400
Received: by gwj17 with SMTP id 17so49425gwj.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x0e+Maie8JlQbPrFiZ7jJR/BtN9y6uw5emplctCdPbg=;
        b=Pi0ukUO0pupSzu1RYOjKRHOLSsaLFvobrVSsx5XVCVPlN5FsRx70+WEus4HiOCcOWA
         jUWH3fh8op75cSPt2gZFaVboqphLzpsgNmxIFrljfDx84ph949n9tZksFGWNyQHott/q
         CLMJ+lTekgrBS/tltrH75REnfur9heP6mA03w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iGvw7oB+ceZmsuRIUKTXdWQIvoQugKYUaDFnYfZ4/eg4s0RlCml8J6Z3PQg0duD6dV
         osoP9Q/kBNErWK+F+rHcGL5u/3cwJNjKG+3KCqP51togGVsPRqQIsAx6nywENnGoBnxg
         EUoW96Nyj446Sc+GfGEzcNKlOwycvZSXG2HAg=
Received: by 10.90.96.17 with SMTP id t17mr234997agb.36.1283956594632; Wed, 08
 Sep 2010 07:36:34 -0700 (PDT)
Received: by 10.90.209.12 with HTTP; Wed, 8 Sep 2010 07:36:34 -0700 (PDT)
In-Reply-To: <20100906181921.GN32601@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155787>

2010/9/6 Shawn O. Pearce <spearce@spearce.org>:
> Sitaram Chamarty <sitaramc@gmail.com> wrote:
>> On Mon, Sep 6, 2010 at 8:26 PM, Shawn O. Pearce <spearce@spearce.org=
> wrote:
>> > That is, the following will trigger a correct error on the client:
>> >
>> > =C2=A0200 OK
>> > =C2=A0Content-Type: application/x-git-upload-pack-advertisement
>> >
>> > =C2=A0001e# service=3Dgit-upload-pack
>> > =C2=A00022ERR You shall not do this
>>
>> are those counts accurate for the specific example you show or just =
made up?
>>
>> It seems the first line has a count in hex that includes the newline
>> at the end, and the second one has a count in decimal that does not
>> include the newline nor even the 4-digits plus "ERR"
>
> Feh. =C2=A0I can't count. =C2=A0The first count is correct. =C2=A0The=
 second count
> should also be 001e. =C2=A0I guess that should be obvious by just loo=
king
> at the two lines, they are equal in length. =C2=A0:-)

Summary of offline discussion with Shawn, so that others can find it if=
 needed:

The first packet (after the HTTP headers of course) should be

XXXX# service=3Dgit-upload-pack\n

(or the same with upload replaced by receive).  These are the service
names passed in the service query parameter (/info/refs?service=3D...).

The XXXX is a hex length of the whole thing.  For these two specific
cases, they will be 1E and 1F.

This should be followed by "0000" (with no \n at the end).  This is a
special packet that means "this sequence of messages is done".

After this you can send any error messages, as follows:

XXXXERR your message\n

where again the XXXX is a hex count of the whole string (including 4
for the count itself, 4 for "ERR ", and a newline if you add it).

--=20
Sitaram
