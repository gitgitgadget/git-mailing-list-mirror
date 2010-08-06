From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git server eats all memory
Date: Fri, 06 Aug 2010 04:34:11 -0700 (PDT)
Message-ID: <m3r5icnfgk.fsf@localhost.localdomain>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
	<AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
	<AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Kanis <expire-by-2010-08-10@kanis.fr>,
	Avery Pennarun <apenwarr@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 13:34:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhLBs-0004JX-HO
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 13:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761259Ab0HFLeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 07:34:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46587 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987Ab0HFLeO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 07:34:14 -0400
Received: by fxm14 with SMTP id 14so3759248fxm.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 04:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=twEQDuNHhN4t90l4wS3ZXgYeggroCeA8fN969D55D7s=;
        b=EXaPY8vJowiqMoCAhzgcgebE5MhhddJD8TuWAppFPZmNetCCAp9B/aHDmlaXHhEOLJ
         EzRov4HHoftdKMhHhSVC617sFxec0O39SqrvMcQqdyrgzeeAKShNhjpR0dfCUJ1NF0kV
         D95Soo4ekZL4dyjTv+fD7enTGoPb8zUKubpcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=KOpQ8cTzZvL+iHM7JBGVR1gf7QxC5J4/kJcmuC9h4jdIkH+jT95qSwAz8LYj9asaqQ
         kyrV5Kw6yXz9crEz7xffXKkLpsYMuEEo6EP6RY9GxFTKWJkLFDtKrFXJ9GSWEgtg9UTF
         EFpGsxcovjn5jcGBTSVM4MUaaVgRV9m4PyBOI=
Received: by 10.223.118.211 with SMTP id w19mr5986474faq.19.1281094452710;
        Fri, 06 Aug 2010 04:34:12 -0700 (PDT)
Received: from localhost.localdomain (abvc105.neoplus.adsl.tpnet.pl [83.8.200.105])
        by mx.google.com with ESMTPS id r27sm586069faa.0.2010.08.06.04.34.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 04:34:11 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o76BXWht013797;
	Fri, 6 Aug 2010 13:33:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o76BXGcn013751;
	Fri, 6 Aug 2010 13:33:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152775>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> On Fri, Aug 6, 2010 at 11:37 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> On Thu, Aug 5, 2010 at 4:33 PM, Ivan Kanis <expire-by-2010-08-10@kanis.fr> wrote:

>>> I am ready to do whatever to diagnose the problem. I know C pretty well
>>> and am ready to look into it but I am not sure where to start.
>>
>> Try "git pack-objects --all --stdout > /dev/null" on the repo on
>> server to see if it uses the same amount of memory you saw in cloning.
>> You can then try debugging that command if it does.
> 
> Naah, git pack-objects needs list of commit tips. Try
> git for-each-ref|cut -c 1-40|git pack-objects --all --stdout > /dev/null

Nitpick: git-for-each-ref has `--format' option, no need for `cut'.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
