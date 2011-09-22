From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)
Date: Fri, 23 Sep 2011 01:33:32 +0200
Message-ID: <201109230133.33214.jnareb@gmail.com>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org> <m3r538qj0j.fsf@localhost.localdomain> <7v4o04xjcb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 01:33:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6sm1-00025I-JK
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 01:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476Ab1IVXdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 19:33:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42963 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab1IVXdk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 19:33:40 -0400
Received: by fxe4 with SMTP id 4so3249181fxe.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=p+kfbiqLIymgeXuKY8haDM4y0gSk3ZQmtMZvyB6esec=;
        b=morCP0/bqR+s0B0B6KwdX0fTP0DiMHHumCcaH7cTToNpUyhmapFvx4cobANfhHfblN
         H8DE6r4ZmcDEJ6rporngH7RwSOAdI6bUAI291zLxR0fZmzJrj3gvh20GscVyzk/JsrvQ
         1fecn0TuVtPNfSIODdViExAtWHJ5IOYz+vNyc=
Received: by 10.223.5.76 with SMTP id 12mr3868221fau.103.1316734419192;
        Thu, 22 Sep 2011 16:33:39 -0700 (PDT)
Received: from [192.168.1.13] (abwe70.neoplus.adsl.tpnet.pl. [83.8.228.70])
        by mx.google.com with ESMTPS id t19sm9053764faj.23.2011.09.22.16.33.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 16:33:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4o04xjcb.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181935>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes: 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> --------------------------------------------------
>>> [New Topics]
>>  
>>> * jc/namespace-doc-with-old-asciidoc (2011-09-16) 1 commit
>>>  - Documentation/gitnamespaces.txt: cater to older asciidoc
>>
>> I'll need this to e.g. test the "rpm" target after adding
>> Documentation/gitweb.txt and Documentation/gitweb.conf.txt
>>
>> But it is not something very urgent...
> 
> Now I am confused. If you apply your patch on top of "master" then you
> cannot create "rpm" on your platform, not because your patch is busted,
> but because "master" lacks the documentation fix from that topic. Is that
> what you mean?

Yes, that is what I mean... but that it is only because I use old
version of asciidoc (7.1.2).
 
"make doc" (which is part of "make rpm") fails on my box with

      ASCIIDOC gitnamespaces.html
  ERROR: gitnamespaces.txt: line 9: second section must be named SYNOPSIS
  make[1]: *** [gitnamespaces.html] Error 1

> If the reason the documentation fix for "master" is needed is because a
> new feature scheduled for the upcoming release has broken documentation,
> then wouldn't we need the fix before the release, whether you are working
> on your patch or not? How can it be not urgent if that is the case?
> 
> On my boxes with recent Debian, Ubuntu, and F14, I am not suffering from
> the lack of the workaround, but if distros need the workaround, then the
> time to apply it is now, not post release.

I don't think _modern_ distributions need this workaround... asciidoc 8.4.5
which fixed the issue with "Synopsis" section was released 2009-05-24:

http://www.methods.co.nz/asciidoc/CHANGELOG.html

  Version 8.4.5 (2009-05-24)
  --------------------------
  Additions and changes
  ~~~~~~~~~~~~~~~~~~~~~

    * Added manpage "Name" and "Synopsis" section title customization to
      languages configuration files.
    * "Synopsis" manpage section no longer mandatory.
  [...]

-- 
Jakub Narebski
Poland
