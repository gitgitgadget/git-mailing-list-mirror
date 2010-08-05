From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC v2 0/12] Re: rerere: let caller decide whether to renormalize
Date: Thu, 5 Aug 2010 21:02:08 +0200
Message-ID: <DB014985-CC03-4DBA-B801-C9B80933AB0B@gmail.com>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com> <20100804031935.GA19699@burratino> <20100804032338.GF19699@burratino> <7vocdifdrk.fsf@alter.siamese.dyndns.org> <20100805110822.GB13779@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 21:02:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh5ht-0005AM-Fo
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 21:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933313Ab0HETCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 15:02:15 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34732 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933244Ab0HETCO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 15:02:14 -0400
Received: by ewy23 with SMTP id 23so2543649ewy.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=VKGv4kZBAUAjMbfUkZpzO5d50C457LlRzabZTHOJQCI=;
        b=PgkaQazU0gjr7kpnzqzwTlLdy7o9uWEREI7CJ+Ym1igOd1QiXpkTsXJC0BV/x6SoJ1
         Jkvy5dhe+3dqCRbMNg4ASNHWHl8HRGXSD+uSFsqGSxT4c6zci4UiQvGFUijgwLSR3c5D
         4M7nlcWfyrN6/gPkk8vz3yxkVU8ikAKQFSoM0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=nvqf7+Jb8q8xDrbNx5/x7xbRWP7JdOyAHTuAHHJvT2covJIdKFApbtA/wm12pi9pGh
         JjVw78WHcQPMgW4I30N69+ZIpMnIT7A6557xbX9a7SobqcNKYChNxVIXwyLb3IHmc3UH
         HjdChm+e34Mn9IWUtDlA2hgmmIv1t7DRh3oYQ=
Received: by 10.14.119.67 with SMTP id m43mr4015773eeh.81.1281034933289;
        Thu, 05 Aug 2010 12:02:13 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id z55sm783717eeh.3.2010.08.05.12.02.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 12:02:11 -0700 (PDT)
In-Reply-To: <20100805110822.GB13779@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152702>

Hi Jonathan,

Sorry I'm late to respond, I've just caught up with work after a long summer holiday.  It's back to working with complicated merges across normalization boundaries now, though.  This series looks like it's taking my hack in a sane direction, so for what it's worth:

Acked-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>

Meanwhile, I've hit an annoyance: currently, files that are introduced with CRLFs on a non-normalized branch are left alone in the merged branch, causing the classical core.autocrlf problem of marking every line in such a file as changed if it is so much as touched.

I think the renormalization setting makes much more sense if the end result of the merge is normalized, so I'm working on a patch to make it do that.

- Eyvind
