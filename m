From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: Re: git-p4 and keyword expansion
Date: Mon, 8 Sep 2008 10:37:05 +0200
Message-ID: <1a6be5fa0809080137r622e9492ob72b6d2239311631@mail.gmail.com>
References: <554296.48174.qm@web95003.mail.in2.yahoo.com>
	 <1a6be5fa0809080127h5db71093o364aade2fb955acc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 10:38:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KccGH-0005DP-So
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 10:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbYIHIhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 04:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbYIHIhK
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 04:37:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:31225 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYIHIhI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 04:37:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1403576fgg.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 01:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pFQd331vwGQ+nIjXSiHZyAoWn49IzSIEEXgyOkuRokU=;
        b=lcsHA9iPsaLP6F7z01PHnrt3pXGsXIdWrPr/tO3tsuGn6gBY5+BfTKG7O//2/j2IlL
         IWgVO0Npyy+nrgexrFqiqlEmw8VOnXOr8f9xUwESQeEnedJM9q/Dd6qgrANxJ4gdHREb
         BZJhPpiCsq5+aoxSsy1/lVpWJSm7tIJBpFetI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=D/yEyOnNUXIcspA2nJ4jO0816UHfYI59EHMxIxJNL/X6l9rnJzst+OcY1pheFb+eVl
         4PcKUi7UDTLprLcv6NbOVPFz0E+Efwql+Y259WkNUOnm0iQhe0yB5t/+9Y9ufAUyYmWk
         0w7UHfSlqncz32n8H6voy+aTumKe1S4RgYKck=
Received: by 10.86.92.7 with SMTP id p7mr11069766fgb.72.1220863025432;
        Mon, 08 Sep 2008 01:37:05 -0700 (PDT)
Received: by 10.86.79.9 with HTTP; Mon, 8 Sep 2008 01:37:05 -0700 (PDT)
In-Reply-To: <1a6be5fa0809080127h5db71093o364aade2fb955acc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95230>

On Mon, Sep 8, 2008 at 10:27 AM, Tor Arvid Lund <torarvid@gmail.com> wrote:
> Hi,
>
> On Mon, Sep 8, 2008 at 6:25 AM, dhruva <dhruva@ymail.com> wrote:
>> Hi,
>>  The git-p4 script unexpands all p4 keywords before feeding it to git fastimport. When there is a new version, it records only the diffs minus the keyword contents at it unexpands and then feeds to fastimport. When trying to submit back to perforce, applying a patch on top of the latest file in p4 with the keyword expanded fails because we have not tracked that difference. Patch applying fails and expects you to manually (out of git) to do a 'p4 submit' and get back and do 'git-p4 submit --continue'.
>>  Removing the keyword unexpanding code in 'git-p4' with the following patch makes it work:
>
> Yes, I have also experienced this problem, and haven't yet come up
> with a solution to it. Your solution seems to solve the problem with
> submitting to p4, but it would also mean that files cloned from p4
> would have diffs in the git database whenever the p4 headers changed.

Hmm... Now that I think about it... Maybe we _want_ the extra diff
hunks... Personally I don't care much for the keyword expansions, but
since they're there in p4, and p4 diff shows a diff hunk there, maybe
we should just do the same. In which case your original patch might be
just fine. I realise I haven't had my morning coffee yet. Me
confused... :-/

-TA-
