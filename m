From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log --graph and root commits
Date: Fri, 13 Feb 2009 08:39:08 -0800 (PST)
Message-ID: <m3wsbuthp1.fsf@localhost.localdomain>
References: <slrngp9t0u.va9.sitaramc@sitaramc.homelinux.net>
	<alpine.DEB.1.00.0902131237490.10279@pacific.mpi-cbg.de>
	<slrngpb2gl.rhg.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 17:40:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY15s-0006E4-BZ
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 17:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758310AbZBMQjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 11:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758067AbZBMQjL
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 11:39:11 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:58503 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757173AbZBMQjK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 11:39:10 -0500
Received: by fxm13 with SMTP id 13so3678214fxm.13
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 08:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=E8fkkNQGLWWzlHEIjIl0RHzxPiO52kodrCo64qOiJSE=;
        b=BktIczBkCnLOVw6mXIEJWr79cer3PPkSlF1ua3YCyvZ4UeccmYwEy9qXDGtdPWp5oe
         hsbK9ppjYT5/t5sysK2VWYBy48WwgUBI26LN8Vc0eAj0J602q0BSMm9Efv7wrhdNOYMM
         MZsNv+3kY1Zzq3f45rgSmblPZLJe+RRJGVpHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Q41LaoIETa3OvZvxDfFZduTMnyeSCPCR2oDq2teslsLGI5kbZyonxlOH2BHhmFpR12
         T2ocv0pWPNLf+BFFlHmL0rkp1YbPKbzabb85YSdVc9dDoA54JJakC4//nZRzPXejxPle
         jTpQQcQF25+pweT93+kIGXkkU2rkY4H93Hq4s=
Received: by 10.223.104.140 with SMTP id p12mr643799fao.7.1234543148475;
        Fri, 13 Feb 2009 08:39:08 -0800 (PST)
Received: from localhost.localdomain (abvs153.neoplus.adsl.tpnet.pl [83.8.216.153])
        by mx.google.com with ESMTPS id z10sm2425042fka.33.2009.02.13.08.39.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 08:39:08 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1DGd7jB015512;
	Fri, 13 Feb 2009 17:39:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1DGd6NT015509;
	Fri, 13 Feb 2009 17:39:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <slrngpb2gl.rhg.sitaramc@sitaramc.homelinux.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109758>

Sitaram Chamarty <sitaramc@gmail.com> writes:
> On 2009-02-13, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Fri, 13 Feb 2009, Sitaram Chamarty wrote:
> 
>>> I was wondering if there was any way, when using 'git log
>>> --graph --pretty=oneline' to get a different marker (perhaps
>>> an underscore) for a root commit.
>>
>> You might be interested in this instead:
>>
>> 	git log --graph --pretty=format:'%h %s%n'
> 
> It doubles the height requirement, but you gave me an idea:
> 
>     git log --graph --pretty=tformat:'%h <%p> %s' --all |
>         perl -pe '$_.="----\n" if /<>/; s/<.*?> //'
> 
> Thanks for pointing me in the right direction.

Gaaah... I tried running it on git.git :-))))

-- 
Jakub Narebski
Poland
ShadeHawk on #git
