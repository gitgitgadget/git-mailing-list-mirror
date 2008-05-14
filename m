From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 2/7] add push line in git-clone
Date: Wed, 14 May 2008 21:07:00 +0200
Message-ID: <482B3854.9040906@gnu.org>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org> <af57d23aca6137c1ae7702027ce3742433840872.1209391614.git.bonzini@gnu.org> <ff298458e7efc14721fdc0420432bf33efd76784.1209391614.git.bonzini@gnu.org> <7vve1yzgfc.fsf@gitster.siamese.dyndns.org> <482018E4.9000908@gnu.org> <482B0354.2060207@gnu.org> <7vhcd0oiov.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 21:08:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwMKl-00079a-O5
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 21:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652AbYENTHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 15:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757176AbYENTHX
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 15:07:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:39602 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598AbYENTHW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 15:07:22 -0400
Received: by nf-out-0910.google.com with SMTP id d3so14828nfc.21
        for <git@vger.kernel.org>; Wed, 14 May 2008 12:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=x5mdgmjKbBXoUxFUslb5PoMnmKIiM1KGpDkg3OAtCSQ=;
        b=QWd1UPEl34T2+KpKK4/JQwLrEVQSj7qzT8OuMdvK0C1N41+qztmapGZOGiBX9aal9+TmtnomEe1RRGPfAbV+Ns5sbsPCvZNC32UJcyjAempoaUQAtUbND5dji+gcy0CYUElPFO+TqrjT1I/UBoiF2GpMVEsw3OGds9zI8mFBF/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=kFq+4oUHq+zPX0spXxPRJ5xdgLSmpleLghksZetkrdqOuV+Vcviq5LIigjMBA/epABmDwk06dCIleEClPuFPHKGFJMXw3PKNgElmJWChRNEh1JA2EOxIjoILahZlW76Ax4f7ERe9Yfuth1geRfTMl4DtHMHXVRQXxxa00dskALc=
Received: by 10.125.122.19 with SMTP id z19mr738241mkm.93.1210792040324;
        Wed, 14 May 2008 12:07:20 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id d6sm1982602fga.2.2008.05.14.12.07.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 12:07:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <7vhcd0oiov.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82134>

Junio C Hamano wrote:
> Paolo Bonzini <bonzini@gnu.org> writes:
> 
>> Paolo Bonzini wrote:
>>>> Used together with [1/7], this change is Ok in a homogeneous environment,
>>>> but it would break people who use git of different vintage on the same
>>>> repository (think of a repository on a networked filesystem).  You clone
>>>> like this, and older git won't grok the push configuration anymore.
>>>>
>>>> It may look a very minor point, but I think it deserves mentioning.
>>>
>>> I think it is reasonable to require cloning with the
>>> least-common-denominator version in this case.  Think of what
>>> happened if the pack format changed.
>> Any news on this (and on 1/7, which is in pu)?
> 
> The pack-format change is a big deal and benefit everybody.  Comparing it
> with this change feels like comparing an apple and a poppy seed, doesn't
> it?

Yes, but it is the same.  Another example is when remotes started being 
created in refs/remotes/origin upon cloning.  In general, you cannot 
expect a clone to be downwards-compatible (or, you should expect a clone 
*not* to be downwards-compatible).

Paolo
