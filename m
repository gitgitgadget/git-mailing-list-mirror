From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH (GIT-GUI) 0/3] Improve gui blame usability for large repositories
Date: Fri, 18 Jul 2008 09:39:05 +0400
Organization: TEPKOM
Message-ID: <200807180939.06082.angavrilov@gmail.com>
References: <200807170042.29462.angavrilov@gmail.com> <20080717021623.GC16740@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 07:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJihc-0000da-56
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 07:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbYGRFjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 01:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbYGRFjQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 01:39:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:3898 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYGRFjP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 01:39:15 -0400
Received: by nf-out-0910.google.com with SMTP id d3so78252nfc.21
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 22:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vyGX8zrDGjO/JaymQ1wxocKOUDQPZsM+THQa8n8H9IU=;
        b=PKsf6nhBw31ZeB88sr3FMD2S+/mXvHkZyxOnUehfx23A4V3X7qoCbyPWl5AYw3qWUO
         bw9QAXG2Z+iygoMjujuUI7TtMDZliqGIPZtllN3u2d1olQPNQzZ4hve75P0RHwJxvHYU
         tOwwwOiR6Y3+lBJ65uriUB3vyU8lGchkBkdXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=L8KpYFXvngdGN327aoUtQd75ZNsQc2c2Wiz7hb/ZHGt8+ASfMnULW9O+oIdwKzLZ5S
         oKomPx+AyzT/tu2eIFMPf/wDHggvrWmlQYKE4GmxPsvirKBvcm4hc2MCGbaw9zpTurof
         4zeJMzQRiQirLNENiErdQOqyjXKC9qYO1NR2M=
Received: by 10.210.141.4 with SMTP id o4mr1856388ebd.154.1216359553806;
        Thu, 17 Jul 2008 22:39:13 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id b36sm1114570ika.5.2008.07.17.22.39.12
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 22:39:13 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <20080717021623.GC16740@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88984>

Hello,

On Thursday 17 July 2008 06:16:23 Shawn O. Pearce wrote:
> Alexander Gavrilov <angavrilov@gmail.com> wrote:
> > Full copy detection can take quite some time on large repositories, which
> > substantially decreases perceived usability of the 'git gui blame' command.
> > This set of patches tries to overcome it by:
> > 
> > 1) Allowing the user to disable '-C -C' and/or set the detection threshold.
> > 
> > 2) Explicitly killing back-end processes, which don't produce any output
> >   during copy detection, and thus normally won't receive SIGPIPE until
> >   it is finished. Runaway processes are annoying.
> > 
> > 3) To compensate for (1), adding a context menu item to manually invoke
> >   blame -C -C -C on a group of lines.
> 
> This series is nicely done.  Works well on revision.c in git.git,
> where the blame can be costly to compute with full copy detection.
> And getting the incremental from the context menu also works well.

I also thought that it would be useful to be able to specify the line range explicitly,
but couldn't invent a good UI for it. Selecting lines with the mouse also causes a
commit to be selected and recolored in green, and popping up a dialog to request
line numbers seems too lame.

Alexander
