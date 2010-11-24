From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #02; Wed, 17)
Date: Wed, 24 Nov 2010 22:30:44 +0100
Message-ID: <201011242230.44920.jnareb@gmail.com>
References: <7v1v6je9g8.fsf@alter.siamese.dyndns.org> <4CEC6E2A.9080605@kernel.org> <7vpqtutzkp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@kernel.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 22:31:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLMve-0007Hd-3l
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 22:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab0KXVa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 16:30:57 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59465 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab0KXVa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 16:30:56 -0500
Received: by fxm13 with SMTP id 13so183244fxm.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 13:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hz1IRnZtdTZuv8udnWDE/zyWvCM57gS5o5xrbPTZFRk=;
        b=TzmZh64ambUk5WzIKko/bmYbj/H9yO0syEJCMGhy2EvpvIheMEPdE2f6Szy+2IBMeK
         M9R19g2v2slN8WopB9YADEzRj0z/wXWoCngt+3CWsB6tPDLUKos2tQ4QF2509jInC0x7
         HTKv/3sLIWd8dCWB1KXWrM96Ql9gKUAfbQhD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=r4sVvGCJieDolduTVgeS8ZLenVQum3OQ3sNvOrqf+OwJ5c2sK8oKfrNbvyUiZz/SLf
         PbRADlwuWSe/mMkpEPtEsL1rh9aGj1tKwkdQBsP2HXJcrcLHJmTBDlCrh7ZZeYcvR+On
         OLJ1zpziI85ICDme6slCNOfh5npMHRchBvAfA=
Received: by 10.223.122.146 with SMTP id l18mr640817far.67.1290634255386;
        Wed, 24 Nov 2010 13:30:55 -0800 (PST)
Received: from [192.168.1.13] (abwq109.neoplus.adsl.tpnet.pl [83.8.240.109])
        by mx.google.com with ESMTPS id e17sm2377838fak.34.2010.11.24.13.30.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 13:30:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vpqtutzkp.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162088>

On Wed, 24 Nov 2010, Junio C Hamano wrote:
> "J.H." <warthog9@kernel.org> writes:
> 
> > While I don't disagree, being able to support other caching systems
> > would be nice, we have this now, it's tested and it works.  I'd argue
> > this is a step 1, step 2 case at this point.
> 
> I would have to agree; getting some cache layer that is known to work (you
> are battle testing your updates on a busy site of yours as you develop,
> right?) early, quick and dirty with minimum changes, is more beneficial
> than waiting for a large rewrite thats "gets it perfect this time".

I also agree, that's why I'd like to go the "minimal fixups" route, where
those minimal fixups are about caching being robust (loading cache.pl,
passing minimal tests), not penalizing non-cached case (moving check for
$caching_enabled out of cache_fetch), and make it possible to move to
better solution / other caching engines in the future while maintaining
backward copmatibility (configuration is API; $caching_enabled, perhaps
also $cache (is 'cache.pl') and %cache_options).

> > I'm currently working from on top of Jakub's last tree, though I've got
> > some questions about his reasoning on a few things now that I've been
> > digging into it.
> 
> Thanks both for keeping the ball rolling.
> 

-- 
Jakub Narebski
Poland
