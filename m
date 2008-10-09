From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/RFC] Add post-init hook
Date: Thu, 9 Oct 2008 13:34:27 +0200
Message-ID: <81b0412b0810090434x41d11f18s4fd7a15d812b3ba3@mail.gmail.com>
References: <1223421033-22340-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <20081008015352.GA29313@coredump.intra.peff.net>
	 <57518fd10810080116gd876f9bv169f575087baccd7@mail.gmail.com>
	 <20081009014146.GA14204@coredump.intra.peff.net>
	 <7viqs2ovte.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Jonathan del Strother" <jon.delStrother@bestbefore.tv>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 13:35:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kntnw-0006iA-ES
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 13:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472AbYJILe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 07:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbYJILe3
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 07:34:29 -0400
Received: from rn-out-0910.google.com ([64.233.170.188]:61037 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340AbYJILe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 07:34:28 -0400
Received: by rn-out-0910.google.com with SMTP id k40so1473636rnd.17
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 04:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LGADl5DnVfXMdrtXBIRbjVRsxYnWB054fgtQsiGPjbc=;
        b=kBs94pLPdzmhabm6y8QGpn2W3p7H89neoiXGGpOmAk+2TWuTzTWQbMBEtuaPkoqjpX
         xmdQBHGZPekMZpo1aJ4SCSs1ey9Dxcv4ZQXMMIrAsYssmwBtH66grKXpTr9t0LAb8h/g
         R5il0CCaEmOzv3JJXkESS8/UK0Pi7dOu5lu/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AVyu2+2S38uQyxWzEf5tr8cPsklQCIQj0skPNFHhdHfw9KKOaw8PRzZXYRVV95hbfn
         dJdpYlcIiMJPVY+72VuHjhYT1epqIQHHOWj95V4Ucy5Vs2HSnZ7gEx6IXf72MROqfFQI
         TYzER65lC3EHhPCPZVm0QVG5AjP7H2FJfGxGw=
Received: by 10.100.210.9 with SMTP id i9mr3621703ang.132.1223552067686;
        Thu, 09 Oct 2008 04:34:27 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Thu, 9 Oct 2008 04:34:27 -0700 (PDT)
In-Reply-To: <7viqs2ovte.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97844>

2008/10/9 Junio C Hamano <gitster@pobox.com>:
> Jeff King <peff@peff.net> writes:
>> On Wed, Oct 08, 2008 at 09:16:56AM +0100, Jonathan del Strother wrote:
>> ...
>>> I want symlinks so I only have to edit my hooks in one place whenever
>>> I change them)
>>
>> This makes a lot of sense to me as a best-practice. I wonder if we
>> wouldn't do better to add a core.symlink-templates option?
>
> AFAIR, "git init" copies symlinks in templates as symlinks, so I do not
> see why you would even want to have such an option.
>
> Wouldn't it be better if users and installations with such a special
> set of templates specified by core.template or --template prepare a
> template directory with files and symbolic links of their liking?  If
> they want some hooks to point at the latest copy of installation specific
> standard hook script, templates/hooks/$that_hook can be a symlink to the
> real location, no?

It will be replaced with a file next time you update your git installation.
Seems like we need ~/.gitconfig/*...
