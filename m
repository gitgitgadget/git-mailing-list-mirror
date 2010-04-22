From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: bug in name-rev on linux-2.6 repo?
Date: Thu, 22 Apr 2010 07:40:43 -0500
Message-ID: <20100422124042.GA1433@progeny.tock>
References: <20100421195822.GX10984@baikonur.stro.at>
 <r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com>
 <20100422121408.GI3211@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: maximilian attems <max@stro.at>
X-From: git-owner@vger.kernel.org Thu Apr 22 14:40:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4vhx-0004AN-0q
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 14:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab0DVMke convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 08:40:34 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59442 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab0DVMkd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 08:40:33 -0400
Received: by pvh1 with SMTP id 1so285876pvh.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vBotIRtlZ39GDlSmmxoM0rRZzbvv7PBVGygMBRHff7c=;
        b=I8yZlZaIAG8hE+d0IBuQT9ltGJdzYUOHYLfqY4NjrEXNrmhy2eA0PJoWoMRR+oV9mw
         QEwF/7bWaLZF5uub/IgQLHNCwdHlLuaKdCF2ZYC+p2ZYNvI15GzNOSOG20VKxNc32RHn
         CyPvnHqZjL3FD0yNduf0RWo0GrBt2iI3CVo7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ssD6TO0A2qtDL6YIz3xwrq4GmpT1WFIE2M9u8l5O8eyJmZ5ZeBYCTqRvo/l/EM6FVV
         0cnBuFTI0X+/l17yKes1Y+sgEgwdEcK9ILn1tH+SavmoEePIITw+CBfOVHtYx6wraGRW
         RjckhA5UkhT9mOMHLEeT+1oV2ZUQa3z3216po=
Received: by 10.140.248.10 with SMTP id v10mr1405901rvh.245.1271940033309;
        Thu, 22 Apr 2010 05:40:33 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2943276iwn.9.2010.04.22.05.40.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 05:40:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100422121408.GI3211@stro.at>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145526>

Hi maks,

maximilian attems wrote:

> ~/src/linux-2.6$ git name-rev a1de02dccf906faba2ee2d99cac56799bda3b96=
a
> =C2=A0a1de02dccf906faba2ee2d99cac56799bda3b96a undefined

Thanks for pointing it out.  This is weird.

The commit doesn=E2=80=99t seem to be part of any tagged release, nor l=
inus=E2=80=99s
master:

| $ git log ^v2.6.34-rc5 ^origin/master a1de02dccf --oneline
| a1de02d ext4: fix async i/o writes beyond 4GB to a sparse file

So maybe it was rewritten; searching for a commit with the same subject=
:

| $ git log v2.6.33..origin/master --grep=3D'ext4: fix async' --oneline
| a1de02d ext4: fix async i/o writes beyond 4GB to a sparse file

Huh?  Is it included in origin/master or not?

| $ git version
| git version 1.7.1.rc1

Jonathan
