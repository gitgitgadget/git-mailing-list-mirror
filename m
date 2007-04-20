From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Do not show progress meter while checking files out.
Date: Fri, 20 Apr 2007 13:37:18 +0100
Message-ID: <200704201337.30836.andyparkins@gmail.com>
References: <11770585393395-git-send-email-junkio@cox.net> <1177058540390-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 14:38:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HesNS-0003Nu-Km
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 14:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992683AbXDTMiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 08:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992689AbXDTMiI
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 08:38:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:23645 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992683AbXDTMiF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 08:38:05 -0400
Received: by ug-out-1314.google.com with SMTP id 44so889879uga
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 05:38:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GR6xPQceVaZy4Z2wGofrzLoLh3yunS+CjMPoiiCZ/tlBvRK7lCCUXtgEjULP5hPD/YVMu6ADOInXp9BZQNH9c8VdlpnUVVyg1AU0w/mHlQcrCLidkGzwcCtq/XKAcK3d4CFQbVdJIcqXxwIXGZdsZ0vDijmwDw7WGg6FEsdLba0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dX4CuezD4oOrr3DNjuHHarft/kLvCcE3ZRC7EURRPB6Q1z8SQKoIQrKG9/xausxOvv5BZWcXrg1Tc/hJePV6wReV9645L2LvOTyJZf4TicdXw0/Flaztiqvn7zX5NX3E8xHlhZN0T1cJFGqeva29FfxAjGNINya3Cmn1i1VFGEY=
Received: by 10.82.107.15 with SMTP id f15mr4528462buc.1177072683135;
        Fri, 20 Apr 2007 05:38:03 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c22sm55249ika.2007.04.20.05.37.48;
        Fri, 20 Apr 2007 05:37:57 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <1177058540390-git-send-email-junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45097>

On Friday 2007 April 20 09:42, Junio C Hamano wrote:
> Originally I thought it would take too long to check out many
> files and to prevent people from getting bored, I added progress
> meter.  But it feels a bit too noisy; let's disable it.

Don't do that.  I like it.

I think you need output like this not to prevent boredom but to reassure that 
nothing has crashed or gone wild.  A checkout of a big project really can 
take time, so it's nice to have the feedback.

Incidentally, the other place that needs some sort of feedback is the 
beginning of git-fetch/git-push.  I think they are off listing remote 
branches, but they don't output anything before they do it, so I have no idea 
where the delay is (actually I know that the delay is from forming the ssh 
connection - which seems to be unable to understand that I'm connecting over 
a VPN and my IP has no reverse DNS so don't check for it - grr - but the 
point is that nothing is (apparently) happening and I have no feedback to 
know why).

I'll submit a patch...


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
