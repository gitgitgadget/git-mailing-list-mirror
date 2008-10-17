From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: Re: commiting while the current version is in conflict
Date: Fri, 17 Oct 2008 09:21:52 +0200
Message-ID: <2d460de70810170021q5daa902er1e6e2fb6633400ec@mail.gmail.com>
References: <7vy70of6t2.fsf@arte.twinsun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Junio Hamano" <junio@twinsun.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 09:23:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqjg0-0006Db-BX
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 09:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbYJQHV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 03:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbYJQHV4
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 03:21:56 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:23728 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbYJQHVz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 03:21:55 -0400
Received: by an-out-0708.google.com with SMTP id d40so26639and.103
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 00:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BVNHJazCfc1M6YLiM3e6jv63PEVaP2EdJLetFP47Njs=;
        b=obW88+xBacW3ayb0gnj0LCP/y/fKLXtRV2spZEWqtfmy6CPZgpKQVpprMpijsN4jVt
         QBf0CZSXI5lyfRrjLVQrB6s7AdsbV/li854o96ywIEabt/PT1ywUx9YBlbTw9JOb9KIQ
         /Jz/guvuefz+ye0dVvwIev6pmKYTONmgzB9EU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Uly3jaiAktGsmvxtUye0ATiZ4i729w6XydE4Dezycnjffqu+UU8ws6rxfrIRfLTBZ/
         70Hs01JnvPJN9qH3sEKxH9mu+rY4zOU6Oin8HdyGQwTkFqzo3PA/MSLba8Ff2SLc6sq+
         OeBz08ZG5BjmlCKF8PNuX9KmfanlWAHex2m9M=
Received: by 10.100.138.17 with SMTP id l17mr4922687and.65.1224228112635;
        Fri, 17 Oct 2008 00:21:52 -0700 (PDT)
Received: by 10.100.43.19 with HTTP; Fri, 17 Oct 2008 00:21:52 -0700 (PDT)
In-Reply-To: <7vy70of6t2.fsf@arte.twinsun.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98452>

On Fri, Oct 17, 2008 at 01:39, Junio Hamano <junio@twinsun.com> wrote:

>  (0) You are wrong to assume that git does not keep conflict
>     information; we can tell if the index is "unmerged" to see
>     if you still have unresolved conflicts;

That information is already lost at the point when the
pre-commit hook is executed. Thus, I more or less had to
arrive at the wrong conclusion :)


>  (1) When the index is unmerged, git-commit will stop even
>     before getting to pre-commit hook, so there is no point
>     for pre-commit hook to check if the index is unmerged;

I realize this, now.


>  (2) pre-commit hook is a last ditch effort to help ignorant
>     users who have already done "git add" without thinking and
>     lost the "unmerged" state.  It has to look at and guess at
>     the contents for that.

Ignoring the ad hominem attack, I would argue that the two
distinct mental concepts of 'I want to commit this in the next
commit' and 'I have resolved this conflict' should have two
distinct commands.
To err is human, which is why rm -i exists. Else, you could
just use alias rm='rm -rf'.

Also, within certain boundaries, a tool should adapt to the
user, not vice versa.

In my opinion, a pre-add hook which is able to warn the user
that something they are about to add is still in conflict would
be best. The one piece of feedback I had up to now was
very positive.


Richard
