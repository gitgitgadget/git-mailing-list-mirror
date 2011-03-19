From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH v2] Allow git mv FileA fILEa on case ignore file systems
Date: Sat, 19 Mar 2011 20:30:46 +0100
Message-ID: <4D850466.8040909@gmail.com>
References: <201103191528.34646.tboegi@web.de> <AANLkTimfk8bb-V8Br+KKpoLbA3G3y9HxyfjA=NrsgR0v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Mar 19 20:31:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q11rc-00026v-Kb
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 20:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299Ab1CSTa7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 15:30:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57664 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab1CSTa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 15:30:58 -0400
Received: by bwz15 with SMTP id 15so4168595bwz.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 12:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Jf/RV/iVRXuzg9u3fYrpLQgj+LRH1jSOxHuHh4aInqw=;
        b=czaPLIOtZ/2kIjr5xSzFJNFO+O5EQdL1wUEaq2MttWenp3N5ppJRZcMTaHArDqrTOh
         wSUB3IhojriBDQVYVzIAwYRdcXKBqfvQYQT1V9pvjfhy9b5tMJdwx9NO7lc+5+6MBoQg
         v/K81J+NOF9d7pV5Yw64HcPzJVQbSJXURXMUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=kLExOmw/vegIzsgahQFuydoVbty5/Hn2g12Rs8YyeLX4/y6/pq4D9Vf89HnQNNMv5Y
         9U1MfV/grImsqfJDx1Dst0y8qd+U+HBFjh85ne/fALKCyZ5SR2jKIYSj2uVJBKcvEhnc
         MtX/ZkTUhlYfO4CgU78ed8oqBaol1moxEPlgw=
Received: by 10.204.7.3 with SMTP id b3mr2151823bkb.160.1300563057164;
        Sat, 19 Mar 2011 12:30:57 -0700 (PDT)
Received: from [192.168.1.101] (app184.neoplus.adsl.tpnet.pl [83.26.149.184])
        by mx.google.com with ESMTPS id k5sm3105697bku.4.2011.03.19.12.30.52
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 12:30:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <AANLkTimfk8bb-V8Br+KKpoLbA3G3y9HxyfjA=NrsgR0v@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169457>

W dniu 19.03.2011 19:20, Erik Faye-Lund pisze:
> 2011/3/19 Torsten B=F6gershausen <tboegi@web.de>:
>> +       if (!(GetFileInformationByHandle(h,&hia)))
>> +               return 0;
>> +  CloseHandle(h);
>=20
> Indentation-slip?

I suspect so. CloseHandle line does not use tabs.

Out of curiosity I've roughly counted number of lines that have
correct and incorrect indentation.=20

About 8% (~12600 out of 151000 indented lines) are incorrectly indented=
=2E
Don't know if that good or bad :)


I have used following to get the numbers:

Bad indentation (includes "Correctly indented comments"):
git$ TAB=3D"`echo -e '\t'`" && grep -E "^[ $TAB]* [ $TAB]*[^ $TAB]" *.s=
h *.[ch] */*.sh */*.[ch] | wc -l
22495

Correctly indented comments:
git$ TAB=3D"`echo -e '\t'`" && grep -E "^[ $TAB]* [*]" *.sh *.[ch] */*.=
sh */*.[ch] | wc -l
9911

Good indentation (does not include "Correctly indented comments"):
git$ TAB=3D"`echo -e '\t'`" && grep -E "^$TAB+[^ $TAB]" *.sh *.[ch] */*=
=2Esh */*.[ch] | wc -l
128173


--=20
Piotr Krukowiecki
