From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv3 2/6] Add a rename + D/F conflict testcase
Date: Wed, 7 Jul 2010 23:04:38 -0600
Message-ID: <AANLkTimLnUHMlXwLwuHsKPibw53lbi4x_LPEgmYtbW9V@mail.gmail.com>
References: <1278480034-22939-1-git-send-email-newren@gmail.com>
	<1278480034-22939-3-git-send-email-newren@gmail.com>
	<7vhbkbt24d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org, agladysh@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 07:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWjHw-0007ge-Ii
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 07:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab0GHFEj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 01:04:39 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53013 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab0GHFEj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 01:04:39 -0400
Received: by vws5 with SMTP id 5so608027vws.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 22:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7ZAW/r21RKjHqZXtCNG31YRIZpw66gfEsY+bG5TThtA=;
        b=dGs5uJqPiN6qyqkOAoLEYl/vLZKrXvo6Zn6dSvPEyBrOVuw6lMKrDYentk3w5zzgSM
         C/aKEMAoyA5FiJmsPDcYDSv3Jz5hqTbHbY3NB1aeoGJVWXzz1qr7MO42KW+79N48TQo/
         neuSsUeOGjt9/TmCe7IDiGAMST+nuGWuXX8r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wJjWq/ojef/Gpf+cbck46VGzFS5uYY0R11DOCtYLl89HbpCiXOvLTGYRiANiYfhA3X
         YTKPkZ+11YlydWdbFR1T8HDZ2SfmQYPys2Mb6oUPAdZbL5ihftISchgy+y/TrH9F0qI6
         zr6dOZHyb0oTkOUA/pEmgbuvI4InjQGp8cabU=
Received: by 10.220.124.66 with SMTP id t2mr3933984vcr.186.1278565478122; Wed, 
	07 Jul 2010 22:04:38 -0700 (PDT)
Received: by 10.220.92.199 with HTTP; Wed, 7 Jul 2010 22:04:38 -0700 (PDT)
In-Reply-To: <7vhbkbt24d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150536>

On Wed, Jul 7, 2010 at 3:26 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> diff --git a/t/t3508-cherry-pick-merge-df.sh b/t/t3508-cherry-pick-m=
erge-df.sh
>> new file mode 100755
>> index 0000000..646a56d
>> --- /dev/null
>> +++ b/t/t3508-cherry-pick-merge-df.sh
>> @@ -0,0 +1,34 @@
>> ...
>> + =C2=A0 =C2=A0 touch f1 &&
>> + =C2=A0 =C2=A0 git add f1 &&
>> + =C2=A0 =C2=A0 git commit -m "f1"
>> +'
>> +
>> +test_expect_failure 'Cherry-pick succeeds with rename across D/F co=
nflicts' '
>> + =C2=A0 =C2=A0 git checkout master &&
>> + =C2=A0 =C2=A0 git cherry-pick branch
>> +'
>
> This is curious. =C2=A0"branch" only adds a totally unrelated path to=
 its
> parent, and picking it should be trivial. =C2=A0I wonder what it does
> here if we used the resolve strategy...

It works with the resolve strategy.  I could add a testcase for it in
the next resend, though using the --strategy option will make the
series depend on master and make it no longer apply to maint.  Is that
an issue?
