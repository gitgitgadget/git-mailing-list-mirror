From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 23:15:02 +0200
Message-ID: <48178FD6.90104@gnu.org>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org> <4816CB46.1050100@op5.se> <4816D505.1000208@gnu.org> <20080429204417.GC6301@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:16:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxBE-0002Fi-PH
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbYD2VPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbYD2VPQ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:15:16 -0400
Received: from hu-out-0506.google.com ([72.14.214.226]:7837 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbYD2VPP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:15:15 -0400
Received: by hu-out-0506.google.com with SMTP id 19so179043hue.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=gNcnUPnvidize/35fZHaraOr3cY+DgxWAN5ToyK6wXA=;
        b=eXCK/IqYzbI3ptSUi2ZkwY3tJwmdQtv4TzmPW/OZ/FHRwAnzayCiEDSrQa3Mj5yEnMb+vtN4VmTf7a7K1a9lkaBu3pgcc3/ggcXTo8lupdljiqQVMvuw0qvJ4f57U62bM3Z1dO1Gr39ecNvU2aeEJK1JG2Pc7iHrggSZ/q3Sd1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=vhObnoyXY+86IkP9lur1pa+rFOJmVIGiXExTEMzboyXzlerlQQNoqIFFFedOL0K8forYLgN+i7xTu/H0VchfgC49oJSYTiwPUH58T6ALoK7stGjfGDcGIlmCkwhTOdeuKEJcJ3VWcS4PownFjBIOEP7/E1h3TfipBBexoiKTfao=
Received: by 10.86.79.19 with SMTP id c19mr383969fgb.19.1209503711211;
        Tue, 29 Apr 2008 14:15:11 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id e11sm44360fga.1.2008.04.29.14.15.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Apr 2008 14:15:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <20080429204417.GC6301@steel.home>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80735>

>> 2) the patch does not touch refs/heads/* unless you are tweaking your  
>> configuration (and quite heavily so).  IMHO that's using enough rope  
>> that you really ought to know about the reflog and... look for backwards  
>> incompatible changes in the release notes!
> 
> Since when do you depend on people reading release notes and
> immediately and correctly changing their behaviour?

I don't, that's why I never expected all patches to go in 1.5.6.

I sent them together to provide a single coherent series and an aim for 
a transition plan -- which I'd prefer to work out with the git 
community, who knows the release mechanics much better than I do.  Jeff 
King's reply to the cover letter is a start towards that; your e-mails 
are also a start towards that, even though I don't think your transition 
plan is feasible (also because it would break "git remote update" 
completely).

>> 4) one man's stupidity is another man's... [fill in]  In particular, did  
>> you understand the rationale for this change?  Do you have any  
>> alternative ideas?
> 
> Do you have a convincing one by now?

See the (long) cover letter.

> And an acceptable transition plan?
> ("Read RelNotes!", yes, you mentioned. Another one?)

See above.

Paolo
