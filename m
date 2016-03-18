From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] Code reorgnization
Date: Fri, 18 Mar 2016 07:28:22 +0700
Message-ID: <CACsJy8Bt211aSusEZ0xTDS96ZQgCjrMi-sDmZXkz_jCuUnkcTA@mail.gmail.com>
References: <20160317111136.GA21745@lanh> <CAGZ79kbcwFcPSJ9xwE6xi4gQ871m3brtfAut2TChGNzL-foxdQ@mail.gmail.com>
 <xmqqy49gzzrf.fsf@gitster.mtv.corp.google.com> <20160317214355.GA32317@serenity.lan>
 <xmqqh9g4zsf8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 01:29:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agiHj-0004f7-Ss
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 01:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbcCRA24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 20:28:56 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:32903 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcCRA2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 20:28:54 -0400
Received: by mail-lb0-f181.google.com with SMTP id oe12so78884861lbc.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 17:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qpb84SyL/o4zwgnKkaD4/0+18Zx3t5wN+x/HYSwjOnU=;
        b=BU8lSHTcv6e8RM7OnZfYEZ735wvzGzsETAXTpQuIkVlkswHmDs4gGMvNvoZUPS/6VP
         cSgbp+bmXmK6U7CBYN92ce5IEW2IAEtiMlnBIRgCZ4bw6LlGMFZgPU7bQXxdp+5DwfNZ
         B5uvOqA7IkNVPUvwMz8jLRlTHr3nmr9ow4xjLpYdPwAzTrvMnFs/u4athzChlgZlHCNw
         MsP/MuBSGVWG51LP8TnN3T79N4e1BJyKHRpsRIhliLlGps2PwLRXG/9Jh9Spt8MGDf3P
         ROmpPRAj39RZ5zs+qgm6Dr5qJKVbZBNir2pb0Mi7TKd9wZgEhzA86ufvrdnjV5+kYeG3
         t7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qpb84SyL/o4zwgnKkaD4/0+18Zx3t5wN+x/HYSwjOnU=;
        b=W9W5XPiE/uPdCyUGEaauTtTfs2qRc30b5yPdMYGuyuKalaRhNhdRad6bfjHWPoY2gy
         vPROQiUlrAVBxgUy0K0/BHdXDwHLNgPwfG81wXfKO2GHASu4tt1tW4Frx3EB6qo7nQvU
         zP/3n2J19uaxkJXtAZlJOhnOiz53dECNfwcA15Ujql323e6qpT37KKO1oLiEXLCdLh4t
         iafSoTIsOXVHIIuC2iWNLTgGAMwKbGSUTRJGchOD/K8t64TPRDqV9dkkIks7fhoWBqLF
         ohKzN5NxRvQFP4rEOwr43FV/AjTK2GrkQvsTaIRepGhYkRdC/d60+6jwtlb27eJWpYx9
         AddA==
X-Gm-Message-State: AD7BkJJWVX2V+rryVv30F6trdGtaw2iXJw1F7WauPxHdTg6CJrR5vjr6ZVHmvBuNNiaV5tTxOkDf266H/+UtpA==
X-Received: by 10.112.150.133 with SMTP id ui5mr4611090lbb.12.1458260932035;
 Thu, 17 Mar 2016 17:28:52 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 17:28:22 -0700 (PDT)
In-Reply-To: <xmqqh9g4zsf8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289175>

On Fri, Mar 18, 2016 at 4:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> The organisation of the git code shouldn't make a difference since CGit
>> just links with libgit.a, even if it does CGit pulls in git.git as a
>> submodule so it can just fix any problems in the same commit that
>> updates the submodule reference.
>
> I was mostly worried about where Duy and Stefan want to place *.h

*.h stay with their *.c. CFLAGS has two more -Isrc and -Ilib. I don't
expect any #include line changes. Maybe we can start moving stuff to
"lib" soon. Many of them rarely receive changes these days. The
creation of "src" could be more disruptive and can wait until
$(topdir) is once again unbearable.
-- 
Duy
