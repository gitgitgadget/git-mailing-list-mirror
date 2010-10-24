From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP PATCH 01/18] rev-parse: add --internal-cwd and
 --internal-git-dir for tests
Date: Sun, 24 Oct 2010 10:40:05 -0500
Message-ID: <20101024154005.GB31764@burratino>
References: <1287922310-14678-1-git-send-email-pclouds@gmail.com>
 <1287922310-14678-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 24 17:44:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA2js-0005Cf-Nn
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 17:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890Ab0JXPn6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 11:43:58 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34549 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932838Ab0JXPn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 11:43:57 -0400
Received: by yxn35 with SMTP id 35so1594233yxn.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SzC0FP67vD7Slj1+oTAD16QsVHvq4Eeechnjr7Ff3kI=;
        b=jrAKt0VIF8winfrjOa4XB+w5Ey4U4E94LiU8QUmphvMphjfthS55A58c6o6+4nw/IN
         12zH4imRIvCMaYcEZ1NO/dnW41tVbsFz8rUrKeJmPs3d03TjWJacFMBRmkV8NOjRcm1j
         W/IAsVfV1ADID26ASawV0VZO3oJLT1ObZ9gEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xYCYVkn9NonSANqP4MXU/ncydh9PcyFuqSSGO+5LWqFAA11OvpX329D/a/yF2YYklN
         i0rIu3uT6qrCTQbpi06Mm8dy8P9LPJO/9tU27TbAVge1LFZwFbVqJzTuTNVUJfVfKYkF
         CYbXDWMEnZwC1xbZREtZqqa0cCSPdE4Ez3JJI=
Received: by 10.150.12.11 with SMTP id 11mr10972328ybl.0.1287935037179;
        Sun, 24 Oct 2010 08:43:57 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m22sm4504989yha.5.2010.10.24.08.43.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 08:43:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287922310-14678-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159880>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --internal-cwd is obvious, no way else to expose it for testing.
>
> --internal-git-dir is introduced because --git-dir prepares its outpu=
t
> suitable for scripting. For tests, it must be exactly what git stores=
=2E

Hmm.  Forget this is used in tests, would it make sense to do this
with trace_printf, at the end of setup, as in your earlier patch?

I think it might: just like the exec: lines provide context about what
command is being traced, such trace: cwd: lines would make it clearer
what paths that are being output might be referring to.

Returning to the topic of tests, is it possible to get at these
variables using an external command that is run by git?  pre-commit
hook, maybe.  Testing of other symptoms is also possible, as in
=46r=C3=A9d=C3=A9ric's example.
