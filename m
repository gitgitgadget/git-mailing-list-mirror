From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/5] diff_tree_sha1: skip diff_tree if old == new
Date: Thu, 31 Mar 2011 19:58:20 +0700
Message-ID: <AANLkTinwovtXfm-OvVivwyjs2RT8+D6Mj=OXkQCNH8uy@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 14:59:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5HSi-0007W5-Gp
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 14:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757222Ab1CaM6v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 08:58:51 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55938 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab1CaM6u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 08:58:50 -0400
Received: by pwi15 with SMTP id 15so406293pwi.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=dnyTHEJHTiN+1uYFewLYU/ig5nAuoVGQdPqPdA5VOuc=;
        b=pnNS375RpaWUCAN6ey6sKDqu8xeOESueNUazvPSh08HK4uTv7nsW2I6f64lTvVrA/x
         Mh9MBlBZ5Gxt3CbWoL4Le1rHzfM/d/Jt0bfBfzEXCKioymvv2a5IJd0yiweFywWDlcH6
         QgDlBVcU5evjpuw4P7H8CXACGACdBQgNzMJL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Or113wGROMUCkzzB7izRc9P/Ph1Izb/plu0Mf0JPZxr3hhWAkvpzwZ1xSSelrTPach
         7/fkuEPMq+xiiGZ5eBqFMQvIjiSEYrcuz8J+C86R9//pShKvD1VYUKYf/SvKXoSK2fve
         rIrMZyPJi2ETx70YkxvTP/+helspN4s79DW0w=
Received: by 10.142.202.12 with SMTP id z12mr1885553wff.442.1301576330094;
 Thu, 31 Mar 2011 05:58:50 -0700 (PDT)
Received: by 10.68.42.234 with HTTP; Thu, 31 Mar 2011 05:58:20 -0700 (PDT)
In-Reply-To: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170485>

On Thu, Mar 31, 2011 at 8:37 AM, Dan McGee <dpmcgee@gmail.com> wrote:
> These next few patches are all derived from trying to make operations=
 on this
> repository a bit faster:
> =C2=A0 =C2=A0http://projects.archlinux.org/svntogit/packages.git/
>
> ...
>
> time git log -- zzzzz_not_exist >/dev/null
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A035.558s =C2=A0 =C2=A0 =C2=A00.976s

Do you have numbers before and after applying this series? It'd be
interesting to see how much we gain from the series.
--=20
Duy
