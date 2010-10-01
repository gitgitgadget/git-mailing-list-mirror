From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Allow gitweb tab width to be set per project.
Date: Fri, 1 Oct 2010 23:02:45 +0200
Message-ID: <201010012302.47269.jnareb@gmail.com>
References: <1285673709-24924-1-git-send-email-magnus@hagander.net> <201009291122.01272.jnareb@gmail.com> <AANLkTimPte3eQMuCE3NTS=03Vv+Q2-nnu8BmXq=4YCbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Magnus Hagander <magnus@hagander.net>
X-From: git-owner@vger.kernel.org Fri Oct 01 23:02:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1mkh-0001iL-7N
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 23:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756232Ab0JAVCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 17:02:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37685 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817Ab0JAVCj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 17:02:39 -0400
Received: by fxm14 with SMTP id 14so901402fxm.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 14:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FSoEZ9csXugRV4KvnIeUbN06dvgpWdbiISezvrttRK0=;
        b=a/1g+fVgMqDYSolIhA4Nh0pjOmZMea7hZ13vdJqAiiNe/9M2PCWO3/6hiPtTZeUMha
         J8iw2aNQpesobtezkmSxCGVbh3f+SlAhs/0M6C4xhaRdcSeNSgRaXhl3kQfEhmwe4WIF
         IY0H0GaXisVDZkKTwGdezPc3K46ELkqlqYW5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=NHNKRp+ydoC4MQ7PEKYqwmKtsGamLw1ZzwILPhaXtgze7aBAFC2xff2pFi+tP8EG1U
         QTX7fweLYp4Kro3N+Yh+BmlrEDtYNHvXdo72WRMAWmvChboIBuegx2RER+TUt6li0odY
         sz3b7Uvj+0si6M0yjblrkqZo7sB4nsJKGsaeQ=
Received: by 10.223.116.68 with SMTP id l4mr5978319faq.98.1285966957648;
        Fri, 01 Oct 2010 14:02:37 -0700 (PDT)
Received: from [192.168.1.13] (abwo184.neoplus.adsl.tpnet.pl [83.8.238.184])
        by mx.google.com with ESMTPS id a6sm864057faa.44.2010.10.01.14.02.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 14:02:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimPte3eQMuCE3NTS=03Vv+Q2-nnu8BmXq=4YCbA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157781>

On Fri, 1 Oct 2010, Magnus Hagander wrote:
> On Wed, Sep 29, 2010 at 11:22, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Wed, 29 Sep 2010, Magnus Hagander wrote:
>>> On Tue, Sep 28, 2010 at 14:25, Jakub Narebski <jnareb@gmail.com> wrote:
>>>> Magnus Hagander <magnus@hagander.net> writes:

>> Nevertheless it is a good practice to check if a change passess
>> appropriate tests from git testsuite; t9500-gitweb-standalone-no-errors
>> should detect this.
> 
> Good point. Now I just need to figure out how to be able to run the
> tests :-) I guess I should just set off a job to build the whole tree,
> and then it will just work..
 
To test other parts of git, you need to first compile, and then run tests
(e.g. by running "make test" after "make").  Gitweb tests check the 
source version (for historical reason, namely that there were no gitweb
target in main makefile, and gitweb didn't get compiled by default),
so in that case you need to compile git once (to satisfy test suite),
and then run e.g.

 # (cd t && ./t9500-gitweb-standalone-no-errors.sh)
 
from the top directory of git repository.

>> P.S. If it is not a %feature, we might want to add description of
>> gitweb.tabwidth to the "Per-repository gitweb configuration" section
>> in gitweb/README (as next to last item)
> 
> Ok. Will add that. Want me to send a new patch with these things included?

Yes, please do.

-- 
Jakub Narebski
Poland
