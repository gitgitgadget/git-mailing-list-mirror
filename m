From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Atomicity of git-push operation.
Date: Wed, 23 Dec 2009 07:25:29 -0800
Message-ID: <20091223152529.GC13762@spearce.org>
References: <4B32044A.7010601@9livesdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Zalcman <zalcman@9livesdata.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 16:28:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNT5m-00086e-AD
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 16:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756197AbZLWPZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 10:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755968AbZLWPZd
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 10:25:33 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:33477 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597AbZLWPZd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 10:25:33 -0500
Received: by yxe17 with SMTP id 17so6846134yxe.33
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 07:25:32 -0800 (PST)
Received: by 10.90.24.26 with SMTP id 26mr5608403agx.37.1261581932482;
        Wed, 23 Dec 2009 07:25:32 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm3262808yxe.54.2009.12.23.07.25.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Dec 2009 07:25:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B32044A.7010601@9livesdata.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135621>

Jan Zalcman <zalcman@9livesdata.com> wrote:
>  I have a simple question about "push" operation but I couldn't find an
> answer: is git-push (also with --tags flag) atomic ? Especially: if refs
> changing (during push) is atomic ?

Yes, its atomic, at the per-ref level.

If you push 3 refs, and one of them updates during the push, the
other two will push successfully, but the one that was updated will
be rejected.

-- 
Shawn.
