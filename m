From: Jonathan Nieder <jrnieder@gmail.com>
Subject: When to use test_commit (Re: [PATCH] checkout: add a test for
 creating a new branch with regexp as a starting point)
Date: Fri, 30 Jul 2010 14:13:57 -0500
Message-ID: <20100730191357.GA2448@burratino>
References: <20100729220111.GA28176@wo.int.altlinux.org>
 <201007300136.13501.trast@student.ethz.ch>
 <AANLkTi=Qf1OUmjkpL-6e8gT8MU9G=m37sxrdAoyj5=R0@mail.gmail.com>
 <20100730084428.GA9577@wo.int.altlinux.org>
 <AANLkTikan0hnUa-p-U1dfRKq+bORmrn7A3YTPOPe2N_k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Dmitry V. Levin" <ldv@altlinux.org>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 21:16:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oev41-0003nv-2w
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 21:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744Ab0G3TPh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 15:15:37 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33490 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab0G3TPM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 15:15:12 -0400
Received: by qyk8 with SMTP id 8so352539qyk.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YEsFOiQFdT+LovmRqPtmLKc10Kp/wu+jSIJ04h3KBM0=;
        b=p46tgteGuX57e4HEoU70c52+EM13CBhtEA6YXbNPjFmSLbxm9QhezkMepfOEuMi3Ut
         A4qWVo8if9jL2ARFBmsYs+gcf/5vjgrVHALiKhOdxFsiRAMiGSo3hCvI+9gk0Jun13vt
         OCzWlphKlZUUB1+QzcOoo47qKGltBrlCiAYP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lLN4OwvXawzy2lkOBzFtXyvSuPiDzcXZuXF+OEXHjltiMw0Tc6Rd9gFx1rIIJYZIBU
         /4b3imygM/RabwPo+/U4LDVh48vT36Kjz4K0FYMwU7KBfxR3Yfpwz95DbLHP7j+JmKkj
         1gDHTW7F8BOSaFbhpOcEUASjMRfw0Gz1/r+no=
Received: by 10.224.78.93 with SMTP id j29mr279879qak.254.1280517309294;
        Fri, 30 Jul 2010 12:15:09 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h41sm2941348qcz.25.2010.07.30.12.15.07
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 12:15:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikan0hnUa-p-U1dfRKq+bORmrn7A3YTPOPe2N_k@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152262>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> And actually, we should probably have a
> test_commit_notag() then.

I don=E2=80=99t know.  What=E2=80=99s so bad about using "git commit" d=
irectly?

I often find myself using "git commit" in tests because test_commit
imposes all the usual restrictions for a ref name on the commit
message.  I would happily use an abbreviation for

 test_tick &&
 git commit -m "something" &&
 git tag something-else

if available because I don=E2=80=99t like typing, but would that help t=
he
reader and test runner any?

(That=E2=80=99s not a rhetorical question.  A patch that answers in the
positive would be fine by me. ;-))
