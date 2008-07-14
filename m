From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [RFH] Finding all commits that touch the same files as a specific commit
Date: Mon, 14 Jul 2008 13:17:09 +0200
Message-ID: <bd6139dc0807140417h7c9cd309g7cf911e78e7f78c5@mail.gmail.com>
References: <bd6139dc0807120858vc058451lb10933b5225c8521@mail.gmail.com>
	 <7viqvavao4.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0807130743y178a865amebcf130a68283854@mail.gmail.com>
	 <alpine.DEB.1.00.0807131929200.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailinglist" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 13:18:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIM4N-0007Fc-BN
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 13:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848AbYGNLRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 07:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756506AbYGNLRK
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 07:17:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:60414 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbYGNLRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 07:17:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4824972wfd.4
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 04:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sh35GJ9ioao1mO5C4YnJasdxxlmwVRC0jJQVdnL2Whs=;
        b=iAcDLc0lAWP3zbwBzSuxlY00Uem0B59zj1hT/NGQk54yFodFqNxkfeP2Ha6gMaZ1Xj
         J/0xc3/fi9xGlKpOIPIUcGsm3Rd80kaL5lKBCXpGuc4jEaE9D4926gCQckjEItzaz/WL
         XHpVwprnU9TJ8EAYEHOsJNdAWrSbCj+f0yTFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=n+hNGyTqwHjcnRptGpNa6Di2U4ThR3v4I4lCYrSkuk5+RMB4rolKxnTa+kQBOPRWbv
         nskf5Vc88kTg2eVM4IQAvauoxShczwSNIWXiNkxILAgadx3BgsLLbw4a/SeUrVDPEo5f
         2YNPAV7sWSPTb+uGFcImSRuFtaBZ1soMnYFUc=
Received: by 10.142.116.13 with SMTP id o13mr4168743wfc.210.1216034229177;
        Mon, 14 Jul 2008 04:17:09 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Mon, 14 Jul 2008 04:17:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807131929200.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88409>

On Sun, Jul 13, 2008 at 8:30 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 13 Jul 2008, Sverre Rabbelier wrote:
>> On Sun, Jul 13, 2008 at 3:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> > The data structure the revision traversal machinery uses does not support
>> > this "path-per-commit" natively.
>>
>> Would it be possible to go for a slightly less complicated approach
>> and instead of passing replacing the tracked file, append it?
>
> Maybe I miss something, but do you not have to keep track of the file
> names, in order to keep track of the proper statistics?

Hmm, no, this is just to get commits that touched a (set of) file(s).
I use it to limit the commits I have to check when searching for
reverts.

> If that is the case, appending does not cut it.

For the activity metric I think pretending that all files with the
same name or renamed versions of those would make sense, which is what
appending the new name would do. The downside is that all files with
the same name get grouped together, I'm not sure which is the lesser
of two evils. Leaving out information, or (possibly) including too
much.

-- 
Cheers,

Sverre Rabbelier
