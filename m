From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
 completion
Date: Mon, 14 Jul 2008 07:50:07 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807140741580.3305@woody.linux-foundation.org>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org>
 <20080714000021.GB13066@spearce.org> <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org> <20080714062755.GA15992@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 16:53:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIPQ3-0002kk-3D
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 16:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbYGNOvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 10:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754733AbYGNOvt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 10:51:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51768 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754688AbYGNOvs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2008 10:51:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6EEo8jH013901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jul 2008 07:50:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6EEo7fh012521;
	Mon, 14 Jul 2008 07:50:07 -0700
In-Reply-To: <20080714062755.GA15992@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.4 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88429>



On Mon, 14 Jul 2008, Shawn O. Pearce wrote:
> 
> What is $COMP_WORDBREAKS set to in your shell?  In mine it
> appears to be:
> 
> 	" \"'@><=;|&(:"
> 
> which is the I believe the shell default.

Ahhah. Indeed. I don't have the ':'.

> Though we could try to detect : in there and if it is not present
> use the workaround you posted.  But I wonder if just asking the
> user to include : is easier.

Umm, if so, git should just set it in the completion script, no?

And doing a google for 'COMP_WORDBREAKS' and 'colon', I don't think I'm 
the only one with it unset. In fact, I'm pretty sure I didn't unset it 
myself, because I've never heard of that thing. So I think it's a generic 
Fedora 9 thing.

(I just checked - that seems to pan out. All the machines with F9 on it I 
have access to are missing the ':' - including machines I have not set up 
myself like master.kernel.org)

		Linus
