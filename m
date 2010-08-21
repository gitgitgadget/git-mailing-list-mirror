From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [feature request] gitweb: tags in history
Date: Sat, 21 Aug 2010 19:21:21 +0200
Message-ID: <201008211921.22495.jnareb@gmail.com>
References: <20100821092616.5e57135b@hyperion.delvare> <20100821111555.11879d02@hyperion.delvare> <AANLkTi=JHzQm4hm-nuTyZq2CL_2z785KtMvVcmaqtgyF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jean Delvare <khali@linux-fr.org>,
	Git mailing list <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 19:21:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmrlA-0003Jj-Or
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 19:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab0HURVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 13:21:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64859 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab0HURVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 13:21:30 -0400
Received: by fxm13 with SMTP id 13so2322374fxm.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rjXEoXXKTfwAF5spjvOrvHUihGWzFTcxES/Vj+OZ08U=;
        b=PtLrLKk+3dLpM3Rd727d/riMO03SvbbwtPTney5/a7dRG3AtmID2UvvWPfnSvOUZOp
         8Kk355sBeSBSGFD3UXoyP4DiqA8VxI3+SvId0x5aH6mu+0vzCPxmOttPVjmeXOLnx97y
         Cjo6aERj3iDjNUNpCDZujUUcevncNN384gyl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cam45tx6Ubxu9onvfFT9BCH4s34cRzbCNdFneMi49suYEJ9IBuz44uGAi9ZdjsETBI
         hty8rwsmjbNiIXJys7OP/bJI4gRhIjSa7hR9eEzSKnWbWymRkHLrjpIHsmG/58wVc/3i
         M2l5zzagw8GCwpiIcHZwTY/5zEviMsk3VTblU=
Received: by 10.223.103.148 with SMTP id k20mr2302808fao.101.1282411289045;
        Sat, 21 Aug 2010 10:21:29 -0700 (PDT)
Received: from [192.168.1.13] (aeho172.neoplus.adsl.tpnet.pl [79.186.196.172])
        by mx.google.com with ESMTPS id p2sm1683403fak.22.2010.08.21.10.21.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 10:21:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=JHzQm4hm-nuTyZq2CL_2z785KtMvVcmaqtgyF@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154146>

Lars Hjemli wrote:
> On Sat, Aug 21, 2010 at 11:15, Jean Delvare <khali@linux-fr.org> wrote:
>> On Sat, 21 Aug 2010 01:22:05 -0700 (PDT), Jakub Narebski wrote:
>>> Jean Delvare <khali@linux-fr.org> writes:
>>>
>>>> I have a feature request for gitweb. In the history view, I would like
>>>> to be (optionally) able to see the tags, interlaced with the actual
>>>> commits. The idea is to get an immediate view of all commits that
>>>> happened between specific tags.
>>>>
> ....
>>
>> But shortlog is a repository-wide view, while I need the same for
>> history which is a file-specific view.
> 
> <shameless plug>
> With cgit, you can answer such questions by combining path limiting
> and range queries, e.g.
> http://hjemli.net/git/cgit/log/scan-tree.c?qt=range&q=v0.8.2..v0.8.3
> shows all commits affecting scan-tree.c between v0.8.2 and v0.8.3.
> Maybe gitweb could implement something similar?
> </shameless plug>

Gitweb also supports range limiting in log-like views from some time,
but currently there is no UI for that, and you have to handcraft the URL,
e.g.:

  http://gitweb.example.com/repo.git?a=history;f=foo.c;hpb=v0.8.2;hb=v0.8.3

or (in the path_info form)

    http://gitweb.example.com/repo.git/history/v0.8.2..v0.8.3:/foo.c

-- 
Jakub Narebski
Poland
