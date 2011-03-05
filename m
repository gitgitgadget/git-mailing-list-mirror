From: Adam Monsen <haircut@gmail.com>
Subject: Re: frustrated forensics: hard to find diff that undid a fix
Date: Sat, 05 Mar 2011 06:34:55 -0800
Message-ID: <4D724A0F.7050904@gmail.com>
References: <4D71D63E.3030907@gmail.com> <m37hcd7qfv.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 15:35:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvsZv-00046h-EM
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 15:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab1CEOf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 09:35:27 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37863 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab1CEOf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 09:35:26 -0500
Received: by iwn34 with SMTP id 34so2705540iwn.19
        for <git@vger.kernel.org>; Sat, 05 Mar 2011 06:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=/LK7ITLkIKaojb34JfAKbHOIUoUvGzkLOyZD+WWWEsA=;
        b=LIe+ywnpd/NQ+SyFOlMMdGg2eKttPBUiLHjHvyllVyff/sL+m+mDyqTY5NCCVAH7xa
         btVxr2OGt2qcJC6zH5PYdtmLIOLBMWdRFg+hs4UBk374JV37OYgrTmB6fDwX5q0YrYAC
         B+0kh7IaGKoCwRtwREZ9wVyKBQ43dkalZT8W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=Crw+iDKuhruLMf4ddyKyUnHdzQi9b01Ij7jvE40n/GTJC3JpoFjSPhnuBJzZOgUqQ7
         56kxLGTSh41Wail8vuOBch4FJ+7c+yNPg3mMikpwTn+bxZgVt2KecaH2iJmfh/7e51s5
         8yyauYKvqduEUeKjBHEuQqOtuROActT6F3brk=
Received: by 10.43.61.147 with SMTP id ww19mr2293286icb.154.1299335725637;
        Sat, 05 Mar 2011 06:35:25 -0800 (PST)
Received: from [192.168.13.8] (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id xa8sm590113icb.10.2011.03.05.06.35.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Mar 2011 06:35:25 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.14) Gecko/20110221 Lightning/1.0b2 Thunderbird/3.1.8
In-Reply-To: <m37hcd7qfv.fsf@localhost.localdomain>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168499>

Jakub Narebski wrote:
> By default "git log -p" and "git show" considers merges uninteresting.
> Try "git log -p -c" or "git log -p -m".

Holy cow, that's a lifesaver! Thank you, Jakub!!

I totally missed the whole "Diff Formatting" section in the git-log(1)
manpage.

"git log -p -c" does exactly what I want. I'll make an alias or
something for these options.

I'm confused by this section of git-log(1):

  COMBINED DIFF FORMAT
    "git-diff-tree", "git-diff-files" and "git-diff" can take -c
    or --cc option to produce combined diff. For showing a merge
    commit with "git log -p", this is the default format; you can
    force showing full diff with the -m option.

Sounds like this is saying that -c is the default with "git log -p".
I'll submit a patch to fix that.
