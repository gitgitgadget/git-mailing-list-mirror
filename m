From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: .git grows after git-gc?
Date: Tue, 24 Apr 2007 15:35:30 +0100
Message-ID: <200704241535.32623.andyparkins@gmail.com>
References: <200704241431.33624.andyparkins@gmail.com> <alpine.LFD.0.98.0704240939360.12375@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 16:36:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgM7f-0002QP-Fp
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 16:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161778AbXDXOgA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 10:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161780AbXDXOgA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 10:36:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:53398 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161778AbXDXOf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 10:35:59 -0400
Received: by ug-out-1314.google.com with SMTP id 44so192204uga
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 07:35:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=J27V2hHIcPKdnl5IZ8HMdUuAFTOxhjGI6nn2G7OXZc7mKx+v+TmCo6p6k/daCBAGr+uyX5WnD472nW3bW2A0mjliAuPsVQNZcCQZc53gR+jZHUwL5sDgyKcbuiMpWQuVKOurwJ4Ko8raK+1iDuj2/osQhhvmtund2tMc6sP5WIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Nh5GiY+NrF6/YUjWCMJpUzC9BrJiBHRbmW9zyGoNS53phP6CvzoXrLnKHcrxr5t/gEoBRyVMqMZO3SoMgqneadU5TF3P+S3xDXX2FjXvTdbHpfDwPhPoIKasUOtIIiXhOemRxTEHCSrvn2pnqgKFVYrb77lw9i3Rr5x1dh2NOxQ=
Received: by 10.82.148.7 with SMTP id v7mr3980757bud.1177425358183;
        Tue, 24 Apr 2007 07:35:58 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y37sm64865iky.2007.04.24.07.35.48;
        Tue, 24 Apr 2007 07:35:56 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <alpine.LFD.0.98.0704240939360.12375@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45453>

On Tuesday 2007 April 24, Nicolas Pitre wrote:

Thank you for your thorough explanation.

>    Now when you repack, this parameter won't be used by default unless
>    you have repack.usedeltabaseoffset set to true in your config, which
>    will cause a small increase in pack size.

That sounds like it could easily be it.  I thought I had usedeltabaseoffset 
turned on ages ago; but it turns out (while investigating this strange 
behaviour) what I actually had turned on was "usedelatabaseoffset".

Doh!

> I think that (2) is the most probable cause of repack growth in your
> case.  Just try:
>
> 	git config --global repack.usedeltabaseoffset true
> 	git gc
>
> and you should get that 2MB back, possibly a bit more.

Strangely enough - I didn't - stayed at 97MB.  It's probably (1) then.

Thanks for your time.  You've helped me find a typo in my config even if I 
didn't get my 2MB back :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
