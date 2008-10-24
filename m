From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 22:30:47 +0200
Message-ID: <200810242230.49238.jnareb@gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <alpine.DEB.1.10.0810241254330.27333@asgard.lang.hm> <cb7bb73a0810241313o341febccgbea1cd59b25b9cc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "David Lang" <david@lang.hm>, "Junio C Hamano" <gitster@pobox.com>,
	"Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 22:29:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtTHa-0003RS-TM
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 22:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930AbYJXU1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 16:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755161AbYJXU1n
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 16:27:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:54040 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811AbYJXU1m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 16:27:42 -0400
Received: by ug-out-1314.google.com with SMTP id k3so286681ugf.37
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dNYuUcjstQMyeu6TvsUiBhWQpSu/CcrM+ubGIge1FG0=;
        b=YyMopCs+JnxePHDRnM2tztdwH8yVeVQhs8USO8GTUcMCmFjVxmSHD8XJYReyH9HYXB
         FrulRljzxhPNjNkxgptQkm97wh+nNKFgWgSTjQaR0BS4xl9ybqAV3lYy1j0cxwN1Rqsr
         Nc3RghrClUdCdPFAYOU7I5N3IK9WrnQ8ePpxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=W8K1W0UeKZomXhXO1eNvevyKTTU4yjKuSeGMwV0ocZO7XmUP6f4lMT2zjpjVwHPEen
         vMKNYphK3BlvWIUa9CvXgLSAy0BTfoeotTdPVDUhNgbRmjo+zpoSnF2vNgAMQALCsBXU
         Q4rJR64lGRgfxn69Y6DXo+JZbTa+wxPwKsTOA=
Received: by 10.67.19.13 with SMTP id w13mr1044676ugi.35.1224880060133;
        Fri, 24 Oct 2008 13:27:40 -0700 (PDT)
Received: from ?192.168.1.11? (abwm208.neoplus.adsl.tpnet.pl [83.8.236.208])
        by mx.google.com with ESMTPS id y6sm75661uge.25.2008.10.24.13.27.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 13:27:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810241313o341febccgbea1cd59b25b9cc4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99063>

On Fri, 24 Oct 2008, Giuseppe Bilotta wrote:
> On Fri, Oct 24, 2008 at 9:54 PM,  <david@lang.hm> wrote:
>> On Fri, 24 Oct 2008, Giuseppe Bilotta wrote:
>>> Zit does
>>>                echo "*" > $GIT_DIR/info/exclude
>>> and yes it sucks to use a whole block for a file that only contains
>>> one character. Suggestions welcome.
>>
>> can this be configured in the config file?
> 
> Yes, the file pointed at by the config key core.excludesfile is read
> too, so we could have it point at $GIT_DIR/zitexclude, which would
> allow us to spare a block. The most space saving would be achieved by
> a core.excludepattern or similar key, which would allow us to get rid
> of the exclude file altogether.

Well, with all zit repositories in '.zit/' directory (similar to RCS/)
you could have point core.excludesfile to _common_ '.zit/excludes';
the pattern doesn't change from zit repository to zit repository?

You could even use per-user ~/.zitignore (I'm not sure if git expands 
'~' in paths; there was some patch for it, but was it accepted?) or 
system-wide /usr/lib/zitignore or /usr/libexec/zitignore file.
-- 
Jakub Narebski
Poland
