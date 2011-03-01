From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without pathspec
Date: Tue, 01 Mar 2011 11:36:35 -0800 (PST)
Message-ID: <m3oc5u7hy9.fsf@localhost.localdomain>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
	<7vei6t4uwa.fsf@alter.siamese.dyndns.org>
	<AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
	<7vy6512rnb.fsf@alter.siamese.dyndns.org>
	<AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
	<7vk4gkk5pd.fsf@alter.siamese.dyndns.org>
	<vpqipw2rixy.fsf@bauges.imag.fr>
	<7vd3maelbh.fsf@alter.siamese.dyndns.org>
	<vpq4o7mfzd1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	=?iso-8859-15?q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:36:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVNH-0008FV-TL
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 20:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab1CATgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 14:36:39 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49277 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498Ab1CATgi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 14:36:38 -0500
Received: by fxm17 with SMTP id 17so5158575fxm.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 11:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=7E1ZDEUH8lWsIuHCpLNTk5kh+g5jYRsUMcpEK+1Nz04=;
        b=TEf3GyI86n9oW9MbxJEz+IHBCQdNseg/JPxyowe6GSwpKRkfRUyvIh0g3IvPTzrjlx
         7LuHRAgZlifmRgH3zsZ52zL5GEzZNXQq0ql1VMB5p6KuTf5q+TVXrlvDPq41z97bNpGH
         yL35DihGqJtbK2Qqo1ucZI8Qv0+T6B4YgFEUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=hub9vj0jRXDKKp278mL/bm6GuO4wnk4e6+OLayYhT0Azaj3lu55vfdrc1fl2VjysQ0
         5BrXDYoKmbGkG7oXzkgpLcVIr0c0Whn+YGLFXYmXU8U//xvDMug2bwXnVVSVLVXIEeVh
         grwg+7NkHZ13t0TcnJDQ54LKThaRqE3A596qc=
Received: by 10.223.79.7 with SMTP id n7mr8735478fak.71.1299008197489;
        Tue, 01 Mar 2011 11:36:37 -0800 (PST)
Received: from localhost.localdomain (abvt248.neoplus.adsl.tpnet.pl [83.8.217.248])
        by mx.google.com with ESMTPS id n2sm81860fam.28.2011.03.01.11.36.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2011 11:36:35 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p21JZX1L029424;
	Tue, 1 Mar 2011 20:35:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p21JYtHa029418;
	Tue, 1 Mar 2011 20:34:55 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <vpq4o7mfzd1.fsf@bauges.imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168243>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> Junio C Hamano <gitster@pobox.com> writes:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

[...]
>>> So, a warning like
>>>
>>>   warning: the behavior of "git add -u" without pathspec will change in
>>>   Git 1.8.0. To keep the current behavior, use this instead:
>>>   
>>>       git add -u .
>>>   
>>>   + explanations about the config options as already discussed here
>>>
>>> would be fine.
>>
>> Yeah, I think you convinced me that an elaborate configuration wouldn't
>> help us at all.  We just keep warning in 1.7.x series when "add -u" didn't
>> see any pathspec, and flip the default at 1.8.0
>>
>> Simpler and cleaner ;-)
> 
> I think is still makes sense to have a config variable, so that people
> who want the new behavior can get it ASAP. Right after 1.8 is out, I'll
> still have machines where I'm too lazy to install a brand new Git, and
> I'll want to get the 1.8 goodness for free ;-).

So it would be the opposite of compat.*; for example `future.wholeTree`
config variable? ;-)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
