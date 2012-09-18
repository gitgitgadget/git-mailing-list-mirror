From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCHv4] clone --single: limit the fetch refspec to fetched branch
Date: Tue, 18 Sep 2012 08:02:13 +0700
Message-ID: <CACsJy8CENp5VasbizzrLRbRELaaPD-gVLepEdXHPv=Diq9s6sg@mail.gmail.com>
References: <7vy5kc1avx.fsf@alter.siamese.dyndns.org> <1347783184-20045-1-git-send-email-ralf.thielow@gmail.com>
 <CACsJy8Bsps_-RaXdBd9ipWPvJukjK7mRN_wG2ezEL5d4JLyx+g@mail.gmail.com> <7vhaqwv2co.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 03:02:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDmDG-00005g-U2
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 03:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005Ab2IRBCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 21:02:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38166 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901Ab2IRBCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 21:02:44 -0400
Received: by iahk25 with SMTP id k25so5749441iah.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 18:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uff44xYCCNPDQ0lQsmTIXRQfvyWkvJX8/qiJ9Dlh88U=;
        b=gG/dndH7BNNZX32J9EtExvUyAnVUx2wn20GQoLGGQYuTUR41n8Azc66vYCLgcJuHmD
         XVnR3ui+SpUg2u6SbHggpF1oSfc3UaFghzHMMJBEd5ehkuhfHrBiH/7ICO4/YK2Hc4cV
         22omJjURTuVmVWBdmwUjfh2ADSwt8jKhfP0vmjvR2clT/4An94x0lrercgvb5gPcCPDG
         pAxLgRDFkQawFVDU/xaBdhyA8Z+u7KJgaVZJ5vYLYPo4/yvuL5911UURNaSNDal/1SZb
         qQmWv/jvXUYlk8+Pzj+6Az/QYov5ss0cKr29q0OjqemWeibxESPTZMfoD8N31HUWqoaq
         farA==
Received: by 10.50.7.210 with SMTP id l18mr8641673iga.26.1347930164134; Mon,
 17 Sep 2012 18:02:44 -0700 (PDT)
Received: by 10.64.167.139 with HTTP; Mon, 17 Sep 2012 18:02:13 -0700 (PDT)
In-Reply-To: <7vhaqwv2co.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205776>

On Tue, Sep 18, 2012 at 3:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> --mirror --single-branch combination does not look right. The "heads/"
>> part is missing..
>
> What does it supposed to do in the first place?  "mirror" is
> primarily about grabbing everything without leaving stuff out, and
> "single" is about grabbing only one thing without other stuff.  It
> smells like a nonsense case we didn't even bother to catch and
> diagnose as an error to me.
>
> Besides, mirror implies bare, so we would expect to see
>
>     refs/heads/$single:refs/heads/$single
>
> and that matches what the "single" gives us without "mirror", no?

Yes that's what I think it should do too.

> How about explicitly forbidding that combination, or ignoring mirror
> when single is given?

I see nothing wrong with mirroring just one branch. But if handling it
is too complex than forbidding it is fine.
-- 
Duy
