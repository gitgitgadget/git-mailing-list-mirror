From: "Peter Harris" <peter@peter.is-a-geek.org>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Mon, 8 Dec 2008 13:40:02 -0500
Message-ID: <eaa105840812081040s1036b79an9914c1f74d6d7f6a@mail.gmail.com>
References: <493A6CEC.4060601@tuffmail.com>
	 <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>
	 <493C1F36.7050504@tuffmail.com>
	 <eaa105840812071230l5e8d54bcg21b36019711bc3cd@mail.gmail.com>
	 <493C47FD.4080302@tuffmail.com>
	 <493D1CC2.8050407@drmicha.warpmail.net>
	 <493D66BB.3060907@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>, git@vger.kernel.org
To: "Grzegorz Kossakowski" <grek@tuffmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 19:41:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9l2v-0007Si-Ks
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 19:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbYLHSkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 13:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbYLHSkG
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 13:40:06 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:54611 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbYLHSkE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 13:40:04 -0500
Received: by yw-out-2324.google.com with SMTP id 9so513112ywe.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 10:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=6v0UytKefjPvJpAb/CKt0Nsxw9MmKQpr35E6jKy+9PI=;
        b=ADz6NMDqJHpsX8/L7I5Q9SzKm2WPUDHr9VC5CgwnVbJFOCUYv5f4WId/E78G7QQKxD
         xqj79bKD5N9hP0UxTIW+e23Asnvs/9cdlkZ2G9D6dKMxmuWJXx4+lnsux0rGfltvQise
         nRUFUOEjnyPBthENFPjoXheM8eA08W8JLhxkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=t6td1h2TtULvVXjynSVE3uKLFcF5954viWYMw6T31fAGtNAaE0v7VIlgeUiNRV8Ao0
         PexT7dAPlmR9n2Z3zC06ZITcvlFVK/Uro4js2on5ZVro1/6K2/gIcZs6FAsNXt3Xvb6V
         HVAupm3w7x1oqDlhWAzvXFBTR9cM7LDFPZqKU=
Received: by 10.65.137.5 with SMTP id p5mr3100299qbn.7.1228761603068;
        Mon, 08 Dec 2008 10:40:03 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Mon, 8 Dec 2008 10:40:02 -0800 (PST)
In-Reply-To: <493D66BB.3060907@tuffmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: e1311af0a5324370
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102572>

On Mon, Dec 8, 2008 at 1:26 PM, Grzegorz Kossakowski wrote:
>
> After doing that git svn rebase resulted in:
> [really long list of revisions]
> r707379 = f61a2d30b6ac5a5136b46fa2b9b5b91e4763feb1
> r710118 = 40997fe552e8581b75b08fed41a6b63a33d58bdf
> r720135 = a8160766ec40fd7ebf95bfa7cebfa50dfa2f9c3a
> r720180 = b094a222bab3671c8277087e7a96589ec76dd5e4
> r720182 = 736b8ed6519c64ad120de2ccf08f135062ee09db
> Done rebuilding .git/svn/origin/trunk/.rev_map.13f79535-47bb-0310-9956-ffa450edef68
> Current branch master is up to date.
>
> Is this expected output?

Yes. The rfoo = sha1hash part is git-svn rebuilding its index.
"Current branch master is up to date" is git-svn calling "git rebase
<svn-branch>", and git saying that there is nothing to do, since there
have been no svn commits to that branch since the last time you ran
git svn rebase (or since you cloned the git mirror, or since the last
time the git mirror pulled from svn).

Peter Harris
