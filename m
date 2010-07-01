From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH v5 2/4] Introduce "double conversion during merge" more gradually
Date: Thu, 1 Jul 2010 22:25:01 +0200
Message-ID: <531FFACB-CBEA-4BC6-B831-CC7C6F954DB5@gmail.com>
References: <cover.1277974452.git.eyvind.bernhardsen@gmail.com> <3ae294ef30c3539da47d101bc39638e63721eb0e.1277974452.git.eyvind.bernhardsen@gmail.com> <4C2C6BC5.1030905@viscovery.net> <7v630z41ao.fsf@alter.siamese.dyndns.org> <D2F8C67C-F7AE-4523-870F-879B741C2591@gmail.com> <m3iq4znnfr.fsf@localhost.localdomain> <20100701185712.GA22421@pvv.org> <m3aaqbnemz.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.orgList" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 22:25:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQJt-0007Gu-Hp
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817Ab0GAUZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 16:25:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50045 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab0GAUZF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 16:25:05 -0400
Received: by wwb24 with SMTP id 24so224364wwb.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=HNqPqBg92zLXeTxg1wdjqV4HiOltSGhxVPmGRBE1kg8=;
        b=TuMQqe3pNw4lGv3ntGdtq2x3jC3oXYfAA7Yl/JUCL3QCl839H2ZNnYFXHzSV3yd4iO
         3RbByPih7jZ89CZopP8gjhhLPODpv/G3rwudZ2N2f76Nj4pcwEak1KiFl+6qh1Cbk14y
         /K/FAxfvmAgGw8gvaCDNwpKZTzFwDUkxikkF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=nEX4QnRmdWm/h37reHvfuKnZHKKfMnXl4UdVLwicGzBBvBalzyc7wKLq66kJsFwEE8
         0KdAuoeQF7gB4IX9f+I5GiuEFUuQ1/+f7rI5sFyJUNue6PGkF8TCaWw2VK0VQdPvisyC
         3uc70lmuGVlSODp1YzK2THiHF+A8o8y7CRTik=
Received: by 10.213.32.141 with SMTP id c13mr24889ebd.22.1278015903422;
        Thu, 01 Jul 2010 13:25:03 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id v8sm320780eeh.20.2010.07.01.13.25.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:25:03 -0700 (PDT)
In-Reply-To: <m3aaqbnemz.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150080>

On 1. juli 2010, at 22.15, Jakub Narebski wrote:

> Finn Arne Gangstad <finnag@pvv.org> writes:
>> On Thu, Jul 01, 2010 at 10:05:17AM -0700, Jakub Narebski wrote:
>>> What about `merge.renormalize' ;-) ?
>> 
>> Best so far! Or what about "merge.canonicalize"? Sorry for bikeshedding :)
> 
> Perhaps `merge.regularize'?  Or `merge.normalizeToWorkTree'?
> It is about converting to worktree version according to current
> settings, IIUC...

Almost, it's about converting to the _repository_ version according to current (that is, merged) settings.  Since the content is already in repository format it needs to be converted to the worktree version before it is converted back, hence Junio's "doubleConvert".

"merge.renormalizeUsingMergedGitattributes"?
-- 
Eyvind
