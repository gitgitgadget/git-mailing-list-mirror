From: Joshua Juran <jjuran@gmail.com>
Subject: Re: What is the scenario for a commit with 3 or more parents
Date: Thu, 29 Jul 2010 11:10:45 -0700
Message-ID: <C77AA970-4288-487F-9568-E86CF776FCED@gmail.com>
References: <AANLkTikMRa_LrD2fU9Piv3GW2H0r7Jf_9s5iM0wc9t6s@mail.gmail.com>  <20100729021946.GG25268@spearce.org> <AANLkTik-wOB-iEGK8EnW1Rdk9wwc1E86tYoBU26WepYJ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bradley Wagner <bradley.wagner@hannonhill.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 20:10:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeXZG-00045c-P4
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 20:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab0G2SKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 14:10:49 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42474 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab0G2SKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 14:10:48 -0400
Received: by pvc7 with SMTP id 7so219018pvc.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=ous5z2fIUSi22lipb3tIIsyCwQSljEdbpPvs8X6JDXg=;
        b=BY3DeropQDOvoVEWgQaL/yWiGfQmPzBJnIvkI7+H46bPkbsAv7vGI1+eeUirhcWxeB
         z8le9pF6UacVrnVKAVgEIQ8EHYxJGnlG4Q9Aa74gJp/YeWu7U4KcPoiJaeew0DprMpbp
         Q5iZvNISYDTea9UgAICB6LNXA5I1FZ7Tb8s4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=mYbzoRuQF49u/I3IdbyNJ/g33AY3Z9Pb9yX6xYSUs21n64BJ34+RHsH0TT6K1pzEGS
         A8B3xXDe+aPs45X/flDpOBVl2u1sofcez+SNelHJn5STk08ZLJEmL67K1i/+nsdfn/6X
         SdNN6r0hqEFC4OJbdJipH/R1nIGAWQHHVdmBo=
Received: by 10.142.156.14 with SMTP id d14mr487164wfe.248.1280427047572;
        Thu, 29 Jul 2010 11:10:47 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id 23sm1325903wfa.10.2010.07.29.11.10.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jul 2010 11:10:46 -0700 (PDT)
In-Reply-To: <AANLkTik-wOB-iEGK8EnW1Rdk9wwc1E86tYoBU26WepYJ@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152191>

On Jul 29, 2010, at 10:55 AM, Sverre Rabbelier wrote:

> Heya,
>
> On Wed, Jul 28, 2010 at 21:19, Shawn O. Pearce <spearce@spearce.org>  
> wrote:
>> Yes.  Its called an octopus merge.  It happpens sometimes when
>> merging 2 or more otherwise fairly isolated changes in a single
>> shot.  E.g. `git merge feature-a feature-b thing-c`.
>
> Do we have an explanation anywhere as to when one would use a  
> octopus merge?

How about if you had two (or more) components with a shared protocol,  
and you updated each to speak a new (and incompatible) protocol.  The  
changes to each component might be done in separate topic branches,  
but you'd want to merge them all at once.

$ git checkout master
$ git merge client-v2 server-v2

Josh
