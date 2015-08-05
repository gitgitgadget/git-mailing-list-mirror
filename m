From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Error pushing new branch: value too great for base (error token is...
Date: Wed, 5 Aug 2015 13:53:19 -0400
Message-ID: <CAPig+cTXO3699MdqSFVDBcnKcHAT=Mkp=c=r3C8F5nT8tfr6gw@mail.gmail.com>
References: <CAGDgvc3Gxn=pKBfYC+yrUhCmL9X6bqjPVwVokF0qPsXmhx_EaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gaurav Chhabra <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:53:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN2sW-0005Sj-4v
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 19:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbbHERxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 13:53:20 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33628 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbbHERxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 13:53:19 -0400
Received: by ykoo205 with SMTP id o205so41955597yko.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bnIjbat9ZVemuCIOhmEHzE7d19M/Ebm+v8yDxrbF9JM=;
        b=FNB+hXs1LzFxwH25Da38MOvfDbFoPaAvZ6Nzoktgk8Qr5FSOjhn4yZdU7FgKegUgf9
         uiUcJ8EpEtwr8DgbrvST6QNFbSaKIqTxoCBoW+ekhrhVG3I+DqMwFDtB7rsqabsCoJAv
         b0c6lAYn+jbRzKzCVS1K79WjmmQffjogm8JPVbzZzqfiHDCrBAWGb6VU4O1JInsXUJC/
         Kl11FvlttZ0iCWIcUw6Kc76iIn1u53YP2erzMe1nEIv8Y2FMVsIRb+ZpqzG1q+vLep73
         bJY91opqIhZ2NPFeqcuUXHSE24NcA36ZDKqebA6owBe1hqYrfDyZW5e9MSiC/E3y2KfP
         bACg==
X-Received: by 10.170.88.212 with SMTP id f203mr10489224yka.34.1438797199125;
 Wed, 05 Aug 2015 10:53:19 -0700 (PDT)
Received: by 10.37.48.193 with HTTP; Wed, 5 Aug 2015 10:53:19 -0700 (PDT)
In-Reply-To: <CAGDgvc3Gxn=pKBfYC+yrUhCmL9X6bqjPVwVokF0qPsXmhx_EaQ@mail.gmail.com>
X-Google-Sender-Auth: hPIjPG0x5qlRdz6dVML8SpJZzpk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275384>

On Wed, Aug 5, 2015 at 1:32 PM, Gaurav Chhabra <varuag.chhabra@gmail.com> wrote:
> I had written the following code to check whether a push is for branch deletion:
>
> #!/bin/bash
>
> NULL="0000000000000000000000000000000000000000"
>     if [[ "$new_sha" -eq "$NULL" ]]; then   # Line 17
> remote: Stdin: [0000000000000000000000000000000000000000]
> [9226289d2416af4cb7365d7aaa5e382bdb3d9a89] [refs/heads/rel-a]
> remote:
> remote: hooks/pre-receive: line 17: [[:
> 9226289d2416af4cb7365d7aaa5e382bdb3d9a89: value too great for base
> (error token is "922628
> 9d2416af4cb7365d7aaa5e382bdb3d9a89")
>
> Although the new branch gets pushed to remote but i'm not sure why i'm
> getting this error and how can i fix it. I checked online and i get
> few links where folks had similar issue but in each such case, the
> error token was 08 or 09. I still tried the suggestion of using "10#"
> in front of my $new_sha variable but to no avail.
>
> Any suggestions?

Yes, try using the string comparison '=' operator rather than the
numeric comparison operator '-eq'.

    if [[ "$new_sha" = "$NULL" ]]; then
