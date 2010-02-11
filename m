From: Jakub Suder <jakub.suder@gmail.com>
Subject: Re: git-subtree.sh - regression introduced by da949cc55
Date: Thu, 11 Feb 2010 14:26:23 +0100
Message-ID: <508e1531002110526u623bffbdi119d009a7af460b8@mail.gmail.com>
References: <20100211130837.GA29916@lonquimay.wrk.lsn.camptocamp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Marc Fournier <marc.fournier@camptocamp.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 14:26:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfZ3u-00022A-Oy
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 14:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab0BKN00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 08:26:26 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:10244 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab0BKN0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 08:26:25 -0500
Received: by fg-out-1718.google.com with SMTP id e21so304675fga.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 05:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=KCmAFzqOZTpbA1HlLQOyveljIR5GUkD+xdJJLm2QMZk=;
        b=kHoDil+d+OHR2V66U3bm12GoVs9OQIBEyyBNHC7STfZnwS8Az2y6CzOKK7ehdAak/Y
         mAAw6ReulVLwknchnil4r6BIM4WmI2EFIlmZu5vo8mmiGCul9beXYrE/WzAwBfDQqUk0
         gdRnkuWNysOFG1e+xb6vJ0lK2+ieg3oQvExqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bYIiK5nMBW27SxSOTbIk8QVGlKh2ITvTjBViW5hBuWl0z3c7k41gptjm2SgmyaXMXT
         XYjo4fZ+nVvoeDV8bQrb/e/thB/wF3914a6ujMKwpb20MXo/hLk6M7N34X5gsX04TN7P
         qKL1iLpW+u1PrZts/MFns7iFIVVPO5ISEHm94=
Received: by 10.102.15.38 with SMTP id 38mr1321235muo.60.1265894783604; Thu, 
	11 Feb 2010 05:26:23 -0800 (PST)
In-Reply-To: <20100211130837.GA29916@lonquimay.wrk.lsn.camptocamp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139588>

On Thu, Feb 11, 2010 at 14:08, Marc Fournier
<marc.fournier@camptocamp.com> wrote:
> Jakub, I'm not sure I understand what this patch is supposed to fix. Could
> you provide an example ? Or a test case ?

Hi,

there is a test case for the change you're talking about - it's near
the end of test.sh, between "check if split can find proper base
without --onto" and "check_equal ..." (it was added a few commits
later). The problem was that without this commit, in some cases if I
called subtree split for an external project which was earlier added
with git subtree (in order to backport some changes to the original
project) it didn't create the new commits on top of the existing ones
like it should (just look at the test case).

I'll take a closer look at this in the evening...

Jakub Suder
