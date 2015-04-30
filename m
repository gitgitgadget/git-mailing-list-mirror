From: Dan Langille <dlangille@sourcefire.com>
Subject: Re: forcing a user@ into the URL if not present
Date: Thu, 30 Apr 2015 16:14:12 -0400
Message-ID: <CABU7BddHuiYK4s+_+Z9v15D+Nj8icMQSWNY13TZ77wq8Vo6r+A@mail.gmail.com>
References: <CABU7BddjAZOk0LyybQ8phO0S4705MrZtLSYEsjzUBKUD=H++RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 22:14:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynuqh-0000Z0-1R
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 22:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbbD3UOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 16:14:14 -0400
Received: from na6sys009bog019.obsmtp.com ([74.125.150.78]:58005 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751360AbbD3UON (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2015 16:14:13 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]) (using TLSv1) by na6sys009bob019.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVUKNFOvGd/QPAUR/rlQeqDFa2rzI5EQZ@postini.com; Thu, 30 Apr 2015 13:14:13 PDT
Received: by iebrs15 with SMTP id rs15so76594179ieb.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sourcefire.com; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=/shVuggnx0ub9kZhhIcJqhJr47duem5UxrO6/yfgoOg=;
        b=Bwk5wJCaKPjh11+LSzsdG5cKaZwbaZLrerGZ++VIizACWj96v5myzQP/ibhFfwFkFE
         JkHKLtxDlCFNq+A0SxBLznTLvnqN9VeAxIOvimxPgLG8/i1UJ32MJHm1VFMjsWJkktrb
         3o01yE//7Z0Oh4BMTPqXjYAICJhYsqQ4hf7bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=/shVuggnx0ub9kZhhIcJqhJr47duem5UxrO6/yfgoOg=;
        b=J21RKV/C0eofXxIfWC908GhVkwbhrutdjf+MK/IB8+gMMdn1amy1H12yxzaDccP3oc
         4DEAnKCkm2yqyXiclUZCW+LvsOWfpdX5PVxclFS0dv1JoIw/sW1di/j+VaAwy/+YRPMn
         4baEU+0Z5Dq/mUmiqX2h8lp2M9E1QboWBwNJQ4JKWLH0A5FoyS3IZywA4o4A2ySPL+Vw
         WfoKuJJIyxd7tc/kZc8gr9c4+gmswsd8WP0gIM/cjqSu4WT4o1XIsns5GsTFnn+WZ3fv
         yKSdftBEIJgH5PqHjUilze37NwSYkHWNIv1Z4wTOSSns5knjU0SxatJ1HldpRVCGSx7i
         BnOw==
X-Gm-Message-State: ALoCoQmsKe+mPRlasMzEvEJJ9EEsd0B5vGs04tcZ/oYeW4IphfUS3GUQnCTZM/OzvvEZzqqPm8WrIAGDjnylLywZWeZpD+Ahlvtv8JbniR84Q+QvNKjXgAuxs9XZR+m5XJ4b2iH35x52SMcdXMJypa+8ndKdTm4rfw==
X-Received: by 10.42.213.136 with SMTP id gw8mr11187240icb.95.1430424852628;
        Thu, 30 Apr 2015 13:14:12 -0700 (PDT)
X-Received: by 10.42.213.136 with SMTP id gw8mr11187236icb.95.1430424852554;
 Thu, 30 Apr 2015 13:14:12 -0700 (PDT)
Received: by 10.107.137.95 with HTTP; Thu, 30 Apr 2015 13:14:12 -0700 (PDT)
In-Reply-To: <CABU7BddjAZOk0LyybQ8phO0S4705MrZtLSYEsjzUBKUD=H++RQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268105>

Would this question be better suited for another list?

On Wed, Apr 22, 2015 at 4:06 PM, Dan Langille <dlangille@sourcefire.com> wrote:
> Hello,
>
> I'm using git 2.3.2 with Kerberos for authentication and gito-lite for
> authorization.
>
> This works:
>
> $ git clone https://dvl@ repo.example.org/git/testing
> Cloning into 'testing'...
> warning: You appear to have cloned an empty repository.
> Checking connectivity... done.
>
> My goal: have it work without supplying dvl@ as shown here:
>
> $ git clone https://repo.example.org/git/testing
> Cloning into 'testing'...
> Username for 'https://repo.example.org':
>
> I don't want to be prompted for a password.  I want Kerberos to kick in.
>
> Following http://git-scm.com/docs/gitcredentials, the following seems to
> have nil effect.  Anyone used this feature already?
>
>   git config --global credential.https://repo.example.org.username dvl
>
> $ cat ~/.gitconfig
> [credential "https://repo.example.org"]
> username = dvl
> [http]
> sslCAInfo = /usr/local/etc/trusted-certificates.pem
>
> With the above, I still get prompted for a password
>
> Given my use of Kerberos for authorization, is this option feasible?
>
> Should I be taking a different approach?
>
> Thank you.
>
> --
> Dan Langille
> Infrastructure & Operations
> Talos Group
> Sourcefire, Inc.



-- 
Dan Langille
Infrastructure & Operations
Talos Group
Sourcefire, Inc.
