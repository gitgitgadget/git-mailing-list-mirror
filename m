From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Reproducible crash in git merge
Date: Tue, 29 Mar 2011 19:40:20 +0100
Message-ID: <201103292040.21419.jnareb@gmail.com>
References: <AANLkTimxHn_fwMKh9cbp9i5LkShUi=HK44nv2KJ7ENaQ@mail.gmail.com> <m3pqpcv5ph.fsf@localhost.localdomain> <7vr59s1lzu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: David Gilman <davidgilman1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:40:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dqJ-0005EQ-2O
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580Ab1C2Sk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:40:27 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59419 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1C2Sk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:40:26 -0400
Received: by wwa36 with SMTP id 36so536550wwa.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=40nurFhxQsJQsRGbzp9y+zt3FkNFoNAkZ14gEvpwq6o=;
        b=ZEK2qAMeikRa0gTk7IB89FEsqxKK/KzgwNcdZxWqSjoN7lbO/aVHWmSKkoPD8dzwNr
         eEtofpZpiLl2zGFkl+IxX+rMxvlAjluGKdJ71oa14Fw59ZbXZbpeVmUNS8rHgAT62U+n
         lcLQAT3IoiGadm2wrDyDiQ3wA2vjOIdNoV1OI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EIi3z0u6jHK77GEwFy6nFykfg1IloQquVPc3rpCTESZtmnou2XoDYJMRFjNILrMtMJ
         liqEccYRWwfbQp5lBLMoNbHn4TMpnOVrUIpYAxweZ/Rh8wFgVrvSeFcNUSMWKdmmqQqj
         cLBtuuGIJ/uDyjYsBAmDBuDkgmD+iTAwn0MJ8=
Received: by 10.227.11.146 with SMTP id t18mr155517wbt.104.1301424024689;
        Tue, 29 Mar 2011 11:40:24 -0700 (PDT)
Received: from [192.168.1.13] (abvv241.neoplus.adsl.tpnet.pl [83.8.219.241])
        by mx.google.com with ESMTPS id bs4sm2575709wbb.52.2011.03.29.11.40.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 11:40:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vr59s1lzu.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170302>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > David Gilman <davidgilman1@gmail.com> writes:
> >
> > > Unfortunately I can't share the repo itself because of its contents.
> >
> > Does anyone remember the script that can be used to anonymize contents
> > of repository that cannot be made public for debugging purposes?
> 
> That might help in certain narrow other cases, but I suspect that it is a
> way off tangent in this case, after looking at the stack trace.

I'm sorry, I didn't examine stack trace...
 
> The process is dying inside the platform implementation of memcpy of
> inflate from zlib; unless the bug is reproduceable independent of the
> contents, any modification done by contents anonymizer is very likely to
> make this particular issue go away, don't you think?

Well, assuming that issue is involved with sizes and not content, then
possibly as long as anonymizer preserves sizes of objects.  Which is not
very likely.

Anyway, from what I remember this heisenbug vanished mysteriously...
-- 
Jakub Narebski
Poland
