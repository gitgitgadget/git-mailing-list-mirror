From: "Robin Burchell" <w00t@inspircd.org>
Subject: Re: Rebasing Multiple branches at once...
Date: Thu, 16 Oct 2008 16:02:38 +0100
Message-ID: <b19eae4e0810160802x3e91cf48oebe668dc1b6425df@mail.gmail.com>
References: <48F730D0.9040008@calicojack.co.uk>
	 <8663nsfxoq.fsf@lola.quinscape.zz> <48F75657.6010308@calicojack.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Rick Moynihan" <rick@calicojack.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 16 17:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqUOM-0006Lm-GS
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 17:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbYJPPCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 11:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYJPPCl
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 11:02:41 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:46588 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbYJPPCl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 11:02:41 -0400
Received: by gxk9 with SMTP id 9so8408252gxk.13
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=QSOtNFRgz1Ywj6mZris3dCZTpNMD+VuwE5Tp4gscS2o=;
        b=JtYfDVNglsxydHKv6WH2LNmUBfcKDijxlpLWW0GKKdvjaI0jGOK3Y4xvkJoA8I0osv
         iBZvBa7zhOtpRtRsckO+2fGPsssGjCPuBvw2V8owp2wR5P0Nqhz4BZCyHsDCotzuOWqn
         swNtFEXglWluqTM0zGLWjp1D3xKGTZEAcDEEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=Z/P7vn7t4geG63qXlJxlY5iyq1AbBV/j60Bfz5PGCeZ0w4EGQpD3c4s/DO0HmBuYSN
         S9LV99LVBTyU7NGKVpfMZLIRn6/ztf2lRfUwjHk9wz77W8LddG7pmewMaKUtIGWkDNEl
         L0o6IZWoM99AV2ChVI4Ji8SwGKGyiD2GqDK2c=
Received: by 10.142.44.11 with SMTP id r11mr760061wfr.285.1224169358475;
        Thu, 16 Oct 2008 08:02:38 -0700 (PDT)
Received: by 10.142.179.15 with HTTP; Thu, 16 Oct 2008 08:02:38 -0700 (PDT)
In-Reply-To: <48F75657.6010308@calicojack.co.uk>
Content-Disposition: inline
X-Google-Sender-Auth: 486678c333081914
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98389>

On Thu, Oct 16, 2008 at 3:57 PM, Rick Moynihan <rick@calicojack.co.uk> wrote:
>
> This appears to be true of the current implementation, but shouldn't it be
> possible to do this as a single operation?
>
> e.g. when the situation is this with dev being the current branch.
>
> o---o---o---o---o  master
>     \
>      o---o---o---o---o  dev (*)
>                       \
>                        o---o---o  topic
>
> Running the hypothetical command:
>
> git rebase master --all
>
> Would produce this:
>
> o---o---o---o---o  master
>                 \
>                  o---o---o---o---o  dev (*)
>                                   \
>                                    o---o---o  topic
>
> I think this can be performed right now with a rebase followed by a rebase
> --onto
>
> I can see how if there were conflicts in the rebase from dev, then you would
> need to resolve them all the way up your topic branches also.  Is there
> anything else that makes this a bad idea?
>
> R.


Rebase is indeed useful IMHO in situations like this with multiple
related topic branches when needing to pull a single fix or two from
somewhere without messy merges (especially when that will end up with
rather a lot of merge commits in history - one or so for each branch,
which is not exactly desirable).

(resent after I learned how to use 'reply to all', sorry Rick)
