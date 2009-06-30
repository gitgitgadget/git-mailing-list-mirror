From: Eric Raible <raible@gmail.com>
Subject: Re: RFH - git-log variant that _does_ search through diffs
Date: Tue, 30 Jun 2009 14:34:45 -0700
Message-ID: <279b37b20906301434r46e6973ftf5e5f68778f9fa1d@mail.gmail.com>
References: <279b37b20906291708g67da3a75p316ea4893f02666a@mail.gmail.com>
	 <20090630040337.GA23741@sigio.peff.net>
	 <279b37b20906301105tf92f471g6146a083ba2e2882@mail.gmail.com>
	 <20090630193135.GA4460@sigio.peff.net>
	 <279b37b20906301422w2b895afai5edf42fcbfcc7d5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 23:40:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward1.uio.no ([129.240.10.70])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLl4N-0001nb-Qt
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 23:40:51 +0200
Received: from exim by mail-out1.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLkzQ-0003mT-3t
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 23:35:44 +0200
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out1.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLkzQ-0003mQ-2l
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 23:35:44 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx1.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLkzO-0006cO-Io
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 23:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759105AbZF3Veo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 17:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758570AbZF3Veo
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 17:34:44 -0400
Received: from mail-vw0-f202.google.com ([209.85.212.202]:33358 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007AbZF3Ven convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 17:34:43 -0400
X-Greylist: delayed 723 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jun 2009 17:34:43 EDT
Received: by vwj40 with SMTP id 40so162053vwj.33
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 14:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4bQtePnmdog7gCc60M29T473uAOOVat8qu1xiy5Em+4=;
        b=XendcoJ+EBexpYPiVdE4eaLd1jjPVvRfeWKbH78+h0JbDIY0XgO8sUIjcc/vkFELBF
         gJdd5T3O+9qvOwC//lALOMDSqhBZ6m2hcb/AZ02+T54hxaJZoTkc08LHp6GksxVoPPKg
         fOdL2l99y4ycwJB/Y4exipZ3EA0GGDO/nEDv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=czSzl1RqXdwxZDhLOOlijggFKJSMt2yaCPCYrcOedFN/Xnj8tVP4YdRn/en/zmD1mi
         nHrsERJLfFXy8T5Rr/U2NHm67E2rBw+nzq+xPhs/XrWukbt3r32LM4oHxdAhZn+K0zmy
         N+FttsQXiCy4CBtWE9CaMeTsyeFpgpuUD5O1Y=
Received: by 10.220.74.2 with SMTP id s2mr7191362vcj.37.1246397685703; Tue, 30 
	Jun 2009 14:34:45 -0700 (PDT)
In-Reply-To: <279b37b20906301422w2b895afai5edf42fcbfcc7d5a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: 8420F88DF5337ED1E6751851BF79E39EF8928E20
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 156 total 2548975 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122546>

On Tue, Jun 30, 2009 at 2:22 PM, Eric Raible<raible@gmail.com> wrote:
> On Tue, Jun 30, 2009 at 12:31 PM, Jeff King<peff@peff.net> wrote:
>>
>> I think you can do this a little more simply and efficiently as:
>>
>>  git log -z -p --format='GREP: %s' |
>>    perl -0ne 'print if /^[-+].*foo/m && !/^GREP:.*dont_want/' |
>>    tr '\0' '\n'
>>
>> (though note that --format is new as of 1.6.3, I think; before that you
>> have to use "--pretty=format:"). Many fewer process invocations, and
>> less typing, though still easy to mess up.
>
> I agree that --format leads to a much prettier solution.
> Unfortunately --format seems to turn off -z (at least in msysgit):

Sorry to self-reply, but one obvious workaround is to encode the NULL
explicitly:

git log -z -p --format='%x00GREP: %s' | ...
