From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 0/4 v2]
Date: Fri, 29 Jun 2012 09:49:16 +0200
Message-ID: <1374057.qfvOg1c6C6@flobuntu>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 29 09:49:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkVxF-0002Zb-8q
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 09:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782Ab2F2HtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 03:49:21 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55036 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab2F2HtU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 03:49:20 -0400
Received: by eaak11 with SMTP id k11so1247828eaa.19
        for <git@vger.kernel.org>; Fri, 29 Jun 2012 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:content-type;
        bh=bGK/jCbcCEoWk3xw020FfywH+kE/B43JDDcc/2RYQd8=;
        b=ptlkQeUDRwTveYNaAo/0AzkRkHXrVHSsdm9E0Quy4rrhnz/sdlwkJyh0ypky22wTsL
         3lyOuZtFj3nh2X/vd+T/urX+QL3/wYh6p8Vqp3nBXJSI0wLam9++2NK+ctmjKBAChTgw
         TL93mVlBzfVwZmpZNcdcnfblERIXMcFuvSmFX5I06E7fffERwLrukQdbmdImdETLpbYG
         T82r/K+mRN3iL/Z6gEkCS1pmtxmHy8ahK29Oc7md04c/HfQDUhmTFzCeH8A3P/1Tssv2
         3DGtib3AyWFI5FZwhqKxYSZHfY/yD8KZ8rqafC+jQTjN3IMk2OD/ajiuIv6gx4HE+6+K
         cVbA==
Received: by 10.216.141.213 with SMTP id g63mr254225wej.34.1340956159000;
        Fri, 29 Jun 2012 00:49:19 -0700 (PDT)
Received: from flobuntu.localnet (m-149.vc-graz.ac.at. [193.170.224.149])
        by mx.google.com with ESMTPS id m4sm4299463wie.1.2012.06.29.00.49.17
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jun 2012 00:49:18 -0700 (PDT)
User-Agent: KMail/4.8.3 (Linux/3.2.0-26-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200804>

This new version uses a fifo instead of a pipe and addresses other issues 
discussed in this thread.
To pass the name of the fifo to fast-import, it gets a new cmd-line-arg.
It no longer requires the prexec_cb and should be more portable, as there 
exist pipes on windows too.



On Monday 04 June 2012 19:20:51 Florian Achleitner wrote:
> Series of patches creating a very basic remote helper in C.
> 
> [RFC 1/4] Implement a basic remote helper vor svn in C.
> [RFC 2/4] Integrate remote-svn into svn-fe/Makefile.
> [RFC 3/4] Add svndump_init_fd to allow reading dumps from arbitrary
> [RFC 4/4] Add cat-blob report pipe from fast-import to
