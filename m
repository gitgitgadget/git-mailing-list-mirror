From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: error out when the "upstream" semantics does not
 make sense
Date: Thu, 5 Apr 2012 14:58:32 -0500
Message-ID: <20120405195832.GA6885@burratino>
References: <7v8vib6pu8.fsf@alter.siamese.dyndns.org>
 <20120405124706.GA3921@sigill.intra.peff.net>
 <7v1uo26ue9.fsf_-_@alter.siamese.dyndns.org>
 <20120405184345.GA6448@burratino>
 <7vlima5591.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 21:59:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFsq0-0003EQ-IZ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 21:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515Ab2DET6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 15:58:45 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55262 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562Ab2DET6o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 15:58:44 -0400
Received: by gghe5 with SMTP id e5so968073ggh.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tAFBXU6XcDPbqYT05OJXvvTmpdZQDmAacod6U1Quywo=;
        b=0yxcyF3YSd0owDae4wrEm48mGtkvktSPDvtlipyPVQZamfT/GUBvVgj8FKXlXrCFu+
         oSclg5W9M1Mf7fY7ODDfyAnKuuiOq7LDsxP+XLdDYzMRxWG/+eA51oKrqxKFm3n1Nv0+
         suyLiHDMn2ND1qP28pfVn9SDkwVV1Nk5bNcSzWY+mzUh+kBV4U3bN3oWwqMqWVSN7MDQ
         Q5ghtzK4nETA8le5DTWaSf3K2UuuQmf5HfsiRkNe97tAKfv+R29pPWvlEDj3DMqdHg07
         zaQKLJUkpy6TtOefQNV9NoQRoyc34PzPGDOm/CfwthlnqliqPdkDd+/5HhFYhkB0NLmm
         2dTw==
Received: by 10.60.18.198 with SMTP id y6mr5823855oed.38.1333655923668;
        Thu, 05 Apr 2012 12:58:43 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vp14sm4126398oeb.5.2012.04.05.12.58.42
        (version=SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 12:58:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vlima5591.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194802>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Maybe something like
>>
>> 		die(_(
>> "You are pushing to remote '%s', which is not the upstream of your\n"
>> "current branch '%s', without specifying a refspec.\n"),
>> 		    remote->name, branch->name);
>>
>> would be harder to misunderstand.
>
> Perhaps.  Do we need to rephrase it without using the word 'refspec'
> (e.g. "without telling me what to push"), or there is no point avoiding
> jargon because other jargons (i.e. 'remote' and 'upstream') already appear
> in the sentence?

"without telling me what to push" sounds good.
