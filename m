From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: Re: How to create tags outside of refs/tags?
Date: Tue, 22 Feb 2011 17:21:37 +0100
Message-ID: <AANLkTinTj7BehKYc15jbQzMq+q=2CfLvzTkGSJ-Ps-FH@mail.gmail.com>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
 <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
 <20110222080305.GA11177@sigill.intra.peff.net> <7vvd0cebi6.fsf@alter.siamese.dyndns.org>
 <20110222081458.GA11825@sigill.intra.peff.net> <m3wrks756a.fsf@localhost.localdomain>
 <20110222152723.GA23353@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 17:22:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pruzz-0007wh-5d
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 17:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab1BVQV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 11:21:58 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47732 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497Ab1BVQV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 11:21:58 -0500
Received: by qwd7 with SMTP id 7so2998940qwd.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 08:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=sd5Q2rhMq2re3x17dcIYYI00kjKE4gW/1ATJm69R/0I=;
        b=F1D8uqmFGKPh4nLIkOQ5Wnr988aDj4/jX3clTY2QRl1k3qQHrTEvseT955uvJVZDZ7
         Ebkys01wjAIqCTJ/ttI/evzTCdYwzoe1AI54toMIB2QJfZcHYr6ekRKGHLNZETsUIjvU
         lK/v+wrTSEME8g3PHOuHchCqgGAgc8PqaRcHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=EVnuptu4rOQs0CS+qypyU8P3Tcsqug2Z13UrAjnj1Bdpa53fJNLWNeXsrqyiaj8D8e
         3ywx38Ra/wO9fzaDa+nPFZvrJtTdddPoxrZf1qvqham0pgf2GLJomda6xcsqj9js3bY3
         +U3jqJX62Ma+VFAWNHdgCRHMOZqADb84VNlJI=
Received: by 10.229.188.68 with SMTP id cz4mr2181608qcb.261.1298391717199;
 Tue, 22 Feb 2011 08:21:57 -0800 (PST)
Received: by 10.229.50.6 with HTTP; Tue, 22 Feb 2011 08:21:37 -0800 (PST)
In-Reply-To: <20110222152723.GA23353@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167561>

On Tue, Feb 22, 2011 at 16:27, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 22, 2011 at 02:09:14AM -0800, Jakub Narebski wrote:
> refspec. But I stand by my statement; if this feature is something we
> want, it should be purely about listing tags. I don't want to get into
> weird tag-specific config affecting the what we push. If somebody wants
> negative refspecs, that can be a separate patch.

I am not sure whether what is discussed now is really solving my
problem best. Maybe I rephrase again the problem I have:
I just want to make sure that certain commits are not garbage
collected. And the artefacts I create to ensure that should not
pollute the namespace of developer-created tags/branches. Is creating
a tag and then hiding it again really the best solution for that?

Here is some background: there is a tool developed in our company
which helps teams to release their git-controlled products. The
release tool gets as input just a commit ID. Whenever the release tool
has succesfully done his work on a product it wants to make sure the
this commit will never be garbage collected. Even not if month's later
the product owner resets all their branches making the released
commits beeing unreachable. And since some projects may run a lot of
attempts until they finally released some stuff we don't to have our
tags namespace to
be polluted with too many attempt-to-release tags.
