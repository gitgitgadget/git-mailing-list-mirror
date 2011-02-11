From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: t7610 is no longer valgrind-clean in pu
Date: Fri, 11 Feb 2011 09:45:57 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102110932360.21859@debian>
References: <201102111146.07303.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Fri Feb 11 15:46:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnuGI-0000JS-7k
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 15:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab1BKOqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 09:46:12 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40885 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab1BKOqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 09:46:10 -0500
Received: by vws16 with SMTP id 16so1676923vws.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 06:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=+FjZtfzypj5LcbOZP7D/Pl710ubTOuiKqtDsmoYafAM=;
        b=Nm2700ePLiE50euNNBDsFuQjtpCl8QHsCUyAbglesPrUFUwvrgPsY0BvOpn6j/Wboa
         6B5vbcvygojGGai547LxcR15WZCiNKdeje1EAIh37rfAtFjF3h8W2o3NfwMO6nY3RIaX
         fyk5BSwBjJZ10j7zag9a0QxSfp9Xq11TKvwUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=n2QMvOdxP0v2o5DfWzIeDHVCh1FeuzuA5c5aQj5tJdXQQ9/oiaO/gV4YcMDgqI5k3P
         bpsv3TSYsQaQDYpkWMWXc3KWBf95MmFPBOe/wj/rGnTybvUiuPzRxf9qyMBvLTY+IrjP
         3Ahohtq6pSta4Uezeh0Int2T6xl6K8eGJoXYY=
Received: by 10.220.203.141 with SMTP id fi13mr701931vcb.112.1297435569385;
        Fri, 11 Feb 2011 06:46:09 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id f17sm637691vbv.16.2011.02.11.06.46.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 06:46:07 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <201102111146.07303.tr@thomasrast.ch>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166558>

Hi,

On Fri, 11 Feb 2011, Thomas Rast wrote:

> Hello Martin
> 
> My valgrind tester cronjob tells me the output below (some cruft
> trimmed).  If you need any more data just ask :-)
> 
> > Switched to a new branch 'test5'
> > ==25695== Invalid free() / delete / delete[]
> > ==25695==    at 0x4C20A31: free (vg_replace_malloc.c:325)
> > ==25695==    by 0x4F2538: string_list_clear (string-list.c:115)
> > ==25695==    by 0x466CE8: cmd_rerere (rerere.c:182)
> > ==25695==    by 0x404771: run_builtin (git.c:290)
> > ==25695==    by 0x4048FC: handle_internal_command (git.c:448)
> > ==25695==    by 0x4049E7: run_argv (git.c:492)
> > ==25695==    by 0x404B43: main (git.c:565)
> > ==25695==  Address 0x772388 is 0 bytes inside data symbol "RERERE_UTIL_STAGED"

This is most definitely the same thing as I reported in [1]. Thanks
for checking and sorry for submitting such a crappy patch :-(.

/Martin


 [1] http://thread.gmane.org/gmane.comp.version-control.git/166329?focus=166535
