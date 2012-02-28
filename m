From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v2] Perform cheaper connectivity check when pack is used
 as medium
Date: Tue, 28 Feb 2012 16:47:56 +0100
Message-ID: <4F4CF72C.6070508@op5.se>
References: <7vmx849ma8.fsf@alter.siamese.dyndns.org> <1330435109-4437-1-git-send-email-pclouds@gmail.com> <4F4CF58A.9090502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 28 16:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2PHc-0004FB-1s
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 16:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965581Ab2B1PsD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 10:48:03 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59951 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751078Ab2B1PsB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 10:48:01 -0500
Received: by lahj13 with SMTP id j13so2359206lah.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 07:48:00 -0800 (PST)
Received-SPF: pass (google.com: domain of exon@op5.com designates 10.112.102.65 as permitted sender) client-ip=10.112.102.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of exon@op5.com designates 10.112.102.65 as permitted sender) smtp.mail=exon@op5.com
Received: from mr.google.com ([10.112.102.65])
        by 10.112.102.65 with SMTP id fm1mr7807772lbb.88.1330444080094 (num_hops = 1);
        Tue, 28 Feb 2012 07:48:00 -0800 (PST)
Received: by 10.112.102.65 with SMTP id fm1mr6512505lbb.88.1330444079984;
        Tue, 28 Feb 2012 07:47:59 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id mc3sm17115578lab.12.2012.02.28.07.47.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 07:47:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <4F4CF58A.9090502@viscovery.net>
X-Gm-Message-State: ALoCoQmpdhlxZIUL2KhZmBV1lTIwGt0zMycxaom9IcEo3st7wIkaAjd8PrAgWOYPpOGl5cRcVw8S
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191741>

On 02/28/2012 04:40 PM, Johannes Sixt wrote:
> Am 2/28/2012 14:18, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
:
>> Without the patch:
>> $ time git fetch file:///home/pclouds/w/git/.git
>> remote: Counting objects: 125638, done.
>> remote: Compressing objects: 100% (33201/33201), done.
> ...
>> With the patch:
>> $ time git fetch file:///home/pclouds/w/git/.git
>> remote: Counting objects: 125647, done.
>> remote: Compressing objects: 100% (33209/33209), done.
>=20
> It is a bit irritating that the number are different when they should=
 be
> identical...
>=20

I found it odd as well, but since the latter shows a larger object
count and a shorter time, I disregarded it and considered it some
evidence that he pushed this patch to that repo.

Since commit created 6 blobs, 2 trees and 1 commit object, and the
latter has 9 objects more, I assume that's what happened anyways.
As such, I think we can live with the small discrepancy. Also note
that the latter post had slower transfer rate. That also skews the
comparison somewhat, but again it's in favour of the patch.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
