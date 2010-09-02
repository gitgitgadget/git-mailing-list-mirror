From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 02 Sep 2010 15:52:02 -0400
Message-ID: <4C800062.7020707@gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>	<4C7FC3DC.3060907@gmail.com>	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>	<alpine.LFD.2.00.1009021249510.19366@xanadu.home> <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 21:52:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFpZ-0004Sa-6F
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750Ab0IBTwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 15:52:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38116 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab0IBTwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:52:06 -0400
Received: by ywh1 with SMTP id 1so368293ywh.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=1TJrvfWfeB0zoJqvkpxmyQAAwInlr46mDRnY1jpuJbI=;
        b=yIQdEkXoZCfUM9fT8oFpPBuGiKuffnETyl0HjsyHqrpbThAhgR8O7RHP+x8YPQzF6i
         t4GBMOkOl9iVJyIeAPfZnlXLDWalEK/C7WB+TzniBfBr6uBY4PtX3o0wP69uIOUxtv2Y
         TowhZQK2jHmb90+Pxd5LfOGChBOqcajIDYR3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=r64SiYC5ab0vzW3dSVptw1VnjbkIHi2hRg25fWyjQjU8hS9x9AzPXWY0BRZwxpWTU8
         BLFG6wqnnlvKFUptweapdFEa9XF8Xv51Cz9G4J0mKIa4Huhqx7w59+YCwi0YC+4VWzRO
         CZtlg1IENS1vETs6jHjPycortgdQcgMyIUgbQ=
Received: by 10.150.237.14 with SMTP id k14mr510910ybh.335.1283457124542;
        Thu, 02 Sep 2010 12:52:04 -0700 (PDT)
Received: from [10.0.1.130] (c-24-129-111-166.hsd1.fl.comcast.net [24.129.111.166])
        by mx.google.com with ESMTPS id f6sm2473710yba.7.2010.09.02.12.52.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:52:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100805 Icedove/3.0.6
In-Reply-To: <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155189>

On 09/02/2010 03:41 PM, Luke Kenneth Casson Leighton wrote:

[...]

>   neeh, i'm flexible.  it looks like i'm going to need to deviate from
> bittorrent, after all, start adding new commands over which the git
> rev-list gets transferred, rather than as a VFS layer.  the reason is
> that bittorrent depends on the files and the data in the files being
> all the same, so that a hash can be taken of the whole lot and the
> end-result verified.
>
>   if the pack-objects are going to vary, then the VFS layer idea is
> blown completely out the water, except for the absolute basic
> meta-info such as "refs/heads/*".  so i might as well just use
> "actual" bittorrent to transfer packs via
> {ref}-{commitref}-{SHA-1}.torrent.
>
> ho hum, drawing board we come...

You can treat the git object store (both loose and packed objects) as a 
VFS and use the refs of interest (the I-needs and the I-haves) to create 
a view...
