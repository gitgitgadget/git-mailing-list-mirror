From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Has there been any discussion about resumable clones recently
 ?
Date: Fri, 20 Sep 2013 12:04:15 +0530
Message-ID: <523BEC67.60003@gmail.com>
References: <CADdDZRmufDTYYxHeAuPbCUn5iQHruAOXXho5KVOQ6McfSFvPJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?c2hpcmlzaCDgpLbgpL/gpLDgpYDgpLc=?= 
	<shirishag75@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 08:34:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMuIT-00026P-6J
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 08:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab3ITGeW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Sep 2013 02:34:22 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:54547 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266Ab3ITGeV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 02:34:21 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so19980pdj.7
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 23:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TVaZXuRX8l1ViAebkFIv4jCLL2CYbLiKg4SO1+oQx6U=;
        b=YvBUkd9Xmh3GzsbNTkxYNRHegjau87AsJqFOlaWsZE87OjpDodxCbWInostlJXWky3
         tZDvgzEa1EZWHT24A1xJSimjRnTfaWNagoiA2wLWG7mhYWExEqQC8chc/XsGJJPBj36o
         IJWkgEaDO6aOzsewltNNamQpC0rPwQvOo6sgL7kOnqNqAwALyYKSftHCOJTfz/jW/7eu
         xS79za8twm8zyUQB2MDmaClmjfRw4fNrAn6E43291iGKsGb1OJ/GjngNVEEcb5xlOa18
         sn4+dFVMw0JK2bRfIFRj2I4PLWGA/DA99cNdUOnAZ0iqTayGY6kBvNn649a++E1HuU45
         4BMw==
X-Received: by 10.66.218.166 with SMTP id ph6mr7183789pac.28.1379658860961;
        Thu, 19 Sep 2013 23:34:20 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id qp10sm16754986pab.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 23:34:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
In-Reply-To: <CADdDZRmufDTYYxHeAuPbCUn5iQHruAOXXho5KVOQ6McfSFvPJw@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235061>

On 09/20/2013 04:48 AM, shirish =E0=A4=B6=E0=A4=BF=E0=A4=B0=E0=A5=80=E0=
=A4=B7 wrote:
> Hi all,
> First of all a big thank you to all for making git. With it being fas=
t
> and cheap (in relation to bandwidth and sizes for subsequent checkout=
s
> as well as CPU usage) . Please CC me if somebody does answer this mai=
l
> as I'm not subscribed to the list.
>=20
> The thing I have been failures number of times while trying to clone =
a
> large repo. The only solution it seems is to ask somebody to make a
> git-bundle and get that bundle via wget or rsync and then unbundle it

Just want to mention that if the server is running gitolite, the admin
can set things up so that this is easy and painless, either for all
repos or just some specific ones.

Such repos can then be cloned like this:

    rsync -P git@host:repo.bundle .
        # downloads a file called "<basename of repo>.bundle"; repeat a=
s
        # needed till the whole thing is downloaded
    git clone repo.bundle repo
    cd repo
    git remote set-url origin git@host:repo
    git fetch origin    # and maybe git pull, etc. to freshen the clone

(yes, I know this is not really a substitute for resumable clone; call
it a stop-gap until that happens!)
