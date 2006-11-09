X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: protect blob and diff output lines from controls.
Date: Thu, 9 Nov 2006 11:02:55 +0100
Message-ID: <200611091102.56565.jnareb@gmail.com>
References: <7vpsbxqzre.fsf@assigned-by-dhcp.cox.net> <200611091024.35019.jnareb@gmail.com> <7vlkmlkkq8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 9 Nov 2006 10:02:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WL5pyhwU+/6TKSMpdr+BQPSzhOiw+u4bUF7rk2B18qOz98fF7nxhvwfKW7O08ftmeEjvtWSNphZDjsxPlsjfaCNSC4gcXAUbW4licnr0KeZ19awwL/FB09+UF+oBioPgEqIr4ggVpy0U1kvrTsj1WdLkyJjRd1GvqDyUuosfzq0=
User-Agent: KMail/1.9.3
In-Reply-To: <7vlkmlkkq8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31190>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi6jc-0007bI-A6 for gcvg-git@gmane.org; Thu, 09 Nov
 2006 11:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754777AbWKIKCJ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006 05:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754778AbWKIKCJ
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 05:02:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:2782 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1754777AbWKIKCH
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 05:02:07 -0500
Received: by ug-out-1314.google.com with SMTP id m3so169266ugc for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 02:02:05 -0800 (PST)
Received: by 10.67.100.17 with SMTP id c17mr1044847ugm.1163066524937; Thu, 09
 Nov 2006 02:02:04 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 30sm610685ugf.2006.11.09.02.02.04; Thu, 09 Nov
 2006 02:02:04 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> [...] =A0There is another
> thing I noticed while testing it with an artifitial test that I
> haven't fixed, but I think you already know about it (when the
> commitdiff is completely empty except mode changes, we end up
> with unbalanced div). =A0My test's tip can be found at
> 'gitweb-test-funny-char' branch temporarily in the git.git
> repository.

Damn. I thought I corrected this on resend...

	if ($patch_found) {
		# close extended header for previous empty patch
		if ($in_header) {
			print "</div>\n" # class=3D"diff extended_header"
		}
		# close previous patch
		print "</div>\n"; # class=3D"patch"
	}
--=20
Jakub Narebski
