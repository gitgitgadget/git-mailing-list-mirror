From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Wed, 11 Jun 2008 23:51:17 -0700
Message-ID: <832adb090806112351t44a4495fsa72c0c98e9eab3fd@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
	 <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>
	 <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
	 <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>
	 <7v1w34dfn3.fsf@gitster.siamese.dyndns.org>
	 <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>
	 <7vwskwbz63.fsf@gitster.siamese.dyndns.org>
	 <832adb090806101724k6199694ftbbc6ed151489a6e3@mail.gmail.com>
	 <20080611124634.GA26729@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Jun 12 08:52:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6gfO-0000KZ-Jq
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 08:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444AbYFLGvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 02:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbYFLGvU
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 02:51:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:30376 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740AbYFLGvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 02:51:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2384642fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 23:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Eh1hkArrnbeHSwTAR0AyqQJueC38P+3lfmdU0SxdqZ4=;
        b=vV06pkulST2iXKMui3+XwoQI10IhjN+QS5X+7n6Ma93l92DC3YlHCxQCcDXWjb+//x
         KAJhWKCv7yXZ4apu10ceGmzfuQD4PBNqmeFrZpQanVgctfiz3qQB8M0EmTg4CWmW62Zs
         g4ev2PPR1bpRGA+i6pQ6JVorewOQ1Ty1BvTls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OBQHCyJyWson5mKAl8UkmItER4fMeHsBJbRIr4qRgVmzwrEgAIWKQPTRx/wKX7KYZ1
         zZKIynsUsi18lum0PwHaM9Uq2xIEDvcJ2NuzoKv4gUTskCjqrLr0M3KSZK9ONRbNSi7p
         6F011D2dbouSGcEabteNze6IJk8dr4SfBAuJ4=
Received: by 10.86.70.8 with SMTP id s8mr1577019fga.79.1213253477276;
        Wed, 11 Jun 2008 23:51:17 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Wed, 11 Jun 2008 23:51:17 -0700 (PDT)
In-Reply-To: <20080611124634.GA26729@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84724>

Thanks everyone who replied. You know, I was a bit apprehensive about
posting originally, because I had heard the git ML was inflammable.
But all these responses have been prompt, well-thought-out and
informative.

I plan to take all these suggestions and have a go at hacking a
race-free index which updates successfully despite concurrent file
operations.

Thanks again,
-Ben

On Wed, Jun 11, 2008 at 5:46 AM, Stephen R. van den Berg <srb@cuci.nl> wrote:
> Ben Lynn wrote:
>>That is problematic. How do I figure out what the filesystem thinks is
>>the current time? I could touch some file and read its mtime, but I
>>want a shortcut.
>
> That basically is as short as it gets, except perhaps statting a freshly
> modified file (not necessarily by oneself).
>
>>Are there any guarantees of any kind? e.g. is the filesystem current
>>time at least never ahead of the system time?
>
> Practically no guarantees, just that it is rather likely for the time at
> the fileserver to progress at about the same pace as yours.
> --
> Sincerely,
>           Stephen R. van den Berg.
>
> Differentiation is an integral part of calculus.
>
