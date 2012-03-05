From: =?iso-8859-1?Q?Ren=E9_Haber?= <rene@habr.de>
Subject: =?iso-8859-1?Q?Re=3A_Bug=3A_pull_--rebase_with_=E9_in_name?=
Date: Mon, 5 Mar 2012 14:19:08 +0100
Message-ID: <47F94015-B812-4034-9910-17912AC0ADA7@habr.de>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de> <20120305102657.GB29061@sigill.intra.peff.net> <87399nqqog.fsf@thomas.inf.ethz.ch> <F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de> <20120305115815.GA4550@sigill.intra.peff.net> <0E2B8DE3-1ABD-453F-BCAA-0D693ECA5987@habr.de> <87ipijkxlm.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 05 14:19:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Xp9-0006Ei-TD
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 14:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186Ab2CENTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 08:19:12 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43344 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165Ab2CENTL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 08:19:11 -0500
Received: by bkcik5 with SMTP id ik5so3125383bkc.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 05:19:10 -0800 (PST)
Received-SPF: pass (google.com: domain of rene@habr.de designates 10.204.154.20 as permitted sender) client-ip=10.204.154.20;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of rene@habr.de designates 10.204.154.20 as permitted sender) smtp.mail=rene@habr.de; dkim=pass header.i=rene@habr.de
Received: from mr.google.com ([10.204.154.20])
        by 10.204.154.20 with SMTP id m20mr10628614bkw.90.1330953550696 (num_hops = 1);
        Mon, 05 Mar 2012 05:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=habr.de; s=habr;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=/czgYmRnNN0DFYbpjLsfRqNKN+IqLCqEhS7z02E6zv0=;
        b=I3cDGUOteP8HuMaDZ4ZI8Vbzlw0WrD7lz3eP+rzvV+F3Sij1NLrWDeROfyWr5Pv3QF
         v6uBHrWo7SmbCuQo9F2h8kI/rRSdXYxQe4Xjf0ZLzKSAciRq9R2obTn6RWwOf8NBNTui
         OhusdCSAB/R9CNUim1VMM/OeNEl3ZVHYZKjWs=
Received: by 10.204.154.20 with SMTP id m20mr8369137bkw.90.1330953550410;
        Mon, 05 Mar 2012 05:19:10 -0800 (PST)
Received: from laptop1.physik.tu-chemnitz.de (laptop1.physik.tu-chemnitz.de. [134.109.16.58])
        by mx.google.com with ESMTPS id f5sm14805496bke.9.2012.03.05.05.19.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Mar 2012 05:19:09 -0800 (PST)
In-Reply-To: <87ipijkxlm.fsf@thomas.inf.ethz.ch>
X-Mailer: Apple Mail (2.1084)
X-Gm-Message-State: ALoCoQkLNVC1W2BqGRIU6JwnjrlYoG9OEm0jE21NNBzvkmQ0u/Obl7SUAiCYP6EBUIARl//e8zkl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192234>

Am 05.03.2012 um 14:04 schrieb Thomas Rast:

> Ren=E9 Haber <rene@habr.de> writes:
>=20
>> sh -c '                                  =20
>>   . /sw/lib/git-core/git-sh-setup
>>    get_author_ident_from_commit 16b94413cbce12531e8f946286851598449d=
3913
>> '
>> GIT_AUTHOR_NAME=3D'Ren'=E9 Haber
>> GIT_AUTHOR_EMAIL=3D'rene@habr.de'
>> GIT_AUTHOR_DATE=3D'@1329212923 +0100'
>=20
> I think this is the same issue that we recently discussed on #git-dev=
el,
> where some broken versions of sed will fail to match "any character"
> with '.' even under LC_ALL=3DC.  Will "shruggar" Palmer (cc) had this
> issue under OS X with a build of GNU sed that ignored LC_*.
>=20
> You can verify that this is the problem by looking at
>=20
>  printf "\370\235\204\236\n" | LC_CTYPE=3DC sed 's/./x/g' | xxd
>=20
> It should say
>=20
>  0000000: 7878 7878 0a                             xxxx.
>=20
> That is, the garbage (if you try to read it as UTF-8) in the printf
> string was matched and replaced byte-by-byte with 'x'.  However,
> Will was getting the unreplaced results
>=20
>  0000000: f89d 849e 0a                             .....
>=20
> I'm not sure he has followed up on that problem; the only hope may be=
 to
> get a better 'sed'.
I can conform this. I get .....
Using the sed from apple results in xxxx.

Thanks.
Ren=E9

> --=20
> Thomas Rast
> trast@{inf,student}.ethz.ch
